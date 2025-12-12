package repository;

import java.util.List;

import model.PageRequest;
import model.ProductDAO;

public interface ProductRepository extends Repository<ProductDAO>{

    List<ProductDAO> findAll(PageRequest pageRequest);

    /**
     * Đếm tổng số bản ghi theo điều kiện lọc.
     */
    int count(String keyword, int brandId, int categoryId);
    int count(String keyword, int brandId, int categoryId, Boolean isActive);

    /**
     * Tìm sản phẩm theo slug (dùng cho trang chi tiết sản phẩm SEO friendly).
     */
    ProductDAO findBySlug(String slug);

}
