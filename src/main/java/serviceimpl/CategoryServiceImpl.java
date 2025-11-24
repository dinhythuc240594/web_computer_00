package serviceimpl;

import model.CategoryDAO;
import model.Page;
import model.PageRequest;
import repository.BrandRepository;
import repository.CategoryRepository;
import repositoryimpl.BrandRepositoryImpl;
import repositoryimpl.CategoryRepositoryImpl;
import service.CategoryService;

import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.List;

public class CategoryServiceImpl implements CategoryService {

    private CategoryRepository categoryRepository;

    public CategoryServiceImpl(DataSource ds) {
        this.categoryRepository = new CategoryRepositoryImpl(ds);
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
    public Boolean create(CategoryDAO entity) {
        return null;
    }

    @Override
    public CategoryDAO update(CategoryDAO entity) {
        return null;
    }

    @Override
    public List<CategoryDAO> getAll() {
        return List.of();
    }
}
