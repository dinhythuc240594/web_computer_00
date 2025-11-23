package repositoryimpl;

import model.BrandDAO;
import repository.BrandRepository;

import javax.sql.DataSource;
import java.util.List;

public class BrandRepositoryImpl implements BrandRepository {

    private final DataSource ds;

    public BrandRepositoryImpl(DataSource ds) {
        this.ds = ds;
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
    public BrandDAO create(BrandDAO entity) {
        return null;
    }

    @Override
    public BrandDAO update(BrandDAO entity) {
        return null;
    }
}
