package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.EmailRequest;
import model.OrderDAO;
import model.OrderItemDAO;
import model.ProductDAO;
import model.UserDAO;
import repositoryimpl.OrderItemRepositoryImpl;
import repositoryimpl.OrderRepositoryImpl;
import service.EmailService;
import service.OrderItemService;
import service.OrderService;
import service.ProductService;
import service.UserService;
import serviceimpl.OrderItemServiceImpl;
import serviceimpl.OrderServiceImpl;
import serviceimpl.ProductServiceImpl;
import serviceimpl.SmtpEmailService;
import serviceimpl.UserServiceImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Date;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@WebServlet(name = "checkout", urlPatterns = "/checkout")
public class CheckoutServlet extends HttpServlet {

    private transient DataSource dataSource;
    private transient OrderService orderService;
    private transient OrderItemService orderItemService;
    private transient UserService userService;
    private transient ProductService productService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.orderService = new OrderServiceImpl(dataSource);
        this.orderItemService = new OrderItemServiceImpl(dataSource);
        this.userService = new UserServiceImpl(dataSource);
        this.productService = new ProductServiceImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Kiểm tra đăng nhập
        if (session == null || session.getAttribute("is_login") == null || !(Boolean) session.getAttribute("is_login")) {
            session = request.getSession(true);
            session.setAttribute("redirectAfterLogin", request.getRequestURI());
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy tên username từ session
        String username = (String) session.getAttribute("username");
        if (username == null || username.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Kiểm tra giỏ hàng
        @SuppressWarnings("unchecked")
        List<CartItem> cartItems = session != null ? (List<CartItem>) session.getAttribute("cartItems") : null;
        
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
        
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("is_login") == null || !(Boolean) session.getAttribute("is_login")) {
            session = request.getSession(true);
            session.setAttribute("redirectAfterLogin", request.getRequestURI());
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Lấy user ID từ session
        String username = (String) session.getAttribute("username");
        int userId = 0;
        
        if (username != null && !username.isBlank()) {
            UserDAO user = userService.findByUsername(username);
            if (user != null) {
                userId = user.getId();
            }
        }
        
        // Nếu không có user, yêu cầu đăng nhập
        if (userId == 0) {
            session.setAttribute("redirectAfterLogin", request.getRequestURI());
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Lấy địa chỉ giao hàng
        String fullAddress = address != null ? address : "";
        
        // Tạo đơn hàng với đầy đủ thông tin
        OrderDAO order = new OrderDAO();
        order.setUser_id(userId);
        order.setOrderDate(new Date(System.currentTimeMillis()));
        order.setStatus("PENDING"); // Trạng thái chờ xử lý (theo ENUM trong database)
        order.setTotalPrice(total);
        order.setAddress(fullAddress);
        order.setPayment(paymentMethod != null && !paymentMethod.isBlank() ? paymentMethod : "bank_transfer");
        order.setNote(note != null ? note : "");
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
        
        // Tạo các order items và cập nhật số lượng sản phẩm
        boolean allItemsCreated = true;
        OrderItemRepositoryImpl orderItemRepo = new OrderItemRepositoryImpl(dataSource);
        
        for (CartItem cartItem : cartItems) {
            if (cartItem.getProduct() == null) {
                continue;
            }
            
            int productId = cartItem.getProduct().getId();
            int quantity = cartItem.getQuantity();
            
            // Kiểm tra số lượng tồn kho
            ProductDAO product = productService.findById(productId);
            if (product == null) {
                request.setAttribute("error", "Sản phẩm không tồn tại hoặc đã bị xóa.");
                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/checkout.jsp");
                rd.forward(request, response);
                return;
            }
            
            if (product.getStock_quantity() < quantity) {
                request.setAttribute("error", "Sản phẩm " + product.getName() + " không đủ số lượng. Số lượng còn lại: " + product.getStock_quantity());
                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/checkout.jsp");
                rd.forward(request, response);
                return;
            }
            
            // Tạo order item
            OrderItemDAO orderItem = new OrderItemDAO();
            orderItem.setOrderId(orderId);
            orderItem.setProductId(productId);
            orderItem.setQuantity(quantity);
            orderItem.setPrice(cartItem.getProduct().getPrice() != null ? cartItem.getProduct().getPrice() : 0.0);
            
            if (!orderItemRepo.create(orderItem)) {
                allItemsCreated = false;
                break;
            }
            
            // Cập nhật số lượng sản phẩm (giảm stock)
            int newStock = product.getStock_quantity() - quantity;
            product.setStock_quantity(newStock);
            if (!productService.update(product)) {
                // Nếu cập nhật stock thất bại, có thể rollback hoặc để admin xử lý
                System.err.println("Lỗi khi cập nhật số lượng sản phẩm ID: " + productId);
            }
        }
        
        if (!allItemsCreated) {
            // Nếu có lỗi khi tạo order items, có thể xóa order đã tạo hoặc để admin xử lý
            request.setAttribute("error", "Có lỗi xảy ra khi tạo chi tiết đơn hàng. Vui lòng liên hệ admin.");
            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/checkout.jsp");
            rd.forward(request, response);
            return;
        }
        
        // Gửi email xác nhận đơn hàng
        boolean emailSent = false;
        String emailError = null;
        try {
            EmailService emailService = new SmtpEmailService();
            EmailRequest emailRequest = createOrderConfirmationEmail(order, cartItems, fullName, email, total, subtotal, shippingFee);
            emailService.send(getServletContext(), emailRequest, null);
            emailSent = true;
        } catch (Exception e) {
            emailError = e.getMessage();
            System.err.println("Lỗi khi gửi email xác nhận đơn hàng: " + e.getMessage());
            e.printStackTrace();
        }
        
        // Xóa giỏ hàng sau khi đặt hàng thành công
        session.removeAttribute("cartItems");
        
        // Lưu thông báo vào session để hiển thị ở trang order detail
        if (emailSent) {
            session.setAttribute("success", "Đặt hàng thành công! Mã đơn hàng: #" + orderId + ". Email xác nhận đã được gửi đến " + email);
        } else {
            session.setAttribute("success", "Đặt hàng thành công! Mã đơn hàng: #" + orderId + ". Lưu ý: Không thể gửi email xác nhận.");
            if (emailError != null) {
                System.err.println("Chi tiết lỗi email: " + emailError);
            }
        }
        
        // Redirect đến trang order detail
        response.sendRedirect(request.getContextPath() + "/order?id=" + orderId);
    }
    
    private EmailRequest createOrderConfirmationEmail(OrderDAO order, List<CartItem> cartItems, 
                                                     String fullName, String email, 
                                                     double total, double subtotal, double shippingFee) {
        EmailRequest emailRequest = new EmailRequest();
        
        // Địa chỉ người nhận
        List<String> toList = new ArrayList<>();
        toList.add(email);
        emailRequest.setTo(toList);
        
        // Tiêu đề email
        emailRequest.setSubject("Xác nhận đơn hàng #" + order.getId() + " - HCMUTE Computer Store");
        
        // Tạo nội dung HTML cho email
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        StringBuilder htmlBody = new StringBuilder();
        htmlBody.append("<!DOCTYPE html>");
        htmlBody.append("<html lang='vi'>");
        htmlBody.append("<head><meta charset='UTF-8'></head>");
        htmlBody.append("<body style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>");
        htmlBody.append("<div style='max-width: 600px; margin: 0 auto; padding: 20px;'>");
        
        // Header
        htmlBody.append("<div style='background-color: #4CAF50; color: white; padding: 20px; text-align: center; border-radius: 5px 5px 0 0;'>");
        htmlBody.append("<h1 style='margin: 0;'>Cảm ơn bạn đã đặt hàng!</h1>");
        htmlBody.append("</div>");
        
        // Content
        htmlBody.append("<div style='background-color: #f9f9f9; padding: 20px; border: 1px solid #ddd;'>");
        htmlBody.append("<p>Xin chào <strong>").append(fullName).append("</strong>,</p>");
        htmlBody.append("<p>Chúng tôi đã nhận được đơn hàng của bạn. Dưới đây là thông tin chi tiết:</p>");
        
        // Order info
        htmlBody.append("<div style='background-color: white; padding: 15px; margin: 15px 0; border-radius: 5px;'>");
        htmlBody.append("<h3 style='margin-top: 0; color: #4CAF50;'>Thông tin đơn hàng</h3>");
        htmlBody.append("<p><strong>Mã đơn hàng:</strong> #").append(order.getId()).append("</p>");
        htmlBody.append("<p><strong>Ngày đặt:</strong> ").append(order.getOrderDate()).append("</p>");
        htmlBody.append("<p><strong>Trạng thái:</strong> ").append(order.getStatus()).append("</p>");
        htmlBody.append("<p><strong>Phương thức thanh toán:</strong> ");
        if ("cod".equalsIgnoreCase(order.getPayment())) {
            htmlBody.append("Thanh toán khi nhận hàng (COD)");
        } else {
            htmlBody.append("Chuyển khoản ngân hàng");
        }
        htmlBody.append("</p>");
        htmlBody.append("<p><strong>Địa chỉ giao hàng:</strong> ").append(order.getAddress()).append("</p>");
        if (order.getNote() != null && !order.getNote().isBlank()) {
            htmlBody.append("<p><strong>Ghi chú:</strong> ").append(order.getNote()).append("</p>");
        }
        htmlBody.append("</div>");
        
        // Order items
        htmlBody.append("<div style='background-color: white; padding: 15px; margin: 15px 0; border-radius: 5px;'>");
        htmlBody.append("<h3 style='margin-top: 0; color: #4CAF50;'>Chi tiết sản phẩm</h3>");
        htmlBody.append("<table style='width: 100%; border-collapse: collapse;'>");
        htmlBody.append("<thead><tr style='background-color: #f0f0f0;'>");
        htmlBody.append("<th style='padding: 10px; text-align: left; border-bottom: 2px solid #ddd;'>Sản phẩm</th>");
        htmlBody.append("<th style='padding: 10px; text-align: center; border-bottom: 2px solid #ddd;'>Số lượng</th>");
        htmlBody.append("<th style='padding: 10px; text-align: right; border-bottom: 2px solid #ddd;'>Thành tiền</th>");
        htmlBody.append("</tr></thead>");
        htmlBody.append("<tbody>");
        
        for (CartItem item : cartItems) {
            if (item.getProduct() != null) {
                String productName = item.getProduct().getName();
                int quantity = item.getQuantity();
                double price = item.getProduct().getPrice() != null ? item.getProduct().getPrice() : 0.0;
                double lineTotal = price * quantity;
                
                htmlBody.append("<tr>");
                htmlBody.append("<td style='padding: 10px; border-bottom: 1px solid #eee;'>").append(productName).append("</td>");
                htmlBody.append("<td style='padding: 10px; text-align: center; border-bottom: 1px solid #eee;'>").append(quantity).append("</td>");
                htmlBody.append("<td style='padding: 10px; text-align: right; border-bottom: 1px solid #eee;'>").append(currencyFormat.format(lineTotal)).append("</td>");
                htmlBody.append("</tr>");
            }
        }
        
        htmlBody.append("</tbody>");
        htmlBody.append("</table>");
        htmlBody.append("</div>");
        
        // Summary
        htmlBody.append("<div style='background-color: white; padding: 15px; margin: 15px 0; border-radius: 5px;'>");
        htmlBody.append("<table style='width: 100%;'>");
        htmlBody.append("<tr><td style='padding: 5px;'>Tạm tính:</td><td style='text-align: right; padding: 5px;'>").append(currencyFormat.format(subtotal)).append("</td></tr>");
        htmlBody.append("<tr><td style='padding: 5px;'>Phí vận chuyển:</td><td style='text-align: right; padding: 5px;'>").append(currencyFormat.format(shippingFee)).append("</td></tr>");
        htmlBody.append("<tr style='font-size: 1.2em; font-weight: bold; border-top: 2px solid #4CAF50;'>");
        htmlBody.append("<td style='padding: 10px 5px;'>Tổng cộng:</td>");
        htmlBody.append("<td style='text-align: right; padding: 10px 5px; color: #4CAF50;'>").append(currencyFormat.format(total)).append("</td>");
        htmlBody.append("</tr>");
        htmlBody.append("</table>");
        htmlBody.append("</div>");
        
        // Footer
        htmlBody.append("<p style='margin-top: 20px;'>Chúng tôi sẽ xử lý đơn hàng của bạn trong thời gian sớm nhất.</p>");
        htmlBody.append("<p>Nếu có bất kỳ thắc mắc nào, vui lòng liên hệ với chúng tôi.</p>");
        htmlBody.append("<p>Trân trọng,<br><strong>HCMUTE Computer Store</strong></p>");
        htmlBody.append("</div>");
        htmlBody.append("</div>");
        htmlBody.append("</body>");
        htmlBody.append("</html>");
        
        emailRequest.setHtmlBody(htmlBody.toString());
        
        // Text body (fallback)
        StringBuilder textBody = new StringBuilder();
        textBody.append("Cảm ơn bạn đã đặt hàng!\n\n");
        textBody.append("Mã đơn hàng: #").append(order.getId()).append("\n");
        textBody.append("Ngày đặt: ").append(order.getOrderDate()).append("\n");
        textBody.append("Tổng tiền: ").append(currencyFormat.format(total)).append("\n\n");
        textBody.append("Chúng tôi sẽ xử lý đơn hàng của bạn trong thời gian sớm nhất.");
        emailRequest.setTextBody(textBody.toString());
        
        return emailRequest;
    }
}

