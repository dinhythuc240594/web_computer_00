package repository;

import model.CategoryDAO;
import model.PageRequest;

import java.util.List;

public interface CategoryRepository extends Repository<CategoryDAO>{
    List<CategoryDAO> findAll(PageRequest pageRequest);
    int count(String keyword);
}
