<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin/layout/init.jspf" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.OrderDAO" %>
<%@ page import="model.OrderItemDAO" %>
<%@ page import="model.ProductDAO" %>
<%@ page import="model.UserDAO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%
    OrderDAO order = (OrderDAO) request.getAttribute("order");
    List<OrderItemDAO> orderItems = (List<OrderItemDAO>) request.getAttribute("orderItems");
    Map<Integer, ProductDAO> productMap = (Map<Integer, ProductDAO>) request.getAttribute("productMap");
    UserDAO customer = (UserDAO) request.getAttribute("customer");
    Integer customerOrderCount = (Integer) request.getAttribute("customerOrderCount");
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>
<!doctype html>

<html
        lang="en"
        class="layout-navbar-fixed layout-menu-fixed layout-compact"
        dir="ltr"
        data-skin="default"
        data-bs-theme="light"
        data-assets-path="${adminAssetsPath}/"
        data-template="vertical-menu-template">
<head>
    <meta charset="utf-8" />
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
    <meta name="robots" content="noindex, nofollow" />
    <title>Demo: Order Details - eCommerce | Materialize - Bootstrap Dashboard PRO</title>

    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="${adminAssetsPath}/img/favicon/Logo%20HCMUTE_White%20background.png" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&ampdisplay=swap"
            rel="stylesheet" />

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/fonts/iconify-icons.css" />

    <!-- Core CSS -->
    <!-- build:css assets/vendor/css/theme.css -->

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/node-waves/node-waves.css" />

    <script src="${adminAssetsPath}/vendor/libs/@algolia/autocomplete-js.js"></script>

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/pickr/pickr-themes.css" />

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/css/core.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/css/demo.css" />

    <!-- Vendors CSS -->

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- endbuild -->

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/datatables-bs5/datatables.bootstrap5.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/tagify/tagify.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/sweetalert2/sweetalert2.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/@form-validation/form-validation.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/select2/select2.css" />

    <script src="${adminAssetsPath}/vendor/js/helpers.js"></script>
    <script src="${adminAssetsPath}/js/config.js"></script>
</head>

<body>
<!-- Layout wrapper -->
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <!-- Menu -->
        <jsp:include page="../admin/layout/sidebar.jsp" />
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">
            <!-- Navbar -->
            <jsp:include page="../admin/layout/navbar.jsp" />
            <!-- / Navbar -->

            <!-- Content wrapper -->
            <div class="content-wrapper">
                <!-- Content -->
                <div class="container-xxl flex-grow-1 container-p-y">
                    <div
                            class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-6 gap-6">
                        <div class="d-flex flex-column justify-content-center">
                            <div class="d-flex align-items-center mb-1">
                                <h5 class="mb-0">Order #<%= order != null ? order.getId() : "" %></h5>
                                <%
                                    if (order != null && order.getStatus() != null) {
                                        String status = order.getStatus();
                                        String badgeClass = "bg-label-secondary";
                                        String statusText = status;
                                        if ("PENDING".equals(status)) {
                                            badgeClass = "bg-label-warning";
                                            statusText = "Chờ xử lý";
                                        } else if ("PROCESSING".equals(status)) {
                                            badgeClass = "bg-label-info";
                                            statusText = "Đang xử lý";
                                        } else if ("SHIPPED".equals(status)) {
                                            badgeClass = "bg-label-primary";
                                            statusText = "Đang giao";
                                        } else if ("DELIVERED".equals(status)) {
                                            badgeClass = "bg-label-success";
                                            statusText = "Đã giao";
                                        } else if ("CANCELLED".equals(status)) {
                                            badgeClass = "bg-label-danger";
                                            statusText = "Đã hủy";
                                        }
                                %>
                                <span class="badge <%= badgeClass %> me-2 ms-2 rounded-pill">
                                    <%= statusText %>
                                </span>
                                <%
                                    }
                                %>
                            </div>
                            <p class="mb-0">
                                Ngày đặt: <%= order != null && order.getOrderDate() != null ? dateFormat.format(order.getOrderDate()) : "" %>
                            </p>
                        </div>
                        <!-- <div class="d-flex align-content-center flex-wrap gap-2">
                            <button class="btn btn-outline-danger delete-order">Delete Order</button>
                        </div> -->
                    </div>

                    <!-- Order Details Table -->

                    <div class="row">
                        <div class="col-12 col-lg-8">
                            <div class="card mb-6">
                                <div class="card-header">
                                    <h5 class="card-title m-0">Chi tiết sản phẩm</h5>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-hover mb-0">
                                            <thead>
                                            <tr>
                                                <th style="width: 60px;"></th>
                                                <th class="w-50">Sản phẩm</th>
                                                <th>Đơn giá</th>
                                                <th>Số lượng</th>
                                                <th>Thành tiền</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <%
                                                if (orderItems != null && !orderItems.isEmpty()) {
                                                    for (OrderItemDAO item : orderItems) {
                                                        ProductDAO product = productMap != null ? productMap.get(item.getProductId()) : null;
                                                        String productName = product != null ? product.getName() : "Sản phẩm #" + item.getProductId();
                                                        String productImage = product != null && product.getImage() != null ? product.getImage() : "";
                                                        double itemTotal = item.getPrice() * item.getQuantity();
                                            %>
                                            <tr>
                                                <td>
                                                    <% if (productImage != null && !productImage.isEmpty()) { %>
                                                    <img src="<%= productImage %>"
                                                         alt="<%= productName %>"
                                                         class="rounded"
                                                         style="width: 50px; height: 50px; object-fit: cover;" />
                                                    <% } else { %>
                                                    <div class="bg-label-secondary rounded d-flex align-items-center justify-content-center"
                                                         style="width: 50px; height: 50px;">
                                                        <i class="icon-base ri ri-image-line"></i>
                                                    </div>
                                                    <% } %>
                                                </td>
                                                <td>
                                                    <h6 class="mb-0"><%= productName %></h6>
                                                </td>
                                                <td><%= currencyFormat.format(item.getPrice()) %></td>
                                                <td><%= item.getQuantity() %></td>
                                                <td><strong><%= currencyFormat.format(itemTotal) %></strong></td>
                                            </tr>
                                            <%
                                                    }
                                                } else {
                                            %>
                                            <tr>
                                                <td colspan="5" class="text-center">Không có sản phẩm nào trong đơn hàng này.</td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="d-flex justify-content-end align-items-center m-4 p-1 mb-0 pb-0">
                                        <div class="order-calculations">
                                            <%
                                                double subtotal = order != null ? order.getTotalPrice() : 0;
                                                double discount = 0;
                                                double tax = 0;
                                                double total = subtotal - discount + tax;
                                            %>
                                            <div class="d-flex justify-content-start gap-4 mb-2">
                                                <span class="w-px-100 text-heading">Tạm tính:</span>
                                                <h6 class="mb-0"><%= currencyFormat.format(subtotal) %></h6>
                                            </div>
<%--                                            <div class="d-flex justify-content-start gap-4 mb-2">--%>
<%--                                                <span class="w-px-100 text-heading">Giảm giá:</span>--%>
<%--                                                <h6 class="mb-0"><%= currencyFormat.format(discount) %></h6>--%>
<%--                                            </div>--%>
<%--                                            <div class="d-flex justify-content-start gap-4 mb-2">--%>
<%--                                                <span class="w-px-100 text-heading">Thuế:</span>--%>
<%--                                                <h6 class="mb-0"><%= currencyFormat.format(tax) %></h6>--%>
<%--                                            </div>--%>
                                            <div class="d-flex justify-content-start gap-4 pt-2 border-top">
                                                <h6 class="w-px-100 mb-0">Tổng cộng:</h6>
                                                <h6 class="mb-0 text-primary"><%= currencyFormat.format(total) %></h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
<%--                            <div class="card mb-6">--%>
<%--                                <div class="card-header">--%>
<%--                                    <h5 class="card-title m-0">Lịch sử đơn hàng</h5>--%>
<%--                                </div>--%>
<%--                                <div class="card-body mt-3">--%>
<%--                                    <ul class="timeline pb-0 mb-0">--%>
<%--                                        <%--%>
<%--                                            if (order != null && order.getOrderDate() != null) {--%>
<%--                                                String status = order.getStatus();--%>
<%--                                                boolean isPending = "PENDING".equals(status);--%>
<%--                                                boolean isProcessing = "PROCESSING".equals(status);--%>
<%--                                                boolean isShipped = "SHIPPED".equals(status);--%>
<%--                                                boolean isDelivered = "DELIVERED".equals(status);--%>
<%--                                                boolean isCancelled = "CANCELLED".equals(status);--%>
<%--                                        %>--%>
<%--                                        <!-- Order Placed - Always shown -->--%>
<%--                                        <li class="timeline-item timeline-item-transparent <%= isCancelled ? "border-transparent" : "border-primary" %>">--%>
<%--                                            <span class="timeline-point timeline-point-primary"></span>--%>
<%--                                            <div class="timeline-event">--%>
<%--                                                <div class="timeline-header mb-2">--%>
<%--                                                    <h6 class="mb-0">Đơn hàng đã được đặt (Order ID: #<%= order.getId() %>)</h6>--%>
<%--                                                    <small class="text-body-secondary"><%= dateFormat.format(order.getOrderDate()) %></small>--%>
<%--                                                </div>--%>
<%--                                                <p class="mt-1 mb-2">Đơn hàng của bạn đã được đặt thành công</p>--%>
<%--                                            </div>--%>
<%--                                        </li>--%>

<%--                                        <!-- Processing -->--%>
<%--                                        <% if (isProcessing || isShipped || isDelivered) { %>--%>
<%--                                        <li class="timeline-item timeline-item-transparent border-primary">--%>
<%--                                            <span class="timeline-point timeline-point-primary"></span>--%>
<%--                                            <div class="timeline-event">--%>
<%--                                                <div class="timeline-header mb-2">--%>
<%--                                                    <h6 class="mb-0">Đang xử lý</h6>--%>
<%--                                                    <small class="text-body-secondary"><%= dateFormat.format(order.getOrderDate()) %></small>--%>
<%--                                                </div>--%>
<%--                                                <p class="mt-1 mb-2">Đơn hàng đang được xử lý</p>--%>
<%--                                            </div>--%>
<%--                                        </li>--%>
<%--                                        <% } %>--%>

<%--                                        <!-- Shipped -->--%>
<%--                                        <% if (isShipped || isDelivered) { %>--%>
<%--                                        <li class="timeline-item timeline-item-transparent border-primary">--%>
<%--                                            <span class="timeline-point timeline-point-primary"></span>--%>
<%--                                            <div class="timeline-event">--%>
<%--                                                <div class="timeline-header mb-2">--%>
<%--                                                    <h6 class="mb-0">Đã gửi hàng</h6>--%>
<%--                                                    <small class="text-body-secondary"><%= dateFormat.format(order.getOrderDate()) %></small>--%>
<%--                                                </div>--%>
<%--                                                <p class="mt-1 mb-2">Đơn hàng đã được gửi đi</p>--%>
<%--                                            </div>--%>
<%--                                        </li>--%>
<%--                                        <% } %>--%>

<%--                                        <!-- Delivered -->--%>
<%--                                        <% if (isDelivered) { %>--%>
<%--                                        <li class="timeline-item timeline-item-transparent border-primary">--%>
<%--                                            <span class="timeline-point timeline-point-primary"></span>--%>
<%--                                            <div class="timeline-event">--%>
<%--                                                <div class="timeline-header mb-2">--%>
<%--                                                    <h6 class="mb-0">Đã giao hàng</h6>--%>
<%--                                                    <small class="text-body-secondary"><%= dateFormat.format(order.getOrderDate()) %></small>--%>
<%--                                                </div>--%>
<%--                                                <p class="mt-1 mb-2">Đơn hàng đã được giao thành công</p>--%>
<%--                                            </div>--%>
<%--                                        </li>--%>
<%--                                        <% } %>--%>

<%--                                        <!-- Cancelled -->--%>
<%--                                        <% if (isCancelled) { %>--%>
<%--                                        <li class="timeline-item timeline-item-transparent border-transparent pb-0">--%>
<%--                                            <span class="timeline-point timeline-point-danger"></span>--%>
<%--                                            <div class="timeline-event pb-0">--%>
<%--                                                <div class="timeline-header mb-2">--%>
<%--                                                    <h6 class="mb-0">Đã hủy</h6>--%>
<%--                                                    <small class="text-body-secondary"><%= dateFormat.format(order.getOrderDate()) %></small>--%>
<%--                                                </div>--%>
<%--                                                <p class="mt-1 mb-2">Đơn hàng đã bị hủy</p>--%>
<%--                                            </div>--%>
<%--                                        </li>--%>
<%--                                        <% } %>--%>

<%--                                        <!-- Pending - Show next step -->--%>
<%--                                        <% if (isPending) { %>--%>
<%--                                        <li class="timeline-item timeline-item-transparent border-dashed">--%>
<%--                                            <span class="timeline-point timeline-point-primary"></span>--%>
<%--                                            <div class="timeline-event">--%>
<%--                                                <div class="timeline-header mb-2">--%>
<%--                                                    <h6 class="mb-0">Chờ xử lý</h6>--%>
<%--                                                </div>--%>
<%--                                                <p class="mt-1 mb-2">Đơn hàng đang chờ được xử lý</p>--%>
<%--                                            </div>--%>
<%--                                        </li>--%>
<%--                                        <% } %>--%>
<%--                                        <%--%>
<%--                                            }--%>
<%--                                        %>--%>
<%--                                    </ul>--%>
<%--                                </div>--%>
<%--                            </div>--%>
                        </div>
                        <!-- Thông tin khách hàng -->
                        <div class="col-12 col-lg-4">
                            <div class="card mb-6">
                                <div class="card-body">
                                    <h5 class="card-title mb-6">Thông tin khách hàng</h5>
                                    <%
                                        if (customer != null) {
                                            String customerName = customer.getFullname() != null && !customer.getFullname().isBlank()
                                                ? customer.getFullname()
                                                : "Khách hàng #" + customer.getId();
                                            String customerEmail = customer.getEmail() != null ? customer.getEmail() : "";
                                            String customerPhone = customer.getPhone() != null ? customer.getPhone() : "";
                                            String avatarPath = customer.getAvatar() != null? (request.getContextPath() + "/avatar?userId=" + customer.getId()): "/assets/admin/img/avatars/1.png";
                                    %>
                                    <div class="d-flex justify-content-start align-items-center mb-6">
                                        <div class="avatar me-3">
                                            <img src="<%= avatarPath %>" alt="Avatar" class="rounded-circle" />
                                        </div>
                                        <div class="d-flex flex-column">
                                            <h6 class="mb-0"><%= customerName %></h6>
                                            <span>Customer ID: #<%= customer.getId() %></span>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-start align-items-center mb-6">
                                        <span class="avatar rounded-circle bg-label-success me-3 d-flex align-items-center justify-content-center">
                                            <i class="icon-base ri ri-shopping-cart-line icon-24px"></i>
                                        </span>
                                        <h6 class="text-nowrap mb-0"><%= customerOrderCount != null ? customerOrderCount : 0 %> Đơn hàng</h6>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <h6 class="mb-1">Thông tin liên hệ</h6>
                                    </div>
                                    <p class="mb-1">Email: <%= customerEmail.isEmpty() ? "-" : customerEmail %></p>
                                    <p class="mb-0">Số điện thoại: <%= customerPhone.isEmpty() ? "-" : customerPhone %></p>
                                    <%
                                        } else {
                                    %>
                                    <p class="text-muted">Không tìm thấy thông tin khách hàng.</p>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>

                            <div class="card mb-6">
                                <div class="card-header d-flex justify-content-between">
                                    <h5 class="card-title mb-1">Địa chỉ giao hàng</h5>
                                </div>
                                <div class="card-body">
                                    <p class="mb-0">
                                        <%= order != null && order.getAddress() != null ? order.getAddress() : "-" %>
                                    </p>
                                </div>
                            </div>
                            <div class="card mb-6">
                                <div class="card-header d-flex justify-content-between pb-0">
                                    <h5 class="card-title mb-1">Địa chỉ thanh toán</h5>
                                </div>
                                <div class="card-body">
                                    <p class="mb-4">
                                        <%= order != null && order.getAddress() != null ? order.getAddress() : "-" %>
                                    </p>
                                    <div class="mb-2">
                                        <strong>Phương thức thanh toán:</strong>
                                        <p class="mb-0">
                                            <%= order != null && order.getPayment() != null ? order.getPayment() : "-" %>
                                        </p>
                                    </div>
                                    <% if (order != null && order.getNote() != null && !order.getNote().isEmpty()) { %>
                                    <div>
                                        <strong>Ghi chú:</strong>
                                        <p class="mb-0"><%= order.getNote() %></p>
                                    </div>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- / Content -->

                <jsp:include page="../admin/layout/footer.jsp"/>

                <div class="content-backdrop fade"></div>
            </div>
            <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
    </div>

    <!-- Overlay -->
    <div class="layout-overlay layout-menu-toggle"></div>

    <!-- Drag Target Area To SlideIn Menu On Small Screens -->
    <div class="drag-target"></div>
</div>
<!-- / Layout wrapper -->

<!-- Core JS -->

<!-- build:js assets/vendor/js/theme.js  -->

<script src="${adminAssetsPath}/vendor/libs/jquery/jquery.js"></script>

<script src="${adminAssetsPath}/vendor/libs/popper/popper.js"></script>
<script src="${adminAssetsPath}/vendor/js/bootstrap.js"></script>
<script src="${adminAssetsPath}/vendor/libs/node-waves/node-waves.js"></script>

<script src="${adminAssetsPath}/vendor/libs/@algolia/autocomplete-js.js"></script>

<script src="${adminAssetsPath}/vendor/libs/pickr/pickr.js"></script>

<script src="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

<script src="${adminAssetsPath}/vendor/libs/hammer/hammer.js"></script>

<script src="${adminAssetsPath}/vendor/libs/i18n/i18n.js"></script>

<script src="${adminAssetsPath}/vendor/js/menu.js"></script>

<!-- endbuild -->

<!-- Vendors JS -->
<script src="${adminAssetsPath}/vendor/libs/datatables-bs5/datatables-bootstrap5.js"></script>
<script src="${adminAssetsPath}/vendor/libs/sweetalert2/sweetalert2.js"></script>
<script src="${adminAssetsPath}/vendor/libs/cleave-zen/cleave-zen.js"></script>
<script src="${adminAssetsPath}/vendor/libs/tagify/tagify.js"></script>
<script src="${adminAssetsPath}/vendor/libs/@form-validation/popular.js"></script>
<script src="${adminAssetsPath}/vendor/libs/@form-validation/bootstrap5.js"></script>
<script src="${adminAssetsPath}/vendor/libs/@form-validation/auto-focus.js"></script>
<script src="${adminAssetsPath}/vendor/libs/select2/select2.js"></script>

<!-- Main JS -->

<script src="${adminAssetsPath}/js/main.js"></script>

<!-- Page JS -->
<script src="${adminAssetsPath}/js/app-ecommerce-order-details.js"></script>
<script src="${adminAssetsPath}/js/modal-add-new-address.js"></script>
<script src="${adminAssetsPath}/js/modal-edit-user.js"></script>
</body>
</html>