package controller;

import java.io.IOException;
import java.util.List;

import javax.sql.DataSource;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.NewsletterDAO;
import model.UserDAO;
import service.UserService;
import serviceimpl.NewsletterServiceImpl;
import serviceimpl.UserServiceImpl;
import utilities.DataSourceUtil;

@WebServlet("/admin/newsletter")
public class AdminNewsletterServlet extends HttpServlet {

    private NewsletterServiceImpl newsletterService;
    private UserService userService;
    private DataSource dataSource;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.newsletterService = new NewsletterServiceImpl();
        this.userService = new UserServiceImpl(dataSource);
    }

    private boolean hasStaffPermission(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;

        Object roleObj = session.getAttribute("type_user");
        if (roleObj == null) return false;

        String role = roleObj.toString();
        return "ADMIN".equalsIgnoreCase(role) || "STAFF".equalsIgnoreCase(role);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("is_login") == null || !(Boolean) session.getAttribute("is_login")) {
            response.sendRedirect(request.getContextPath() + "/admin/auth/login");
            return;
        }

        if (!hasStaffPermission(request)) {
            response.sendRedirect(request.getContextPath() + "/admin/auth/login");
            return;
        }

        // Lấy currentUser từ session để set vào request (cho sidebar.jsp)
        String username = (String) session.getAttribute("username");
        if (username != null && !username.isBlank()) {
            UserDAO currentUser = userService.findByUsername(username);
            if (currentUser != null) {
                request.setAttribute("currentUser", currentUser);
            }
        }

        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "list";
        }

        String view = "/WEB-INF/views/admin/newsletter/list.jsp";
        
        // Set pageTitle for newsletter management
        request.setAttribute("pageTitle", "Quản lý Newsletter");

        switch (action) {
            case "list":
                String includeUnsubscribed = request.getParameter("includeUnsubscribed");
                boolean include = "true".equals(includeUnsubscribed);
                
                List<NewsletterDAO> subscriptions = newsletterService.findAll(include);
                request.setAttribute("subscriptions", subscriptions);
                request.setAttribute("includeUnsubscribed", include);
                break;
            case "delete":
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    try {
                        int id = Integer.parseInt(idStr);
                        newsletterService.deleteById(id);
                        request.setAttribute("success", "Đã xóa đăng ký newsletter thành công!");
                    } catch (NumberFormatException e) {
                        request.setAttribute("error", "ID không hợp lệ!");
                    }
                }
                // Redirect về list sau khi xóa
                response.sendRedirect(request.getContextPath() + "/admin/newsletter");
                return;
        }

        RequestDispatcher rd = request.getRequestDispatcher(view);
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!hasStaffPermission(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    boolean deleted = newsletterService.deleteById(id);
                    if (deleted) {
                        response.sendRedirect(request.getContextPath() + "/admin/newsletter?success=deleted");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin/newsletter?error=delete_failed");
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/admin/newsletter?error=invalid_id");
                }
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/newsletter");
        }
    }
}

