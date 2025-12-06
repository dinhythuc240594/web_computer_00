package serviceimpl;

import model.WishlistDAO;
import repository.WishlistRepository;
import repositoryimpl.WishlistRepositoryImpl;
import service.WishlistService;

import javax.sql.DataSource;
import java.util.List;

public class WishlistServiceImpl implements WishlistService {

    private final WishlistRepository wishlistRepository;

    public WishlistServiceImpl(DataSource ds) {
        this.wishlistRepository = new WishlistRepositoryImpl(ds);
    }

    @Override
    public List<WishlistDAO> getAll() {
        return wishlistRepository.getAll();
    }

    @Override
    public WishlistDAO findById(int id) {
        return wishlistRepository.findById(id);
    }

    @Override
    public Boolean deleteById(int id) {
        return wishlistRepository.deleteById(id);
    }

    @Override
    public int count(String keyword) {
        return wishlistRepository.count(keyword);
    }

    @Override
    public Boolean create(WishlistDAO entity) {
        return wishlistRepository.create(entity);
    }

    @Override
    public Boolean update(WishlistDAO entity) {
        return wishlistRepository.update(entity);
    }

    @Override
    public List<WishlistDAO> findByUserId(int userId) {
        return wishlistRepository.findByUserId(userId);
    }

    @Override
    public Boolean existsByUserIdAndProductId(int userId, int productId) {
        return wishlistRepository.existsByUserIdAndProductId(userId, productId);
    }

    @Override
    public Boolean deleteByUserIdAndProductId(int userId, int productId) {
        return wishlistRepository.deleteByUserIdAndProductId(userId, productId);
    }
}

