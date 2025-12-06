package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.WishlistDAO;
import service.WishlistService;
import serviceimpl.WishlistServiceImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;

@WebServlet(name = "wishlist", urlPatterns = "/wishlist")
public class WishlistServlet extends HttpServlet {

    private transient DataSource dataSource;
    private transient WishlistService wishlistService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.wishlistService = new WishlistServiceImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        // Get user_id from database
        service.UserService userService = new serviceimpl.UserServiceImpl(dataSource);
        model.UserDAO user = userService.findByUsername(username);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        int userId = user.getId();

        String action = request.getParameter("action");
        if (action == null || action.isBlank()) {
            action = "list";
        }

        switch (action) {
            case "add" -> handleAdd(request, response, userId);
            case "remove" -> handleRemove(request, response, userId);
            default -> {
                // This will be handled in profile.jsp
                response.sendRedirect(request.getContextPath() + "/user");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response, int userId) throws IOException {
        String productIdParam = request.getParameter("productId");
        if (productIdParam == null || productIdParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/user");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdParam);

            // Check if already exists
            if (wishlistService.existsByUserIdAndProductId(userId, productId)) {
                response.sendRedirect(request.getContextPath() + "/user?tab=wishlist&message=already_exists");
                return;
            }

            WishlistDAO wishlist = new WishlistDAO();
            wishlist.setUserId(userId);
            wishlist.setProductId(productId);

            boolean success = wishlistService.create(wishlist);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/user?tab=wishlist&message=added");
            } else {
                response.sendRedirect(request.getContextPath() + "/user?tab=wishlist&message=error");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/user?tab=wishlist&message=error");
        }
    }

    private void handleRemove(HttpServletRequest request, HttpServletResponse response, int userId) throws IOException {
        String productIdParam = request.getParameter("productId");
        if (productIdParam == null || productIdParam.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/user");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdParam);
            boolean success = wishlistService.deleteByUserIdAndProductId(userId, productId);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/user?tab=wishlist&message=removed");
            } else {
                response.sendRedirect(request.getContextPath() + "/user?tab=wishlist&message=error");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/user?tab=wishlist&message=error");
        }
    }
}

