package repositoryimpl;

import model.PageRequest;
import model.ReviewDAO;
import model.UserDAO;
import repository.UserRepository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserRepositoryImpl implements UserRepository {

    private final DataSource ds;

    public UserRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<UserDAO> getAll() {
        List<UserDAO> items = new ArrayList<>();
        String sql = "SELECT id, username, email, password_hash, full_name, "
                + "phone_number, address, is_active, role "
                + "FROM reviews WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery(sql)) {

            while (rs.next()) {
                items.add(mapResultSetToUserDAO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi tìm đơn hàng theo ID: ", e);
        }
        return null;
    }

    @Override
    public UserDAO findById(int id) {

        String sql = "SELECT id, username, email, password_hash, full_name, "
                + "phone_number, address, is_active, role "
                + "FROM reviews WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUserDAO(rs);
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

        String sql = "UPDATE users SET is_active = ? WHERE id = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setBoolean(1, false);
            ps.setInt(2, id);

            ps.executeUpdate();

            return true;
        } catch (Exception e) {
            System.err.println("Error delete: " + e.getMessage());
            return false;
        }

    }

    @Override
    public int count(String keyword) {
        return 0;
    }

    @Override
    public Boolean create(UserDAO entity) {

        String sql = "INSERT INTO users (username, email, password_hash, full_name, "
                    +"phone_number, address, is_active, role)"
                    +"VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, entity.getUsername());
            ps.setString(2, entity.getEmail());
            ps.setString(3, entity.getPassword());
            ps.setString(4, entity.getRole());
            ps.setString(5, entity.getAddress());
            ps.setString(6, entity.getPhone());
            ps.setString(7, entity.getFullname());
            ps.setBoolean(8, entity.getIsActive());

            ps.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }

    @Override
    public Boolean update(UserDAO entity) {

        String sql = "UPDATE users SET username = ?, email = ?, password_hash = ?, full_name = ?, "
                + "phone_number = ?, address = ?, is_active = ?, role = ?"
                + "WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, entity.getUsername());
            ps.setString(2, entity.getEmail());
            ps.setString(3, entity.getPassword());
            ps.setString(4, entity.getRole());
            ps.setString(5, entity.getAddress());
            ps.setString(6, entity.getPhone());
            ps.setString(7, entity.getFullname());
            ps.setBoolean(8, entity.getIsActive());
            ps.setInt(9, entity.getId());

            ps.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }

    private UserDAO mapResultSetToUserDAO(ResultSet rs) throws SQLException {
        UserDAO item = new UserDAO();

        item.setId(rs.getInt("id"));
        item.setUsername(rs.getString("username"));
        item.setPassword(rs.getString("password"));
        item.setEmail(rs.getString("email"));
        item.setRole(rs.getString("role"));
        item.setAddress(rs.getString("address"));
        item.setPhone(rs.getString("phone"));
        item.setFullname(rs.getString("fullname"));
        item.setIsActive(rs.getBoolean("isActive"));

        return item;
    }

    @Override
    public List<UserDAO> findAll(PageRequest pageRequest) {
        return List.of();
    }
}
