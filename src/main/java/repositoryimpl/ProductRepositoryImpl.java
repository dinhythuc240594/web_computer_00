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
    public List<ProductDAO> getAll(PageRequest pageRequest) {
        List<ProductDAO> products = new ArrayList<>();

        int pageSize = pageRequest.getPageSize();
        int offset = pageRequest.getOffset();
        String keyword = pageRequest.getKeyword();
        String sortField = pageRequest.getSortField();
        String orderField = pageRequest.getOrderField();
        int brandId = pageRequest.getBrandId();
        int categoryId = pageRequest.getCategoryId();

        String sql = "SELECT id, name, slug, description, " +
                "price, stock_quantity, image_url, category_id, brand_id, is_active, " +
                "created_at, updated_at FROM products ";

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

//                int id = rs.getInt("id");
//                String name = rs.getString("name");
//                double price = rs.getDouble("price");
//                int stock_quantity = rs.getInt("stock_quantity");
//                int category_id = rs.getInt("category_id");
//                String image_url = rs.getString("image_url");
//                String slug = rs.getString("slug");
//                int brand_id = rs.getInt("brand_id");
//                boolean is_active = rs.getBoolean("is_active");
//                String description = rs.getString("description");

//                ProductDAO productDAO = new ProductDAO(id, name, description, price,
//                        image_url, slug, category_id, stock_quantity, brand_id, is_active);

                ProductDAO productDAO = mapResultSetToProductDAO(rs);
                products.add(productDAO);
            }
        } catch (Exception e) {
            System.err.println("error getAll: " + e.getMessage());
        }
        return products;
    }

    @Override
    public ProductDAO findById(int id) {
        return null;
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
                + "stock_quantity, image_url, category_id, brand_id, "
                + "is_active) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, entity.getName());
            ps.setString(2, entity.getSlug());
            ps.setString(3, entity.getDescription());
            ps.setDouble(4, entity.getPrice());
            ps.setInt(5, entity.getStock_quantity());
            ps.setString(6, entity.getImage_url());
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
    public ProductDAO update(ProductDAO entity) {

        String sql = "UPDATE products SET name = ?, description = ?, price = ?, slug = ?"
                + "image_url = ?, category_id = ?, brand_id = ?, is_active = ? "
                + "stock_quantity = ?, brand_id = ?, is_active = ? "
                + " WHERE id = ?";

        try (Connection conn = ds.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);) {

            ps.setString(1, entity.getName());
            ps.setString(2, entity.getDescription());
            ps.setDouble(3, entity.getPrice());
            ps.setString(4, entity.getSlug());
            ps.setString(5, entity.getImage_url());
            ps.setInt(6, entity.getCategory_id());
            ps.setInt(7, entity.getBrand_id());
            ps.setBoolean(8, entity.getIs_active());
            ps.setInt(9, entity.getId());
            ps.executeUpdate();

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ProductDAO newEntity = mapResultSetToProductDAO(rs);
                    return newEntity;
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi update: " + e.getMessage());
            e.printStackTrace();
        }
        return entity;
    }

    private ProductDAO mapResultSetToProductDAO(ResultSet rs) throws SQLException {
        ProductDAO item = new ProductDAO();

        item.setId(rs.getInt("id"));
        item.setBrand_id(rs.getInt("brand_id"));
        item.setCategory_id(rs.getInt("category_id"));
        item.setName(rs.getString("name"));
        item.setPrice(rs.getDouble("price"));
        item.setStock_quantity(rs.getInt("stock_quantity"));
        item.setIs_active(rs.getBoolean("is_active"));
        item.setDescription(rs.getString("description"));

        return item;
    }

}
