package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.BrandDAO;
import model.CategoryDAO;
import model.Page;
import model.PageRequest;
import model.ProductDAO;
import model.ProductSpecDAO;
import model.ReviewDAO;
import repository.ProductRepository;
import repositoryimpl.ProductRepositoryImpl;
import service.BrandService;
import service.CategoryService;
import service.ProductService;
import service.ProductSpecService;
import service.ReviewService;
import serviceimpl.BrandServiceImpl;
import serviceimpl.CategoryServiceImpl;
import serviceimpl.ProductServiceImpl;
import serviceimpl.ProductSpecServiceImpl;
import serviceimpl.ReviewServiceImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name="product", urlPatterns="/product")
public class ProductServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ProductServlet.class.getName());
    private static final long serialVersionUID = 1L;
    private static final int DEFAULT_PAGE_SIZE = 12;

    private transient DataSource dataSource;
    private transient ProductRepository productRepository;
    private transient ProductService productService;
    private transient CategoryService categoryService;
    private transient BrandService brandService;
    private transient ProductSpecService productSpecService;
    private transient ReviewService reviewService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.productRepository = new ProductRepositoryImpl(dataSource);
        this.productService = new ProductServiceImpl(dataSource);
        this.categoryService = new CategoryServiceImpl(dataSource);
        this.brandService = new BrandServiceImpl(dataSource);
        this.productSpecService = new ProductSpecServiceImpl(dataSource);
        this.reviewService = new ReviewServiceImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra action parameter
        String action = request.getParameter("action");
        
        // Nếu action=list, hiển thị danh sách tất cả sản phẩm
        if ("list".equals(action)) {
            handleListAction(request, response);
            return;
        }

        // Logic hiện tại: hiển thị chi tiết sản phẩm
        // Ưu tiên slug, fallback sang id
        String slug = request.getParameter("slug");
        String idParam = request.getParameter("id");

        ProductDAO product = null;
        Integer productId = null;
        if (slug != null && !slug.isBlank()) {
            product = productRepository.findBySlug(slug);
        } else if (idParam != null && !idParam.isBlank()) {
            try {
                int id = Integer.parseInt(idParam);
                product = productRepository.findById(id);
                productId = id;
            } catch (NumberFormatException ex) {
                product = null;
            }
        }

        if (product == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sản phẩm không tồn tại");
            return;
        }

        if (productId == null && product != null) {
            productId = product.getId();
        }

        List<ReviewDAO> reviews;
        try {
            reviews = reviewService.findByProductId(productId);
        } catch (Exception ex) {
            reviews = Collections.emptyList();
        }

        // Lấy category name
        CategoryDAO category = null;
        if (product.getCategory_id() > 0) {
            try {
                category = categoryService.findById(product.getCategory_id());
            } catch (Exception ex) {
                LOGGER.log(Level.WARNING, "Không thể lấy thông tin category", ex);
            }
        }

        // Lấy brand name
        BrandDAO brand = null;
        if (product.getBrand_id() > 0) {
            try {
                brand = brandService.findById(product.getBrand_id());
            } catch (Exception ex) {
                LOGGER.log(Level.WARNING, "Không thể lấy thông tin brand", ex);
            }
        }

        // Lấy product specs
        List<ProductSpecDAO> productSpecs = Collections.emptyList();
        try {
            productSpecs = productSpecService.findAllByProductId(productId);
        } catch (Exception ex) {
            LOGGER.log(Level.WARNING, "Không thể lấy thông số kỹ thuật sản phẩm", ex);
        }

        request.setAttribute("product", product);
        request.setAttribute("reviews", reviews);
        request.setAttribute("category", category);
        request.setAttribute("brand", brand);
        request.setAttribute("productSpecs", productSpecs);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/product-detail.jsp");
        rd.forward(request, response);
    }

    /**
     * Xử lý action list - hiển thị danh sách tất cả sản phẩm
     */
    private void handleListAction(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Load categories từ database
        List<CategoryDAO> categories = fetchCategories();
        request.setAttribute("categories", categories);

        // Lấy tham số từ request
        String keyword = trimToNull(request.getParameter("keyword"));
        int categoryId = parsePositiveInt(request.getParameter("categoryId"));
        int page = parsePositiveInt(request.getParameter("page"));
        if (page <= 0) {
            page = 1;
        }

        // Đưa lại tham số ra view để giữ trạng thái form
        request.setAttribute("searchKeyword", keyword);
        request.setAttribute("selectedCategoryId", categoryId);
        request.setAttribute("currentPage", page);

        // Tạo PageRequest với phân trang
        // Lấy tất cả sản phẩm (không filter theo category hoặc brand)
        PageRequest pageRequest = new PageRequest(
                page,
                DEFAULT_PAGE_SIZE,
                "created_at",
                "DESC",
                keyword != null ? keyword : "",
                0,
                0,  // Không filter theo category
                0   // Không filter theo brand
        );

        // Lấy kết quả với phân trang
        Page<ProductDAO> productPage = productService.findAll(pageRequest);
        request.setAttribute("productPage", productPage);
        request.setAttribute("products", productPage.getData());

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/category.jsp");
        rd.forward(request, response);
    }

    private List<CategoryDAO> fetchCategories() {
        try {
            return categoryService.getAll();
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Không thể tải danh mục", ex);
            return Collections.emptyList();
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}