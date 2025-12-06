package repositoryimpl;

import model.WishlistDAO;
import repository.WishlistRepository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WishlistRepositoryImpl implements WishlistRepository {

    private final DataSource ds;

    public WishlistRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<WishlistDAO> getAll() {
        List<WishlistDAO> items = new ArrayList<>();
        String sql = "SELECT id, user_id, product_id, created_at FROM wishlist";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                items.add(mapResultSetToWishlistDAO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy tất cả wishlist.", e);
        }
        return items;
    }

    @Override
    public WishlistDAO findById(int id) {
        String sql = "SELECT id, user_id, product_id, created_at FROM wishlist WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToWishlistDAO(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi tìm wishlist theo ID: " + id, e);
        }
        return null;
    }

    @Override
    public Boolean deleteById(int id) {
        String sql = "DELETE FROM wishlist WHERE id = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.err.println("Lỗi delete: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public int count(String keyword) {
        String baseSql = "SELECT COUNT(1) FROM wishlist";
        StringBuilder sql = new StringBuilder(baseSql);
        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();

        if (hasKeyword) {
            sql.append(" WHERE CAST(id AS CHAR) LIKE ? OR CAST(user_id AS CHAR) LIKE ? OR CAST(product_id AS CHAR) LIKE ?");
        }

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            if (hasKeyword) {
                String like = "%" + keyword + "%";
                ps.setString(1, like);
                ps.setString(2, like);
                ps.setString(3, like);
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
    public Boolean create(WishlistDAO entity) {
        String sql = "INSERT INTO wishlist (user_id, product_id) VALUES (?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, entity.getUserId());
            ps.setInt(2, entity.getProductId());

            ps.executeUpdate();

            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    entity.setId(generatedKeys.getInt(1));
                }
            }

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Boolean update(WishlistDAO entity) {
        String sql = "UPDATE wishlist SET user_id = ?, product_id = ? WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, entity.getUserId());
            ps.setInt(2, entity.getProductId());
            ps.setInt(3, entity.getId());

            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.err.println("Lỗi update: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<WishlistDAO> findByUserId(int userId) {
        List<WishlistDAO> items = new ArrayList<>();
        String sql = "SELECT id, user_id, product_id, created_at FROM wishlist WHERE user_id = ? ORDER BY created_at DESC";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(mapResultSetToWishlistDAO(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy wishlist theo user_id: " + userId, e);
        }
        return items;
    }

    @Override
    public Boolean existsByUserIdAndProductId(int userId, int productId) {
        String sql = "SELECT COUNT(1) FROM wishlist WHERE user_id = ? AND product_id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Boolean deleteByUserIdAndProductId(int userId, int productId) {
        String sql = "DELETE FROM wishlist WHERE user_id = ? AND product_id = ?";
        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.err.println("Lỗi delete: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    private WishlistDAO mapResultSetToWishlistDAO(ResultSet rs) throws SQLException {
        WishlistDAO item = new WishlistDAO();

        item.setId(rs.getInt("id"));
        item.setUserId(rs.getInt("user_id"));
        item.setProductId(rs.getInt("product_id"));
        item.setCreatedAt(rs.getDate("created_at"));

        return item;
    }
}

