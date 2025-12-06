package service;

import model.CategoryDAO;
import model.Page;
import model.PageRequest;

public interface CategoryService extends Service<CategoryDAO>{
    Page<CategoryDAO> findAll(PageRequest pageRequest);
}
