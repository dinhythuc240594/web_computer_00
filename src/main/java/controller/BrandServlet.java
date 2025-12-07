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
            brand.setIs_active(true);

            // Xử lý upload image sử dụng handleImageUpload
            try {
                String image = handleImageUpload(request);
                if (image != null && !image.isBlank()) {
                    brand.setImage(image);
                }
            } catch (Exception e) {
                LOGGER.log(Level.WARNING, "Lỗi khi xử lý upload image: " + e.getMessage(), e);
                // Tiếp tục tạo brand mà không có image nếu có lỗi
            }

            boolean success = Boolean.TRUE.equals(brandService.create(brand));
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/staff?action=brand");
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
            
            // Xử lý upload image sử dụng handleImageUpload
            try {
                String image = handleImageUpload(request);
                if (image != null && !image.isBlank()) {
                    brand.setImage(image);
                }else{
                    image = brand.getImage();
                    brand.setImage(image);
                }
            } catch (Exception e) {
                LOGGER.log(Level.WARNING, "Lỗi khi xử lý upload image: " + e.getMessage(), e);
                // Tiếp tục tạo brand mà không có image nếu có lỗi
            }

            if (activeStr != null) {
                brand.setIs_active(Boolean.parseBoolean(activeStr));
            }
            
            boolean success = Boolean.TRUE.equals(brandService.update(brand));
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/staff?action=brand");
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
				
				Path uploadDir = Paths.get(appRealPath, "uploads", "brands");
				Files.createDirectories(uploadDir);
				
				try (InputStream in = imagePart.getInputStream()) {
					Files.copy(in, uploadDir.resolve(safeName), StandardCopyOption.REPLACE_EXISTING);
				}
				
				return request.getContextPath() + "/uploads/brands/" + URLEncoder.encode(safeName, "UTF-8");
			}
		}
		return null;
	}
    
}