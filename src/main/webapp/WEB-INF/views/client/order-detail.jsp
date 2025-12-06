<%--
  Created by IntelliJ IDEA.
  User: Windows
  Date: 25/11/2025
  Time: 1:45 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.OrderDAO" %>
<%@ page import="model.OrderItemDAO" %>
<%@ page import="model.ProductDAO" %>
<%@ page import="service.ProductService" %>
<%
    OrderDAO order = (OrderDAO) request.getAttribute("order");
    List<OrderItemDAO> orderItems = (List<OrderItemDAO>) request.getAttribute("orderItems");
    ProductService productService = (ProductService) request.getAttribute("productService");
    String successMessage = (String) request.getAttribute("success");
    String errorMessage = (String) request.getAttribute("error");
    
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    
    // Tính toán lại tổng tiền từ order items
    double subtotal = 0.0;
    if (orderItems != null) {
        for (OrderItemDAO item : orderItems) {
            subtotal += item.getPrice() * item.getQuantity();
        }
    }
    double shippingFee = order != null && order.getTotalPrice() > subtotal ? order.getTotalPrice() - subtotal : 0;
    double total = order != null ? order.getTotalPrice() : subtotal + shippingFee;
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <title>Chi tiết đơn hàng | HCMUTE Computer Store</title>

    <!-- Fav Icon -->
    <link rel="icon" href="${pageContext.request.contextPath}/assets/client/images/Logo%20HCMUTE_White%20background.png" type="image/x-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Rethink+Sans:ital,wght@0,400..800;1,400..800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link href="${pageContext.request.contextPath}/assets/client/css/font-awesome-all.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/flaticon.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/owl.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/jquery.fancybox.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/animate.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/nice-select.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/elpath.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/jquery-ui.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/color.css" id="jssDefault" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/rtl.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/page-title.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/checkout.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/highlights.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/footer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/responsive.css" rel="stylesheet">

    <style>
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
        }
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border-color: #f5c6cb;
        }
        .order-detail-box {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .order-detail-box h3 {
            margin-top: 0;
            color: #4CAF50;
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 10px;
        }
        .order-info-item {
            margin-bottom: 10px;
        }
        .order-info-item strong {
            display: inline-block;
            width: 150px;
        }
        .order-items-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .order-items-table th,
        .order-items-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .order-items-table th {
            background-color: #f0f0f0;
            font-weight: bold;
        }
        .order-items-table tr:hover {
            background-color: #f9f9f9;
        }
        .text-right {
            text-align: right;
        }
        .text-center {
            text-align: center;
        }
        .order-summary {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid #4CAF50;
        }
        .order-summary table {
            width: 100%;
        }
        .order-summary td {
            padding: 8px 0;
        }
        .order-summary .total-row {
            font-size: 1.2em;
            font-weight: bold;
            color: #4CAF50;
        }
        .status-badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: bold;
        }
        .status-pending {
            background-color: #ffc107;
            color: #000;
        }
        .status-processing {
            background-color: #17a2b8;
            color: #fff;
        }
        .status-shipped {
            background-color: #007bff;
            color: #fff;
        }
        .status-delivered {
            background-color: #28a745;
            color: #fff;
        }
        .status-cancelled {
            background-color: #dc3545;
            color: #fff;
        }
    </style>

</head>

<!-- page wrapper -->
<body>

<div class="boxed_wrapper ltr">

    <!-- page-direction -->
    <div class="page_direction">
        <div class="demo-rtl direction_switch"><button class="rtl">RTL</button></div>
        <div class="demo-ltr direction_switch"><button class="ltr">LTR</button></div>
    </div>
    <!-- page-direction end -->

    <!-- main header -->
    <jsp:include page="../common/header.jsp" />
    <!-- main-header end -->

    <jsp:include page="../common/mobile-menu.jsp" />

    <jsp:include page="../common/category-menu.jsp" />

    <!-- page-title -->
    <section class="page-title pt_20 pb_18">
        <div class="large-container">
            <ul class="bread-crumb clearfix">
                <li><a href="<%= request.getContextPath() %>/home">Trang chủ</a></li>
                <li>Chi tiết đơn hàng</li>
            </ul>
        </div>
    </section>
    <!-- page-title end -->

    <!-- order-detail-section -->
    <section class="checkout-section pb_80">
        <div class="large-container">
            <div class="sec-title centred pb_30">
                <h2>Chi tiết đơn hàng</h2>
            </div>

            <!-- Thông báo -->
            <% if (successMessage != null && !successMessage.isBlank()) { %>
            <div class="alert alert-success">
                <strong>Thành công!</strong> <%= successMessage %>
            </div>
            <% } %>

            <% if (errorMessage != null && !errorMessage.isBlank()) { %>
            <div class="alert alert-danger">
                <strong>Lỗi!</strong> <%= errorMessage %>
            </div>
            <% } %>

            <% if (order == null) { %>
            <div class="alert alert-danger">
                <strong>Lỗi!</strong> Không tìm thấy đơn hàng.
            </div>
            <% } else { %>

            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <!-- Thông tin đơn hàng -->
                    <div class="order-detail-box">
                        <h3>Thông tin đơn hàng</h3>
                        <div class="order-info-item">
                            <strong>Mã đơn hàng:</strong> #<%= order.getId() %>
                        </div>
                        <div class="order-info-item">
                            <strong>Ngày đặt:</strong> <%= order.getOrderDate() != null ? order.getOrderDate() : "N/A" %>
                        </div>
                        <div class="order-info-item">
                            <strong>Trạng thái:</strong> 
                            <span class="status-badge status-<%= order.getStatus() != null ? order.getStatus().toLowerCase() : "pending" %>">
                                <% 
                                    boolean isCancelled = "CANCELLED".equals(order.getStatus()) || 
                                                         (order.getIs_active() != null && !order.getIs_active());
                                    String statusDisplay = "";
                                    if (isCancelled) {
                                        statusDisplay = "Đã hủy";
                                    } else if ("PENDING".equals(order.getStatus())) {
                                        statusDisplay = "Chờ xử lý";
                                    } else if ("PROCESSING".equals(order.getStatus())) {
                                        statusDisplay = "Đang xử lý";
                                    } else if ("SHIPPED".equals(order.getStatus())) {
                                        statusDisplay = "Đang giao";
                                    } else if ("DELIVERED".equals(order.getStatus())) {
                                        statusDisplay = "Đã giao";
                                    } else {
                                        statusDisplay = order.getStatus() != null ? order.getStatus() : "Chưa xác định";
                                    }
                                %>
                                <%= statusDisplay %>
                            </span>
                            <% if ("PENDING".equals(order.getStatus()) && !isCancelled) { %>
                            <form method="post" action="<%= request.getContextPath() %>/user" style="display: inline-block; margin-left: 15px;" onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?');">
                                <input type="hidden" name="action" value="cancelOrder">
                                <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                <button type="submit" style="background-color: #dc3545; color: white; border: none; padding: 8px 20px; border-radius: 4px; cursor: pointer; font-size: 14px;">Hủy đơn</button>
                            </form>
                            <% } %>
                        </div>
                        <div class="order-info-item">
                            <strong>Phương thức thanh toán:</strong> 
                            <%= "cod".equalsIgnoreCase(order.getPayment()) ? "Thanh toán khi nhận hàng (COD)" : "Chuyển khoản ngân hàng" %>
                        </div>
                        <div class="order-info-item">
                            <strong>Địa chỉ giao hàng:</strong> <%= order.getAddress() != null ? order.getAddress() : "N/A" %>
                        </div>
                        <% if (order.getNote() != null && !order.getNote().isBlank()) { %>
                        <div class="order-info-item">
                            <strong>Ghi chú:</strong> <%= order.getNote() %>
                        </div>
                        <% } %>
                    </div>

                    <!-- Chi tiết sản phẩm -->
                    <div class="order-detail-box">
                        <h3>Chi tiết sản phẩm</h3>
                        <% if (orderItems == null || orderItems.isEmpty()) { %>
                        <p>Không có sản phẩm nào trong đơn hàng này.</p>
                        <% } else { %>
                        <table class="order-items-table">
                            <thead>
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th class="text-center">Số lượng</th>
                                    <th class="text-right">Đơn giá</th>
                                    <th class="text-right">Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (OrderItemDAO item : orderItems) {
                                    ProductDAO product = productService != null ? productService.findById(item.getProductId()) : null;
                                    String productName = product != null ? product.getName() : "Sản phẩm #" + item.getProductId();
                                    double itemTotal = item.getPrice() * item.getQuantity();
                                %>
                                <tr>
                                    <td><%= productName %></td>
                                    <td class="text-center"><%= item.getQuantity() %></td>
                                    <td class="text-right"><%= currencyFormat.format(item.getPrice()) %></td>
                                    <td class="text-right"><%= currencyFormat.format(itemTotal) %></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>

                        <!-- Tóm tắt đơn hàng -->
                        <div class="order-summary">
                            <table>
                                <tr>
                                    <td>Tạm tính:</td>
                                    <td class="text-right"><%= currencyFormat.format(subtotal) %></td>
                                </tr>
                                <tr>
                                    <td>Phí vận chuyển:</td>
                                    <td class="text-right"><%= currencyFormat.format(shippingFee) %></td>
                                </tr>
                                <tr class="total-row">
                                    <td>Tổng cộng:</td>
                                    <td class="text-right"><%= currencyFormat.format(total) %></td>
                                </tr>
                            </table>
                        </div>
                        <% } %>
                    </div>

                    <!-- Nút quay lại -->
                    <div style="text-align: center; margin-top: 30px;">
                        <a href="<%= request.getContextPath() %>/home" class="theme-btn">Tiếp tục mua sắm</a>
                    </div>
                </div>
            </div>

            <% } %>
        </div>
    </section>
    <!-- order-detail-section end -->

    <!-- highlights-section -->
    <section class="highlights-section inner-highlights">
        <div class="large-container">
            <div class="inner-container clearfix">
                <div class="shape" style="background-image: url(${pageContext.request.contextPath}/assets/client/images/shape/shape-5.png);"></div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-23"></i></div>
                        <h5>Same day Product Delivery</h5>
                    </div>
                </div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-17"></i></div>
                        <h5>100% Customer Satisfaction</h5>
                    </div>
                </div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-25"></i></div>
                        <h5>Help and access is our mission</h5>
                    </div>
                </div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-38"></i></div>
                        <h5>100% quality Car Accessories</h5>
                    </div>
                </div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-27"></i></div>
                        <h5>24/7 Support for Clients</h5>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- highlights-section end -->

    <!-- main-footer -->
    <jsp:include page="../common/footer.jsp" />
    <!-- main-footer end -->

    <!--Scroll to top-->
    <div class="scroll-to-top">
        <svg class="scroll-top-inner" viewBox="-1 -1 102 102">
            <path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98" />
        </svg>
    </div>

</div>

<!-- jequery plugins -->
<script src="${pageContext.request.contextPath}/assets/client/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/owl.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/wow.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/validation.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/jquery.fancybox.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/appear.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/isotope.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/parallax-scroll.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/jquery.nice-select.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/scrolltop.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/language.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/countdown.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/jquery-ui.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/product-filter.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/jquery.bootstrap-touchspin.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/bxslider.js"></script>

<!-- main-js -->
<script src="${pageContext.request.contextPath}/assets/client/js/script.js"></script>

<!-- cart-js -->
<script src="${pageContext.request.contextPath}/assets/client/js/cart.js"></script>

<!-- Clear cart after successful payment -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        <% if (successMessage != null && !successMessage.isBlank()) { %>
        // Clear cart from localStorage after successful payment
        if (typeof CartManager !== 'undefined') {
            CartManager.clearCart();
            console.log('Giỏ hàng đã được làm trống sau khi thanh toán thành công.');
        }
        <% } %>
    });
</script>

</body><!-- End of .page_wrapper -->
</html>

