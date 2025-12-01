package repository;

import model.PageRequest;
import model.ProductDAO;

import java.util.List;

public interface ProductRepository extends Repository<ProductDAO>{

    List<ProductDAO> findAll(PageRequest pageRequest);

    /**
     * Đếm tổng số bản ghi theo điều kiện lọc.
     */
    int count(String keyword, int brandId, int categoryId);

    /**
     * Tìm sản phẩm theo slug (dùng cho trang chi tiết sản phẩm SEO friendly).
     */
    ProductDAO findBySlug(String slug);

}
