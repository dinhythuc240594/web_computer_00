package repositoryimpl;

import model.CategoryDAO;
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
        String sql = "SELECT id, name, description, is_active, parent_id FROM categories";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery(sql)) {

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

        String sql = "SELECT id, name, description, is_active, parent_id " +
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
    public int count(String keyword) {
        return 0;
    }

    @Override
    public Boolean create(CategoryDAO entity) {

        String sql = "INSERT INTO categories (name, description, is_active, parent_id) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, entity.getName());
            ps.setString(2, entity.getDescription());
            ps.setBoolean(3, entity.getIs_active());
            ps.setInt(4, entity.getParent_id());

            ps.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }

    @Override
    public Boolean update(CategoryDAO entity) {

        String sql = "UPDATE categories SET name = ?, description = ?, is_active = ?, parent_id = ?"
                + " WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);) {

            ps.setString(1, entity.getName());
            ps.setString(2, entity.getDescription());
            ps.setBoolean(3, entity.getIs_active());
            ps.setInt(4, entity.getParent_id());
            ps.setInt(5, entity.getId());
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

        return item;
    }

}
