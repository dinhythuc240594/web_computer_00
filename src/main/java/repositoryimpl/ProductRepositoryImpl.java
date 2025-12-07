package repositoryimpl;

import model.PageRequest;
import model.ProductDAO;
import repository.ProductRepository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductRepositoryImpl implements ProductRepository {

    private final DataSource ds;

    public ProductRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<ProductDAO> findAll(PageRequest pageRequest) {
        List<ProductDAO> products = new ArrayList<>();

        int pageSize = pageRequest.getPageSize();
        int offset = pageRequest.getOffset();
        String keyword = pageRequest.getKeyword();
        String sortField = pageRequest.getSortField();
        String orderField = pageRequest.getOrderField();
        int brandId = pageRequest.getBrandId();
        int categoryId = pageRequest.getCategoryId();

        String sql = "SELECT id, name, slug, description, "
                    + "price, stock_quantity, image, category_id, brand_id, is_active, "
                    + "created_at, updated_at FROM products ";

        List<String> conditions = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        if(keyword != null && !keyword.trim().isEmpty()) {
            conditions.add("(name LIKE ? OR CAST(price AS CHAR) LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }

        if(brandId > 0) {
            conditions.add("brand_id = ?");
            params.add(brandId);
        }

        if(categoryId > 0) {
            conditions.add("category_id = ?");
            params.add(categoryId);
        }

        if(!conditions.isEmpty()) {
            sql += "WHERE " + String.join(" AND ", conditions) + " ";
        }

        sql += "ORDER BY " + sortField + " " + orderField + " LIMIT ? OFFSET ?";
        params.add(pageSize);
        params.add(offset);

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for(int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if(param instanceof String) {
                    ps.setString(i + 1, (String) param);
                } else if(param instanceof Integer) {
                    ps.setInt(i + 1, (Integer) param);
                }
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductDAO productDAO = mapResultSetToProductDAO(rs);
                products.add(productDAO);
            }
        } catch (Exception e) {
            System.err.println("error getAll: " + e.getMessage());
        }
        return products;
    }

    @Override
    public List<ProductDAO> getAll() {
        List<ProductDAO> products = new ArrayList<>();
        String sql = "SELECT id, name, slug, description, price, stock_quantity, " +
                "image, category_id, brand_id, is_active " +
                "FROM products";

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                products.add(mapResultSetToProductDAO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy danh sách sản phẩm", e);
        }
        return products;
    }

    @Override
    public ProductDAO findById(int id) {

        String sql = "SELECT id, name, description, price,"
                    + " image, slug, category_id, stock_quantity, "
                    + " brand_id, is_active "
                    + "FROM products WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProductDAO(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi tìm đơn hàng theo ID: " + id, e);
        }
        return null;
    }

    @Override
    public ProductDAO findBySlug(String slug) {
        String sql = "SELECT id, name, description, price, image, slug, " +
                "category_id, stock_quantity, brand_id, is_active " +
                "FROM products WHERE slug = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, slug);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProductDAO(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi tìm sản phẩm theo slug: " + slug, e);
        }
        return null;
    }

    @Override
    public int count(String keyword) {
        return count(keyword, 0, 0);
    }

    @Override
    public int count(String keyword, int brandId, int categoryId) {

        String sql = "SELECT COUNT(1) FROM products";
        List<String> conditions = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        boolean hasKeywords = keyword != null && !keyword.trim().isEmpty();

        if (hasKeywords) {
            conditions.add("(name LIKE ? OR CAST(price AS CHAR) LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }

        if(brandId > 0) {
            conditions.add("brand_id = ?");
            params.add(brandId);
        }

        if(categoryId > 0) {
            conditions.add("category_id = ?");
            params.add(categoryId);
        }

        if(!conditions.isEmpty()) {
            sql += " WHERE " + String.join(" AND ", conditions);
        }

        int total = 0;
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for(int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if(param instanceof String) {
                    ps.setString(i + 1, (String) param);
                } else if(param instanceof Integer) {
                    ps.setInt(i + 1, (Integer) param);
                }
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (Exception e) {
            System.err.println("Lỗi count: " + e.getMessage());
            return -1;
        }

        return total;
    }

    @Override
    public Boolean create(ProductDAO entity) {

        String sql = "INSERT INTO products (name, slug, description, price, "
                + "stock_quantity, image, category_id, brand_id, "
                + "is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, entity.getName());
            ps.setString(2, entity.getSlug());
            ps.setString(3, entity.getDescription());
            ps.setDouble(4, entity.getPrice());
            ps.setInt(5, entity.getStock_quantity());
            ps.setString(6, entity.getImage());
            ps.setInt(7, entity.getCategory_id());
            ps.setInt(8, entity.getBrand_id());
            ps.setBoolean(9, entity.getIs_active());

            ps.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Boolean update(ProductDAO entity) {

        String sql = "UPDATE products SET name = ?, slug = ?, description = ?, price = ?, " +
                "stock_quantity = ?, image = ?, category_id = ?, brand_id = ?, is_active = ? " +
                "WHERE id = ?";

        try (Connection conn = ds.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);) {

            ps.setString(1, entity.getName());
            ps.setString(2, entity.getSlug());
            ps.setString(3, entity.getDescription());
            ps.setDouble(4, entity.getPrice());
            ps.setInt(5, entity.getStock_quantity());
            ps.setString(6, entity.getImage());
            ps.setInt(7, entity.getCategory_id());
            ps.setInt(8, entity.getBrand_id());
            ps.setBoolean(9, entity.getIs_active());
            ps.setInt(10, entity.getId());

            ps.executeUpdate();

            return true;
        } catch (Exception e) {
            System.err.println("Lỗi update: " + e.getMessage());
            e.printStackTrace();
        }
        return false;

    }

    @Override
    public Boolean deleteById(int id) {

        String sql = "UPDATE products SET is_active = ? WHERE id = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, false);
            ps.setInt(2, id);

            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.err.println("Lỗi delete: " + e.getMessage());
            return false;
        }

    }

    private ProductDAO mapResultSetToProductDAO(ResultSet rs) throws SQLException {
        ProductDAO item = new ProductDAO();

        item.setId(rs.getInt("id"));
        item.setBrand_id(rs.getInt("brand_id"));
        item.setCategory_id(rs.getInt("category_id"));
        item.setName(rs.getString("name"));
        item.setSlug(getColumnIfExists(rs, "slug"));
        if (hasColumn(rs, "price")) {
            item.setPrice(rs.getDouble("price"));
        }
        if (hasColumn(rs, "stock_quantity")) {
            item.setStock_quantity(rs.getInt("stock_quantity"));
        }
        if (hasColumn(rs, "is_active")) {
            item.setIs_active(rs.getBoolean("is_active"));
        }
        item.setDescription(getColumnIfExists(rs, "description"));
        try {
            String image = rs.getString("image");
            item.setImage(image);
        } catch (SQLException e) {
            // Nếu cột không tồn tại hoặc null, set null
            item.setImage(null);
        }

        return item;
    }

    private boolean hasColumn(ResultSet rs, String columnName) throws SQLException {
        try {
            rs.findColumn(columnName);
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }

    private String getColumnIfExists(ResultSet rs, String columnName) throws SQLException {
        return hasColumn(rs, columnName) ? rs.getString(columnName) : null;
    }

}
