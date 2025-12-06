package service;

import model.ProductSpecDAO;

import java.util.List;

public interface ProductSpecService extends Service<ProductSpecDAO>{
    List<ProductSpecDAO> findAllByProductId(int productId);
}
