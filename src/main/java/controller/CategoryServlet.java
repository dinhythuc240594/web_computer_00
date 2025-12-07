package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.CategoryDAO;
import model.Page;
import model.PageRequest;
import model.ProductDAO;
import service.CategoryService;
import service.ProductService;
import serviceimpl.CategoryServiceImpl;
import serviceimpl.ProductServiceImpl;
import utilities.DataSourceUtil;
import utilities.FileUpload;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "category", urlPatterns = "/category")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024) // 5MB file, 10MB request
public class CategoryServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CategoryServlet.class.getName());
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
        // Nếu categoryId = 0, sẽ lấy tất cả sản phẩm từ tất cả danh mục
        PageRequest pageRequest = new PageRequest(
                page,
                DEFAULT_PAGE_SIZE,
                "created_at",
                "DESC",
                keyword != null ? keyword : "",
                0,
                categoryId > 0 ? categoryId : 0,  // Nếu categoryId = 0, không filter theo category
                0  // Không filter theo brand trong CategoryServlet
        );

        // Lấy kết quả với phân trang
        Page<ProductDAO> productPage = productService.findAll(pageRequest);
        request.setAttribute("productPage", productPage);
        request.setAttribute("products", productPage.getData());

        // Lấy thông tin category nếu có
        if (categoryId > 0) {
            CategoryDAO selectedCategory = categoryService.findById(categoryId);
            request.setAttribute("selectedCategory", selectedCategory);
        }

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/category.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            handleCreateCategory(request, response);
        } else if ("update".equals(action)) {
            handleUpdateCategory(request, response);
        } else {
            // Nếu không có action, chuyển sang GET để xử lý
            doGet(request, response);
        }
    }
    
    private void handleCreateCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String name = trimToNull(request.getParameter("name"));
            String description = trimToNull(request.getParameter("description"));
            int parentId = parsePositiveInt(request.getParameter("parent_id"));
            
            if (name == null || name.isBlank()) {
                request.setAttribute("errorMessage", "Tên danh mục không được để trống.");
                doGet(request, response);
                return;
            }
            
            CategoryDAO category = new CategoryDAO();
            category.setName(name);
            category.setDescription(description != null ? description : "");
            category.setParent_id(parentId);
            category.setIs_active(true);
            
            // Xử lý upload logo sử dụng FileUpload utility
            Part logoPart = request.getPart("image");
            if (logoPart != null && logoPart.getSize() > 0) {
                try {
                    // Validate file bằng FileUpload utility - validate trước khi đọc bytes
                    String contentType = logoPart.getContentType();
                    if (contentType != null && contentType.startsWith("image/")) {
                        // Validate file size (5MB max) - giống FileUpload.MAX_IMAGE_SIZE
                        if (logoPart.getSize() <= 5 * 1024 * 1024) {
                            // Đọc bytes từ Part để lưu vào logo_blob
                            // Lưu ý: Part stream chỉ đọc được một lần, nên đọc bytes trước
                            try (InputStream is = logoPart.getInputStream()) {
                                byte[] logoBytes = is.readAllBytes();
                                if (logoBytes.length > 0) {
                                    // Validate magic bytes để đảm bảo file là ảnh thật
                                    // Sử dụng logic tương tự FileUpload
                                    if (isValidImageBytes(logoBytes)) {
                                        category.setLogo_blob(logoBytes);
                                    } else {
                                        request.setAttribute("errorMessage", 
                                                "File logo không đúng định dạng ảnh hợp lệ.");
                                        doGet(request, response);
                                        return;
                                    }
                                }
                            }
                        } else {
                            request.setAttribute("errorMessage", "Kích thước file logo vượt quá 5MB.");
                            doGet(request, response);
                            return;
                        }
                    } else if (logoPart.getSize() > 0) {
                        request.setAttribute("errorMessage", "Chỉ chấp nhận file ảnh (JPG, PNG, GIF, WebP).");
                        doGet(request, response);
                        return;
                    }
                } catch (Exception e) {
                    LOGGER.log(Level.WARNING, "Lỗi khi xử lý upload logo: " + e.getMessage(), e);
                    // Tiếp tục tạo category mà không có logo nếu có lỗi
                }
            }
            
            boolean success = Boolean.TRUE.equals(categoryService.create(category));
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/category?success=created");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi tạo danh mục. Vui lòng thử lại.");
                doGet(request, response);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tạo danh mục", e);
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            doGet(request, response);
        }
    }
    
    private void handleUpdateCategory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null) {
                response.sendRedirect(request.getContextPath() + "/category");
                return;
            }
            
            int id = parsePositiveInt(idStr);
            if (id <= 0) {
                response.sendRedirect(request.getContextPath() + "/category");
                return;
            }
            
            CategoryDAO category = categoryService.findById(id);
            if (category == null) {
                response.sendRedirect(request.getContextPath() + "/category");
                return;
            }
            
            // Lưu logo hiện tại để giữ lại nếu không upload mới
            byte[] existingLogo = category.getLogo_blob();
            
            String name = trimToNull(request.getParameter("name"));
            String description = trimToNull(request.getParameter("description"));
            int parentId = parsePositiveInt(request.getParameter("parent_id"));
            String activeStr = request.getParameter("is_active");
            
            if (name == null || name.isBlank()) {
                request.setAttribute("errorMessage", "Tên danh mục không được để trống.");
                request.setAttribute("category", category);
                doGet(request, response);
                return;
            }
            
            category.setName(name);
            category.setDescription(description != null ? description : "");
            category.setParent_id(parentId);
            if (activeStr != null) {
                category.setIs_active(Boolean.parseBoolean(activeStr));
            }
            
            // Xử lý upload logo mới - chỉ cập nhật nếu có file mới
            Part logoPart = request.getPart("image");
            if (logoPart != null && logoPart.getSize() > 0) {
                try {
                    // Validate file bằng FileUpload utility - validate trước khi đọc bytes
                    String contentType = logoPart.getContentType();
                    if (contentType != null && contentType.startsWith("image/")) {
                        // Validate file size (5MB max) - giống FileUpload.MAX_IMAGE_SIZE
                        if (logoPart.getSize() <= 5 * 1024 * 1024) {
                            // Đọc bytes từ Part để lưu vào logo_blob
                            // Lưu ý: Part stream chỉ đọc được một lần, nên đọc bytes trước
                            try (InputStream is = logoPart.getInputStream()) {
                                byte[] logoBytes = is.readAllBytes();
                                if (logoBytes.length > 0) {
                                    // Validate magic bytes để đảm bảo file là ảnh thật
                                    // Sử dụng logic tương tự FileUpload
                                    if (isValidImageBytes(logoBytes)) {
                                        category.setLogo_blob(logoBytes);
                                    } else {
                                        request.setAttribute("errorMessage", 
                                                "File logo không đúng định dạng ảnh hợp lệ.");
                                        request.setAttribute("category", category);
                                        doGet(request, response);
                                        return;
                                    }
                                }
                            }
                        } else {
                            request.setAttribute("errorMessage", "Kích thước file logo vượt quá 5MB.");
                            request.setAttribute("category", category);
                            doGet(request, response);
                            return;
                        }
                    } else if (logoPart.getSize() > 0) {
                        request.setAttribute("errorMessage", "Chỉ chấp nhận file ảnh (JPG, PNG, GIF, WebP).");
                        request.setAttribute("category", category);
                        doGet(request, response);
                        return;
                    }
                } catch (Exception e) {
                    LOGGER.log(Level.WARNING, "Lỗi khi xử lý upload logo: " + e.getMessage(), e);
                    // Giữ logo cũ nếu có lỗi
                    category.setLogo_blob(existingLogo);
                }
            } else {
                // Không có file mới, giữ logo cũ
                category.setLogo_blob(existingLogo);
            }
            
            boolean success = Boolean.TRUE.equals(categoryService.update(category));
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/category?success=updated");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật danh mục. Vui lòng thử lại.");
                request.setAttribute("category", category);
                doGet(request, response);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi cập nhật danh mục", e);
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            doGet(request, response);
        }
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
    
    /**
     * Validate image bytes bằng cách kiểm tra magic bytes
     * Sử dụng logic tương tự FileUpload utility
     */
    private boolean isValidImageBytes(byte[] bytes) {
        if (bytes == null || bytes.length < 4) {
            return false;
        }
        
        // JPEG: FF D8 FF
        if (bytes.length >= 3 && bytes[0] == (byte)0xFF && bytes[1] == (byte)0xD8 && bytes[2] == (byte)0xFF) {
            return true;
        }
        
        // PNG: 89 50 4E 47 0D 0A 1A 0A
        if (bytes.length >= 8 && bytes[0] == (byte)0x89 && bytes[1] == 0x50 && 
            bytes[2] == 0x4E && bytes[3] == 0x47 && bytes[4] == 0x0D && 
            bytes[5] == 0x0A && bytes[6] == 0x1A && bytes[7] == 0x0A) {
            return true;
        }
        
        // GIF: 47 49 46 38 37 61 hoặc 47 49 46 38 39 61
        if (bytes.length >= 6 && bytes[0] == 0x47 && bytes[1] == 0x49 && 
            bytes[2] == 0x46 && bytes[3] == 0x38 && 
            (bytes[4] == 0x37 || bytes[4] == 0x39) && bytes[5] == 0x61) {
            return true;
        }
        
        // WebP: RIFF...WEBP (bytes 0-3: 52 49 46 46, bytes 8-11: 57 45 42 50)
        if (bytes.length >= 12 && bytes[0] == 0x52 && bytes[1] == 0x49 && 
            bytes[2] == 0x46 && bytes[3] == 0x46 &&
            bytes[8] == 0x57 && bytes[9] == 0x45 && 
            bytes[10] == 0x42 && bytes[11] == 0x50) {
            return true;
        }
        
        return false;
    }
}