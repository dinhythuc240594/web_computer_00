<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="utilities.DataSourceUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DatabaseMetaData" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <style>
        .db-status {
            padding: 15px;
            margin: 20px 0;
            border-radius: 5px;
            font-family: Arial, sans-serif;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .info {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
            margin-top: 10px;
            padding: 10px;
        }
    </style>
</head>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>

<%
    Connection conn = null;
    String status = "";
    String message = "";
    String dbInfo = "";
    boolean isConnected = false;

    try {
        // Lấy DataSource và tạo connection
        conn = DataSourceUtil.getDataSource().getConnection();

        if (conn != null && !conn.isClosed()) {
            isConnected = true;
            status = "success";
            message = "✓ Kết nối database thành công!";

            // Lấy thông tin database
            DatabaseMetaData metaData = conn.getMetaData();
            dbInfo = "Database: " + metaData.getDatabaseProductName() +
                    " " + metaData.getDatabaseProductVersion() + "<br/>" +
                    "Driver: " + metaData.getDriverName() + "<br/>" +
                    "URL: " + metaData.getURL() + "<br/>" +
                    "Username: " + metaData.getUserName();
        } else {
            status = "error";
            message = "✗ Không thể kết nối database!";
        }
    } catch (Exception e) {
        status = "error";
        message = "✗ Lỗi kết nối database: " + e.getMessage();
        e.printStackTrace();
    } finally {
        // Đóng connection
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
%>

<div class="db-status <%= status %>">
    <h2>Trạng thái kết nối Database</h2>
    <p><strong><%= message %></strong></p>
    <% if (isConnected && !dbInfo.isEmpty()) { %>
    <div class="info">
        <strong>Thông tin Database:</strong><br/>
        <%= dbInfo %>
    </div>
    <% } %>
</div>

<br/>
<a href="hello-servlet">Hello Servlet</a>
</body>
</html>