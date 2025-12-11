package controller;

import java.io.IOException;

import javax.sql.DataSource;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.UserDAO;
import service.UserService;
import serviceimpl.UserServiceImpl;
import utilities.DataSourceUtil;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

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
        forwardToLogin(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String identifier = request.getParameter("email");
        String password = request.getParameter("password");

        if (identifier == null || identifier.isBlank() || password == null || password.isBlank()) {
            request.setAttribute("loginError", "Vui lòng nhập đầy đủ email và mật khẩu.");
            forwardToLogin(request, response);
            return;
        }

        UserDAO user = null;
        try {
            // Tạm thời đăng nhập theo username; có thể mở rộng thêm theo email nếu cần
            user = userService.findByUsername(identifier);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (user == null || user.getPassword() == null || !password.equals(user.getPassword())) {
            request.setAttribute("loginError", "Email hoặc mật khẩu không chính xác.");
            forwardToLogin(request, response);
            return;
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("is_login", true);
        session.setAttribute("username", user.getUsername());
        session.setAttribute("type_user", user.getRole());

        String role = user.getRole();
        boolean isStaff = role != null &&
                (role.equalsIgnoreCase("ADMIN") || role.equalsIgnoreCase("STAFF"));

        String redirectAfterLogin = (String) session.getAttribute("redirectAfterLogin");
        if (redirectAfterLogin != null && !redirectAfterLogin.isBlank()) {
            // Nếu URL đích là khu vực admin/staff nhưng tài khoản không đủ quyền thì chuyển về trang chủ
            String lowerRedirect = redirectAfterLogin.toLowerCase();
            if (!isStaff && (lowerRedirect.contains("/admin") || lowerRedirect.contains("/staff"))) {
                session.removeAttribute("redirectAfterLogin");
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            session.removeAttribute("redirectAfterLogin");
            response.sendRedirect(redirectAfterLogin);
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    private void forwardToLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp");
        rd.forward(request, response);
    }
}


