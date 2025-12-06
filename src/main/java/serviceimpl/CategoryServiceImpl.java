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
        return categoryRepository.findById(id);
    }

    @Override
    public Boolean deleteById(int id) {
        return categoryRepository.deleteById(id);
    }

    @Override
    public int count(String keyword) {
        return categoryRepository.count(keyword);
    }

    @Override
    public Boolean create(CategoryDAO entity) {
        return categoryRepository.create(entity);
    }

    @Override
    public Boolean update(CategoryDAO entity) {
        return categoryRepository.update(entity);
    }

    @Override
    public List<CategoryDAO> getAll() {
        return categoryRepository.getAll();
    }

    @Override
    public Page<CategoryDAO> findAll(PageRequest pageRequest) {
        List<CategoryDAO> data = this.categoryRepository.findAll(pageRequest);
        int totalCount = this.count(pageRequest.getKeyword());
        return new Page<>(data, pageRequest.getPage(), totalCount, pageRequest.getPageSize());
    }
}
