<%--
  Created by IntelliJ IDEA.
  User: Windows
  Date: 28/11/2025
  Time: 10:07 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.OrderDAO" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm");
    dateFormat.setTimeZone(java.util.TimeZone.getTimeZone("GMT+7"));
    List<OrderDAO> orders = (List<OrderDAO>) request.getAttribute("orders");
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    Integer totalOrders = (Integer) request.getAttribute("totalOrders");
    Integer pageSize = (Integer) request.getAttribute("pageSize");
    
    if (currentPage == null) currentPage = 1;
    if (totalPages == null) totalPages = 1;
    if (totalOrders == null) totalOrders = 0;
    if (pageSize == null) pageSize = 10;
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <title>Lịch sử đơn hàng | HCMUTE Computer Store</title>

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
        .order-section {
            padding: 40px 0;
        }
        .back-to-profile-btn {
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>

<!-- page wrapper -->
<body>

<div class="boxed_wrapper ltr">

    <!-- main header -->
    <jsp:include page="../../common/header.jsp" />
    <!-- main-header end -->

    <jsp:include page="../../common/mobile-menu.jsp" />

    <jsp:include page="../../common/category-menu.jsp" />

   

    <!-- order-section -->
    <section class="order-section pb_80">
        <div class="large-container">
            <div class="sec-title centred pb_30">
                <h2>Lịch sử đơn hàng</h2>
            </div>

            <div class="container mt-4 mb-5">

    <%
        String successMsg = request.getParameter("success");
        String errorMsg = request.getParameter("error");
        if (successMsg != null) {
            if ("order_cancelled".equals(successMsg)) {
    %>
    <div class="alert alert-success">
        <strong>Thành công!</strong> Đơn hàng đã được hủy thành công.
    </div>
    <%
            }
        }
        if (errorMsg != null) {
            String errorText = "";
            if ("invalid_order".equals(errorMsg)) errorText = "Mã đơn hàng không hợp lệ.";
            else if ("order_not_found".equals(errorMsg)) errorText = "Không tìm thấy đơn hàng.";
            else if ("cannot_cancel".equals(errorMsg)) errorText = "Chỉ có thể hủy đơn hàng ở trạng thái 'Chờ xử lý'.";
            else if ("cancel_failed".equals(errorMsg)) errorText = "Có lỗi xảy ra khi hủy đơn hàng. Vui lòng thử lại.";
            else errorText = "Có lỗi xảy ra.";
    %>
    <div class="alert alert-danger">
        <strong>Lỗi!</strong> <%= errorText %>
    </div>
    <%
        }
    %>

    <%
        if (orders == null || orders.isEmpty()) {
    %>
    <div class="alert alert-info">
        Bạn chưa có đơn hàng nào.
    </div>
    <%
        } else {
    %>
    <div class="table-responsive">
        <table class="table table-bordered table-striped">
            <thead>
            <tr>
                <th>Mã đơn</th>
                <th>Ngày đặt</th>
                <th>Tổng tiền</th>
                <th>Trạng thái</th>
                <th>Ghi chú</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (OrderDAO o : orders) {
                    String status = o.getStatus() != null ? o.getStatus() : "";
                    boolean isCancelled = "CANCELLED".equals(status) || 
                                          (o.getIs_active() != null && !o.getIs_active());
                    String statusDisplay = "";
                    if (isCancelled) {
                        statusDisplay = "Đã hủy";
                    } else if ("PENDING".equals(status)) {
                        statusDisplay = "Chờ xử lý";
                    } else if ("PROCESSING".equals(status)) {
                        statusDisplay = "Đang xử lý";
                    } else if ("SHIPPED".equals(status)) {
                        statusDisplay = "Đang giao";
                    } else if ("DELIVERED".equals(status)) {
                        statusDisplay = "Đã giao";
                    } else {
                        statusDisplay = status;
                    }
            %>
            <tr class="<%= isCancelled ? "table-danger" : "" %>">
                <td>#<%= o.getId() %></td>
                <td><%= o.getOrderDate() != null ? dateFormat.format(o.getOrderDate()) : "" %></td>
                <td><%= String.format("%,.0f", o.getTotalPrice()) %> đ</td>
                <td><%= statusDisplay %></td>
                <td><%= o.getNote() != null ? o.getNote() : "" %></td>
                <td>
                    <a href="${pageContext.request.contextPath}/order?id=<%= o.getId() %>" style="color: #007bff; text-decoration: none; margin-right: 10px;">Xem chi tiết</a>
                    <% if ("PENDING".equals(status) && !isCancelled) { %>
                    <form method="post" action="${pageContext.request.contextPath}/user" style="display: inline-block;" onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?');">
                        <input type="hidden" name="action" value="cancelOrder">
                        <input type="hidden" name="orderId" value="<%= o.getId() %>">
                        <button type="submit" style="background-color: #dc3545; color: white; border: none; padding: 5px 15px; border-radius: 4px; cursor: pointer; font-size: 14px;">Hủy đơn</button>
                    </form>
                    <% } %>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
    <%
        }
    %>
    
    <%
        // Pagination controls
        if (totalOrders > 0 && totalPages > 1) {
    %>
    <div class="pagination-container" style="margin-top: 30px; margin-bottom: 30px; text-align: center;">
        <nav aria-label="Phân trang đơn hàng">
            <ul class="pagination justify-content-center" style="display: inline-flex; list-style: none; padding: 0;">
                <%
                    // Previous button
                    if (currentPage > 1) {
                %>
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/user?action=orders&page=<%= currentPage - 1 %>" style="padding: 8px 15px; margin: 0 5px; border: 1px solid #ddd; border-radius: 4px; text-decoration: none; color: #007bff; background-color: #fff;">Trước</a>
                </li>
                <%
                    } else {
                %>
                <li class="page-item disabled">
                    <span class="page-link" style="padding: 8px 15px; margin: 0 5px; border: 1px solid #ddd; border-radius: 4px; color: #6c757d; background-color: #e9ecef; cursor: not-allowed;">Trước</span>
                </li>
                <%
                    }
                    
                    // Page numbers
                    int startPage = Math.max(1, currentPage - 2);
                    int endPage = Math.min(totalPages, currentPage + 2);
                    
                    if (startPage > 1) {
                %>
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/user?action=orders&page=1" style="padding: 8px 15px; margin: 0 5px; border: 1px solid #ddd; border-radius: 4px; text-decoration: none; color: #007bff; background-color: #fff;">1</a>
                </li>
                <%
                    if (startPage > 2) {
                %>
                <li class="page-item disabled">
                    <span class="page-link" style="padding: 8px 15px; margin: 0 5px; border: none; color: #6c757d;">...</span>
                </li>
                <%
                    }
                    }
                    
                    for (int i = startPage; i <= endPage; i++) {
                        if (i == currentPage) {
                %>
                <li class="page-item active">
                    <span class="page-link" style="padding: 8px 15px; margin: 0 5px; border: 1px solid #007bff; border-radius: 4px; background-color: #007bff; color: #fff; font-weight: bold;"><%= i %></span>
                </li>
                <%
                        } else {
                %>
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/user?action=orders&page=<%= i %>" style="padding: 8px 15px; margin: 0 5px; border: 1px solid #ddd; border-radius: 4px; text-decoration: none; color: #007bff; background-color: #fff;"><%= i %></a>
                </li>
                <%
                        }
                    }
                    
                    if (endPage < totalPages) {
                        if (endPage < totalPages - 1) {
                %>
                <li class="page-item disabled">
                    <span class="page-link" style="padding: 8px 15px; margin: 0 5px; border: none; color: #6c757d;">...</span>
                </li>
                <%
                        }
                %>
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/user?action=orders&page=<%= totalPages %>" style="padding: 8px 15px; margin: 0 5px; border: 1px solid #ddd; border-radius: 4px; text-decoration: none; color: #007bff; background-color: #fff;"><%= totalPages %></a>
                </li>
                <%
                    }
                    
                    // Next button
                    if (currentPage < totalPages) {
                %>
                <li class="page-item">
                    <a class="page-link" href="${pageContext.request.contextPath}/user?action=orders&page=<%= currentPage + 1 %>" style="padding: 8px 15px; margin: 0 5px; border: 1px solid #ddd; border-radius: 4px; text-decoration: none; color: #007bff; background-color: #fff;">Sau</a>
                </li>
                <%
                    } else {
                %>
                <li class="page-item disabled">
                    <span class="page-link" style="padding: 8px 15px; margin: 0 5px; border: 1px solid #ddd; border-radius: 4px; color: #6c757d; background-color: #e9ecef; cursor: not-allowed;">Sau</span>
                </li>
                <%
                    }
                %>
            </ul>
        </nav>
        <p style="margin-top: 10px; color: #6c757d; font-size: 14px;">
            Hiển thị <%= (currentPage - 1) * pageSize + 1 %> - <%= Math.min(currentPage * pageSize, totalOrders) %> trong tổng số <%= totalOrders %> đơn hàng
        </p>
    </div>
    <%
        }
    %>

            <!-- Nút quay về trang cá nhân -->
            <div class="back-to-profile-btn">
                <a href="${pageContext.request.contextPath}/user" class="theme-btn">Quay về trang cá nhân</a>
            </div>
            </div>
        </div>
    </section>
    <!-- order-section end -->

    <!-- highlights-section -->
    <jsp:include page="../../common/highlight-section.jsp" />
    <!-- highlights-section end -->

    <!-- main-footer -->
    <jsp:include page="../../common/footer.jsp" />
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

</body><!-- End of .page_wrapper -->
</html>
