package serviceimpl;

import model.BrandDAO;
import model.Page;
import model.PageRequest;
import model.ProductDAO;
import repository.BrandRepository;
import repositoryimpl.BrandRepositoryImpl;
import service.BrandService;
import service.ProductService;

import javax.sql.DataSource;
import java.util.List;

public class BrandServiceImpl implements BrandService {

    private BrandRepository brandRepository;

    public BrandServiceImpl(DataSource ds) {
        this.brandRepository = new BrandRepositoryImpl(ds);
    }

    @Override
    public List<BrandDAO> getAll() {
        return List.of();
    }

    @Override
    public BrandDAO findById(int id) {
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
    public Boolean create(BrandDAO entity) {
        return false;
    }

    @Override
    public BrandDAO update(BrandDAO entity) {
        return null;
    }
}
