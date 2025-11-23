package repositoryimpl;

import model.CategoryDAO;
import model.PageRequest;
import repository.CategoryRepository;

import javax.sql.DataSource;
import java.util.List;

public class CategoryRepositoryImpl implements CategoryRepository {

    private final DataSource ds;

    public CategoryRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<CategoryDAO> getAll(PageRequest pageRequest) {
        return List.of();
    }

    @Override
    public CategoryDAO findById(int id) {
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
    public CategoryDAO create(CategoryDAO entity) {
        return null;
    }

    @Override
    public CategoryDAO update(CategoryDAO entity) {
        return null;
    }
}
