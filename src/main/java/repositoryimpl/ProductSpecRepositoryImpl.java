package repositoryimpl;

import model.ProductSpecDAO;
import repository.ProductSpecRepository;

import javax.sql.DataSource;
import java.util.List;

public class ProductSpecRepositoryImpl implements ProductSpecRepository {

    private final DataSource ds;

    public ProductSpecRepositoryImpl(DataSource ds) {
        this.ds = ds;
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
    public ProductSpecDAO create(ProductSpecDAO entity) {
        return null;
    }

    @Override
    public ProductSpecDAO update(ProductSpecDAO entity) {
        return null;
    }
}
