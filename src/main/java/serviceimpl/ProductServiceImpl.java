package serviceimpl;

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
    public ProductDAO create(ProductDAO entity) {
        return null;
    }

    @Override
    public ProductDAO update(ProductDAO entity) {
        return null;
    }
}
