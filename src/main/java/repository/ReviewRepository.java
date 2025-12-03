package repository;

import model.ReviewDAO;

public interface ReviewRepository extends Repository<ReviewDAO>{

    /**
     * Lấy tất cả review của một sản phẩm theo product_id.
     */
    java.util.List<ReviewDAO> findByProductId(int productId);
}