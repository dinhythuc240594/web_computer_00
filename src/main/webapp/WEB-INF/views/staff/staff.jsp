<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin/layout/init.jspf" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.OrderDAO" %>
<%@ page import="model.ProductDAO" %>
<%@ page import="model.CategoryDAO" %>
<%@ page import="model.BrandDAO" %>
<%@ page import="model.Page" %>
<%@ page import="java.util.Map" %>
<%
    String tab = (String) request.getAttribute("tab");
    if (tab == null || tab.isBlank()) {
        tab = request.getParameter("tab");
        if (tab == null || tab.isBlank()) {
            tab = "orders";
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
    Map<Integer, String> customerNames = (Map<Integer, String>) request.getAttribute("customerNames");
    List<ProductDAO> products = (List<ProductDAO>) request.getAttribute("products");
    Page<ProductDAO> productPage = (Page<ProductDAO>) request.getAttribute("productPage");
    List<CategoryDAO> allCategories = (List<CategoryDAO>) request.getAttribute("allCategories");
    List<BrandDAO> allBrands = (List<BrandDAO>) request.getAttribute("allBrands");
    
    List<BrandDAO> brands = (List<BrandDAO>) request.getAttribute("brands");
    Page<BrandDAO> brandPage = (Page<BrandDAO>) request.getAttribute("brandPage");
    
    List<CategoryDAO> categories = (List<CategoryDAO>) request.getAttribute("categories");
    Page<CategoryDAO> categoryPage = (Page<CategoryDAO>) request.getAttribute("categoryPage");
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
        <jsp:include page="../admin/layout/sidebar.jsp"/>
        <div class="layout-page">
            <jsp:include page="../admin/layout/navbar.jsp"/>
            <div class="content-wrapper">
                <div class="container-xxl flex-grow-1 container-p-y">
                    <h4 class="fw-bold py-3 mb-4">Dashboard Quản lý</h4>

                    <!-- Tabs Navigation -->
                    <ul class="nav nav-tabs mb-4" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link <%= "orders".equals(tab) ? "active" : "" %>" 
                               href="${contextPath}/staff?action=dashboard&tab=orders">
                                <i class="icon-base ri ri-shopping-cart-line me-2"></i>Đơn hàng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <%= "products".equals(tab) ? "active" : "" %>" 
                               href="${contextPath}/staff?action=dashboard&tab=products">
                                <i class="icon-base ri ri-product-hunt-line me-2"></i>Sản phẩm
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <%= "brands".equals(tab) ? "active" : "" %>" 
                               href="${contextPath}/staff?action=dashboard&tab=brands">
                                <i class="icon-base ri ri-star-line me-2"></i>Thương hiệu
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link <%= "categories".equals(tab) ? "active" : "" %>" 
                               href="${contextPath}/staff?action=dashboard&tab=categories">
                                <i class="icon-base ri ri-folder-line me-2"></i>Danh mục
                            </a>
                        </li>
                    </ul>

                    <!-- Tab Content -->
                    <div class="tab-content">
                        <!-- Orders Tab -->
                        <% if ("orders".equals(tab)) { %>
                        <div class="tab-pane fade show active">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="mb-0">Quản lý Đơn hàng</h5>
                            </div>

                            <!-- Search Form -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <form method="get" action="${contextPath}/staff">
                                        <input type="hidden" name="action" value="dashboard"/>
                                        <input type="hidden" name="tab" value="orders"/>
                                        <div class="row g-3">
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name="keyword" 
                                                       placeholder="Tìm kiếm theo ID đơn hàng, ID khách hàng hoặc trạng thái..." 
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
                                <div class="card-datatable table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên Khách hàng</th>
                                            <th>Ngày đặt</th>
                                            <th>Tổng tiền</th>
                                            <th>Trạng thái</th>
                                            <th>Phương thức thanh toán</th>
                                            <th>Thao tác</th>
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
                                                <td><%= order.getPayment() != null ? order.getPayment() : "-" %></td>
                                                <td>
                                                    <div class="d-flex gap-2">
                                                        <a href="${contextPath}/staff?action=order-details&id=<%= order.getId() %>" 
                                                           class="btn btn-sm btn-outline-info">
                                                            <i class="icon-base ri ri-eye-line"></i>
                                                        </a>
                                                        <form method="post" action="${contextPath}/staff" style="display: inline;">
                                                            <input type="hidden" name="action" value="order-update-status"/>
                                                            <input type="hidden" name="id" value="<%= order.getId() %>"/>
                                                            <select name="status" class="form-select form-select-sm" 
                                                                    onchange="this.form.submit()" style="width: auto; display: inline-block;">
                                                                <option value="PENDING" <%= "PENDING".equals(status) ? "selected" : "" %>>Chờ xử lý</option>
                                                                <option value="PROCESSING" <%= "PROCESSING".equals(status) ? "selected" : "" %>>Đang xử lý</option>
                                                                <option value="SHIPPED" <%= "SHIPPED".equals(status) ? "selected" : "" %>>Đang giao</option>
                                                                <option value="DELIVERED" <%= "DELIVERED".equals(status) ? "selected" : "" %>>Đã giao</option>
                                                                <option value="CANCELLED" <%= "CANCELLED".equals(status) ? "selected" : "" %>>Đã hủy</option>
                                                            </select>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        <%
                                                }
                                            } else {
                                        %>
                                            <tr>
                                                <td colspan="7" class="text-center">Không có đơn hàng nào</td>
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
                                        String baseUrl = request.getContextPath() + "/staff?action=dashboard&tab=orders";
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

                        <!-- Products Tab -->
                        <% if ("products".equals(tab)) { %>
                        <div class="tab-pane fade show active">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="mb-0">Quản lý Sản phẩm</h5>
                                <a href="${contextPath}/staff?action=product-add" class="btn btn-primary">
                                    <i class="icon-base ri ri-add-line me-2"></i>Thêm sản phẩm
                                </a>
                            </div>

                            <!-- Search Form -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <form method="get" action="${contextPath}/staff">
                                        <input type="hidden" name="action" value="dashboard"/>
                                        <input type="hidden" name="tab" value="products"/>
                                        <div class="row g-3">
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name="keyword" 
                                                       placeholder="Tìm kiếm theo tên hoặc giá..." 
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

                            <!-- Products Table -->
                            <div class="card">
                                <div class="card-datatable table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Hình ảnh</th>
                                            <th>Tên sản phẩm</th>
                                            <th>Giá</th>
                                            <th>Tồn kho</th>
                                            <th>Danh mục</th>
                                            <th>Thương hiệu</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%
                                            if (products != null && !products.isEmpty()) {
                                                for (ProductDAO product : products) {
                                        %>
                                            <tr>
                                                <td><%= product.getId() %></td>
                                                <td>
                                                    <%
                                                        if (product.getImage() != null && !product.getImage().isEmpty()) {
                                                    %>
                                                        <img src="<%= product.getImage() %>" alt="<%= product.getName() %>" 
                                                             style="width: 50px; height: 50px; object-fit: cover;"/>
                                                    <%
                                                        }
                                                    %>
                                                </td>
                                                <td><%= product.getName() %></td>
                                                <td><%= currencyFormat.format(product.getPrice() != null ? product.getPrice() : 0) %></td>
                                                <td><%= product.getStock_quantity() %></td>
                                                <td>
                                                    <%
                                                        String categoryName = "-";
                                                        if (allCategories != null) {
                                                            for (CategoryDAO cat : allCategories) {
                                                                if (cat.getId() == product.getCategory_id()) {
                                                                    categoryName = cat.getName();
                                                                    break;
                                                                }
                                                            }
                                                        }
                                                    %>
                                                    <%= categoryName %>
                                                </td>
                                                <td>
                                                    <%
                                                        String brandName = "-";
                                                        if (allBrands != null) {
                                                            for (BrandDAO brand : allBrands) {
                                                                if (brand.getId() == product.getBrand_id()) {
                                                                    brandName = brand.getName();
                                                                    break;
                                                                }
                                                            }
                                                        }
                                                    %>
                                                    <%= brandName %>
                                                </td>
                                                <td>
                                                    <%
                                                        if (product.getIs_active() != null && product.getIs_active()) {
                                                    %>
                                                        <span class="badge bg-label-success">Hoạt động</span>
                                                    <%
                                                        } else {
                                                    %>
                                                        <span class="badge bg-label-danger">Đã ẩn</span>
                                                    <%
                                                        }
                                                    %>
                                                </td>
                                                <td>
                                                    <div class="d-flex gap-2">
                                                        <a href="${contextPath}/staff?action=product-edit&id=<%= product.getId() %>" 
                                                           class="btn btn-sm btn-outline-primary">
                                                            <i class="icon-base ri ri-edit-line"></i>
                                                        </a>
                                                        <form method="post" action="${contextPath}/staff" style="display: inline;">
                                                            <input type="hidden" name="action" value="product-delete"/>
                                                            <input type="hidden" name="id" value="<%= product.getId() %>"/>
                                                            <button type="submit" class="btn btn-sm btn-outline-danger" 
                                                                    onclick="return confirm('Bạn có chắc muốn ẩn sản phẩm này?');">
                                                                <i class="icon-base ri ri-delete-bin-line"></i>
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        <%
                                                }
                                            } else {
                                        %>
                                            <tr>
                                                <td colspan="9" class="text-center">Không có sản phẩm nào</td>
                                            </tr>
                                        <%
                                            }
                                        %>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                <%
                                    if (productPage != null && productPage.getTotalPage() > 1) {
                                        int currentPageNum = productPage.getCurrentPage();
                                        int totalPages = productPage.getTotalPage();
                                        String baseUrl = request.getContextPath() + "/staff?action=dashboard&tab=products";
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
                                                (Tổng <%= productPage.getTotalItem() %> sản phẩm)</small>
                                        </div>
                                    </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <% } %>

                        <!-- Brands Tab -->
                        <% if ("brands".equals(tab)) { %>
                        <div class="tab-pane fade show active">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="mb-0">Quản lý Thương hiệu</h5>
                                <a href="${contextPath}/staff?action=brand-add" class="btn btn-primary">
                                    <i class="icon-base ri ri-add-line me-2"></i>Thêm thương hiệu
                                </a>
                            </div>

                            <!-- Search Form -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <form method="get" action="${contextPath}/staff">
                                        <input type="hidden" name="action" value="dashboard"/>
                                        <input type="hidden" name="tab" value="brands"/>
                                        <div class="row g-3">
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name="keyword" 
                                                       placeholder="Tìm kiếm theo tên hoặc mã..." 
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

                            <!-- Brands Table -->
                            <div class="card">
                                <div class="card-datatable table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Logo</th>
                                            <th>Tên thương hiệu</th>
                                            <th>Mã</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%
                                            if (brands != null && !brands.isEmpty()) {
                                                for (BrandDAO brand : brands) {
                                        %>
                                            <tr>
                                                <td><%= brand.getId() %></td>
                                                <td>
                                                    <%
                                                        if (brand.getImage() != null && !brand.getImage().isEmpty()) {
                                                    %>
                                                        <img src="<%= brand.getImage() %>" alt="<%= brand.getName() %>" 
                                                             style="width: 50px; height: 50px; object-fit: cover;"/>
                                                    <%
                                                        }
                                                    %>
                                                </td>
                                                <td><%= brand.getName() %></td>
                                                <td><%= brand.getCode() %></td>
                                                <td>
                                                    <%
                                                        if (brand.getIs_active() != null && brand.getIs_active()) {
                                                    %>
                                                        <span class="badge bg-label-success">Hoạt động</span>
                                                    <%
                                                        } else {
                                                    %>
                                                        <span class="badge bg-label-danger">Đã ẩn</span>
                                                    <%
                                                        }
                                                    %>
                                                </td>
                                                <td>
                                                    <div class="d-flex gap-2">
                                                        <a href="${contextPath}/staff?action=brand-edit&id=<%= brand.getId() %>" 
                                                           class="btn btn-sm btn-outline-primary">
                                                            <i class="icon-base ri ri-edit-line"></i>
                                                        </a>
                                                        <form method="post" action="${contextPath}/staff" style="display: inline;">
                                                            <input type="hidden" name="action" value="brand-delete"/>
                                                            <input type="hidden" name="id" value="<%= brand.getId() %>"/>
                                                            <button type="submit" class="btn btn-sm btn-outline-danger" 
                                                                    onclick="return confirm('Bạn có chắc muốn ẩn thương hiệu này?');">
                                                                <i class="icon-base ri ri-delete-bin-line"></i>
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        <%
                                                }
                                            } else {
                                        %>
                                            <tr>
                                                <td colspan="6" class="text-center">Không có thương hiệu nào</td>
                                            </tr>
                                        <%
                                            }
                                        %>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                <%
                                    if (brandPage != null && brandPage.getTotalPage() > 1) {
                                        int currentPageNum = brandPage.getCurrentPage();
                                        int totalPages = brandPage.getTotalPage();
                                        String baseUrl = request.getContextPath() + "/staff?action=dashboard&tab=brands";
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
                                                (Tổng <%= brandPage.getTotalItem() %> thương hiệu)</small>
                                        </div>
                                    </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <% } %>

                        <!-- Categories Tab -->
                        <% if ("categories".equals(tab)) { %>
                        <div class="tab-pane fade show active">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="mb-0">Quản lý Danh mục</h5>
                                <a href="${contextPath}/staff?action=category-add" class="btn btn-primary">
                                    <i class="icon-base ri ri-add-line me-2"></i>Thêm danh mục
                                </a>
                            </div>

                            <!-- Search Form -->
                            <div class="card mb-4">
                                <div class="card-body">
                                    <form method="get" action="${contextPath}/staff">
                                        <input type="hidden" name="action" value="dashboard"/>
                                        <input type="hidden" name="tab" value="categories"/>
                                        <div class="row g-3">
                                            <div class="col-md-8">
                                                <input type="text" class="form-control" name="keyword" 
                                                       placeholder="Tìm kiếm theo tên hoặc mô tả..." 
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

                            <!-- Categories Table -->
                            <div class="card">
                                <div class="card-datatable table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên danh mục</th>
                                            <th>Mô tả</th>
                                            <th>Danh mục cha</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <%
                                            if (categories != null && !categories.isEmpty()) {
                                                for (CategoryDAO category : categories) {
                                        %>
                                            <tr>
                                                <td><%= category.getId() %></td>
                                                <td><%= category.getName() %></td>
                                                <td><%= category.getDescription() != null ? category.getDescription() : "-" %></td>
                                                <td>
                                                    <%
                                                        if (category.getParent_id() > 0) {
                                                            String parentName = "-";
                                                            for (CategoryDAO parent : categories) {
                                                                if (parent.getId() == category.getParent_id()) {
                                                                    parentName = parent.getName();
                                                                    break;
                                                                }
                                                            }
                                                            out.print(parentName);
                                                        } else {
                                                            out.print("-");
                                                        }
                                                    %>
                                                </td>
                                                <td>
                                                    <%
                                                        if (category.getIs_active() != null && category.getIs_active()) {
                                                    %>
                                                        <span class="badge bg-label-success">Hoạt động</span>
                                                    <%
                                                        } else {
                                                    %>
                                                        <span class="badge bg-label-danger">Đã ẩn</span>
                                                    <%
                                                        }
                                                    %>
                                                </td>
                                                <td>
                                                    <div class="d-flex gap-2">
                                                        <a href="${contextPath}/staff?action=category-edit&id=<%= category.getId() %>" 
                                                           class="btn btn-sm btn-outline-primary">
                                                            <i class="icon-base ri ri-edit-line"></i>
                                                        </a>
                                                        <form method="post" action="${contextPath}/staff" style="display: inline;">
                                                            <input type="hidden" name="action" value="category-delete"/>
                                                            <input type="hidden" name="id" value="<%= category.getId() %>"/>
                                                            <button type="submit" class="btn btn-sm btn-outline-danger" 
                                                                    onclick="return confirm('Bạn có chắc muốn ẩn danh mục này?');">
                                                                <i class="icon-base ri ri-delete-bin-line"></i>
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        <%
                                                }
                                            } else {
                                        %>
                                            <tr>
                                                <td colspan="6" class="text-center">Không có danh mục nào</td>
                                            </tr>
                                        <%
                                            }
                                        %>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                <%
                                    if (categoryPage != null && categoryPage.getTotalPage() > 1) {
                                        int currentPageNum = categoryPage.getCurrentPage();
                                        int totalPages = categoryPage.getTotalPage();
                                        String baseUrl = request.getContextPath() + "/staff?action=dashboard&tab=categories";
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
                                                (Tổng <%= categoryPage.getTotalItem() %> danh mục)</small>
                                        </div>
                                    </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
                <jsp:include page="../admin/layout/footer.jsp"/>
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

