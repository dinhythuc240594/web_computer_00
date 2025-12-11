package repositoryimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import model.NewsletterDAO;
import repository.NewsletterRepository;
import utilities.DataSourceUtil;

public class NewsletterRepositoryImpl implements NewsletterRepository {

    private final DataSource ds;

    public NewsletterRepositoryImpl() {
        this.ds = DataSourceUtil.getDataSource();
    }

    public NewsletterRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<NewsletterDAO> getAll() {
        return findAll(true);
    }

    @Override
    public NewsletterDAO findById(int id) {
        String sql = "SELECT id, email, status, subscribed_at, unsubscribed_at " +
                "FROM newsletter_subscriptions WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToNewsletterDAO(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi tìm newsletter subscription theo ID.", e);
        }
        return null;
    }

    @Override
    public Boolean create(NewsletterDAO entity) {
        String sql = "INSERT INTO newsletter_subscriptions (email, status) VALUES (?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, entity.getEmail());
            ps.setString(2, entity.getStatus() != null ? entity.getStatus() : "active");

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        entity.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi tạo newsletter subscription.", e);
        }
        return false;
    }

    @Override
    public Boolean update(NewsletterDAO entity) {
        String sql = "UPDATE newsletter_subscriptions SET email = ?, status = ?, " +
                "unsubscribed_at = ? WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, entity.getEmail());
            ps.setString(2, entity.getStatus());
            if (entity.getUnsubscribed_at() != null) {
                ps.setTimestamp(3, entity.getUnsubscribed_at());
            } else {
                ps.setNull(3, Types.TIMESTAMP);
            }
            ps.setInt(4, entity.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi cập nhật newsletter subscription.", e);
        }
    }

    @Override
    public Boolean deleteById(int id) {
        String sql = "DELETE FROM newsletter_subscriptions WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi xóa newsletter subscription.", e);
        }
    }

    @Override
    public int count(String keyword) {
        String sql = "SELECT COUNT(*) FROM newsletter_subscriptions";
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " WHERE email LIKE ?";
        }

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(1, "%" + keyword.trim() + "%");
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi đếm newsletter subscriptions.", e);
        }
        return 0;
    }

    @Override
    public NewsletterDAO findByEmail(String email) {
        String sql = "SELECT id, email, status, subscribed_at, unsubscribed_at " +
                "FROM newsletter_subscriptions WHERE email = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToNewsletterDAO(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi tìm newsletter subscription theo email.", e);
        }
        return null;
    }

    @Override
    public List<NewsletterDAO> findAllActive() {
        return findAll(false);
    }

    @Override
    public List<NewsletterDAO> findAll(boolean includeUnsubscribed) {
        List<NewsletterDAO> items = new ArrayList<>();
        String sql = "SELECT id, email, status, subscribed_at, unsubscribed_at " +
                "FROM newsletter_subscriptions";
        
        if (!includeUnsubscribed) {
            sql += " WHERE status = 'active'";
        }
        
        sql += " ORDER BY subscribed_at DESC";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                items.add(mapResultSetToNewsletterDAO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy danh sách newsletter subscriptions.", e);
        }
        return items;
    }

    @Override
    public boolean unsubscribe(String email) {
        String sql = "UPDATE newsletter_subscriptions SET status = 'unsubscribed', " +
                "unsubscribed_at = CURRENT_TIMESTAMP WHERE email = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi hủy đăng ký newsletter.", e);
        }
    }

    private NewsletterDAO mapResultSetToNewsletterDAO(ResultSet rs) throws SQLException {
        NewsletterDAO item = new NewsletterDAO();
        item.setId(rs.getInt("id"));
        item.setEmail(rs.getString("email"));
        item.setStatus(rs.getString("status"));
        item.setSubscribed_at(rs.getTimestamp("subscribed_at"));
        item.setUnsubscribed_at(rs.getTimestamp("unsubscribed_at"));
        return item;
    }
}

