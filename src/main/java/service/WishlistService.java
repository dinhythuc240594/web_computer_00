package service;

import model.WishlistDAO;

import java.util.List;

public interface WishlistService extends Service<WishlistDAO> {
    List<WishlistDAO> findByUserId(int userId);
    Boolean existsByUserIdAndProductId(int userId, int productId);
    Boolean deleteByUserIdAndProductId(int userId, int productId);
}

