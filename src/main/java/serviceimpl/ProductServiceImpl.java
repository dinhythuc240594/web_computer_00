package serviceimpl;

import model.Page;
import model.PageRequest;
import model.ProductDAO;
import repository.OrderRepository;
import repository.ProductRepository;
import repositoryimpl.OrderRepositoryImpl;
import repositoryimpl.ProductRepositoryImpl;
import service.ProductService;

import javax.sql.DataSource;
import java.util.List;

public class ProductServiceImpl implements ProductService {

    private ProductRepository productRepository;

    public ProductServiceImpl(DataSource ds) {
        this.productRepository = new ProductRepositoryImpl(ds);
    }

    @Override
    public Page<ProductDAO> findAll(PageRequest pageRequest) {
        List<ProductDAO> data = this.productRepository.findAll(pageRequest);
        int totalCount = this.count(pageRequest.getKeyword(), pageRequest.getBrandId(), pageRequest.getCategoryId());
        return new Page<>(data, pageRequest.getPage(), totalCount, pageRequest.getPageSize());
    }

    @Override
    public List<ProductDAO> getAll() {
        return List.of();
    }

    @Override
    public ProductDAO findById(int id) {
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
    public Boolean create(ProductDAO entity) {
        return false;
    }

    @Override
    public Boolean update(ProductDAO entity) {
        return false;
    }

    @Override
    public int count(String keyword, int brandId, int categoryId) {
        return this.productRepository.count(keyword, brandId, categoryId);
    }
}
