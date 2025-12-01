package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.ReviewDAO;
import model.UserDAO;
import service.ReviewService;
import service.UserService;
import serviceimpl.ReviewServiceImpl;
import serviceimpl.UserServiceImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name="review", urlPatterns="/review")
public class ReviewServlet extends HttpServlet {

    private transient DataSource dataSource;
    private transient ReviewService reviewService;
    private transient UserService userService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.reviewService = new ReviewServiceImpl(dataSource);
        this.userService = new UserServiceImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Tuỳ nhu cầu, hiện tại không dùng GET cho review -> trả về 405
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Vui lòng gửi đánh giá bằng phương thức POST.");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String productIdParam = request.getParameter("productId");
        String slug = request.getParameter("slug");

        // Nếu chưa đăng nhập thì chuyển hướng tới trang đăng nhập
        if (session == null || session.getAttribute("username") == null) {
            session = request.getSession(true);
            String redirectUrl = buildProductRedirectUrl(request, productIdParam, slug);
            session.setAttribute("redirectAfterLogin", redirectUrl);
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String username = (String) session.getAttribute("username");
        UserDAO currentUser = userService.findByUsername(username);
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int productId;
        try {
            productId = Integer.parseInt(productIdParam);
        } catch (Exception ex) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu hoặc sai mã sản phẩm.");
            return;
        }

        String ratingParam = request.getParameter("rating");
        int rating = 5;
        try {
            rating = Integer.parseInt(ratingParam);
            if (rating < 1 || rating > 5) {
                rating = 5;
            }
        } catch (Exception ignored) {
        }

        String comment = request.getParameter("comment");
        if (comment == null || comment.isBlank()) {
            comment = "";
        } else {
            comment = comment.trim();
        }

        ReviewDAO review = new ReviewDAO();
        review.setUserId(currentUser.getId());
        review.setProductId(productId);
        review.setRating(rating);
        review.setComment(comment);

        boolean success = Boolean.TRUE.equals(reviewService.create(review));

        if (success) {
            session.setAttribute("reviewMessage", "Gửi đánh giá thành công. Cảm ơn bạn!");
        } else {
            session.setAttribute("reviewMessage", "Có lỗi xảy ra khi gửi đánh giá. Vui lòng thử lại.");
        }

        String redirectUrl = buildProductRedirectUrl(request, productIdParam, slug);
        response.sendRedirect(redirectUrl);
    }

    private String buildProductRedirectUrl(HttpServletRequest request, String productIdParam, String slug) {
        String base = request.getContextPath() + "/product";
        if (slug != null && !slug.isBlank()) {
            return base + "?slug=" + URLEncoder.encode(slug, StandardCharsets.UTF_8);
        }
        if (productIdParam != null && !productIdParam.isBlank()) {
            return base + "?id=" + productIdParam;
        }
        return request.getContextPath() + "/";
    }
}