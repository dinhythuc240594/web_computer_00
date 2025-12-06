package controller;

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

@WebServlet(name = "avatar", urlPatterns = "/avatar")
public class AvatarServlet extends HttpServlet {

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
        String userIdParam = request.getParameter("userId");
        String usernameParam = request.getParameter("username");

        UserDAO user = null;

        if (userIdParam != null && !userIdParam.isBlank()) {
            try {
                int userId = Integer.parseInt(userIdParam);
                user = userService.findById(userId);
            } catch (NumberFormatException e) {
                // Invalid userId, ignore
            }
        } else if (usernameParam != null && !usernameParam.isBlank()) {
            user = userService.findByUsername(usernameParam);
        }

        if (user == null || user.getAvatar() == null || user.getAvatar().length == 0) {
            // Return default avatar or 404
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Avatar not found");
            return;
        }

        // Set content type based on image format (default to JPEG)
        response.setContentType("image/jpeg");
        response.setContentLength(user.getAvatar().length);
        response.setHeader("Cache-Control", "max-age=3600"); // Cache for 1 hour

        // Write avatar bytes to response
        response.getOutputStream().write(user.getAvatar());
        response.getOutputStream().flush();
    }
}

