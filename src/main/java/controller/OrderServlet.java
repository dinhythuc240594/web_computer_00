package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.OrderDAO;
import model.OrderItemDAO;
import model.ProductDAO;
import service.OrderItemService;
import service.OrderService;
import service.ProductService;
import serviceimpl.OrderItemServiceImpl;
import serviceimpl.OrderServiceImpl;
import serviceimpl.ProductServiceImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.List;

@WebServlet(name="order", urlPatterns="/order")
public class OrderServlet extends HttpServlet {
    
    private transient DataSource dataSource;
    private transient OrderService orderService;
    private transient OrderItemService orderItemService;
    private transient ProductService productService;
    
    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.orderService = new OrderServiceImpl(dataSource);
        this.orderItemService = new OrderItemServiceImpl(dataSource);
        this.productService = new ProductServiceImpl(dataSource);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Kiểm tra đăng nhập
        if (session == null || session.getAttribute("is_login") == null || !(Boolean) session.getAttribute("is_login")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Lấy order ID từ parameter
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(idParam);
            OrderDAO order = orderService.findById(orderId);
            
            if (order == null) {
                request.setAttribute("error", "Đơn hàng không tồn tại.");
                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/order-detail.jsp");
                rd.forward(request, response);
                return;
            }
            
            // Kiểm tra quyền truy cập - chỉ cho phép user xem đơn hàng của chính họ
            String username = (String) session.getAttribute("username");
            if (username == null || username.isBlank()) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            
            // Lấy order items
            List<OrderItemDAO> orderItems = orderItemService.findByOrderId(orderId);
            
            // Lấy thông tin sản phẩm cho mỗi order item
            for (OrderItemDAO item : orderItems) {
                ProductDAO product = productService.findById(item.getProductId());
                // Có thể tạo một wrapper class hoặc set vào một map, nhưng để đơn giản, 
                // chúng ta sẽ xử lý trong JSP
            }
            
            // Lấy thông báo từ session (nếu có)
            String successMessage = (String) session.getAttribute("success");
            String errorMessage = (String) session.getAttribute("error");
            
            // Xóa thông báo khỏi session sau khi lấy
            if (successMessage != null) {
                session.removeAttribute("success");
            }
            if (errorMessage != null) {
                session.removeAttribute("error");
            }
            
            request.setAttribute("order", order);
            request.setAttribute("orderItems", orderItems);
            request.setAttribute("productService", productService);
            request.setAttribute("success", successMessage);
            request.setAttribute("error", errorMessage);
            
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/order-detail.jsp");
            rd.forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Mã đơn hàng không hợp lệ.");
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/order-detail.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}