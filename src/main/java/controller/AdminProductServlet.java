package controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet quản lý trang sản phẩm trong khu vực admin.
 * Chỉ cho phép người dùng có vai trò nhân viên/quản trị truy cập.
 */
@WebServlet("/admin/product")
public class AdminProductServlet extends HttpServlet {

    private boolean hasStaffPermission(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;

        Object roleObj = session.getAttribute("type_user");
        if (roleObj == null) return false;

        String role = roleObj.toString();
        // Tuỳ DB của bạn, có thể dùng ADMIN / STAFF / EMPLOYEE ...
        return "ADMIN".equalsIgnoreCase(role) || "STAFF".equalsIgnoreCase(role);
    }

    private boolean ensureAuthorized(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (!hasStaffPermission(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập chức năng sản phẩm.");
            return false;
        }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!ensureAuthorized(request, response)) {
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "list";
        }

        String view;
        switch (action) {
            case "add" -> view = "/WEB-INF/views/admin/product/add.jsp";
            // Có thể bổ sung view edit.jsp riêng sau, hiện tại tạm dùng add.jsp
            case "edit" -> view = "/WEB-INF/views/admin/product/add.jsp";
            default -> view = "/WEB-INF/views/admin/product/list.jsp";
        }
        
        // Set pageTitle for product management
        request.setAttribute("pageTitle", "Quản lý sản phẩm");

        RequestDispatcher rd = request.getRequestDispatcher(view);
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!ensureAuthorized(request, response)) {
            return;
        }

        // TODO: Xử lý submit tạo / cập nhật sản phẩm ở đây (sử dụng ProductRepository)
        response.sendRedirect(request.getContextPath() + "/admin/product");
    }
}


