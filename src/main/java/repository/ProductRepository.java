package repository;

import model.ProductDAO;

public interface ProductRepository extends Repository<ProductDAO>{

    public int count(String keyword, int brandId, int categoryId);

}
