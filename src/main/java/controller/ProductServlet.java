package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
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
import utilities.FileUpload;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name="product", urlPatterns="/product")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024) // 5MB file, 10MB request
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
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            handleCreateProduct(request, response);
        } else if ("update".equals(action)) {
            handleUpdateProduct(request, response);
        } else {
            // Nếu không có action, chuyển sang GET để xử lý
            doGet(request, response);
        }
    }
    
    private void handleCreateProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String name = trimToNull(request.getParameter("name"));
            String slug = trimToNull(request.getParameter("slug"));
            String description = trimToNull(request.getParameter("description"));
            String imageUrl = trimToNull(request.getParameter("image_url"));
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stock_quantity");
            int categoryId = parsePositiveInt(request.getParameter("category_id"));
            int brandId = parsePositiveInt(request.getParameter("brand_id"));
            
            if (name == null || name.isBlank()) {
                request.setAttribute("errorMessage", "Tên sản phẩm không được để trống.");
                doGet(request, response);
                return;
            }
            
            ProductDAO product = new ProductDAO();
            product.setName(name);
            product.setSlug(slug != null ? slug : "");
            product.setDescription(description != null ? description : "");
            product.setImage_url(imageUrl != null ? imageUrl : "");
            
            try {
                if (priceStr != null && !priceStr.isBlank()) {
                    product.setPrice(Double.parseDouble(priceStr));
                }
            } catch (NumberFormatException ignored) {
            }
            
            try {
                if (stockStr != null && !stockStr.isBlank()) {
                    product.setStock_quantity(Integer.parseInt(stockStr));
                } else {
                    product.setStock_quantity(0);
                }
            } catch (NumberFormatException ignored) {
                product.setStock_quantity(0);
            }
            
            product.setCategory_id(categoryId);
            product.setBrand_id(brandId);
            product.setIs_active(true);
            
            // Xử lý upload image_blob sử dụng FileUpload utility
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                try {
                    // Validate file bằng FileUpload utility - validate trước khi đọc bytes
                    String contentType = imagePart.getContentType();
                    if (contentType != null && contentType.startsWith("image/")) {
                        // Validate file size (5MB max) - giống FileUpload.MAX_IMAGE_SIZE
                        if (imagePart.getSize() <= 5 * 1024 * 1024) {
                            // Đọc bytes từ Part để lưu vào image_blob
                            // Lưu ý: Part stream chỉ đọc được một lần, nên đọc bytes trước
                            try (InputStream is = imagePart.getInputStream()) {
                                byte[] imageBytes = is.readAllBytes();
                                if (imageBytes.length > 0) {
                                    // Validate magic bytes để đảm bảo file là ảnh thật
                                    // Sử dụng logic tương tự FileUpload
                                    if (isValidImageBytes(imageBytes)) {
                                        product.setImage_blob(imageBytes);
                                    } else {
                                        request.setAttribute("errorMessage", 
                                                "File ảnh không đúng định dạng ảnh hợp lệ.");
                                        doGet(request, response);
                                        return;
                                    }
                                }
                            }
                        } else {
                            request.setAttribute("errorMessage", "Kích thước file ảnh vượt quá 5MB.");
                            doGet(request, response);
                            return;
                        }
                    } else if (imagePart.getSize() > 0) {
                        request.setAttribute("errorMessage", "Chỉ chấp nhận file ảnh (JPG, PNG, GIF, WebP).");
                        doGet(request, response);
                        return;
                    }
                } catch (Exception e) {
                    LOGGER.log(Level.WARNING, "Lỗi khi xử lý upload ảnh: " + e.getMessage(), e);
                    // Tiếp tục tạo product mà không có image_blob nếu có lỗi
                }
            }
            
            boolean success = Boolean.TRUE.equals(productService.create(product));
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/product?success=created");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi tạo sản phẩm. Vui lòng thử lại.");
                doGet(request, response);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tạo sản phẩm", e);
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            doGet(request, response);
        }
    }
    
    private void handleUpdateProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null) {
                response.sendRedirect(request.getContextPath() + "/product");
                return;
            }
            
            int id = parsePositiveInt(idStr);
            if (id <= 0) {
                response.sendRedirect(request.getContextPath() + "/product");
                return;
            }
            
            ProductDAO product = productService.findById(id);
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/product");
                return;
            }
            
            // Lưu image_blob hiện tại để giữ lại nếu không upload mới
            byte[] existingImageBlob = product.getImage_blob();
            
            String name = trimToNull(request.getParameter("name"));
            String slug = trimToNull(request.getParameter("slug"));
            String description = trimToNull(request.getParameter("description"));
            String imageUrl = trimToNull(request.getParameter("image_url"));
            String priceStr = request.getParameter("price");
            String stockStr = request.getParameter("stock_quantity");
            int categoryId = parsePositiveInt(request.getParameter("category_id"));
            int brandId = parsePositiveInt(request.getParameter("brand_id"));
            String activeStr = request.getParameter("is_active");
            
            if (name == null || name.isBlank()) {
                request.setAttribute("errorMessage", "Tên sản phẩm không được để trống.");
                request.setAttribute("product", product);
                doGet(request, response);
                return;
            }
            
            product.setName(name);
            product.setSlug(slug != null ? slug : "");
            product.setDescription(description != null ? description : "");
            product.setImage_url(imageUrl != null ? imageUrl : "");
            
            try {
                if (priceStr != null && !priceStr.isBlank()) {
                    product.setPrice(Double.parseDouble(priceStr));
                }
            } catch (NumberFormatException ignored) {
            }
            
            try {
                if (stockStr != null && !stockStr.isBlank()) {
                    product.setStock_quantity(Integer.parseInt(stockStr));
                }
            } catch (NumberFormatException ignored) {
            }
            
            product.setCategory_id(categoryId);
            product.setBrand_id(brandId);
            if (activeStr != null) {
                product.setIs_active(Boolean.parseBoolean(activeStr));
            }
            
            // Xử lý upload image_blob mới - chỉ cập nhật nếu có file mới
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                try {
                    // Validate file bằng FileUpload utility - validate trước khi đọc bytes
                    String contentType = imagePart.getContentType();
                    if (contentType != null && contentType.startsWith("image/")) {
                        // Validate file size (5MB max) - giống FileUpload.MAX_IMAGE_SIZE
                        if (imagePart.getSize() <= 5 * 1024 * 1024) {
                            // Đọc bytes từ Part để lưu vào image_blob
                            // Lưu ý: Part stream chỉ đọc được một lần, nên đọc bytes trước
                            try (InputStream is = imagePart.getInputStream()) {
                                byte[] imageBytes = is.readAllBytes();
                                if (imageBytes.length > 0) {
                                    // Validate magic bytes để đảm bảo file là ảnh thật
                                    // Sử dụng logic tương tự FileUpload
                                    if (isValidImageBytes(imageBytes)) {
                                        product.setImage_blob(imageBytes);
                                    } else {
                                        request.setAttribute("errorMessage", 
                                                "File ảnh không đúng định dạng ảnh hợp lệ.");
                                        request.setAttribute("product", product);
                                        doGet(request, response);
                                        return;
                                    }
                                }
                            }
                        } else {
                            request.setAttribute("errorMessage", "Kích thước file ảnh vượt quá 5MB.");
                            request.setAttribute("product", product);
                            doGet(request, response);
                            return;
                        }
                    } else if (imagePart.getSize() > 0) {
                        request.setAttribute("errorMessage", "Chỉ chấp nhận file ảnh (JPG, PNG, GIF, WebP).");
                        request.setAttribute("product", product);
                        doGet(request, response);
                        return;
                    }
                } catch (Exception e) {
                    LOGGER.log(Level.WARNING, "Lỗi khi xử lý upload ảnh: " + e.getMessage(), e);
                    // Giữ image_blob cũ nếu có lỗi
                    product.setImage_blob(existingImageBlob);
                }
            } else {
                // Không có file mới, giữ image_blob cũ
                product.setImage_blob(existingImageBlob);
            }
            
            boolean success = Boolean.TRUE.equals(productService.update(product));
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/product?success=updated");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật sản phẩm. Vui lòng thử lại.");
                request.setAttribute("product", product);
                doGet(request, response);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi cập nhật sản phẩm", e);
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            doGet(request, response);
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