package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CartItem;
import model.ProductDAO;
import repository.ProductRepository;
import repositoryimpl.ProductRepositoryImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "cart", urlPatterns = "/cart")
public class CartServlet extends HttpServlet {

    private transient DataSource dataSource;
    private transient ProductRepository productRepository;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.productRepository = new ProductRepositoryImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Hiển thị trang giỏ hàng
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/cart.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            handleAddToCart(request, response);
        } else if ("remove".equals(action)) {
            handleRemoveFromCart(request, response);
        } else if ("update".equals(action)) {
            handleUpdateCart(request, response);
        } else if ("sync".equals(action)) {
            handleSyncCart(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    private void handleAddToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");
        
        if (productIdStr == null || productIdStr.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = 1;
            if (quantityStr != null && !quantityStr.isBlank()) {
                quantity = Integer.parseInt(quantityStr);
            }
            
            if (quantity <= 0) {
                quantity = 1;
            }
            
            ProductDAO product = productRepository.findById(productId);
            if (product == null || !product.getIs_active()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
            
            // Lấy giỏ hàng từ session
            @SuppressWarnings("unchecked")
            List<CartItem> cartItems = (List<CartItem>) request.getSession().getAttribute("cartItems");
            if (cartItems == null) {
                cartItems = new ArrayList<>();
                request.getSession().setAttribute("cartItems", cartItems);
            }
            
            // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
            boolean found = false;
            for (CartItem item : cartItems) {
                if (item.getProduct() != null && item.getProduct().getId() == productId) {
                    // Cập nhật số lượng
                    item.setQuantity(item.getQuantity() + quantity);
                    found = true;
                    break;
                }
            }
            
            // Nếu chưa có, thêm mới
            if (!found) {
                cartItems.add(new CartItem(product, quantity));
            }
            
            // Redirect về trang trước hoặc giỏ hàng
            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/cart");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    private void handleRemoveFromCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String productIdStr = request.getParameter("productId");
        
        if (productIdStr == null || productIdStr.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        try {
            int productId = Integer.parseInt(productIdStr);
            
            // Lấy giỏ hàng từ session
            @SuppressWarnings("unchecked")
            List<CartItem> cartItems = (List<CartItem>) request.getSession().getAttribute("cartItems");
            if (cartItems != null) {
                cartItems.removeIf(item -> 
                    item.getProduct() != null && item.getProduct().getId() == productId
                );
            }
            
            // Redirect về trang trước hoặc giỏ hàng
            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/cart");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    private void handleUpdateCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");
        
        if (productIdStr == null || productIdStr.isBlank() || quantityStr == null || quantityStr.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);
            
            if (quantity <= 0) {
                // Nếu số lượng <= 0, xóa sản phẩm
                handleRemoveFromCart(request, response);
                return;
            }
            
            // Lấy giỏ hàng từ session
            @SuppressWarnings("unchecked")
            List<CartItem> cartItems = (List<CartItem>) request.getSession().getAttribute("cartItems");
            if (cartItems != null) {
                for (CartItem item : cartItems) {
                    if (item.getProduct() != null && item.getProduct().getId() == productId) {
                        item.setQuantity(quantity);
                        break;
                    }
                }
            }
            
            response.sendRedirect(request.getContextPath() + "/cart");
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    private void handleSyncCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        java.io.PrintWriter out = null;
        try {
            // Set response type
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out = response.getWriter();
            
            // Lấy dữ liệu giỏ hàng từ parameter
            String json = request.getParameter("cartData");
            
            if (json == null || json.isBlank()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"success\": false, \"message\": \"No data provided\"}");
                out.flush();
                return;
            }
            
            // Parse JSON đơn giản - tìm các productId và quantity
            // Format: {"items":[{"id":1,"quantity":2},{"id":3,"quantity":1}]}
            List<CartItem> cartItems = new ArrayList<>();
            
            // Tìm tất cả các object trong mảng items
            int itemsStart = json.indexOf("\"items\":[");
            if (itemsStart == -1) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"success\": false, \"message\": \"Invalid data format\"}");
                out.flush();
                return;
            }
            
            int arrayStart = json.indexOf("[", itemsStart) + 1;
            int arrayEnd = json.lastIndexOf("]");
            
            if (arrayStart > 0 && arrayEnd > arrayStart) {
                String itemsStr = json.substring(arrayStart, arrayEnd);
                
                // Parse từng item: {"id":1,"quantity":2}
                int pos = 0;
                while (pos < itemsStr.length()) {
                    int objStart = itemsStr.indexOf("{", pos);
                    if (objStart == -1) break;
                    
                    int objEnd = itemsStr.indexOf("}", objStart);
                    if (objEnd == -1) break;
                    
                    String itemStr = itemsStr.substring(objStart, objEnd + 1);
                    
                    // Extract id và quantity
                    int idStart = itemStr.indexOf("\"id\":");
                    int quantityStart = itemStr.indexOf("\"quantity\":");
                    
                    if (idStart != -1 && quantityStart != -1) {
                        int idValueStart = itemStr.indexOf(":", idStart) + 1;
                        int idValueEnd = itemStr.indexOf(",", idValueStart);
                        if (idValueEnd == -1) idValueEnd = itemStr.indexOf("}", idValueStart);
                        
                        int quantityValueStart = itemStr.indexOf(":", quantityStart) + 1;
                        int quantityValueEnd = itemStr.indexOf(",", quantityValueStart);
                        if (quantityValueEnd == -1) quantityValueEnd = itemStr.indexOf("}", quantityValueStart);
                        
                        try {
                            String idStr = itemStr.substring(idValueStart, idValueEnd).trim();
                            String quantityStr = itemStr.substring(quantityValueStart, quantityValueEnd).trim();
                            
                            int productId = Integer.parseInt(idStr);
                            int quantity = Integer.parseInt(quantityStr);
                            
                            if (quantity > 0) {
                                ProductDAO product = productRepository.findById(productId);
                                if (product != null && product.getIs_active()) {
                                    cartItems.add(new CartItem(product, quantity));
                                }
                            }
                        } catch (NumberFormatException e) {
                            // Skip invalid item
                        }
                    }
                    
                    pos = objEnd + 1;
                }
            }
            
            // Lưu vào session
            request.getSession().setAttribute("cartItems", cartItems);
            
            // Trả về success
            String result = "{\"success\": true, \"message\": \"Cart synced successfully\", \"itemCount\": " + cartItems.size() + "}";
            out.write(result);
            out.flush();
            
        } catch (Exception e) {
            e.printStackTrace();
            if (out != null) {
                try {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    String errorMsg = e.getMessage() != null ? e.getMessage().replace("\"", "\\\"").replace("\n", " ").replace("\r", " ") : "Unknown error";
                    out.write("{\"success\": false, \"message\": \"Error syncing cart: " + errorMsg + "\"}");
                    out.flush();
                } catch (Exception ex) {
                    // Ignore
                }
            }
        } finally {
            if (out != null) {
                try {
                    out.close();
                } catch (Exception e) {
                    // Ignore
                }
            }
        }
    }
}

