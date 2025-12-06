package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.OrderDAO;
import model.ProductDAO;
import model.CategoryDAO;
import model.BrandDAO;
import model.UserDAO;
import model.Page;
import model.PageRequest;
import service.OrderService;
import service.ProductService;
import service.CategoryService;
import service.BrandService;
import service.UserService;
import serviceimpl.OrderServiceImpl;
import serviceimpl.ProductServiceImpl;
import serviceimpl.CategoryServiceImpl;
import serviceimpl.BrandServiceImpl;
import serviceimpl.UserServiceImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "staff", urlPatterns = "/staff")
public class StaffServlet extends HttpServlet {

    private transient DataSource dataSource;
    private transient UserService userService;
    private transient OrderService orderService;
    private transient ProductService productService;
    private transient CategoryService categoryService;
    private transient BrandService brandService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.userService = new UserServiceImpl(dataSource);
        this.orderService = new OrderServiceImpl(dataSource);
        this.productService = new ProductServiceImpl(dataSource);
        this.categoryService = new CategoryServiceImpl(dataSource);
        this.brandService = new BrandServiceImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("is_login") == null || !(Boolean) session.getAttribute("is_login")) {
            // Lưu URL để redirect sau khi đăng nhập
            session = request.getSession(true);
            session.setAttribute("redirectAfterLogin", request.getRequestURI());
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String username = (String) session.getAttribute("username");
        if (username == null || username.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserDAO currentUser = userService.findByUsername(username);
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Chỉ cho phép tài khoản STAFF hoặc ADMIN truy cập khu vực này
        if (currentUser.getRole() == null ||
                !(currentUser.getRole().equalsIgnoreCase("STAFF") ||
                  currentUser.getRole().equalsIgnoreCase("ADMIN"))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang nhân viên.");
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "dashboard";
        }

        switch (action) {
            case "products" -> showProductList(request, response, currentUser);
            case "product-add" -> showProductAddForm(request, response, currentUser);
            case "product-edit" -> showProductEditForm(request, response, currentUser);
            case "categories" -> showCategoryList(request, response, currentUser);
            case "category-add" -> showCategoryAddForm(request, response, currentUser);
            case "category-edit" -> showCategoryEditForm(request, response, currentUser);
            case "brands" -> showBrandList(request, response, currentUser);
            case "brand-add" -> showBrandAddForm(request, response, currentUser);
            case "brand-edit" -> showBrandEditForm(request, response, currentUser);
            case "orders" -> showOrderManagement(request, response, currentUser);
            case "order-details" -> showOrderDetails(request, response, currentUser);
            default -> showStaffDashboard(request, response, currentUser);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("is_login") == null || !(Boolean) session.getAttribute("is_login")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String username = (String) session.getAttribute("username");
        if (username == null || username.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserDAO currentUser = userService.findByUsername(username);
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Chỉ cho phép tài khoản STAFF hoặc ADMIN
        if (currentUser.getRole() == null ||
                !(currentUser.getRole().equalsIgnoreCase("STAFF") ||
                  currentUser.getRole().equalsIgnoreCase("ADMIN"))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền thực hiện thao tác này.");
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "";
        }

        switch (action) {
            // Sản phẩm
            case "product-create" -> handleCreateProduct(request, response, currentUser);
            case "product-update" -> handleUpdateProduct(request, response, currentUser);
            case "product-delete" -> handleDeleteProduct(request, response, currentUser);
            case "product-update-stock" -> handleUpdateProductStock(request, response, currentUser);

            // Danh mục
            case "category-create" -> handleCreateCategory(request, response, currentUser);
            case "category-update" -> handleUpdateCategory(request, response, currentUser);
            case "category-delete" -> handleDeleteCategory(request, response, currentUser);

            // Thương hiệu
            case "brand-create" -> handleCreateBrand(request, response, currentUser);
            case "brand-update" -> handleUpdateBrand(request, response, currentUser);
            case "brand-delete" -> handleDeleteBrand(request, response, currentUser);

            // Đơn hàng
            case "order-update-status" -> handleUpdateOrderStatus(request, response, currentUser);

            default -> response.sendRedirect(request.getContextPath() + "/staff");
        }
    }

    // ====== KHU VỰC HIỂN THỊ TRANG QUẢN LÝ NHÂN VIÊN ======

    private void showStaffDashboard(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {
        request.setAttribute("currentUser", currentUser);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/admin/dashboard/index.jsp");
        rd.forward(request, response);
    }

    private void showProductList(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {
        request.setAttribute("currentUser", currentUser);
        
        // Lấy tham số pagination và search
        String keyword = request.getParameter("keyword");
        if (keyword == null) keyword = "";
        int page = 1;
        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isBlank()) {
                page = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        
        int pageSize = 10;
        PageRequest pageRequest = new PageRequest(page, pageSize, "id", "DESC", keyword, 0, 0, 0);
        Page<ProductDAO> productPage = productService.findAll(pageRequest);
        
        request.setAttribute("productPage", productPage);
        request.setAttribute("products", productPage.getData());
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", page);
        
        // Load categories and brands for filters
        List<CategoryDAO> categories = categoryService.getAll();
        List<BrandDAO> brands = brandService.getAll();
        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/staff/products.jsp");
        rd.forward(request, response);
    }

    private void showProductAddForm(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {
        request.setAttribute("currentUser", currentUser);
        List<CategoryDAO> categories = categoryService.getAll();
        List<BrandDAO> brands = brandService.getAll();
        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/staff/product-form.jsp");
        rd.forward(request, response);
    }
    
    private void showProductEditForm(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/staff?action=products");
            return;
        }
        try {
            int id = Integer.parseInt(idStr);
            ProductDAO product = productService.findById(id);
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/staff?action=products");
                return;
            }
            request.setAttribute("currentUser", currentUser);
            request.setAttribute("product", product);
            List<CategoryDAO> categories = categoryService.getAll();
            List<BrandDAO> brands = brandService.getAll();
            request.setAttribute("categories", categories);
            request.setAttribute("brands", brands);
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/staff/product-form.jsp");
            rd.forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff?action=products");
        }
    }

    private void showCategoryList(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {
        request.setAttribute("currentUser", currentUser);
        
        // Lấy tham số pagination và search
        String keyword = request.getParameter("keyword");
        if (keyword == null) keyword = "";
        int page = 1;
        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isBlank()) {
                page = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        
        int pageSize = 10;
        PageRequest pageRequest = new PageRequest(page, pageSize, "id", "DESC", keyword);
        Page<CategoryDAO> categoryPage = categoryService.findAll(pageRequest);
        
        request.setAttribute("categoryPage", categoryPage);
        request.setAttribute("categories", categoryPage.getData());
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", page);
        
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/staff/categories.jsp");
        rd.forward(request, response);
    }
    
    private void showCategoryAddForm(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {
        request.setAttribute("currentUser", currentUser);
        List<CategoryDAO> parentCategories = categoryService.getAll();
        request.setAttribute("parentCategories", parentCategories);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/staff/category-form.jsp");
        rd.forward(request, response);
    }
    
    private void showCategoryEditForm(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/staff?action=categories");
            return;
        }
        try {
            int id = Integer.parseInt(idStr);
            CategoryDAO category = categoryService.findById(id);
            if (category == null) {
                response.sendRedirect(request.getContextPath() + "/staff?action=categories");
                return;
            }
            request.setAttribute("currentUser", currentUser);
            request.setAttribute("category", category);
            List<CategoryDAO> parentCategories = categoryService.getAll();
            request.setAttribute("parentCategories", parentCategories);
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/staff/category-form.jsp");
            rd.forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff?action=categories");
        }
    }

    private void showBrandList(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {
        request.setAttribute("currentUser", currentUser);
        
        // Lấy tham số pagination và search
        String keyword = request.getParameter("keyword");
        if (keyword == null) keyword = "";
        int page = 1;
        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isBlank()) {
                page = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        
        int pageSize = 10;
        PageRequest pageRequest = new PageRequest(page, pageSize, "id", "DESC", keyword);
        Page<BrandDAO> brandPage = brandService.findAll(pageRequest);
        
        request.setAttribute("brandPage", brandPage);
        request.setAttribute("brands", brandPage.getData());
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", page);
        
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/staff/brands.jsp");
        rd.forward(request, response);
    }
    
    private void showBrandAddForm(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {
        request.setAttribute("currentUser", currentUser);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/staff/brand-form.jsp");
        rd.forward(request, response);
    }
    
    private void showBrandEditForm(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/staff?action=brands");
            return;
        }
        try {
            int id = Integer.parseInt(idStr);
            BrandDAO brand = brandService.findById(id);
            if (brand == null) {
                response.sendRedirect(request.getContextPath() + "/staff?action=brands");
                return;
            }
            request.setAttribute("currentUser", currentUser);
            request.setAttribute("brand", brand);
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/staff/brand-form.jsp");
            rd.forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff?action=brands");
        }
    }

    private void showOrderManagement(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {
        request.setAttribute("currentUser", currentUser);
        
        // Lấy tham số pagination và search
        String keyword = request.getParameter("keyword");
        if (keyword == null) keyword = "";
        int page = 1;
        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isBlank()) {
                page = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        
        int pageSize = 10;
        PageRequest pageRequest = new PageRequest(page, pageSize, "id", "DESC", keyword);
        Page<OrderDAO> orderPage = orderService.findAll(pageRequest);
        
        request.setAttribute("orderPage", orderPage);
        request.setAttribute("orders", orderPage.getData());
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", page);
        
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/staff/orders.jsp");
        rd.forward(request, response);
    }

    private void showOrderDetails(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {
        request.setAttribute("currentUser", currentUser);
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                OrderDAO order = orderService.findById(id);
                request.setAttribute("order", order);
            } catch (NumberFormatException ignored) {
            }
        }
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/admin/order/details.jsp");
        rd.forward(request, response);
    }

    // ====== XỬ LÝ NGHIỆP VỤ SẢN PHẨM ======

    private void handleCreateProduct(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws IOException {
        String name = request.getParameter("name");
        String slug = request.getParameter("slug");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("image_url");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock_quantity");
        String categoryIdStr = request.getParameter("category_id");
        String brandIdStr = request.getParameter("brand_id");

        ProductDAO product = new ProductDAO();
        product.setName(name);
        product.setSlug(slug);
        product.setDescription(description);
        product.setImage_url(imageUrl);
        try {
            if (priceStr != null) {
                product.setPrice(Double.parseDouble(priceStr));
            }
        } catch (NumberFormatException ignored) {
        }
        try {
            if (stockStr != null) {
                product.setStock_quantity(Integer.parseInt(stockStr));
            }
        } catch (NumberFormatException ignored) {
        }
        try {
            if (categoryIdStr != null) {
                product.setCategory_id(Integer.parseInt(categoryIdStr));
            }
        } catch (NumberFormatException ignored) {
        }
        try {
            if (brandIdStr != null) {
                product.setBrand_id(Integer.parseInt(brandIdStr));
            }
        } catch (NumberFormatException ignored) {
        }
        product.setIs_active(true);

        productService.create(product);
        response.sendRedirect(request.getContextPath() + "/staff?action=products");
    }

    private void handleUpdateProduct(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/staff?action=products");
            return;
        }
        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff?action=products");
            return;
        }

        ProductDAO product = productService.findById(id);
        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/staff?action=products");
            return;
        }

        String name = request.getParameter("name");
        String slug = request.getParameter("slug");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("image_url");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock_quantity");
        String categoryIdStr = request.getParameter("category_id");
        String brandIdStr = request.getParameter("brand_id");
        String activeStr = request.getParameter("is_active");

        if (name != null) product.setName(name);
        if (slug != null) product.setSlug(slug);
        if (description != null) product.setDescription(description);
        if (imageUrl != null) product.setImage_url(imageUrl);
        try {
            if (priceStr != null) {
                product.setPrice(Double.parseDouble(priceStr));
            }
        } catch (NumberFormatException ignored) {
        }
        try {
            if (stockStr != null) {
                product.setStock_quantity(Integer.parseInt(stockStr));
            }
        } catch (NumberFormatException ignored) {
        }
        try {
            if (categoryIdStr != null) {
                product.setCategory_id(Integer.parseInt(categoryIdStr));
            }
        } catch (NumberFormatException ignored) {
        }
        try {
            if (brandIdStr != null) {
                product.setBrand_id(Integer.parseInt(brandIdStr));
            }
        } catch (NumberFormatException ignored) {
        }
        if (activeStr != null) {
            product.setIs_active(Boolean.parseBoolean(activeStr));
        }

        productService.update(product);
        response.sendRedirect(request.getContextPath() + "/staff?action=products");
    }

    private void handleDeleteProduct(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                productService.deleteById(id);
            } catch (NumberFormatException ignored) {
            }
        }
        response.sendRedirect(request.getContextPath() + "/staff?action=products");
    }

    /**
     * Cập nhật nhanh tồn kho sản phẩm (chỉ nhân viên / admin).
     * URL: POST /staff?action=product-update-stock&id=...&stock_quantity=...
     */
    private void handleUpdateProductStock(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws IOException {
        String idStr = request.getParameter("id");
        String stockStr = request.getParameter("stock_quantity");

        if (idStr == null || stockStr == null) {
            response.sendRedirect(request.getContextPath() + "/staff?action=products");
            return;
        }

        int id;
        int stock;
        try {
            id = Integer.parseInt(idStr);
            stock = Integer.parseInt(stockStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff?action=products");
            return;
        }

        ProductDAO product = productService.findById(id);
        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/staff?action=products");
            return;
        }

        product.setStock_quantity(Math.max(stock, 0));
        // Nếu hết hàng thì có thể set is_active vẫn true để hiển thị nhưng không cho đặt hàng
        productService.update(product);

        response.sendRedirect(request.getContextPath() + "/staff?action=products");
    }

    // ====== XỬ LÝ NGHIỆP VỤ DANH MỤC ======

    private void handleCreateCategory(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String parentIdStr = request.getParameter("parent_id");

        CategoryDAO category = new CategoryDAO();
        category.setName(name);
        category.setDescription(description);
        try {
            if (parentIdStr != null && !parentIdStr.isBlank()) {
                int parentId = Integer.parseInt(parentIdStr);
                category.setParent_id(parentId > 0 ? parentId : 0);
            } else {
                category.setParent_id(0);
            }
        } catch (NumberFormatException e) {
            category.setParent_id(0);
        }
        category.setIs_active(true);

        categoryService.create(category);
        response.sendRedirect(request.getContextPath() + "/staff?action=categories");
    }

    private void handleUpdateCategory(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/staff?action=categories");
            return;
        }
        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff?action=categories");
            return;
        }

        CategoryDAO category = categoryService.findById(id);
        if (category == null) {
            response.sendRedirect(request.getContextPath() + "/staff?action=categories");
            return;
        }

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String parentIdStr = request.getParameter("parent_id");
        String activeStr = request.getParameter("is_active");

        if (name != null) category.setName(name);
        if (description != null) category.setDescription(description);
        try {
            if (parentIdStr != null && !parentIdStr.isBlank()) {
                int parentId = Integer.parseInt(parentIdStr);
                category.setParent_id(parentId > 0 ? parentId : 0);
            }
        } catch (NumberFormatException ignored) {
        }
        if (activeStr != null) {
            category.setIs_active(Boolean.parseBoolean(activeStr));
        }

        categoryService.update(category);
        response.sendRedirect(request.getContextPath() + "/staff?action=categories");
    }

    private void handleDeleteCategory(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                categoryService.deleteById(id);
            } catch (NumberFormatException ignored) {
            }
        }
        response.sendRedirect(request.getContextPath() + "/staff?action=categories");
    }

    // ====== XỬ LÝ NGHIỆP VỤ THƯƠNG HIỆU ======

    private void handleCreateBrand(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws IOException {
        String name = request.getParameter("name");
        String code = request.getParameter("code");
        String logoUrl = request.getParameter("logo_url");

        BrandDAO brand = new BrandDAO();
        brand.setName(name);
        brand.setCode(code);
        brand.setLogo_url(logoUrl);
        brand.setIs_active(true);

        brandService.create(brand);
        response.sendRedirect(request.getContextPath() + "/staff?action=brands");
    }

    private void handleUpdateBrand(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/staff?action=brands");
            return;
        }
        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff?action=brands");
            return;
        }

        BrandDAO brand = brandService.findById(id);
        if (brand == null) {
            response.sendRedirect(request.getContextPath() + "/staff?action=brands");
            return;
        }

        String name = request.getParameter("name");
        String code = request.getParameter("code");
        String logoUrl = request.getParameter("logo_url");
        String activeStr = request.getParameter("is_active");

        if (name != null) brand.setName(name);
        if (code != null) brand.setCode(code);
        if (logoUrl != null) brand.setLogo_url(logoUrl);
        if (activeStr != null) {
            brand.setIs_active(Boolean.parseBoolean(activeStr));
        }

        brandService.update(brand);
        response.sendRedirect(request.getContextPath() + "/staff?action=brands");
    }

    private void handleDeleteBrand(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                brandService.deleteById(id);
            } catch (NumberFormatException ignored) {
            }
        }
        response.sendRedirect(request.getContextPath() + "/staff?action=brands");
    }

    // ====== XỬ LÝ NGHIỆP VỤ ĐƠN HÀNG ======

    private void handleUpdateOrderStatus(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws IOException {
        String idStr = request.getParameter("id");
        String status = request.getParameter("status");
        if (idStr == null || status == null) {
            response.sendRedirect(request.getContextPath() + "/staff?action=orders");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff?action=orders");
            return;
        }

        OrderDAO order = orderService.findById(id);
        if (order != null) {
            order.setStatus(status);
            orderService.update(order);
        }

        response.sendRedirect(request.getContextPath() + "/staff?action=orders");
    }
}