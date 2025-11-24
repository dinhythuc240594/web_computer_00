package repositoryimpl;

import model.PageRequest;
import model.ReviewDAO;
import model.UserDAO;
import repository.UserRepository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class UserRepositoryImpl implements UserRepository {

    private final DataSource ds;

    public UserRepositoryImpl(DataSource ds) {
        this.ds = ds;
    }

    @Override
    public List<UserDAO> getAll(PageRequest pageRequest) {
        return List.of();
    }

    @Override
    public UserDAO findById(int id) {
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
    public UserDAO create(UserDAO entity) {
        return null;
    }

    @Override
    public UserDAO update(UserDAO entity) {
        return null;
    }

    private UserDAO mapResultSetToUserDAO(ResultSet rs) throws SQLException {
        UserDAO item = new UserDAO();

        item.setId(rs.getInt("id"));
        item.setUsername(rs.getString("username"));
        item.setPassword(rs.getString("password"));
        item.setEmail(rs.getString("email"));
        item.setRole(rs.getString("role"));
        item.setAddress(rs.getString("address"));
        item.setPhone(rs.getString("phone"));
        item.setFullname(rs.getString("fullname"));
        item.setIsActive(rs.getBoolean("isActive"));

        return item;
    }

}
