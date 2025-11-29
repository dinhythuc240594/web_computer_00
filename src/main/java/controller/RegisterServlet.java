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

@WebServlet("/auth/register")
public class RegisterServlet extends HttpServlet {

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
        forwardToRegister(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String agreeTerm = request.getParameter("agree-term");

        if (fullName == null || fullName.isBlank()
                || email == null || email.isBlank()
                || phone == null || phone.isBlank()
                || password == null || password.isBlank()) {
            request.setAttribute("registerError", "Vui lòng nhập đầy đủ thông tin.");
            forwardToRegister(request, response);
            return;
        }

        if (agreeTerm == null) {
            request.setAttribute("registerError", "Bạn cần đồng ý với điều khoản sử dụng để tiếp tục.");
            forwardToRegister(request, response);
            return;
        }

        // Dùng email làm username cho đơn giản
        String username = email.trim().toLowerCase();

        try {
            UserDAO existing = userService.findByUsername(username);
            if (existing != null) {
                request.setAttribute("registerError", "Email này đã được sử dụng. Vui lòng đăng nhập hoặc dùng email khác.");
                forwardToRegister(request, response);
                return;
            }

            UserDAO user = new UserDAO();
            user.setUsername(username);
            user.setFullname(fullName.trim());
            user.setEmail(email.trim());
            user.setPhone(phone.trim());
            user.setPassword(password); // TODO: mã hoá mật khẩu (BCrypt, SHA-256, ...)
            user.setAddress("");
            user.setIsActive(true);
            user.setRole("CUSTOMER");

            boolean created = Boolean.TRUE.equals(userService.create(user));
            if (!created) {
                request.setAttribute("registerError", "Không thể tạo tài khoản. Vui lòng thử lại sau.");
                forwardToRegister(request, response);
                return;
            }

            request.setAttribute("registerSuccess", "Đăng ký thành công! Vui lòng đăng nhập để tiếp tục.");
            forwardToRegister(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("registerError", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.");
            forwardToRegister(request, response);
        }
    }

    private void forwardToRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp");
        rd.forward(request, response);
    }
}


