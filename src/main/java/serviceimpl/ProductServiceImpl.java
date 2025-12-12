package serviceimpl;

import java.util.List;

import javax.sql.DataSource;

import model.Page;
import model.PageRequest;
import model.ProductDAO;
import repository.ProductRepository;
import repositoryimpl.ProductRepositoryImpl;
import service.ProductService;

public class ProductServiceImpl implements ProductService {

    private ProductRepository productRepository;

    public ProductServiceImpl(DataSource ds) {
        this.productRepository = new ProductRepositoryImpl(ds);
    }

    @Override
    public Page<ProductDAO> findAll(PageRequest pageRequest) {
        List<ProductDAO> data = this.productRepository.findAll(pageRequest);
        int totalCount = this.count(pageRequest.getKeyword(), pageRequest.getBrandId(), pageRequest.getCategoryId(), pageRequest.getIsActive());
        return new Page<>(data, pageRequest.getPage(), totalCount, pageRequest.getPageSize());
    }

    @Override
    public List<ProductDAO> getAll() {
        return this.productRepository.getAll();
    }

    @Override
    public ProductDAO findById(int id) {
        return this.productRepository.findById(id);
    }

    @Override
    public Boolean deleteById(int id) {
        return this.productRepository.deleteById(id);
    }

    @Override
    public int count(String keyword) {
        return this.productRepository.count(keyword);
    }

    @Override
    public Boolean create(ProductDAO entity) {
        return this.productRepository.create(entity);
    }

    @Override
    public Boolean update(ProductDAO entity) {
        return this.productRepository.update(entity);
    }

    @Override
    public int count(String keyword, int brandId, int categoryId) {
        return this.productRepository.count(keyword, brandId, categoryId);
    }

    @Override
    public int count(String keyword, int brandId, int categoryId, Boolean isActive) {
        return this.productRepository.count(keyword, brandId, categoryId, isActive);
    }
}
