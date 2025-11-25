package repositoryimpl;

import model.PageRequest;
import model.ProductSpecDAO;
import model.ReviewDAO;
import repository.ReviewRepository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReviewRepositoryImpl implements ReviewRepository {

    private final DataSource ds;

    public ReviewRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<ReviewDAO> getAll() {
        List<ReviewDAO> items = new ArrayList<>();
        String sql = "SELECT id, user_id, product_id, rating, comment, created_at, updated_at FROM reviews";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery(sql)) {

            while (rs.next()) {
                items.add(mapResultSetToReviewDAO(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi lấy tất cả chi tiết đơn hàng.", e);
        }
        return items;
    }

    @Override
    public ReviewDAO findById(int id) {

        String sql = "SELECT id, user_id, product_id, rating, comment, created_at, updated_at "
                + "FROM reviews WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToReviewDAO(rs);
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

        String sql = "UPDATE reviews SET is_active = ? WHERE id = ?";
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
    public Boolean create(ReviewDAO entity) {

        String sql = "INSERT INTO reviews (user_id, product_id, rating, comment "
                    +"VALUES (?, ?, ?, ?)";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, entity.getUserId());
            ps.setInt(2, entity.getProductId());
            ps.setInt(3, entity.getRating());
            ps.setString(4, entity.getComment());

            ps.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Boolean update(ReviewDAO entity) {

        String sql = "UPDATE orders SET user_id = ?, product_id = ?, rating = ?, comment = ?, "
                + "WHERE id = ?";

        try (Connection conn = ds.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, entity.getUserId());
            ps.setInt(2, entity.getProductId());
            ps.setInt(3, entity.getRating());
            ps.setString(4, entity.getComment());
            ps.setInt(5, entity.getId());

            ps.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

    }

    private ReviewDAO mapResultSetToReviewDAO(ResultSet rs) throws SQLException {
        ReviewDAO item = new ReviewDAO();

        item.setId(rs.getInt("id"));
        item.setComment(rs.getString("comment"));
        item.setRating(rs.getInt("rating"));
        item.setUserId(rs.getInt("user_id"));
        item.setProductId(rs.getInt("product_id"));

        return item;
    }

}
