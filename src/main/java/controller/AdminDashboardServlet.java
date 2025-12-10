package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.OrderDAO;
import model.OrderItemDAO;
import model.PageRequest;
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

        // Lấy tham số tìm kiếm & phân trang cho đơn hàng / người dùng
        String keyword = request.getParameter("keyword");
        if (keyword == null) {
            keyword = "";
        }
        int page = 1;
        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isBlank()) {
                page = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException ignore) {
            page = 1;
        }
        int pageSize = 10;

        // Quản lý tài khoản - lấy tất cả người dùng (phục vụ thống kê)
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

        List<OrderDAO> overviewOrders = java.util.Collections.emptyList();
        try {
            List<OrderDAO> orders = orderService.getAll();
            overviewOrders = orders;
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
            // Chỉ đếm các sản phẩm đang hoạt động để hiển thị lên cửa hàng
            totalProducts = (int) products.stream()
                    .filter(p -> Boolean.TRUE.equals(p.getIs_active()))
                    .count();
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        // Lấy danh sách đơn hàng có phân trang và tìm kiếm
        PageRequest pageRequest = new PageRequest(page, pageSize, "id", "DESC", keyword);
        var orderPage = orderService.findAll(pageRequest);
        List<OrderDAO> pagedOrders = orderPage.getData() != null ? orderPage.getData() : java.util.Collections.emptyList();

        // Map tên khách hàng cho danh sách phân trang
        Map<Integer, String> customerNames = new HashMap<>();
        for (OrderDAO order : pagedOrders) {
            if (!customerNames.containsKey(order.getUser_id())) {
                UserDAO customer = userService.findById(order.getUser_id());
                if (customer != null) {
                    customerNames.put(order.getUser_id(),
                            customer.getFullname() != null && !customer.getFullname().isBlank()
                                    ? customer.getFullname()
                                    : "Khách hàng #" + order.getUser_id());
                } else {
                    customerNames.put(order.getUser_id(), "Khách hàng #" + order.getUser_id());
                }
            }
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
        request.setAttribute("orderPage", orderPage);
        request.setAttribute("orders", pagedOrders);
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", page);

        // Phân trang cho người dùng (tab users)
        PageRequest userPageRequest = new PageRequest(page, pageSize, "id", "DESC", keyword);
        var userPage = userService.findAll(userPageRequest);
        List<UserDAO> pagedUsers = userPage != null && userPage.getData() != null
                ? userPage.getData() : java.util.Collections.emptyList();
        request.setAttribute("userPage", userPage);
        request.setAttribute("users", pagedUsers);

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

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("is_login") == null || !(Boolean) session.getAttribute("is_login")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String username = (String) session.getAttribute("username");
        UserDAO currentUser = userService.findByUsername(username);
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("customerNames", customerNames);
        request.setAttribute("tab", tab);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/admin/dashboard/index.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(true);

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

        else if ("create-staff".equals(action)) {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String fullname = request.getParameter("fullname");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            if (username == null || username.isBlank()
                    || email == null || email.isBlank()
                    || password == null || password.isBlank()) {
                session.setAttribute("adminError", "Vui lòng nhập đầy đủ Username, Email và Mật khẩu.");
                response.sendRedirect(request.getContextPath() + "/admin?tab=users");
                return;
            }

            try {
                // Kiểm tra trùng username / email
                boolean usernameExists = userService.findByUsername(username) != null;
                boolean emailExists = userService.findByEmail(email) != null;
                if (usernameExists) {
                    session.setAttribute("adminError", "Username đã tồn tại, vui lòng chọn tên khác.");
                } else if (emailExists) {
                    session.setAttribute("adminError", "Email đã tồn tại, vui lòng chọn email khác.");
                } else {
                    UserDAO newUser = new UserDAO();
                    newUser.setUsername(username.trim());
                    newUser.setEmail(email.trim());
                    newUser.setPassword(password); // Hệ thống hiện tại đang lưu mật khẩu dạng plain
                    newUser.setFullname(fullname != null ? fullname.trim() : null);
                    newUser.setPhone(phone != null ? phone.trim() : null);
                    newUser.setAddress(address != null ? address.trim() : null);
                    newUser.setIsActive(true);
                    newUser.setRole("STAFF");

                    boolean created = Boolean.TRUE.equals(userService.create(newUser));
                    if (created) {
                        session.setAttribute("adminSuccess", "Tạo tài khoản nhân viên thành công.");
                    } else {
                        session.setAttribute("adminError", "Không thể tạo tài khoản nhân viên. Vui lòng thử lại.");
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
                session.setAttribute("adminError", "Có lỗi xảy ra khi tạo tài khoản nhân viên.");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin?tab=users");
    }
}


