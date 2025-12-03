package service;

import model.ReviewDAO;

public interface ReviewService extends  Service<ReviewDAO>{

    /**
     * Lấy tất cả review cho một sản phẩm.
     */
    java.util.List<ReviewDAO> findByProductId(int productId);
}
