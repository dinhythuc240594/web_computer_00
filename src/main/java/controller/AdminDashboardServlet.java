package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.OrderDAO;
import model.OrderItemDAO;
import model.ProductDAO;
import model.ProductSalesStats;
import model.UserDAO;
import repositoryimpl.OrderItemRepositoryImpl;
import service.UserService;
import service.OrderService;
import service.ProductService;
import serviceimpl.UserServiceImpl;
import serviceimpl.OrderServiceImpl;
import serviceimpl.ProductServiceImpl;
import utilities.DataSourceUtil;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/admin")
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
        String tab = request.getParameter("tab");
        if (tab == null || tab.isBlank()) {
            tab = "overview";
        }

        // Quản lý tài khoản - lấy tất cả người dùng
        List<UserDAO> allUsers;
        try {
            allUsers = userService.getAll();
        } catch (Exception ex) {
            allUsers = java.util.Collections.emptyList();
        }
        request.setAttribute("allUsers", allUsers);

        // Tổng quan doanh thu và thống kê đơn hàng
        double totalRevenue = 0.0;
        double todayRevenue = 0.0;
        double monthRevenue = 0.0;
        int totalOrders = 0;
        int todayOrders = 0;
        int completedOrders = 0;
        int pendingOrders = 0;
        int processingOrders = 0;
        int shippedOrders = 0;
        int cancelledOrders = 0;
        int totalUsers = allUsers.size();
        int activeUsers = 0;
        int totalProducts = 0;

        try {
            List<OrderDAO> orders = orderService.getAll();
            totalOrders = orders.size();
            
            Calendar today = Calendar.getInstance();
            today.set(Calendar.HOUR_OF_DAY, 0);
            today.set(Calendar.MINUTE, 0);
            today.set(Calendar.SECOND, 0);
            today.set(Calendar.MILLISECOND, 0);
            
            Calendar monthStart = Calendar.getInstance();
            monthStart.set(Calendar.DAY_OF_MONTH, 1);
            monthStart.set(Calendar.HOUR_OF_DAY, 0);
            monthStart.set(Calendar.MINUTE, 0);
            monthStart.set(Calendar.SECOND, 0);
            monthStart.set(Calendar.MILLISECOND, 0);
            
            for (OrderDAO o : orders) {
                if (Boolean.TRUE.equals(o.getIs_active()) && "DELIVERED".equalsIgnoreCase(o.getStatus())) {
                    totalRevenue += o.getTotalPrice();
                    
                    if (o.getOrderDate() != null) {
                        Calendar orderDate = Calendar.getInstance();
                        orderDate.setTimeInMillis(o.getOrderDate().getTime());
                        
                        if (orderDate.after(today) || orderDate.equals(today)) {
                            todayRevenue += o.getTotalPrice();
                            todayOrders++;
                        }
                        
                        if (orderDate.after(monthStart) || orderDate.equals(monthStart)) {
                            monthRevenue += o.getTotalPrice();
                        }
                    }
                }
                
                if (o.getStatus() == null) continue;
                String st = o.getStatus().toUpperCase();
                if ("DELIVERED".equals(st)) {
                    completedOrders++;
                } else if ("PENDING".equals(st)) {
                    pendingOrders++;
                } else if ("PROCESSING".equals(st)) {
                    processingOrders++;
                } else if ("SHIPPED".equals(st)) {
                    shippedOrders++;
                } else if ("CANCELLED".equals(st)) {
                    cancelledOrders++;
                }
            }
            
            // Đếm người dùng active
            for (UserDAO user : allUsers) {
                if (Boolean.TRUE.equals(user.getIsActive())) {
                    activeUsers++;
                }
            }
            
            // Đếm tổng sản phẩm
            List<ProductDAO> products = productService.getAll();
            totalProducts = products.size();
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("todayRevenue", todayRevenue);
        request.setAttribute("monthRevenue", monthRevenue);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("todayOrders", todayOrders);
        request.setAttribute("completedOrders", completedOrders);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("processingOrders", processingOrders);
        request.setAttribute("shippedOrders", shippedOrders);
        request.setAttribute("cancelledOrders", cancelledOrders);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("activeUsers", activeUsers);
        request.setAttribute("totalProducts", totalProducts);

        // Thống kê sản phẩm bán được
        Map<Integer, ProductSalesStats> productSalesMap = new HashMap<>();
        try {
            String sql = "SELECT oi.product_id, SUM(oi.quantity) as total_quantity, " +
                        "SUM(oi.quantity * oi.price_at_purchase) as total_revenue, " +
                        "COUNT(DISTINCT oi.order_id) as order_count " +
                        "FROM order_items oi " +
                        "INNER JOIN orders o ON oi.order_id = o.id " +
                        "WHERE o.is_active = TRUE AND o.status = 'DELIVERED' " +
                        "GROUP BY oi.product_id " +
                        "ORDER BY total_quantity DESC";
            
            try (Connection conn = dataSource.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                
                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    int totalQuantity = rs.getInt("total_quantity");
                    double totalRevenueForProduct = rs.getDouble("total_revenue");
                    int orderCount = rs.getInt("order_count");
                    
                    ProductSalesStats stats = new ProductSalesStats();
                    stats.setProductId(productId);
                    stats.setTotalQuantity(totalQuantity);
                    stats.setTotalRevenue(totalRevenueForProduct);
                    stats.setOrderCount(orderCount);
                    
                    ProductDAO product = productService.findById(productId);
                    if (product != null) {
                        stats.setProductName(product.getName());
                        stats.setProductImage(product.getImage());
                        stats.setCurrentPrice(product.getPrice() != null ? product.getPrice() : 0.0);
                    }
                    
                    productSalesMap.put(productId, stats);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        List<ProductSalesStats> productSalesList = new ArrayList<>(productSalesMap.values());
        productSalesList.sort((a, b) -> Integer.compare(b.getTotalQuantity(), a.getTotalQuantity()));
        request.setAttribute("productSalesList", productSalesList);

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
        request.setAttribute("tab", tab);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/admin/dashboard/index.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("toggle-user-status".equals(action)) {
            String userIdParam = request.getParameter("userId");
            if (userIdParam != null && !userIdParam.isBlank()) {
                try {
                    int userId = Integer.parseInt(userIdParam);
                    UserDAO user = userService.findById(userId);
                    if (user != null) {
                        // Toggle status
                        user.setIsActive(!Boolean.TRUE.equals(user.getIsActive()));
                        userService.update(user);
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin?tab=users");
    }
}


