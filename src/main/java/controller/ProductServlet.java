package controller;

import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Collections;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.sql.DataSource;

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
            
            // Xử lý upload image sử dụng handleImageUpload
            try {
                String image = handleImageUpload(request);
                if (image != null && !image.isBlank()) {
                    product.setImage(image);
                }
            } catch (Exception e) {
                LOGGER.log(Level.WARNING, "Lỗi khi xử lý upload logo: " + e.getMessage(), e);
                // Tiếp tục tạo category mà không có logo nếu có lỗi
            }

            try {
                if (priceStr != null && !priceStr.isBlank()) {
                    product.setPrice(Double.parseDouble(priceStr));
                }
            } catch (NumberFormatException ignored) {
            }
            
            // Xử lý giá gốc
            String originalPriceStr = request.getParameter("original_price");
            try {
                if (originalPriceStr != null && !originalPriceStr.isBlank()) {
                    product.setOriginal_price(Double.parseDouble(originalPriceStr));
                } else if (priceStr != null && !priceStr.isBlank()) {
                    // Nếu không có original_price, dùng price làm giá gốc
                    product.setOriginal_price(Double.parseDouble(priceStr));
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
            
            // Xử lý các trường giảm giá
            String isOnSaleStr = request.getParameter("is_on_sale");
            if (isOnSaleStr != null && "true".equals(isOnSaleStr)) {
                product.setIs_on_sale(true);
                
                String discountPercentStr = request.getParameter("discount_percentage");
                try {
                    if (discountPercentStr != null && !discountPercentStr.isBlank()) {
                        product.setDiscount_percentage(Double.parseDouble(discountPercentStr));
                    }
                } catch (NumberFormatException ignored) {
                }
                
                // Xử lý ngày bắt đầu và kết thúc giảm giá
                String saleStartDateStr = request.getParameter("sale_start_date");
                if (saleStartDateStr != null && !saleStartDateStr.isBlank()) {
                    try {
                        java.time.LocalDateTime localDateTime = java.time.LocalDateTime.parse(saleStartDateStr);
                        product.setSale_start_date(java.sql.Timestamp.valueOf(localDateTime));
                    } catch (Exception ignored) {
                    }
                }
                
                String saleEndDateStr = request.getParameter("sale_end_date");
                if (saleEndDateStr != null && !saleEndDateStr.isBlank()) {
                    try {
                        java.time.LocalDateTime localDateTime = java.time.LocalDateTime.parse(saleEndDateStr);
                        product.setSale_end_date(java.sql.Timestamp.valueOf(localDateTime));
                    } catch (Exception ignored) {
                    }
                }
            } else {
                product.setIs_on_sale(false);
            }
            
            product.setCategory_id(categoryId);
            product.setBrand_id(brandId);
            product.setIs_active(true);
            
            // is_new sẽ được tự động tính dựa trên created_at, không cần set thủ công
            
            boolean success = Boolean.TRUE.equals(productService.create(product));
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/staff?action=products");
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
            
            String name = trimToNull(request.getParameter("name"));
            String slug = trimToNull(request.getParameter("slug"));
            String description = trimToNull(request.getParameter("description"));
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

            // Xử lý upload image sử dụng handleImageUpload
            try {
                String image = handleImageUpload(request);
                if (image != null && !image.isBlank()) {
                    product.setImage(image);
                } else{
                    image = product.getImage();
                    product.setImage(image);
                }
            } catch (Exception e) {
                LOGGER.log(Level.WARNING, "Lỗi khi xử lý upload image: " + e.getMessage(), e);
                // Tiếp tục tạo product mà không có image nếu có lỗi
            }

            product.setName(name);
            product.setSlug(slug != null ? slug : "");
            product.setDescription(description != null ? description : "");
            
            try {
                if (priceStr != null && !priceStr.isBlank()) {
                    product.setPrice(Double.parseDouble(priceStr));
                }
            } catch (NumberFormatException ignored) {
            }
            
            // Xử lý giá gốc
            String originalPriceStr = request.getParameter("original_price");
            try {
                if (originalPriceStr != null && !originalPriceStr.isBlank()) {
                    product.setOriginal_price(Double.parseDouble(originalPriceStr));
                } else if (priceStr != null && !priceStr.isBlank()) {
                    // Nếu không có original_price, dùng price làm giá gốc
                    product.setOriginal_price(Double.parseDouble(priceStr));
                }
            } catch (NumberFormatException ignored) {
            }
            
            try {
                if (stockStr != null && !stockStr.isBlank()) {
                    product.setStock_quantity(Integer.parseInt(stockStr));
                }
            } catch (NumberFormatException ignored) {
            }
            
            // Xử lý các trường giảm giá
            String isOnSaleStr = request.getParameter("is_on_sale");
            if (isOnSaleStr != null && "true".equals(isOnSaleStr)) {
                product.setIs_on_sale(true);
                
                String discountPercentStr = request.getParameter("discount_percentage");
                try {
                    if (discountPercentStr != null && !discountPercentStr.isBlank()) {
                        product.setDiscount_percentage(Double.parseDouble(discountPercentStr));
                    }
                } catch (NumberFormatException ignored) {
                }
                
                // Xử lý ngày bắt đầu và kết thúc giảm giá
                String saleStartDateStr = request.getParameter("sale_start_date");
                if (saleStartDateStr != null && !saleStartDateStr.isBlank()) {
                    try {
                        java.time.LocalDateTime localDateTime = java.time.LocalDateTime.parse(saleStartDateStr);
                        product.setSale_start_date(java.sql.Timestamp.valueOf(localDateTime));
                    } catch (Exception ignored) {
                    }
                }
                
                String saleEndDateStr = request.getParameter("sale_end_date");
                if (saleEndDateStr != null && !saleEndDateStr.isBlank()) {
                    try {
                        java.time.LocalDateTime localDateTime = java.time.LocalDateTime.parse(saleEndDateStr);
                        product.setSale_end_date(java.sql.Timestamp.valueOf(localDateTime));
                    } catch (Exception ignored) {
                    }
                }
            } else {
                product.setIs_on_sale(false);
                product.setDiscount_percentage(null);
                product.setSale_start_date(null);
                product.setSale_end_date(null);
            }
            
            product.setCategory_id(categoryId);
            product.setBrand_id(brandId);
            if (activeStr != null) {
                product.setIs_active(Boolean.parseBoolean(activeStr));
            } else{
                product.setIs_active(false);
            }
            
            // is_new sẽ được tự động tính dựa trên created_at, không cần set thủ công
            
            boolean success = Boolean.TRUE.equals(productService.update(product));
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/staff?action=products");
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

	private String handleImageUpload(HttpServletRequest request) throws IOException, ServletException {
		Part imagePart = request.getPart("image");
		if (imagePart != null && imagePart.getSize() > 0) {
			String contentType = imagePart.getContentType();
			if (contentType != null && contentType.startsWith("image/")) {
				String submitted = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
				String ext = submitted.contains(".") ? submitted.substring(submitted.lastIndexOf(".")) : ".jpg";
				String safeName = UUID.randomUUID().toString().replace("-", "") + ext.toLowerCase();
				
				String appRealPath = request.getServletContext().getRealPath("");
				if (appRealPath == null) {
					appRealPath = System.getProperty("user.home") + "/uploads";
				}
				
				Path uploadDir = Paths.get(appRealPath, "uploads", "products");
				Files.createDirectories(uploadDir);
				
				try (InputStream in = imagePart.getInputStream()) {
					Files.copy(in, uploadDir.resolve(safeName), StandardCopyOption.REPLACE_EXISTING);
				}
				
				return request.getContextPath() + "/uploads/products/" + URLEncoder.encode(safeName, "UTF-8");
			}
		}
		return null;
	}

}