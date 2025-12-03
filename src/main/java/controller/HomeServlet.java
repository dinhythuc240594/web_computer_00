package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.BrandDAO;
import model.CategoryDAO;
import model.NewsItem;
import model.PageRequest;
import model.ProductDAO;
import repository.BrandRepository;
import repository.CategoryRepository;
import repository.ProductRepository;
import repositoryimpl.BrandRepositoryImpl;
import repositoryimpl.CategoryRepositoryImpl;
import repositoryimpl.ProductRepositoryImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(HomeServlet.class.getName());
    private static final long serialVersionUID = 1L;
    private static final int FEATURED_PRODUCT_LIMIT = 8;
    private static final int FLASH_SALE_PRODUCT_LIMIT = 6;
    private static final int POPULAR_PRODUCT_LIMIT = 10;
    private static final int TOP_SOLD_LIMIT = 6;
    private static final int NEWS_LIMIT = 4;

    private transient DataSource dataSource;
    private transient ProductRepository productRepository;
    private transient CategoryRepository categoryRepository;
    private transient BrandRepository brandRepository;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.productRepository = new ProductRepositoryImpl(dataSource);
        this.categoryRepository = new CategoryRepositoryImpl(dataSource);
        this.brandRepository = new BrandRepositoryImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Dữ liệu dùng chung cho trang home
        request.setAttribute("homeCategories", fetchCategories());
        request.setAttribute("homeBrands", fetchBrands());

        // Xử lý tham số tìm kiếm & lọc (keyword, categoryId, brandId)
        String keyword = trimToNull(request.getParameter("keyword"));
        int categoryId = parsePositiveInt(request.getParameter("categoryId"));
        int brandId = parsePositiveInt(request.getParameter("brandId"));

        // Đưa lại tham số ra view để giữ trạng thái form
        request.setAttribute("searchKeyword", keyword);
        request.setAttribute("selectedCategoryId", categoryId);
        request.setAttribute("selectedBrandId", brandId);

        // Nếu có bất kỳ tham số tìm kiếm / lọc nào thì load danh sách sản phẩm phù hợp
        if ((keyword != null && !keyword.isBlank()) || categoryId > 0 || brandId > 0) {
            request.setAttribute("searchResults", fetchFilteredProducts(keyword, categoryId, brandId));
        }

        request.setAttribute("featuredProducts", fetchProducts("created_at", "DESC", FEATURED_PRODUCT_LIMIT));
        request.setAttribute("flashSaleProducts", fetchProducts("price", "ASC", FLASH_SALE_PRODUCT_LIMIT));
        request.setAttribute("popularProducts", fetchProducts("stock_quantity", "DESC", POPULAR_PRODUCT_LIMIT));
        request.setAttribute("topSoldProducts", fetchProducts("stock_quantity", "ASC", TOP_SOLD_LIMIT));
        request.setAttribute("homeNews", buildNewsItems());

        populateDbStatus(request);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/home.jsp");
        rd.forward(request, response);
    }

    private List<ProductDAO> fetchFilteredProducts(String keyword, int categoryId, int brandId) {
        try {
            // Giới hạn số kết quả hiển thị trên trang home
            int pageSize = 20;
            PageRequest pageRequest = new PageRequest(
                    1,
                    Math.max(pageSize, 1),
                    "created_at",
                    "DESC",
                    keyword != null ? keyword : "",
                    0,
                    categoryId,
                    brandId
            );
            return productRepository.findAll(pageRequest);
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Không thể tải danh sách sản phẩm theo điều kiện tìm kiếm", ex);
            return Collections.emptyList();
        }
    }

    private List<CategoryDAO> fetchCategories() {
        try {
            return categoryRepository.getAll();
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Không thể tải danh mục", ex);
            return Collections.emptyList();
        }
    }

    private List<BrandDAO> fetchBrands() {
        try {
            return brandRepository.getAll();
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Không thể tải thương hiệu", ex);
            return Collections.emptyList();
        }
    }

    private List<ProductDAO> fetchProducts(String sortField, String orderField, int limit) {
        try {
            PageRequest pageRequest = new PageRequest(1, Math.max(limit, 1), sanitizeSortField(sortField),
                    sanitizeOrderField(orderField), "");
            return productRepository.findAll(pageRequest);
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Không thể tải danh sách sản phẩm", ex);
            return Collections.emptyList();
        }
    }

    private String sanitizeSortField(String sortField) {
        if (sortField == null) {
            return "created_at";
        }
        return switch (sortField) {
            case "price", "name", "created_at", "stock_quantity" -> sortField;
            default -> "created_at";
        };
    }

    private String sanitizeOrderField(String orderField) {
        if (orderField == null) {
            return "DESC";
        }
        return "ASC".equalsIgnoreCase(orderField) ? "ASC" : "DESC";
    }

    private void populateDbStatus(HttpServletRequest request) {
        if (dataSource == null) {
            request.setAttribute("dbStatusOk", false);
            request.setAttribute("dbStatusMessage", "Datasource chưa được cấu hình.");
            request.setAttribute("dbStatusDetails", "Vui lòng kiểm tra cấu hình JNDI jdbc/computerStoreDS.");
            return;
        }

        try (Connection connection = dataSource.getConnection()) {
            DatabaseMetaData metaData = connection.getMetaData();
            request.setAttribute("dbStatusOk", true);
            request.setAttribute("dbStatusMessage", "Đã kết nối tới cơ sở dữ liệu.");
            request.setAttribute("dbStatusDetails",
                    String.format("%s %s | Driver: %s | User: %s",
                            metaData.getDatabaseProductName(),
                            metaData.getDatabaseProductVersion(),
                            metaData.getDriverName(),
                            metaData.getUserName()));
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Không thể kết nối tới cơ sở dữ liệu", ex);
            request.setAttribute("dbStatusOk", false);
            request.setAttribute("dbStatusMessage", "Không thể kết nối tới cơ sở dữ liệu.");
            request.setAttribute("dbStatusDetails", ex.getMessage());
        }
    }

    private String trimToNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private int parsePositiveInt(String value) {
        if (value == null || value.isBlank()) {
            return 0;
        }
        try {
            int parsed = Integer.parseInt(value);
            return Math.max(parsed, 0);
        } catch (NumberFormatException ex) {
            return 0;
        }
    }

    private List<NewsItem> buildNewsItems() {
        List<ProductDAO> latestProducts = fetchProducts("created_at", "DESC", NEWS_LIMIT);
        if (!latestProducts.isEmpty()) {
            return latestProducts.stream()
                    .map(this::mapProductToNewsItem)
                    .toList();
        }
        return List.of(
                new NewsItem(
                        "HCMUTE Computer chào đón bạn",
                        "Khám phá không gian mua sắm thiết bị công nghệ với nhiều ưu đãi độc quyền cho sinh viên HCMUTE.",
                        "Thông báo",
                        "Đội ngũ HCMUTE",
                        "/assets/client/images/news/news-1.jpg",
                        "#"
                ),
                new NewsItem(
                        "Cập nhật kho mới mỗi tuần",
                        "Chúng tôi liên tục bổ sung laptop, linh kiện và phụ kiện mới nhằm đáp ứng nhu cầu học tập và làm việc.",
                        "Tin tức",
                        "HCMUTE Store",
                        "/assets/client/images/news/news-2.jpg",
                        "#"
                )
        );
    }

    private NewsItem mapProductToNewsItem(ProductDAO product) {
        String summary = truncateText(product.getDescription());
        String imagePath = normalizeImagePath(product.getImage_url());
        String productLink = product.getSlug() != null && !product.getSlug().isBlank()
                ? "/product?slug=" + product.getSlug()
                : "/product?id=" + product.getId();

        return new NewsItem(
                product.getName(),
                summary,
                "Sản phẩm mới",
                "HCMUTE Store",
                imagePath,
                productLink
        );
    }

    private String truncateText(String text) {
        if (text == null || text.isBlank()) {
            return "Chi tiết sản phẩm đang được cập nhật.";
        }
        text = text.trim();
        int limit = 130;
        if (text.length() <= limit) {
            return text;
        }
        return text.substring(0, limit - 3) + "...";
    }

    private String normalizeImagePath(String imagePath) {
        if (imagePath == null || imagePath.isBlank()) {
            return "/assets/client/images/news/news-1.jpg";
        }
        if (!imagePath.startsWith("http") && !imagePath.startsWith("/")) {
            return "/" + imagePath;
        }
        return imagePath;
    }
}
