package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.EmailRequest;
import model.UserDAO;
import service.EmailService;
import service.UserService;
import serviceimpl.SmtpEmailService;
import serviceimpl.UserServiceImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private transient DataSource dataSource;
    private transient UserService userService;
    private transient EmailService emailService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.userService = new UserServiceImpl(dataSource);
        this.emailService = new SmtpEmailService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");

        if (username == null || username.isBlank() || email == null || email.isBlank()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ tên đăng nhập và email.");
            forwardToForgotPassword(request, response);
            return;
        }

        // Tìm user theo username
        UserDAO user = userService.findByUsername(username);
        if (user == null) {
            request.setAttribute("error", "Tên đăng nhập không tồn tại.");
            forwardToForgotPassword(request, response);
            return;
        }

        // Kiểm tra email có khớp không
        if (!email.equalsIgnoreCase(user.getEmail())) {
            request.setAttribute("error", "Email không khớp với tài khoản.");
            forwardToForgotPassword(request, response);
            return;
        }

        // Tạo token
        String token = generateToken();
        LocalDateTime expiresAt = LocalDateTime.now().plusHours(1); // Token hết hạn sau 1 giờ

        // Lưu token vào database
        if (saveToken(user.getId(), token, expiresAt)) {
            // Gửi email
            try {
                sendResetEmail(user.getEmail(), token, request);
                request.setAttribute("success", "Chúng tôi đã gửi link đặt lại mật khẩu vào email của bạn. Vui lòng kiểm tra hộp thư.");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Có lỗi xảy ra khi gửi email. Vui lòng thử lại sau.");
            }
        } else {
            request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại sau.");
        }

        forwardToForgotPassword(request, response);
    }

    private String generateToken() {
        SecureRandom random = new SecureRandom();
        byte[] bytes = new byte[32];
        random.nextBytes(bytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
    }

    private boolean saveToken(int userId, String token, LocalDateTime expiresAt) {
        // Xóa token cũ của user (nếu có)
        String deleteSql = "DELETE FROM password_reset_tokens WHERE user_id = ?";
        
        // Thêm token mới
        String insertSql = "INSERT INTO password_reset_tokens (user_id, token, expires_at, used) VALUES (?, ?, ?, FALSE)";

        try (Connection conn = dataSource.getConnection()) {
            // Xóa token cũ
            try (PreparedStatement ps = conn.prepareStatement(deleteSql)) {
                ps.setInt(1, userId);
                ps.executeUpdate();
            }

            // Thêm token mới
            try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                ps.setInt(1, userId);
                ps.setString(2, token);
                ps.setTimestamp(3, Timestamp.valueOf(expiresAt));
                ps.executeUpdate();
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private void sendResetEmail(String userEmail, String token, HttpServletRequest request) throws Exception {
        String resetUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() 
                + request.getContextPath() + "/reset-password?token=" + token;

        EmailRequest emailReq = new EmailRequest();
        emailReq.setTo(new ArrayList<>(List.of(userEmail)));
        emailReq.setSubject("Đặt lại mật khẩu - Cửa hàng máy tính HCMUTE");

        String htmlBody = "<html><body style='font-family: Arial, sans-serif;'>" +
                "<h2 style='color: #333;'>Đặt lại mật khẩu</h2>" +
                "<p>Xin chào,</p>" +
                "<p>Bạn đã yêu cầu đặt lại mật khẩu cho tài khoản của mình.</p>" +
                "<p>Vui lòng click vào link sau để đặt lại mật khẩu:</p>" +
                "<p><a href='" + resetUrl + "' style='background-color: #4CAF50; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block;'>Đặt lại mật khẩu</a></p>" +
                "<p>Hoặc copy link sau vào trình duyệt:</p>" +
                "<p style='word-break: break-all; color: #666;'>" + resetUrl + "</p>" +
                "<p>Link này sẽ hết hạn sau 1 giờ.</p>" +
                "<p>Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.</p>" +
                "<p>Trân trọng,<br>Cửa hàng máy tính HCMUTE</p>" +
                "</body></html>";

        String textBody = "Đặt lại mật khẩu\n\n" +
                "Bạn đã yêu cầu đặt lại mật khẩu cho tài khoản của mình.\n\n" +
                "Vui lòng truy cập link sau để đặt lại mật khẩu:\n" + resetUrl + "\n\n" +
                "Link này sẽ hết hạn sau 1 giờ.\n\n" +
                "Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.\n\n" +
                "Trân trọng,\nCửa hàng máy tính HCMUTE";

        emailReq.setHtmlBody(htmlBody);
        emailReq.setTextBody(textBody);

        emailService.send(getServletContext(), emailReq, null);
    }

    private void forwardToForgotPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp");
        rd.forward(request, response);
    }
}

