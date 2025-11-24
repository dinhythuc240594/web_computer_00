package repositoryimpl;

import model.PageRequest;
import model.ProductSpecDAO;
import model.ReviewDAO;
import repository.ReviewRepository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class ReviewRepositoryImpl implements ReviewRepository {

    private final DataSource ds;

    public ReviewRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<ReviewDAO> getAll(PageRequest pageRequest) {
        return List.of();
    }

    @Override
    public ReviewDAO findById(int id) {
        return null;
    }

    @Override
    public Boolean deleteById(int id) {
        return null;
    }

    @Override
    public int count(String keyword) {
        return 0;
    }

    @Override
    public ReviewDAO create(ReviewDAO entity) {
        return null;
    }

    @Override
    public ReviewDAO update(ReviewDAO entity) {
        return null;
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
