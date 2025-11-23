package serviceimpl;

import model.ProductDAO;
import repository.BrandRepository;
import repositoryimpl.BrandRepositoryImpl;
import service.ProductService;

import javax.sql.DataSource;
import java.util.List;

public class BrandServiceImpl implements ProductService {

    private BrandRepository brandRepository;

    public BrandServiceImpl(DataSource ds) {
        this.brandRepository = new BrandRepositoryImpl(ds);
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
