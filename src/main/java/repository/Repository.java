package repository;

import java.util.List;

public interface Repository<T> {

    List<T> getAll();
    T findById(int id);
    Boolean deleteById(int id);
    int count(String keyword);
    T create(T entity);
    T update(T entity);

}
