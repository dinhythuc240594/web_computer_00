<%--
  Created by IntelliJ IDEA.
  User: Windows
  Date: 28/11/2025
  Time: 10:07 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.OrderDAO" %>
<%
    List<OrderDAO> orders = (List<OrderDAO>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử đơn hàng | HCMUTE Computer Store</title>
    <link href="${pageContext.request.contextPath}/assets/client/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/style.css" rel="stylesheet">
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
    </style>
</head>
<body>
<div class="container mt-4 mb-5">
    <h2 class="mb-4">Lịch sử đơn hàng</h2>

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
                <td><%= o.getOrderDate() != null ? o.getOrderDate() : "" %></td>
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
</div>
</body>
</html>
