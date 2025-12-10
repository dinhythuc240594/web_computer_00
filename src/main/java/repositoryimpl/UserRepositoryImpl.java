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
        String sql = "SELECT id, username, email, password_hash, full_name, " +
                "phone_number, address, avatar_blob, is_active, role FROM users";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                items.add(mapResultSetToUserDAO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy tất cả người dùng.", e);
        }
        return items;
    }

    @Override
    public UserDAO findById(int id) {

        String sql = "SELECT id, username, email, password_hash, full_name, " +
                "phone_number, address, avatar_blob, is_active, role FROM users WHERE id = ?";

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
            throw new RuntimeException("Lỗi khi tìm người dùng theo ID: " + id, e);
        }
        return null;

    }

    @Override
    public UserDAO findByUsername(String username) {

        String sql = "SELECT id, username, email, password_hash, full_name, " +
                "phone_number, address, avatar_blob, is_active, role FROM users WHERE username = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUserDAO(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi tìm người dùng theo username: " + username, e);
        }
        return null;
    }

    @Override
    public UserDAO findByEmail(String email) {

        String sql = "SELECT id, username, email, password_hash, full_name, " +
                "phone_number, address, avatar_blob, is_active, role FROM users WHERE email = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUserDAO(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi tìm người dùng theo email: " + email, e);
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
        String sql = "SELECT COUNT(1) FROM users";
        List<String> conditions = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        if (hasKeyword) {
            conditions.add("(username LIKE ? OR email LIKE ? OR full_name LIKE ? OR phone_number LIKE ? OR role LIKE ?)");
            String like = "%" + keyword + "%";
            params.add(like);
            params.add(like);
            params.add(like);
            params.add(like);
            params.add(like);
        }

        if (!conditions.isEmpty()) {
            sql += " WHERE " + String.join(" AND ", conditions);
        }

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            for (int i = 0; i < params.size(); i++) {
                ps.setString(i + 1, (String) params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi đếm người dùng", e);
        }
        return 0;
    }

    @Override
    public Boolean create(UserDAO entity) {

        String sql = "INSERT INTO users (username, email, password_hash, full_name, " +
                "phone_number, address, avatar_blob, is_active, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, entity.getUsername());
            ps.setString(2, entity.getEmail());
            ps.setString(3, entity.getPassword());
            ps.setString(4, entity.getFullname());
            ps.setString(5, entity.getPhone());
            ps.setString(6, entity.getAddress());
            if (entity.getAvatar() != null) {
                ps.setBytes(7, entity.getAvatar());
            } else {
                ps.setNull(7, java.sql.Types.BLOB);
            }
            ps.setBoolean(8, entity.getIsActive());
            ps.setString(9, entity.getRole());

            ps.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }

    @Override
    public Boolean update(UserDAO entity) {
        // Always update avatar if provided (entity already has existing avatar if not updating)
        String sql = "UPDATE users SET username = ?, email = ?, password_hash = ?, full_name = ?, " +
                "phone_number = ?, address = ?, avatar_blob = ?, is_active = ?, role = ? WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, entity.getUsername());
            ps.setString(2, entity.getEmail());
            ps.setString(3, entity.getPassword());
            ps.setString(4, entity.getFullname());
            ps.setString(5, entity.getPhone());
            ps.setString(6, entity.getAddress());
            
            if (entity.getAvatar() != null && entity.getAvatar().length > 0) {
                ps.setBytes(7, entity.getAvatar());
            } else {
                ps.setNull(7, java.sql.Types.BLOB);
            }
            
            ps.setBoolean(8, entity.getIsActive());
            ps.setString(9, entity.getRole());
            ps.setInt(10, entity.getId());

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
        item.setPassword(rs.getString("password_hash"));
        item.setEmail(rs.getString("email"));
        item.setFullname(rs.getString("full_name"));
        item.setPhone(rs.getString("phone_number"));
        item.setAddress(rs.getString("address"));
        java.sql.Blob avatarBlob = rs.getBlob("avatar_blob");
        if (avatarBlob != null) {
            item.setAvatar(avatarBlob.getBytes(1, (int) avatarBlob.length()));
        } else {
            item.setAvatar(null);
        }
        item.setIsActive(rs.getBoolean("is_active"));
        item.setRole(rs.getString("role"));

        return item;
    }

    @Override
    public List<UserDAO> findAll(PageRequest pageRequest) {
        List<UserDAO> items = new ArrayList<>();

        int pageSize = pageRequest.getPageSize();
        int offset = pageRequest.getOffset();
        String keyword = pageRequest.getKeyword();
        String sortField = pageRequest.getSortField();
        String orderField = pageRequest.getOrderField();

        String sql = "SELECT id, username, email, password_hash, full_name, phone_number, " +
                "address, avatar_blob, is_active, role FROM users ";

        List<String> conditions = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        if (hasKeyword) {
            conditions.add("(username LIKE ? OR email LIKE ? OR full_name LIKE ? OR phone_number LIKE ? OR role LIKE ?)");
            String like = "%" + keyword + "%";
            params.add(like);
            params.add(like);
            params.add(like);
            params.add(like);
            params.add(like);
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

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(mapResultSetToUserDAO(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi phân trang người dùng", e);
        }

        return items;
    }
}
