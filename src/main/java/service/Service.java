package service;

import model.Page;
import model.PageRequest;

import java.util.List;

public interface Service <T>{

    Page<T> getAll(PageRequest pageRequest);
    T findById(int id);
    Boolean deleteById(int id);
    int count(String keyword);
    T create(T entity);
    T update(T entity);

}
