package repositoryimpl;

import model.BrandDAO;
import model.CategoryDAO;
import model.PageRequest;
import repository.CategoryRepository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class CategoryRepositoryImpl implements CategoryRepository {

    private final DataSource ds;

    public CategoryRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<CategoryDAO> getAll(PageRequest pageRequest) {
        return List.of();
    }

    @Override
    public CategoryDAO findById(int id) {
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
    public Boolean create(CategoryDAO entity) {
        return false;
    }

    @Override
    public CategoryDAO update(CategoryDAO entity) {
        return null;
    }

    private CategoryDAO mapResultSetToCategoryDAO(ResultSet rs) throws SQLException {
        CategoryDAO item = new CategoryDAO();

        item.setId(rs.getInt("id"));
        item.setName(rs.getString("name"));
        item.setDescription(rs.getString("description"));
        item.setIs_active(rs.getBoolean("is_active"));

        return item;
    }

}
