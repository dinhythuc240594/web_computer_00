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
import model.Page;
import model.PageRequest;
import model.ProductDAO;
import service.BrandService;
import service.ProductService;
import serviceimpl.BrandServiceImpl;
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

@WebServlet(name="brand", urlPatterns="/brand")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024) // 5MB file, 10MB request
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
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            handleCreateBrand(request, response);
        } else if ("update".equals(action)) {
            handleUpdateBrand(request, response);
        } else {
            // Nếu không có action, chuyển sang GET để xử lý
            doGet(request, response);
        }
    }
    
    private void handleCreateBrand(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String name = trimToNull(request.getParameter("name"));
            String code = trimToNull(request.getParameter("code"));
            String logoUrl = trimToNull(request.getParameter("logo_url"));
            
            if (name == null || name.isBlank()) {
                request.setAttribute("errorMessage", "Tên thương hiệu không được để trống.");
                doGet(request, response);
                return;
            }
            
            if (code == null || code.isBlank()) {
                request.setAttribute("errorMessage", "Mã thương hiệu không được để trống.");
                doGet(request, response);
                return;
            }
            
            BrandDAO brand = new BrandDAO();
            brand.setName(name);
            brand.setCode(code);
            brand.setLogo_url(logoUrl != null ? logoUrl : "");
            brand.setIs_active(true);
            
            // Xử lý upload logo_blob sử dụng FileUpload utility
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                try {
                    // Validate file bằng FileUpload utility - validate trước khi đọc bytes
                    String contentType = imagePart.getContentType();
                    if (contentType != null && contentType.startsWith("image/")) {
                        // Validate file size (5MB max) - giống FileUpload.MAX_IMAGE_SIZE
                        if (imagePart.getSize() <= 5 * 1024 * 1024) {
                            // Đọc bytes từ Part để lưu vào logo_blob
                            // Lưu ý: Part stream chỉ đọc được một lần, nên đọc bytes trước
                            try (InputStream is = imagePart.getInputStream()) {
                                byte[] logoBytes = is.readAllBytes();
                                if (logoBytes.length > 0) {
                                    // Validate magic bytes để đảm bảo file là ảnh thật
                                    // Sử dụng logic tương tự FileUpload
                                    if (isValidImageBytes(logoBytes)) {
                                        brand.setLogo_blob(logoBytes);
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
                    } else if (imagePart.getSize() > 0) {
                        request.setAttribute("errorMessage", "Chỉ chấp nhận file ảnh (JPG, PNG, GIF, WebP).");
                        doGet(request, response);
                        return;
                    }
                } catch (Exception e) {
                    LOGGER.log(Level.WARNING, "Lỗi khi xử lý upload logo: " + e.getMessage(), e);
                    // Tiếp tục tạo brand mà không có logo nếu có lỗi
                }
            }
            
            boolean success = Boolean.TRUE.equals(brandService.create(brand));
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/brand?success=created");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi tạo thương hiệu. Vui lòng thử lại.");
                doGet(request, response);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi tạo thương hiệu", e);
            request.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            doGet(request, response);
        }
    }
    
    private void handleUpdateBrand(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            if (idStr == null) {
                response.sendRedirect(request.getContextPath() + "/brand");
                return;
            }
            
            int id = parsePositiveInt(idStr);
            if (id <= 0) {
                response.sendRedirect(request.getContextPath() + "/brand");
                return;
            }
            
            BrandDAO brand = brandService.findById(id);
            if (brand == null) {
                response.sendRedirect(request.getContextPath() + "/brand");
                return;
            }
            
            // Lưu logo_blob hiện tại để giữ lại nếu không upload mới
            byte[] existingLogoBlob = brand.getLogo_blob();
            
            String name = trimToNull(request.getParameter("name"));
            String code = trimToNull(request.getParameter("code"));
            String logoUrl = trimToNull(request.getParameter("logo_url"));
            String activeStr = request.getParameter("is_active");
            
            if (name == null || name.isBlank()) {
                request.setAttribute("errorMessage", "Tên thương hiệu không được để trống.");
                request.setAttribute("brand", brand);
                doGet(request, response);
                return;
            }
            
            if (code == null || code.isBlank()) {
                request.setAttribute("errorMessage", "Mã thương hiệu không được để trống.");
                request.setAttribute("brand", brand);
                doGet(request, response);
                return;
            }
            
            brand.setName(name);
            brand.setCode(code);
            brand.setLogo_url(logoUrl != null ? logoUrl : "");
            if (activeStr != null) {
                brand.setIs_active(Boolean.parseBoolean(activeStr));
            }
            
            // Xử lý upload logo_blob mới - chỉ cập nhật nếu có file mới
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                try {
                    // Validate file bằng FileUpload utility - validate trước khi đọc bytes
                    String contentType = imagePart.getContentType();
                    if (contentType != null && contentType.startsWith("image/")) {
                        // Validate file size (5MB max) - giống FileUpload.MAX_IMAGE_SIZE
                        if (imagePart.getSize() <= 5 * 1024 * 1024) {
                            // Đọc bytes từ Part để lưu vào logo_blob
                            // Lưu ý: Part stream chỉ đọc được một lần, nên đọc bytes trước
                            try (InputStream is = imagePart.getInputStream()) {
                                byte[] logoBytes = is.readAllBytes();
                                if (logoBytes.length > 0) {
                                    // Validate magic bytes để đảm bảo file là ảnh thật
                                    // Sử dụng logic tương tự FileUpload
                                    if (isValidImageBytes(logoBytes)) {
                                        brand.setLogo_blob(logoBytes);
                                    } else {
                                        request.setAttribute("errorMessage", 
                                                "File logo không đúng định dạng ảnh hợp lệ.");
                                        request.setAttribute("brand", brand);
                                        doGet(request, response);
                                        return;
                                    }
                                }
                            }
                        } else {
                            request.setAttribute("errorMessage", "Kích thước file logo vượt quá 5MB.");
                            request.setAttribute("brand", brand);
                            doGet(request, response);
                            return;
                        }
                    } else if (imagePart.getSize() > 0) {
                        request.setAttribute("errorMessage", "Chỉ chấp nhận file ảnh (JPG, PNG, GIF, WebP).");
                        request.setAttribute("brand", brand);
                        doGet(request, response);
                        return;
                    }
                } catch (Exception e) {
                    LOGGER.log(Level.WARNING, "Lỗi khi xử lý upload logo: " + e.getMessage(), e);
                    // Giữ logo_blob cũ nếu có lỗi
                    brand.setLogo_blob(existingLogoBlob);
                }
            } else {
                // Không có file mới, giữ logo_blob cũ
                brand.setLogo_blob(existingLogoBlob);
            }
            
            boolean success = Boolean.TRUE.equals(brandService.update(brand));
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/brand?success=updated");
            } else {
                request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật thương hiệu. Vui lòng thử lại.");
                request.setAttribute("brand", brand);
                doGet(request, response);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi cập nhật thương hiệu", e);
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