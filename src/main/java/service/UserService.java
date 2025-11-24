package service;

import model.Page;
import model.PageRequest;
import model.ProductDAO;
import model.UserDAO;

public interface UserService extends Service<UserDAO>{

    Page<UserDAO> findAll(PageRequest pageRequest);

}
