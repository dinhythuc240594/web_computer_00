package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.BrandDAO;
import model.Page;
import model.PageRequest;
import model.ProductDAO;
import service.BrandService;
import service.ProductService;
import serviceimpl.BrandServiceImpl;
import serviceimpl.ProductServiceImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name="brand", urlPatterns="/brand")
public class BrandServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(BrandServlet.class.getName());
    private static final long serialVersionUID = 1L;
    private static final int DEFAULT_PAGE_SIZE = 12;

    private transient DataSource dataSource;
    private transient ProductService productService;
    private transient BrandService brandService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.productService = new ProductServiceImpl(dataSource);
        this.brandService = new BrandServiceImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Load brands từ database
        List<BrandDAO> brands = fetchBrands();
        request.setAttribute("brands", brands);

        // Lấy tham số từ request
        String keyword = trimToNull(request.getParameter("keyword"));
        int brandId = parsePositiveInt(request.getParameter("brandId"));
        int page = parsePositiveInt(request.getParameter("page"));
        if (page <= 0) {
            page = 1;
        }

        // Đưa lại tham số ra view để giữ trạng thái form
        request.setAttribute("searchKeyword", keyword);
        request.setAttribute("selectedBrandId", brandId);
        request.setAttribute("currentPage", page);

        // Tạo PageRequest với phân trang
        // Nếu brandId = 0, sẽ lấy tất cả sản phẩm từ tất cả thương hiệu
        PageRequest pageRequest = new PageRequest(
                page,
                DEFAULT_PAGE_SIZE,
                "created_at",
                "DESC",
                keyword != null ? keyword : "",
                0,
                0,  // Không filter theo category trong BrandServlet
                brandId > 0 ? brandId : 0  // Nếu brandId = 0, không filter theo brand
        );

        // Lấy kết quả với phân trang
        Page<ProductDAO> productPage = productService.findAll(pageRequest);
        request.setAttribute("productPage", productPage);
        request.setAttribute("products", productPage.getData());

        // Lấy thông tin brand nếu có
        if (brandId > 0) {
            BrandDAO selectedBrand = brandService.findById(brandId);
            request.setAttribute("selectedBrand", selectedBrand);
        }

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/brand.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển POST sang GET để xử lý
        doGet(request, response);
    }

    private List<BrandDAO> fetchBrands() {
        try {
            return brandService.getAll();
        } catch (Exception ex) {
            LOGGER.log(Level.SEVERE, "Không thể tải thương hiệu", ex);
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