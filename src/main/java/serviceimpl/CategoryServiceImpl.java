package serviceimpl;

import model.CategoryDAO;
import repository.BrandRepository;
import repository.CategoryRepository;
import repositoryimpl.BrandRepositoryImpl;
import repositoryimpl.CategoryRepositoryImpl;
import service.CategoryService;

import javax.sql.DataSource;
import java.util.List;

public class CategoryServiceImpl implements CategoryService {

    private CategoryRepository categoryRepository;

    public CategoryServiceImpl(DataSource ds) {
        this.categoryRepository = new CategoryRepositoryImpl(ds);
    }

    @Override
    public List<CategoryDAO> getAll() {
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
