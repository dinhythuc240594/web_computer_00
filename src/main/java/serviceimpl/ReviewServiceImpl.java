package serviceimpl;

import model.ReviewDAO;
import repository.ReviewRepository;
import repositoryimpl.ReviewRepositoryImpl;
import service.ReviewService;

import javax.sql.DataSource;
import java.util.List;

public class ReviewServiceImpl implements ReviewService {

    private final ReviewRepository reviewRepository;

    public ReviewServiceImpl(DataSource ds) {
        this.reviewRepository = new ReviewRepositoryImpl(ds);
    }

    @Override
    public List<ReviewDAO> getAll() {
        return reviewRepository.getAll();
    }

    @Override
    public ReviewDAO findById(int id) {
        return reviewRepository.findById(id);
    }

    @Override
    public Boolean deleteById(int id) {
        return reviewRepository.deleteById(id);
    }

    @Override
    public int count(String keyword) {
        return reviewRepository.count(keyword);
    }

    @Override
    public Boolean create(ReviewDAO entity) {
        return reviewRepository.create(entity);
    }

    @Override
    public Boolean update(ReviewDAO entity) {
        return reviewRepository.update(entity);
    }
}
