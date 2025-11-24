package repository;

import model.PageRequest;
import model.ProductDAO;
import model.UserDAO;

import java.util.List;

public interface UserRepository extends Repository<UserDAO>{

    List<UserDAO> findAll(PageRequest pageRequest);

}
