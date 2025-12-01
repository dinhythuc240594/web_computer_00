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
</head>
<body>
<div class="container mt-4 mb-5">
    <h2 class="mb-4">Lịch sử đơn hàng</h2>

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
            </tr>
            </thead>
            <tbody>
            <%
                for (OrderDAO o : orders) {
                    String status = o.getStatus() != null ? o.getStatus() : "";
                    boolean isCancelled = status.toUpperCase().contains("CANCEL") || status.toUpperCase().contains("FAIL");
            %>
            <tr class="<%= isCancelled ? "table-danger" : "" %>">
                <td>#<%= o.getId() %></td>
                <td><%= o.getOrderDate() != null ? o.getOrderDate() : "" %></td>
                <td><%= String.format("%,.0f", o.getTotalPrice()) %> đ</td>
                <td><%= status %></td>
                <td><%= o.getNote() != null ? o.getNote() : "" %></td>
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
