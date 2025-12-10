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
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Collections;
import java.util.List;
import java.util.UUID;
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
            
            // Xử lý upload image sử dụng handleImageUpload
            try {
                String image = handleImageUpload(request);
                if (image != null && !image.isBlank()) {
                    category.setImage(image);
                }
            } catch (Exception e) {
                LOGGER.log(Level.WARNING, "Lỗi khi xử lý upload logo: " + e.getMessage(), e);
                // Tiếp tục tạo category mà không có logo nếu có lỗi
            }
            
            boolean success = Boolean.TRUE.equals(categoryService.create(category));
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/staff?action=categories");
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
            } else{
                category.setIs_active(false);
            }
            
            // Xử lý upload image sử dụng handleImageUpload
            try {
                String image = handleImageUpload(request);
                if (image != null && !image.isBlank()) {
                    category.setImage(image);
                }else{
					image = category.getImage();
                    category.setImage(image);
				}
            } catch (Exception e) {
                LOGGER.log(Level.WARNING, "Lỗi khi xử lý upload logo: " + e.getMessage(), e);
                // Tiếp tục tạo category mà không có logo nếu có lỗi
            }
            
            boolean success = Boolean.TRUE.equals(categoryService.update(category));
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/staff?action=categories");
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

	private String handleImageUpload(HttpServletRequest request) throws IOException, ServletException {
		Part imagePart = request.getPart("image");
		if (imagePart != null && imagePart.getSize() > 0) {
			String contentType = imagePart.getContentType();
			if (contentType != null && contentType.startsWith("image/")) {
				// Validate file size (5MB max)
				if (imagePart.getSize() > 5 * 1024 * 1024) {
					throw new ServletException("Kích thước file logo vượt quá 5MB.");
				}
				
				String submitted = imagePart.getSubmittedFileName();
				if (submitted == null || submitted.isEmpty()) {
					return null;
				}
				
				String fileName = Paths.get(submitted).getFileName().toString();
				String ext = fileName.contains(".") ? fileName.substring(fileName.lastIndexOf(".")) : ".jpg";
				String safeName = UUID.randomUUID().toString().replace("-", "") + ext.toLowerCase();
				
				String appRealPath = request.getServletContext().getRealPath("");
				if (appRealPath == null) {
					appRealPath = System.getProperty("user.home") + "/uploads";
				}
				
				Path uploadDir = Paths.get(appRealPath, "uploads", "categories");
				Files.createDirectories(uploadDir);
				
				try (InputStream in = imagePart.getInputStream()) {
					Files.copy(in, uploadDir.resolve(safeName), StandardCopyOption.REPLACE_EXISTING);
				}
				
				return request.getContextPath() + "/uploads/categories/" + URLEncoder.encode(safeName, StandardCharsets.UTF_8);
			} else {
				throw new ServletException("Chỉ chấp nhận file ảnh (JPG, PNG, GIF, WebP).");
			}
		}
		return null;
	}

}