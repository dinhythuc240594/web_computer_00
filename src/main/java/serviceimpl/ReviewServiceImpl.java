package serviceimpl;

import model.PageRequest;
import model.ReviewDAO;
import repository.ProductSpecRepository;
import repository.ReviewRepository;
import repositoryimpl.ProductSpecRepositoryImpl;
import repositoryimpl.ReviewRepositoryImpl;
import service.ReviewService;

import javax.sql.DataSource;
import java.util.List;

public class ReviewServiceImpl implements ReviewService {

    private ReviewRepository reviewRepository;

    public ReviewServiceImpl(DataSource ds) {
        this.reviewRepository = new ReviewRepositoryImpl(ds);
    }

    @Override
    public List<ReviewDAO> getAll() {
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
    public Boolean create(ReviewDAO entity) {
        return false;
    }

    @Override
    public Boolean update(ReviewDAO entity) {
        return false;
    }
}
