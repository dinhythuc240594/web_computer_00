package service;

import model.ProductDAO;

public interface ProductService extends Service<ProductDAO>{

    public int count(String keyword, int brandId, int categoryId);

}
