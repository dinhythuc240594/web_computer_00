package serviceimpl;

import model.Page;
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
        return userRepository.getAll();
    }

    @Override
    public UserDAO findById(int id) {
        return userRepository.findById(id);
    }

    @Override
    public Boolean deleteById(int id) {
        return userRepository.deleteById(id);
    }

    @Override
    public int count(String keyword) {
        return userRepository.count(keyword);
    }

    @Override
    public Boolean create(UserDAO entity) {
        return userRepository.create(entity);
    }

    @Override
    public Boolean update(UserDAO entity) {
        return userRepository.update(entity);
    }

    @Override
    public Page<UserDAO> findAll(PageRequest pageRequest) {
        // Chưa dùng phân trang cho user, có thể triển khai sau
        return null;
    }

    @Override
    public UserDAO findByUsername(String username) {
        return userRepository.findByUsername(username);
    }
}
