package repositoryimpl;

import model.PageRequest;
import model.UserDAO;
import repository.UserRepository;

import javax.sql.DataSource;
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
}
