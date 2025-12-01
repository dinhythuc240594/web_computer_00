package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.OrderDAO;
import model.UserDAO;
import service.UserService;
import service.OrderService;
import service.ProductService;
import serviceimpl.UserServiceImpl;
import serviceimpl.OrderServiceImpl;
import serviceimpl.ProductServiceImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private transient DataSource dataSource;
    private transient UserService userService;
    private transient OrderService orderService;
    private transient ProductService productService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.dataSource = DataSourceUtil.getDataSource();
        this.userService = new UserServiceImpl(dataSource);
        this.orderService = new OrderServiceImpl(dataSource);
        this.productService = new ProductServiceImpl(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Quản lý tài khoản (chỉ hiển thị ADMIN/STAFF)
        List<UserDAO> adminUsers;
        try {
            List<UserDAO> allUsers = userService.getAll();
            adminUsers = allUsers.stream()
                    .filter(u -> u.getRole() != null &&
                            ("ADMIN".equalsIgnoreCase(u.getRole()) || "STAFF".equalsIgnoreCase(u.getRole())))
                    .toList();
        } catch (Exception ex) {
            adminUsers = java.util.Collections.emptyList();
        }
        request.setAttribute("adminUsers", adminUsers);

        // Tổng quan doanh thu (đơn giản: tổng tất cả đơn hàng active)
        double totalRevenue = 0.0;
        int totalOrders = 0;
        int completedOrders = 0;
        int pendingOrders = 0;
        int cancelledOrders = 0;

        try {
            List<OrderDAO> orders = orderService.getAll();
            totalOrders = orders.size();
            for (OrderDAO o : orders) {
                if (Boolean.TRUE.equals(o.getIs_active())) {
                    totalRevenue += o.getTotalPrice();
                }
                if (o.getStatus() == null) continue;
                String st = o.getStatus().toUpperCase();
                if (st.contains("COMPLETE") || st.contains("SUCCESS")) {
                    completedOrders++;
                } else if (st.contains("PENDING") || st.contains("PROCESS")) {
                    pendingOrders++;
                } else if (st.contains("CANCEL") || st.contains("FAIL")) {
                    cancelledOrders++;
                }
            }
        } catch (Exception ignored) {
        }

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("completedOrders", completedOrders);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("cancelledOrders", cancelledOrders);

        // Danh sách đơn hàng mới nhất cho dashboard (giới hạn 10)
        List<OrderDAO> latestOrders;
        try {
            List<OrderDAO> allOrders = orderService.getAll();
            latestOrders = allOrders.stream()
                    .sorted((a, b) -> {
                        if (a.getOrderDate() == null && b.getOrderDate() == null) return 0;
                        if (a.getOrderDate() == null) return 1;
                        if (b.getOrderDate() == null) return -1;
                        return b.getOrderDate().compareTo(a.getOrderDate());
                    })
                    .limit(10)
                    .toList();
        } catch (Exception ex) {
            latestOrders = java.util.Collections.emptyList();
        }
        request.setAttribute("latestOrders", latestOrders);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/admin/dashboard/index.jsp");
        rd.forward(request, response);
    }
}


