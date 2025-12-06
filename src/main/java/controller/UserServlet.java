package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.OrderDAO;
import model.UserDAO;
import service.OrderService;
import service.UserService;
import serviceimpl.OrderServiceImpl;
import serviceimpl.UserServiceImpl;
import utilities.DataSourceUtil;
import utilities.FileUpload;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "user", urlPatterns = "/user")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024, maxRequestSize = 10 * 1024 * 1024) // 5MB file, 10MB request
public class UserServlet extends HttpServlet {

    private transient DataSource dataSource;
    private transient UserService userService;
    private transient OrderService orderService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.userService = new UserServiceImpl(dataSource);
        this.orderService = new OrderServiceImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("is_login") == null || !(Boolean) session.getAttribute("is_login")) {
            // Lưu URL để redirect sau khi đăng nhập
            session = request.getSession(true);
            session.setAttribute("redirectAfterLogin", request.getRequestURI());
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String username = (String) session.getAttribute("username");
        if (username == null || username.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserDAO currentUser = userService.findByUsername(username);
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "profile";
        }

        switch (action) {
            case "orders" -> showOrderHistory(request, response, currentUser);
            case "edit-profile" -> showEditProfile(request, response, currentUser);
            case "change-password" -> showChangePassword(request, response, currentUser);
            default -> showProfile(request, response, currentUser);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("is_login") == null || !(Boolean) session.getAttribute("is_login")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String username = (String) session.getAttribute("username");
        if (username == null || username.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserDAO currentUser = userService.findByUsername(username);
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "updateProfile";
        }

        switch (action) {
            case "changePassword" -> handleChangePassword(request, response, currentUser);
            case "updateProfile" -> handleUpdateProfile(request, response, currentUser);
            case "cancelOrder" -> handleCancelOrder(request, response, currentUser);
            default -> handleUpdateProfile(request, response, currentUser);
        }
    }

    private void showProfile(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {
        request.setAttribute("currentUser", currentUser);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/account/profile.jsp");
        rd.forward(request, response);
    }

    private void showEditProfile(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {
        request.setAttribute("currentUser", currentUser);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/account/edit-profile.jsp");
        rd.forward(request, response);
    }

    private void showChangePassword(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {
        request.setAttribute("currentUser", currentUser);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/account/change-password.jsp");
        rd.forward(request, response);
    }

    private void showOrderHistory(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {

        List<OrderDAO> allOrders = orderService.getAll();
        List<OrderDAO> userOrders = allOrders.stream()
                .filter(o -> o.getUser_id() == currentUser.getId())
                .collect(Collectors.toList());

        request.setAttribute("currentUser", currentUser);
        request.setAttribute("orders", userOrders);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/client/account/order.jsp");
        rd.forward(request, response);
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {

        // Reload user to preserve existing avatar if not updating
        UserDAO existingUser = userService.findById(currentUser.getId());
        if (existingUser != null && existingUser.getAvatar() != null) {
            currentUser.setAvatar(existingUser.getAvatar());
        }

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (fullname != null) currentUser.setFullname(fullname.trim());
        if (email != null) currentUser.setEmail(email.trim());
        if (phone != null) currentUser.setPhone(phone.trim());
        if (address != null) currentUser.setAddress(address.trim());

        // Handle avatar upload - only update if new file is provided
        try {
            Part avatarPart = request.getPart("avatar");
            if (avatarPart != null && avatarPart.getSize() > 0) {
                // Validate using FileUpload utility
                String contentType = avatarPart.getContentType();
                if (contentType != null && contentType.startsWith("image/")) {
                    // Validate file size (5MB max)
                    if (avatarPart.getSize() <= 5 * 1024 * 1024) {
                        // Read avatar bytes
                        try (InputStream is = avatarPart.getInputStream()) {
                            byte[] avatarBytes = is.readAllBytes();
                            if (avatarBytes.length > 0) {
                                currentUser.setAvatar(avatarBytes);
                            }
                        }
                    } else {
                        request.setAttribute("errorMessage", "Kích thước file ảnh vượt quá 5MB.");
                        showEditProfile(request, response, currentUser);
                        return;
                    }
                } else if (avatarPart.getSize() > 0) {
                    request.setAttribute("errorMessage", "Chỉ chấp nhận file ảnh (JPG, PNG, GIF, WebP).");
                    showEditProfile(request, response, currentUser);
                    return;
                }
            }
            // If no avatar part or empty, keep existing avatar (already set above)
        } catch (Exception e) {
            // If error getting part, keep existing avatar (already set above)
        }

        boolean success = Boolean.TRUE.equals(userService.update(currentUser));

        if (success) {
            // Redirect về trang profile sau khi cập nhật thành công
            response.sendRedirect(request.getContextPath() + "/user?success=updated");
            return;
        } else {
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật thông tin. Vui lòng thử lại.");
            showEditProfile(request, response, currentUser);
        }
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (currentPassword == null || newPassword == null || confirmPassword == null
                || currentPassword.isBlank() || newPassword.isBlank() || confirmPassword.isBlank()) {
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ các trường mật khẩu.");
            showProfile(request, response, currentUser);
            return;
        }

        if (!currentPassword.equals(currentUser.getPassword())) {
            request.setAttribute("errorMessage", "Mật khẩu hiện tại không chính xác.");
            showProfile(request, response, currentUser);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu mới và xác nhận mật khẩu không khớp.");
            showProfile(request, response, currentUser);
            return;
        }

        currentUser.setPassword(newPassword);
        boolean success = Boolean.TRUE.equals(userService.update(currentUser));

        if (success) {
            // Invalidate session và yêu cầu đăng nhập lại
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            // Redirect về trang login với thông báo
            response.sendRedirect(request.getContextPath() + "/login?message=password_changed");
            return;
        } else {
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi đổi mật khẩu. Vui lòng thử lại.");
            showChangePassword(request, response, currentUser);
        }
    }

    private void handleCancelOrder(HttpServletRequest request, HttpServletResponse response, UserDAO currentUser)
            throws ServletException, IOException {

        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null || orderIdParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/user?action=orders&error=invalid_order");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdParam);
            OrderDAO order = orderService.findById(orderId);

            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/user?action=orders&error=order_not_found");
                return;
            }

            // Kiểm tra quyền - chỉ cho phép user hủy đơn hàng của chính họ
            if (order.getUser_id() != currentUser.getId()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền hủy đơn hàng này.");
                return;
            }

            // Chỉ cho phép hủy đơn hàng khi trạng thái là PENDING
            if (order.getStatus() == null || !order.getStatus().equalsIgnoreCase("PENDING")) {
                response.sendRedirect(request.getContextPath() + "/user?action=orders&error=cannot_cancel");
                return;
            }

            // Cập nhật trạng thái đơn hàng thành CANCELLED và is_active = false
            order.setStatus("CANCELLED");
            order.setIs_active(false);
            boolean success = Boolean.TRUE.equals(orderService.update(order));

            if (success) {
                response.sendRedirect(request.getContextPath() + "/user?action=orders&success=order_cancelled");
            } else {
                response.sendRedirect(request.getContextPath() + "/user?action=orders&error=cancel_failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/user?action=orders&error=invalid_order");
        }
    }
}