package repository;

import model.PageRequest;
import model.ProductDAO;
import model.ProductSpecDAO;

import java.util.List;

public interface ProductSpecRepository extends Repository<ProductSpecDAO>{

    Boolean deleteByProductId(int id, int productId);
    ProductSpecDAO findByProductId(int id, int productId);
    List<ProductSpecDAO> findAllByProductId(int productId);

}
