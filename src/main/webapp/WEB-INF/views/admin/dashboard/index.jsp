<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/init.jspf" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.OrderDAO" %>
<%@ page import="model.ProductDAO" %>
<%@ page import="model.CategoryDAO" %>
<%@ page import="model.BrandDAO" %>
<%@ page import="model.UserDAO" %>
<%@ page import="model.Page" %>
<%@ page import="model.ProductSalesStats" %>
<%@ page import="java.util.Map" %>
<%
    String tab = (String) request.getAttribute("tab");
    if (tab == null || tab.isBlank()) {
        tab = request.getParameter("tab");
        if (tab == null || tab.isBlank()) {
            tab = "overview";
        }
    }
    
    String keyword = (String) request.getAttribute("keyword");
    if (keyword == null) keyword = "";
    
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    if (currentPage == null) currentPage = 1;
    String contextPath = request.getContextPath();
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    
    // Get data for each tab
    List<OrderDAO> orders = (List<OrderDAO>) request.getAttribute("orders");
    Page<OrderDAO> orderPage = (Page<OrderDAO>) request.getAttribute("orderPage");
    List<UserDAO> users = (List<UserDAO>) request.getAttribute("users");
    Page<UserDAO> userPage = (Page<UserDAO>) request.getAttribute("userPage");
    
    List<ProductDAO> products = (List<ProductDAO>) request.getAttribute("products");
    Page<ProductDAO> productPage = (Page<ProductDAO>) request.getAttribute("productPage");
    List<CategoryDAO> allCategories = (List<CategoryDAO>) request.getAttribute("allCategories");
    List<BrandDAO> allBrands = (List<BrandDAO>) request.getAttribute("allBrands");
    
    List<BrandDAO> brands = (List<BrandDAO>) request.getAttribute("brands");
    Page<BrandDAO> brandPage = (Page<BrandDAO>) request.getAttribute("brandPage");
    
    List<CategoryDAO> categories = (List<CategoryDAO>) request.getAttribute("categories");
    Page<CategoryDAO> categoryPage = (Page<CategoryDAO>) request.getAttribute("categoryPage");
    
    // New data for admin dashboard
    List<UserDAO> allUsers = (List<UserDAO>) request.getAttribute("allUsers");
    List<ProductSalesStats> productSalesList = (List<ProductSalesStats>) request.getAttribute("productSalesList");
    
    // Business overview statistics
    Double totalRevenue = (Double) request.getAttribute("totalRevenue");
    Double todayRevenue = (Double) request.getAttribute("todayRevenue");
    Double monthRevenue = (Double) request.getAttribute("monthRevenue");
    Integer totalOrders = (Integer) request.getAttribute("totalOrders");
    Integer todayOrders = (Integer) request.getAttribute("todayOrders");
    Integer completedOrders = (Integer) request.getAttribute("completedOrders");
    Integer pendingOrders = (Integer) request.getAttribute("pendingOrders");
    Integer processingOrders = (Integer) request.getAttribute("processingOrders");
    Integer shippedOrders = (Integer) request.getAttribute("shippedOrders");
    Integer cancelledOrders = (Integer) request.getAttribute("cancelledOrders");
    Integer totalUsers = (Integer) request.getAttribute("totalUsers");
    Integer activeUsers = (Integer) request.getAttribute("activeUsers");
    Integer totalProducts = (Integer) request.getAttribute("totalProducts");
    List<OrderDAO> latestOrders = (List<OrderDAO>) request.getAttribute("latestOrders");
    Map<Integer, String> customerNames = (Map<Integer, String>) request.getAttribute("customerNames");
    if (totalRevenue == null) totalRevenue = 0.0;
    if (todayRevenue == null) todayRevenue = 0.0;
    if (monthRevenue == null) monthRevenue = 0.0;
    if (totalOrders == null) totalOrders = 0;
    if (todayOrders == null) todayOrders = 0;
    if (completedOrders == null) completedOrders = 0;
    if (pendingOrders == null) pendingOrders = 0;
    if (processingOrders == null) processingOrders = 0;
    if (shippedOrders == null) shippedOrders = 0;
    if (cancelledOrders == null) cancelledOrders = 0;
    if (totalUsers == null) totalUsers = 0;
    if (activeUsers == null) activeUsers = 0;
    if (totalProducts == null) totalProducts = 0;
    if (allUsers == null) allUsers = java.util.Collections.emptyList();
    if (users == null) users = java.util.Collections.emptyList();
    if (productSalesList == null) productSalesList = java.util.Collections.emptyList();
    if (latestOrders == null) latestOrders = java.util.Collections.emptyList();

    String successMessage = (String) session.getAttribute("adminSuccess");
    String errorMessage = (String) session.getAttribute("adminError");
    if (successMessage != null) {
        session.removeAttribute("adminSuccess");
    }
    if (errorMessage != null) {
        session.removeAttribute("adminError");
    }
%>
<!doctype html>
<html lang="en" class="layout-navbar-fixed layout-menu-fixed layout-compact" dir="ltr"
      data-skin="default" data-bs-theme="light" data-assets-path="${adminAssetsPath}/"
      data-template="vertical-menu-template">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <meta name="robots" content="noindex, nofollow"/>
    <title>Dashboard Nhân viên - Staff</title>
    <link rel="icon" type="image/x-icon" href="${adminAssetsPath}/img/favicon/Logo%20HCMUTE_White%20background.png"/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&ampdisplay=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/fonts/iconify-icons.css"/>
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/node-waves/node-waves.css"/>
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/pickr/pickr-themes.css"/>
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/css/core.css"/>
    <link rel="stylesheet" href="${adminAssetsPath}/css/demo.css"/>
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.css"/>
    <script src="${adminAssetsPath}/vendor/js/helpers.js"></script>
    <!-- <script src="${adminAssetsPath}/vendor/js/template-customizer.js"></script> -->
    <script src="${adminAssetsPath}/js/config.js"></script>
</head>
<body>
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <jsp:include page="../layout/sidebar.jsp"/>
        <div class="layout-page">
            <jsp:include page="../layout/navbar.jsp"/>
            <div class="content-wrapper">
                <div class="container-xxl flex-grow-1 container-p-y">
                    <% if (successMessage != null) { %>
                        <div class="alert alert-success alert-dismissible" role="alert">
                            <%= successMessage %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    <% } %>
                    <% if (errorMessage != null) { %>
                        <div class="alert alert-danger alert-dismissible" role="alert">
                            <%= errorMessage %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    <% } %>
                    <!-- <h4 class="fw-bold py-3 mb-4">Quản lý</h4> -->

                    <!-- Tabs Navigation -->
                    <!-- <ul class="nav nav-tabs mb-4" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link <%= "overview".equals(tab) ? "active" : "" %>" 
                               href="${contextPath}/admin?tab=overview">
                                <i class="icon-base ri ri-dashboard-line me-2"></i>Tổng quan
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <%= "users".equals(tab) ? "active" : "" %>" 
                               href="${contextPath}/admin?tab=users">
                                <i class="icon-base ri ri-user-line me-2"></i>Quản lý tài khoản
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <%= "product-sales".equals(tab) ? "active" : "" %>" 
                               href="${contextPath}/admin?tab=product-sales">
                                <i class="icon-base ri ri-bar-chart-line me-2"></i>Thống kê sản phẩm
                            </a>
                        </li>
                    </ul> -->

                    <!-- Tab Content -->
                    <div class="tab-content">
                        <!-- Overview Tab -->
                        <% if ("overview".equals(tab)) { %>
                        <div class="tab-pane fade show active">
                            <h4 class="fw-bold mb-4">Tổng quan tình hình kinh doanh</h4>
                            
                            <!-- Revenue Cards -->
                            <div class="row mb-4">
                                <div class="col-md-3 mb-3">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h6 class="text-muted mb-1">Tổng doanh thu</h6>
                                                    <h4 class="mb-0"><%= currencyFormat.format(totalRevenue) %></h4>
                                                </div>
                                                <div class="avatar avatar-lg">
                                                    <span class="avatar-initial rounded bg-label-success">
                                                        <i class="icon-base ri ri-money-dollar-circle-line"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h6 class="text-muted mb-1">Doanh thu hôm nay</h6>
                                                    <h4 class="mb-0"><%= currencyFormat.format(todayRevenue) %></h4>
                                                </div>
                                                <div class="avatar avatar-lg">
                                                    <span class="avatar-initial rounded bg-label-primary">
                                                        <i class="icon-base ri ri-calendar-line"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h6 class="text-muted mb-1">Doanh thu tháng này</h6>
                                                    <h4 class="mb-0"><%= currencyFormat.format(monthRevenue) %></h4>
                                                </div>
                                                <div class="avatar avatar-lg">
                                                    <span class="avatar-initial rounded bg-label-info">
                                                        <i class="icon-base ri ri-calendar-2-line"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h6 class="text-muted mb-1">Đơn hàng hôm nay</h6>
                                                    <h4 class="mb-0"><%= todayOrders %></h4>
                                                </div>
                                                <div class="avatar avatar-lg">
                                                    <span class="avatar-initial rounded bg-label-warning">
                                                        <i class="icon-base ri ri-shopping-bag-line"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Statistics Cards -->
                            <div class="row mb-4">
                                <div class="col-md-3 mb-3">
                                    <div class="card">
                                        <div class="card-body">
                                            <h6 class="text-muted mb-1">Tổng đơn hàng</h6>
                                            <h4 class="mb-0"><%= totalOrders %></h4>
                                            <small class="text-muted">
                                                Đã giao: <%= completedOrders %> | 
                                                Đang xử lý: <%= pendingOrders + processingOrders + shippedOrders %> | 
                                                Đã hủy: <%= cancelledOrders %>
                                            </small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="card">
                                        <div class="card-body">
                                            <h6 class="text-muted mb-1">Tổng người dùng</h6>
                                            <h4 class="mb-0"><%= totalUsers %></h4>
                                            <small class="text-muted">Đang hoạt động: <%= activeUsers %></small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="card">
                                        <div class="card-body">
                                            <h6 class="text-muted mb-1">Tổng sản phẩm</h6>
                                            <h4 class="mb-0"><%= totalProducts %></h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <div class="card">
                                        <div class="card-body">
                                            <h6 class="text-muted mb-1">Trạng thái đơn hàng</h6>
                                            <div class="d-flex flex-column gap-1">
                                                <small><span class="badge bg-label-warning">Chờ xử lý: <%= pendingOrders %></span></small>
                                                <small><span class="badge bg-label-info">Đang xử lý: <%= processingOrders %></span></small>
                                                <small><span class="badge bg-label-primary">Đang giao: <%= shippedOrders %></span></small>
                                                <small><span class="badge bg-label-success">Đã giao: <%= completedOrders %></span></small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Orders Search -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <form method="get" action="${contextPath}/admin">
                                        <input type="hidden" name="tab" value="overview"/>
                                        <div class="row g-3">
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name="keyword"
                                                       placeholder="Tìm theo ID, khách hàng, trạng thái..."
                                                       value="<%= keyword %>"/>
                                            </div>
                                            <div class="col-md-4">
                                                <button type="submit" class="btn btn-primary w-100">
                                                    <i class="icon-base ri ri-search-line me-2"></i>Tìm kiếm
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Orders Table -->
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="mb-0">Đơn hàng</h5>
                                </div>
                                <div class="card-datatable table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Tên Khách hàng</th>
                                                <th>Ngày đặt</th>
                                                <th>Tổng tiền</th>
                                                <th>Trạng thái</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                if (orders != null && !orders.isEmpty()) {
                                                    for (OrderDAO order : orders) {
                                                        String status = order.getStatus() != null ? order.getStatus() : "";
                                            %>
                                                <tr>
                                                    <td><%= order.getId() %></td>
                                                    <td>
                                                        <%
                                                            String customerName = "Khách hàng #" + order.getUser_id();
                                                            if (customerNames != null && customerNames.containsKey(order.getUser_id())) {
                                                                customerName = customerNames.get(order.getUser_id());
                                                            }
                                                            out.print(customerName);
                                                        %>
                                                    </td>
                                                    <td>
                                                        <%
                                                            if (order.getOrderDate() != null) {
                                                                out.print(dateFormat.format(order.getOrderDate()));
                                                            }
                                                        %>
                                                    </td>
                                                    <td><%= currencyFormat.format(order.getTotalPrice()) %></td>
                                                    <td>
                                                        <%
                                                            if ("PENDING".equals(status)) {
                                                        %>
                                                            <span class="badge bg-label-warning">Chờ xử lý</span>
                                                        <%
                                                            } else if ("PROCESSING".equals(status)) {
                                                        %>
                                                            <span class="badge bg-label-info">Đang xử lý</span>
                                                        <%
                                                            } else if ("SHIPPED".equals(status)) {
                                                        %>
                                                            <span class="badge bg-label-primary">Đang giao</span>
                                                        <%
                                                            } else if ("DELIVERED".equals(status)) {
                                                        %>
                                                            <span class="badge bg-label-success">Đã giao</span>
                                                        <%
                                                            } else if ("CANCELLED".equals(status)) {
                                                        %>
                                                            <span class="badge bg-label-danger">Đã hủy</span>
                                                        <%
                                                            } else {
                                                        %>
                                                            <span class="badge bg-label-secondary"><%= status %></span>
                                                        <%
                                                            }
                                                        %>
                                                    </td>
                                                </tr>
                                            <%
                                                    }
                                                } else {
                                            %>
                                                <tr>
                                                    <td colspan="5" class="text-center">Không có đơn hàng nào</td>
                                                </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                <%
                                    if (orderPage != null && orderPage.getTotalPage() > 1) {
                                        int currentPageNum = orderPage.getCurrentPage();
                                        int totalPages = orderPage.getTotalPage();
                                        String baseUrl = request.getContextPath() + "/admin?tab=overview";
                                        if (keyword != null && !keyword.isEmpty()) {
                                            baseUrl += "&keyword=" + java.net.URLEncoder.encode(keyword, "UTF-8");
                                        }
                                %>
                                    <div class="card-footer">
                                        <nav aria-label="Page navigation">
                                            <ul class="pagination justify-content-center mb-0">
                                                <li class="page-item <%= currentPageNum == 1 ? "disabled" : "" %>">
                                                    <a class="page-link" href="<%= baseUrl %>&page=<%= currentPageNum - 1 %>">Trước</a>
                                                </li>
                                                <%
                                                    for (int i = 1; i <= totalPages; i++) {
                                                        if (i == 1 || i == totalPages || (i >= currentPageNum - 2 && i <= currentPageNum + 2)) {
                                                %>
                                                    <li class="page-item <%= i == currentPageNum ? "active" : "" %>">
                                                        <a class="page-link" href="<%= baseUrl %>&page=<%= i %>"><%= i %></a>
                                                    </li>
                                                <%
                                                        }
                                                        if (i == currentPageNum - 3 || i == currentPageNum + 3) {
                                                %>
                                                    <li class="page-item disabled"><span class="page-link">...</span></li>
                                                <%
                                                        }
                                                    }
                                                %>
                                                <li class="page-item <%= currentPageNum == totalPages ? "disabled" : "" %>">
                                                    <a class="page-link" href="<%= baseUrl %>&page=<%= currentPageNum + 1 %>">Sau</a>
                                                </li>
                                            </ul>
                                        </nav>
                                        <div class="text-center mt-2">
                                            <small class="text-muted">Trang <%= currentPageNum %> / <%= totalPages %>
                                                (Tổng <%= orderPage.getTotalItem() %> đơn hàng)</small>
                                        </div>
                                    </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <% } %>

                        <!-- Users Tab -->
                        <% if ("users".equals(tab)) { %>
                        <div class="tab-pane fade show active">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="fw-bold py-3 mb-4">Quản lý tài khoản người dùng</h4>
                            </div>

                            <!-- Create Staff Form -->
                            <div class="card mb-4">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0">Tạo tài khoản nhân viên</h5>
                                    <small class="text-muted">Thêm nhanh nhân viên mới</small>
                                </div>
                                <div class="card-body">
                                    <form method="post" action="${contextPath}/admin">
                                        <input type="hidden" name="action" value="create-staff"/>
                                        <div class="row g-3">
                                            <div class="col-md-4">
                                                <label class="form-label">Username *</label>
                                                <input type="text" class="form-control" name="username" placeholder="vd: staff01" required/>
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label">Email *</label>
                                                <input type="email" class="form-control" name="email" placeholder="staff@example.com" required/>
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label">Mật khẩu *</label>
                                                <input type="password" class="form-control" name="password" placeholder="******" required/>
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label">Họ tên</label>
                                                <input type="text" class="form-control" name="fullname" placeholder="Nguyễn Văn A"/>
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label">Số điện thoại</label>
                                                <input type="text" class="form-control" name="phone" placeholder="0123456789"/>
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label">Địa chỉ</label>
                                                <input type="text" class="form-control" name="address" placeholder="Địa chỉ liên hệ"/>
                                            </div>
                                        </div>
                                        <div class="mt-3 d-flex justify-content-end">
                                            <button type="submit" class="btn btn-success">
                                                <i class="icon-base ri ri-user-add-line me-2"></i>Tạo nhân viên
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Search Form -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <form method="get" action="${contextPath}/admin">
                                        <input type="hidden" name="tab" value="users"/>
                                        <div class="row g-3">
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name="keyword" 
                                                       placeholder="Tìm kiếm theo tên, email, username..." 
                                                       value="<%= keyword %>"/>
                                            </div>
                                            <div class="col-md-4">
                                                <button type="submit" class="btn btn-primary w-100">
                                                    <i class="icon-base ri ri-search-line me-2"></i>Tìm kiếm
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Users Table -->
                            <div class="card">
                                <div class="card-datatable table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Username</th>
                                                <!-- <th>Họ tên</th> -->
                                                <th>Email</th>
                                                <th>Số điện thoại</th>
                                                <th>Vai trò</th>
                                                <th>Trạng thái</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                if (users != null && !users.isEmpty()) {
                                                    for (UserDAO user : users) {
                                                        boolean isActive = Boolean.TRUE.equals(user.getIsActive());
                                                        String role = user.getRole() != null ? user.getRole() : "USER";
                                            %>
                                                <tr>
                                                    <td><%= user.getId() %></td>
                                                    <td><%= user.getUsername() != null ? user.getUsername() : "-" %></td>
                                                    <!-- <td><%= user.getFullname() != null ? user.getFullname() : "-" %></td> -->
                                                    <td><%= user.getEmail() != null ? user.getEmail() : "-" %></td>
                                                    <td><%= user.getPhone() != null ? user.getPhone() : "-" %></td>
                                                    <td>
                                                        <span class="badge bg-label-primary text-uppercase"><%= role %></span>
                                                    </td>
                                                    <td>

                                                            <% if (isActive) { %>
                                                                <span class="badge bg-label-success">Hoạt động</span>
                                                            <% } else { %>
                                                                <span class="badge bg-label-danger">Bị khóa</span>
                                                            <% } %>

                                                    </td>
                                                    <td>
                                                        <% if(role.equalsIgnoreCase("STAFF") || role.equalsIgnoreCase("CUSTOMER")){ %>
                                                        <form method="post" action="${contextPath}/admin" style="display: inline;">
                                                            <input type="hidden" name="action" value="toggle-user-status"/>
                                                            <input type="hidden" name="userId" value="<%= user.getId() %>"/>
                                                            <button type="submit" class="btn btn-sm <%= isActive ? "btn-outline-warning" : "btn-outline-success" %>"
                                                                    onclick="return confirm('Bạn có chắc muốn <%= isActive ? "khóa" : "mở khóa" %> tài khoản này?');">
                                                                <i class="icon-base ri <%= isActive ? "ri-lock-line" : "ri-lock-unlock-line" %>"></i>
                                                                <%= isActive ? "Khóa" : "Mở khóa" %>
                                                            </button>
                                                        </form>
                                                        <% } %>
                                                    </td>
                                                </tr>
                                            <%
                                                    }
                                                } else {
                                            %>
                                                <tr>
                                                    <td colspan="8" class="text-center">Không có người dùng nào</td>
                                                </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                                
                                <!-- Pagination -->
                                <%
                                    if (userPage != null && userPage.getTotalPage() > 1) {
                                        int currentPageNum = userPage.getCurrentPage();
                                        int totalPages = userPage.getTotalPage();
                                        String baseUrl = request.getContextPath() + "/admin?tab=users";
                                        if (keyword != null && !keyword.isEmpty()) {
                                            baseUrl += "&keyword=" + java.net.URLEncoder.encode(keyword, "UTF-8");
                                        }
                                %>
                                    <div class="card-footer">
                                        <nav aria-label="Page navigation">
                                            <ul class="pagination justify-content-center mb-0">
                                                <li class="page-item <%= currentPageNum == 1 ? "disabled" : "" %>">
                                                    <a class="page-link" href="<%= baseUrl %>&page=<%= currentPageNum - 1 %>">Trước</a>
                                                </li>
                                                <%
                                                    for (int i = 1; i <= totalPages; i++) {
                                                        if (i == 1 || i == totalPages || (i >= currentPageNum - 2 && i <= currentPageNum + 2)) {
                                                %>
                                                    <li class="page-item <%= i == currentPageNum ? "active" : "" %>">
                                                        <a class="page-link" href="<%= baseUrl %>&page=<%= i %>"><%= i %></a>
                                                    </li>
                                                <%
                                                        }
                                                        if (i == currentPageNum - 3 || i == currentPageNum + 3) {
                                                %>
                                                    <li class="page-item disabled"><span class="page-link">...</span></li>
                                                <%
                                                        }
                                                    }
                                                %>
                                                <li class="page-item <%= currentPageNum == totalPages ? "disabled" : "" %>">
                                                    <a class="page-link" href="<%= baseUrl %>&page=<%= currentPageNum + 1 %>">Sau</a>
                                                </li>
                                            </ul>
                                        </nav>
                                        <div class="text-center mt-2">
                                            <small class="text-muted">Trang <%= currentPageNum %> / <%= totalPages %>
                                                (Tổng <%= userPage.getTotalItem() %> người dùng)</small>
                                        </div>
                                    </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <% } %>

                        <!-- Product Sales Statistics Tab -->
                        <% if ("product-sales".equals(tab)) { %>
                        <div class="tab-pane fade show active">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h4 class="fw-bold py-3 mb-4">Báo cáo thống kê sản phẩm bán được</h4>
                            </div>

                            <!-- Product Sales Table -->
                            <div class="card">
                                <div class="card-datatable table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>STT</th>
                                                <th>Hình ảnh</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Số lượng bán</th>
                                                <th>Doanh thu</th>
                                                <th>Số đơn hàng</th>
                                                <th>Giá hiện tại</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                if (productSalesList != null && !productSalesList.isEmpty()) {
                                                    int index = 1;
                                                    for (ProductSalesStats stats : productSalesList) {
                                            %>
                                                <tr>
                                                    <td><%= index++ %></td>
                                                    <td>
                                                        <%
                                                            if (stats.getProductImage() != null && !stats.getProductImage().isEmpty()) {
                                                        %>
                                                            <img src="<%= stats.getProductImage() %>" alt="<%= stats.getProductName() != null ? stats.getProductName() : "" %>" 
                                                                 style="width: 50px; height: 50px; object-fit: cover;"/>
                                                        <%
                                                            } else {
                                                        %>
                                                            <span class="text-muted">-</span>
                                                        <%
                                                            }
                                                        %>
                                                    </td>
                                                    <td><%= stats.getProductName() != null ? stats.getProductName() : "Sản phẩm #" + stats.getProductId() %></td>
                                                    <td><strong><%= stats.getTotalQuantity() %></strong></td>
                                                    <td><strong class="text-success"><%= currencyFormat.format(stats.getTotalRevenue()) %></strong></td>
                                                    <td><%= stats.getOrderCount() %></td>
                                                    <td><%= currencyFormat.format(stats.getCurrentPrice()) %></td>
                                                </tr>
                                            <%
                                                    }
                                                } else {
                                            %>
                                                <tr>
                                                    <td colspan="7" class="text-center">Chưa có dữ liệu thống kê sản phẩm</td>
                                                </tr>
                                            <%
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
                <jsp:include page="../layout/footer.jsp"/>
            </div>
        </div>
    </div>
</div>

<script src="${adminAssetsPath}/vendor/libs/jquery/jquery.js"></script>
<script src="${adminAssetsPath}/vendor/libs/popper/popper.js"></script>
<script src="${adminAssetsPath}/vendor/js/bootstrap.js"></script>
<script src="${adminAssetsPath}/vendor/libs/node-waves/node-waves.js"></script>
<script src="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="${adminAssetsPath}/vendor/js/menu.js"></script>
<script src="${adminAssetsPath}/js/main.js"></script>
</body>
</html>