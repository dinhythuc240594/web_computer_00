package service;

import model.BrandDAO;
import model.Page;
import model.PageRequest;

public interface BrandService extends Service<BrandDAO>{
    Page<BrandDAO> findAll(PageRequest pageRequest);
}
