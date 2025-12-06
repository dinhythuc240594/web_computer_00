package serviceimpl;

import model.PageRequest;
import model.ProductSpecDAO;
import repository.ProductRepository;
import repository.ProductSpecRepository;
import repositoryimpl.ProductRepositoryImpl;
import repositoryimpl.ProductSpecRepositoryImpl;
import service.ProductSpecService;

import javax.sql.DataSource;
import java.util.List;

public class ProductSpecServiceImpl implements ProductSpecService {

    private ProductSpecRepository productSpecRepository;

    public ProductSpecServiceImpl(DataSource ds) {
        this.productSpecRepository = new ProductSpecRepositoryImpl(ds);
    }

    @Override
    public List<ProductSpecDAO> getAll() {
        return List.of();
    }

    @Override
    public ProductSpecDAO findById(int id) {
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
    public Boolean create(ProductSpecDAO entity) {
        return false;
    }

    @Override
    public Boolean update(ProductSpecDAO entity) {
        return false;
    }

    @Override
    public List<ProductSpecDAO> findAllByProductId(int productId) {
        return productSpecRepository.findAllByProductId(productId);
    }
}
