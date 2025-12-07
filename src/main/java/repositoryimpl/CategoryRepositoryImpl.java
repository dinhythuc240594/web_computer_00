package repositoryimpl;

import model.CategoryDAO;
import model.PageRequest;
import repository.CategoryRepository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryRepositoryImpl implements CategoryRepository {

    private final DataSource ds;

    public CategoryRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<CategoryDAO> getAll() {

        List<CategoryDAO> items = new ArrayList<>();
        String sql = "SELECT id, name, description, is_active, parent_id, logo_blob FROM categories";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                items.add(mapResultSetToCategoryDAO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy tất cả chi tiết đơn hàng.", e);
        }
        return items;

    }

    @Override
    public CategoryDAO findById(int id) {

        String sql = "SELECT id, name, description, is_active, parent_id, image " +
                    "FROM categories WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCategoryDAO(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi tìm đơn hàng theo ID: " + id, e);
        }
        return null;

    }

    @Override
    public Boolean deleteById(int id) {

        String sql = "UPDATE categories SET is_active = ? WHERE id = ?";
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
    public List<CategoryDAO> findAll(PageRequest pageRequest) {
        List<CategoryDAO> categories = new ArrayList<>();

        int pageSize = pageRequest.getPageSize();
        int offset = pageRequest.getOffset();
        String keyword = pageRequest.getKeyword();
        String sortField = pageRequest.getSortField();
        String orderField = pageRequest.getOrderField();

        String sql = "SELECT id, name, description, is_active, parent_id, image FROM categories ";

        List<String> conditions = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            conditions.add("(name LIKE ? OR description LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }

        if (!conditions.isEmpty()) {
            sql += "WHERE " + String.join(" AND ", conditions) + " ";
        }

        sql += "ORDER BY " + sortField + " " + orderField + " LIMIT ? OFFSET ?";
        params.add(pageSize);
        params.add(offset);

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof String) {
                    ps.setString(i + 1, (String) param);
                } else if (param instanceof Integer) {
                    ps.setInt(i + 1, (Integer) param);
                }
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(mapResultSetToCategoryDAO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy danh sách danh mục", e);
        }
        return categories;
    }

    @Override
    public int count(String keyword) {
        String baseSql = "SELECT COUNT(1) FROM categories";
        StringBuilder sql = new StringBuilder(baseSql);
        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();

        if (hasKeyword) {
            sql.append(" WHERE (name LIKE ? OR description LIKE ?)");
        }

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            if (hasKeyword) {
                String like = "%" + keyword + "%";
                ps.setString(1, like);
                ps.setString(2, like);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public Boolean create(CategoryDAO entity) {

        String sql = "INSERT INTO categories (name, description, is_active, parent_id, image) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, entity.getName());
            ps.setString(2, entity.getDescription());
            ps.setBoolean(3, entity.getIs_active());
            ps.setInt(4, entity.getParent_id());
            ps.setString(5, entity.getImage());

            ps.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }

    @Override
    public Boolean update(CategoryDAO entity) {

        String sql = "UPDATE categories SET name = ?, description = ?, is_active = ?, parent_id = ?, image = ?"
                + " WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);) {
            System.out.println(entity.getIs_active());
            ps.setString(1, entity.getName());
            ps.setString(2, entity.getDescription());
            ps.setBoolean(3, entity.getIs_active());
            ps.setInt(4, entity.getParent_id());
            ps.setString(5, entity.getImage());
            ps.setInt(6, entity.getId());

            ps.executeUpdate();

            return true;
        } catch (Exception e) {
            System.err.println("Lỗi update: " + e.getMessage());
            e.printStackTrace();
        }
        return false;

    }

    private CategoryDAO mapResultSetToCategoryDAO(ResultSet rs) throws SQLException {
        CategoryDAO item = new CategoryDAO();

        item.setId(rs.getInt("id"));
        item.setName(rs.getString("name"));
        item.setDescription(rs.getString("description"));
        item.setIs_active(rs.getBoolean("is_active"));
        item.setParent_id(rs.getInt("parent_id"));

        try {
            String image = rs.getString("image");
            item.setImage(image);
        } catch (SQLException e) {
            // Nếu cột không tồn tại hoặc null, set null
            item.setImage(null);
        }

        return item;
    }

}
