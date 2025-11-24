package service;

import model.Page;
import model.PageRequest;

import java.util.List;

public interface Service <T>{

    List<T> getAll();
    T findById(int id);
    Boolean deleteById(int id);
    int count(String keyword);
    Boolean create(T entity);
    Boolean update(T entity);

}
