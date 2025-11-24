package service;

import model.Page;
import model.PageRequest;
import model.ProductDAO;

public interface ProductService extends Service<ProductDAO>{

    Page<ProductDAO> findAll(PageRequest pageRequest);
    public int count(String keyword, int brandId, int categoryId);

}
