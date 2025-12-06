package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CategoryDAO;
import model.Page;
import model.PageRequest;
import model.ProductDAO;
import repository.CategoryRepository;
import repositoryimpl.CategoryRepositoryImpl;
import service.CategoryService;
import service.ProductService;
import serviceimpl.CategoryServiceImpl;
import serviceimpl.ProductServiceImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "shop", urlPatterns = "/shop")
public class ShopServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ShopServlet.class.getName());
    private static final long serialVersionUID = 1L;
    private static final int DEFAULT_PAGE_SIZE = 12;

    private transient DataSource dataSource;
    private transient ProductService productService;
    private transient CategoryService categoryService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.productService = new ProductServiceImpl(dataSource);
        this.categoryService = new CategoryServiceImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        PageRequest pageRequest = new PageRequest(
                page,
                DEFAULT_PAGE_SIZE,
                "created_at",
                "DESC",
                keyword != null ? keyword : "",
                0,
                categoryId,
                0
        );

        // Lấy kết quả tìm kiếm với phân trang
        Page<ProductDAO> productPage = productService.findAll(pageRequest);
        request.setAttribute("productPage", productPage);
        request.setAttribute("products", productPage.getData());

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/shop.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển POST sang GET để xử lý
        doGet(request, response);
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
}

