package repository;

import model.WishlistDAO;

import java.util.List;

public interface WishlistRepository extends Repository<WishlistDAO> {
    List<WishlistDAO> findByUserId(int userId);
    Boolean existsByUserIdAndProductId(int userId, int productId);
    Boolean deleteByUserIdAndProductId(int userId, int productId);
}

