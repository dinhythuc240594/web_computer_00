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
        return brandRepository.getAll();
    }

    @Override
    public BrandDAO findById(int id) {
        return brandRepository.findById(id);
    }

    @Override
    public Boolean deleteById(int id) {
        return brandRepository.deleteById(id);
    }

    @Override
    public int count(String keyword) {
        return brandRepository.count(keyword);
    }

    @Override
    public Boolean create(BrandDAO entity) {
        return brandRepository.create(entity);
    }

    @Override
    public Boolean update(BrandDAO entity) {
        return brandRepository.update(entity);
    }
}
