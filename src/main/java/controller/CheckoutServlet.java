package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CartItem;
import model.OrderDAO;
import model.OrderItemDAO;
import model.UserDAO;
import repositoryimpl.OrderItemRepositoryImpl;
import repositoryimpl.OrderRepositoryImpl;
import service.OrderItemService;
import service.OrderService;
import service.UserService;
import serviceimpl.OrderItemServiceImpl;
import serviceimpl.OrderServiceImpl;
import serviceimpl.UserServiceImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "checkout", urlPatterns = "/checkout")
public class CheckoutServlet extends HttpServlet {

    private transient DataSource dataSource;
    private transient OrderService orderService;
    private transient OrderItemService orderItemService;
    private transient UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.orderService = new OrderServiceImpl(dataSource);
        this.orderItemService = new OrderItemServiceImpl(dataSource);
        this.userService = new UserServiceImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra giỏ hàng
        @SuppressWarnings("unchecked")
        List<CartItem> cartItems = (List<CartItem>) request.getSession().getAttribute("cartItems");
        
        if (cartItems == null || cartItems.isEmpty()) {
            // Nếu giỏ hàng trống, redirect về trang giỏ hàng
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Hiển thị trang checkout
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/checkout.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy giỏ hàng từ session
        @SuppressWarnings("unchecked")
        List<CartItem> cartItems = (List<CartItem>) request.getSession().getAttribute("cartItems");
        
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Lấy thông tin từ form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String zip = request.getParameter("zip");
        String paymentMethod = request.getParameter("payment");
        String note = request.getParameter("note");
        
        // Validate thông tin bắt buộc
        if (fullName == null || fullName.isBlank() ||
            email == null || email.isBlank() ||
            phone == null || phone.isBlank() ||
            address == null || address.isBlank()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin bắt buộc.");
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/checkout.jsp");
            rd.forward(request, response);
            return;
        }
        
        // Tính tổng tiền
        double subtotal = 0.0;
        for (CartItem item : cartItems) {
            if (item.getProduct() != null && item.getProduct().getPrice() != null) {
                subtotal += item.getProduct().getPrice() * item.getQuantity();
            }
        }
        
        double freeShipThreshold = 500000;
        double shippingFee = subtotal >= freeShipThreshold || subtotal == 0 ? 0 : 30000;
        double total = subtotal + shippingFee;
        
        // Lấy user ID từ session
        String username = (String) request.getSession().getAttribute("username");
        int userId = 0;
        
        if (username != null && !username.isBlank()) {
            UserDAO user = userService.findByUsername(username);
            if (user != null) {
                userId = user.getId();
            }
        }
        
        // Nếu không có user (guest checkout), có thể tạo user mới hoặc để userId = 0
        // Ở đây giả sử cần đăng nhập để checkout
        if (userId == 0) {
            request.setAttribute("error", "Vui lòng đăng nhập để thanh toán.");
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/checkout.jsp");
            rd.forward(request, response);
            return;
        }
        
        // Tạo địa chỉ giao hàng đầy đủ
        StringBuilder fullAddress = new StringBuilder();
        if (address != null && !address.isBlank()) {
            fullAddress.append(address);
        }
        if (city != null && !city.isBlank()) {
            if (fullAddress.length() > 0) {
                fullAddress.append(", ");
            }
            fullAddress.append(city);
        }
        if (zip != null && !zip.isBlank()) {
            if (fullAddress.length() > 0) {
                fullAddress.append(", ");
            }
            fullAddress.append(zip);
        }
        
        // Tạo đơn hàng
        OrderDAO order = new OrderDAO();
        order.setUser_id(userId);
        order.setOrderDate(new Date(System.currentTimeMillis()));
        order.setStatus("pending"); // Trạng thái chờ xử lý
        order.setTotalPrice(total);
        order.setAddress(fullAddress.toString());
        order.setPayment(paymentMethod != null && !paymentMethod.isBlank() ? paymentMethod : "bank_transfer");
        order.setNote(note);
        order.setIs_active(true);
        
        // Lưu đơn hàng và lấy ID
        boolean orderCreated = orderService.create(order);
        
        if (!orderCreated || order.getId() == 0) {
            request.setAttribute("error", "Có lỗi xảy ra khi tạo đơn hàng. Vui lòng thử lại.");
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/checkout.jsp");
            rd.forward(request, response);
            return;
        }
        
        int orderId = order.getId();
        
        // Tạo các order items
        boolean allItemsCreated = true;
        OrderItemRepositoryImpl orderItemRepo = new OrderItemRepositoryImpl(dataSource);
        
        for (CartItem cartItem : cartItems) {
            if (cartItem.getProduct() == null) {
                continue;
            }
            
            OrderItemDAO orderItem = new OrderItemDAO();
            orderItem.setOrderId(orderId);
            orderItem.setProductId(cartItem.getProduct().getId());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPrice(cartItem.getProduct().getPrice() != null ? cartItem.getProduct().getPrice() : 0.0);
            
            if (!orderItemRepo.create(orderItem)) {
                allItemsCreated = false;
                break;
            }
        }
        
        if (!allItemsCreated) {
            // Nếu có lỗi khi tạo order items, có thể xóa order đã tạo hoặc để admin xử lý
            request.setAttribute("error", "Có lỗi xảy ra khi tạo chi tiết đơn hàng. Vui lòng liên hệ admin.");
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/checkout.jsp");
            rd.forward(request, response);
            return;
        }
        
        // Xóa giỏ hàng sau khi đặt hàng thành công
        request.getSession().removeAttribute("cartItems");
        
        // Redirect đến trang thành công hoặc trang đơn hàng
        request.setAttribute("orderId", orderId);
        request.setAttribute("success", "Đặt hàng thành công! Mã đơn hàng: " + orderId);
        
        // Có thể redirect đến trang order detail hoặc hiển thị thông báo
        response.sendRedirect(request.getContextPath() + "/order?id=" + orderId);
    }
}

