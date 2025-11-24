package repositoryimpl;

import model.BrandDAO;
import model.PageRequest;
import model.ProductDAO;
import repository.BrandRepository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class BrandRepositoryImpl implements BrandRepository {

    private final DataSource ds;

    public BrandRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<BrandDAO> getAll(PageRequest pageRequest) {
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

    private BrandDAO mapResultSetToBrandDAO(ResultSet rs) throws SQLException {
        BrandDAO item = new BrandDAO();

        item.setId(rs.getInt("id"));
        item.setName(rs.getString("name"));
        item.setCode(rs.getString("code"));
        item.setIs_active(rs.getBoolean("is_active"));

        return item;
    }

}
