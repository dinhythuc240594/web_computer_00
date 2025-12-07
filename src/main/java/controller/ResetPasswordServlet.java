package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.UserDAO;
import service.UserService;
import serviceimpl.UserServiceImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    private transient DataSource dataSource;
    private transient UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.userService = new UserServiceImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");

        if (token == null || token.isBlank()) {
            request.setAttribute("error", "Token không hợp lệ.");
            forwardToResetPassword(request, response);
            return;
        }

        // Kiểm tra token có hợp lệ không
        TokenValidationResult validation = validateToken(token);
        if (!validation.isValid) {
            request.setAttribute("error", validation.errorMessage);
            forwardToResetPassword(request, response);
            return;
        }

        request.setAttribute("token", token);
        forwardToResetPassword(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (token == null || token.isBlank()) {
            request.setAttribute("error", "Token không hợp lệ.");
            forwardToResetPassword(request, response);
            return;
        }

        if (newPassword == null || newPassword.isBlank() || confirmPassword == null || confirmPassword.isBlank()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ mật khẩu mới và xác nhận mật khẩu.");
            request.setAttribute("token", token);
            forwardToResetPassword(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp.");
            request.setAttribute("token", token);
            forwardToResetPassword(request, response);
            return;
        }

        if (newPassword.length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự.");
            request.setAttribute("token", token);
            forwardToResetPassword(request, response);
            return;
        }

        // Kiểm tra token
        TokenValidationResult validation = validateToken(token);
        if (!validation.isValid) {
            request.setAttribute("error", validation.errorMessage);
            forwardToResetPassword(request, response);
            return;
        }

        // Lấy user từ token
        UserDAO user = userService.findById(validation.userId);
        if (user == null) {
            request.setAttribute("error", "Không tìm thấy người dùng.");
            forwardToResetPassword(request, response);
            return;
        }

        // Cập nhật mật khẩu
        user.setPassword(newPassword);
        boolean success = Boolean.TRUE.equals(userService.update(user));

        if (success) {
            // Đánh dấu token đã sử dụng
            markTokenAsUsed(token);
            // Redirect về login với thông báo thành công
            response.sendRedirect(request.getContextPath() + "/login?message=password_changed");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật mật khẩu. Vui lòng thử lại.");
            request.setAttribute("token", token);
            forwardToResetPassword(request, response);
        }
    }

    private TokenValidationResult validateToken(String token) {
        String sql = "SELECT user_id, expires_at, used FROM password_reset_tokens WHERE token = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, token);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return new TokenValidationResult(false, "Token không tồn tại hoặc đã hết hạn.");
                }

                boolean used = rs.getBoolean("used");
                if (used) {
                    return new TokenValidationResult(false, "Token đã được sử dụng.");
                }

                Timestamp expiresAt = rs.getTimestamp("expires_at");
                if (expiresAt == null || expiresAt.toLocalDateTime().isBefore(LocalDateTime.now())) {
                    return new TokenValidationResult(false, "Token đã hết hạn.");
                }

                int userId = rs.getInt("user_id");
                return new TokenValidationResult(true, null, userId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new TokenValidationResult(false, "Có lỗi xảy ra khi xác thực token.");
        }
    }

    private void markTokenAsUsed(String token) {
        String sql = "UPDATE password_reset_tokens SET used = TRUE WHERE token = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, token);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void forwardToResetPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/auth/reset-password.jsp");
        rd.forward(request, response);
    }

    private static class TokenValidationResult {
        boolean isValid;
        String errorMessage;
        int userId;

        TokenValidationResult(boolean isValid, String errorMessage) {
            this.isValid = isValid;
            this.errorMessage = errorMessage;
        }

        TokenValidationResult(boolean isValid, String errorMessage, int userId) {
            this.isValid = isValid;
            this.errorMessage = errorMessage;
            this.userId = userId;
        }
    }
}

