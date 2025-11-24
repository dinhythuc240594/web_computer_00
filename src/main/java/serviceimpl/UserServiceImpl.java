package serviceimpl;

import model.PageRequest;
import model.UserDAO;
import repository.ReviewRepository;
import repository.UserRepository;
import repositoryimpl.ReviewRepositoryImpl;
import repositoryimpl.UserRepositoryImpl;
import service.UserService;

import javax.sql.DataSource;
import java.util.List;

public class UserServiceImpl implements UserService {

    private UserRepository userRepository;

    public UserServiceImpl(DataSource ds) {
        this.userRepository = new UserRepositoryImpl(ds);
    }

    @Override
    public List<UserDAO> getAll() {
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
    public Boolean create(UserDAO entity) {
        return false;
    }

    @Override
    public UserDAO update(UserDAO entity) {
        return null;
    }
}
