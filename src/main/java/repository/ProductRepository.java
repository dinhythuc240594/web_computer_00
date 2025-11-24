package repository;

import model.PageRequest;
import model.ProductDAO;

import java.util.List;

public interface ProductRepository extends Repository<ProductDAO>{

    List<ProductDAO> findAll(PageRequest pageRequest);
    int count(String keyword, int brandId, int categoryId);

}
