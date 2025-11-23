package repositoryimpl;

import model.ReviewDAO;
import repository.ReviewRepository;

import javax.sql.DataSource;
import java.util.List;

public class ReviewRepositoryImpl implements ReviewRepository {

    private final DataSource ds;

    public ReviewRepositoryImpl(DataSource ds) {
        this.ds = ds;
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
    public ReviewDAO create(ReviewDAO entity) {
        return null;
    }

    @Override
    public ReviewDAO update(ReviewDAO entity) {
        return null;
    }
}
