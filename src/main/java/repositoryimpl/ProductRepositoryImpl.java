package repositoryimpl;

import model.ProductDAO;
import repository.ProductRepository;

import javax.sql.DataSource;
import java.util.List;

public class ProductRepositoryImpl implements ProductRepository {

    private final DataSource ds;

    public ProductRepositoryImpl(DataSource ds) {
        this.ds = ds;
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
