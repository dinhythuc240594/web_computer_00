package repositoryimpl;

import model.PageRequest;
import model.ProductDAO;
import model.ProductSpecDAO;
import repository.ProductSpecRepository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class ProductSpecRepositoryImpl implements ProductSpecRepository {

    private final DataSource ds;

    public ProductSpecRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<ProductSpecDAO> getAll(PageRequest pageRequest) {
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
    public ProductSpecDAO update(ProductSpecDAO entity) {
        return null;
    }

    private ProductSpecDAO mapResultSetToProductSpecDAO(ResultSet rs) throws SQLException {
        ProductSpecDAO item = new ProductSpecDAO();

        item.setId(rs.getInt("id"));
        item.setName(rs.getString("name"));
        item.setDescription(rs.getString("description"));
        item.setValue(rs.getInt("value"));

        return item;
    }

}
