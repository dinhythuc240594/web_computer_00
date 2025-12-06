<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin/layout/init.jspf" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.OrderDAO" %>
<%@ page import="model.Page" %>
<%
    List<OrderDAO> orders = (List<OrderDAO>) request.getAttribute("orders");
    Page<OrderDAO> orderPage = (Page<OrderDAO>) request.getAttribute("orderPage");
    String keyword = (String) request.getAttribute("keyword");
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>
<!doctype html>
<html lang="en" class="layout-navbar-fixed layout-menu-fixed layout-compact" dir="ltr"
      data-skin="default" data-bs-theme="light" data-assets-path="${adminAssetsPath}/"
      data-template="vertical-menu-template">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <meta name="robots" content="noindex, nofollow"/>
    <title>Quản lý Đơn hàng - Staff</title>
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
    <script src="${adminAssetsPath}/vendor/js/template-customizer.js"></script>
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
                    <h4 class="fw-bold py-3 mb-4">Quản lý Đơn hàng</h4>

                    <!-- Search Form -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <form method="get" action="${contextPath}/staff">
                                <input type="hidden" name="action" value="orders"/>
                                <div class="row g-3">
                                    <div class="col-md-8">
                                        <input type="text" class="form-control" name="keyword" 
                                               placeholder="Tìm kiếm theo ID đơn hàng, ID khách hàng hoặc trạng thái..." 
                                               value="<%= keyword != null ? keyword : "" %>"/>
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
                                    <th>ID Khách hàng</th>
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
                                        <td><%= order.getUser_id() %></td>
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
                                int currentPage = orderPage.getCurrentPage();
                                int totalPages = orderPage.getTotalPage();
                                String baseUrl = contextPath + "/staff?action=orders";
                                if (keyword != null && !keyword.isEmpty()) {
                                    baseUrl += "&keyword=" + java.net.URLEncoder.encode(keyword, "UTF-8");
                                }
                        %>
                            <div class="card-footer">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center mb-0">
                                        <li class="page-item <%= currentPage == 1 ? "disabled" : "" %>">
                                            <a class="page-link" href="<%= baseUrl %>&page=<%= currentPage - 1 %>">Trước</a>
                                        </li>
                                        <%
                                            for (int i = 1; i <= totalPages; i++) {
                                                if (i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)) {
                                        %>
                                            <li class="page-item <%= i == currentPage ? "active" : "" %>">
                                                <a class="page-link" href="<%= baseUrl %>&page=<%= i %>"><%= i %></a>
                                            </li>
                                        <%
                                                }
                                                if (i == currentPage - 3 || i == currentPage + 3) {
                                        %>
                                            <li class="page-item disabled"><span class="page-link">...</span></li>
                                        <%
                                                }
                                            }
                                        %>
                                        <li class="page-item <%= currentPage == totalPages ? "disabled" : "" %>">
                                            <a class="page-link" href="<%= baseUrl %>&page=<%= currentPage + 1 %>">Sau</a>
                                        </li>
                                    </ul>
                                </nav>
                                <div class="text-center mt-2">
                                    <small class="text-muted">Trang <%= currentPage %> / <%= totalPages %> 
                                        (Tổng <%= orderPage.getTotalItem() %> đơn hàng)</small>
                                </div>
                            </div>
                        <%
                            }
                        %>
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
