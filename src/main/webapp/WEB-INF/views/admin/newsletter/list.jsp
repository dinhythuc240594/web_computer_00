<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/init.jspf" %>
<%@ page import="java.util.List" %>
<%@ page import="model.NewsletterDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    List<NewsletterDAO> subscriptions = (List<NewsletterDAO>) request.getAttribute("subscriptions");
    if (subscriptions == null) {
        subscriptions = java.util.Collections.emptyList();
    }
    Boolean includeUnsubscribed = (Boolean) request.getAttribute("includeUnsubscribed");
    if (includeUnsubscribed == null) {
        includeUnsubscribed = false;
    }
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
    String contextPath = request.getContextPath();
%>
<!doctype html>
<html lang="en" class="layout-navbar-fixed layout-menu-fixed layout-compact" dir="ltr"
      data-skin="default" data-bs-theme="light" data-assets-path="${adminAssetsPath}/"
      data-template="vertical-menu-template">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
    <meta name="robots" content="noindex, nofollow" />
    <title>Quản lý Newsletter - Admin</title>
    <link rel="icon" type="image/x-icon" href="${adminAssetsPath}/img/favicon/Logo%20HCMUTE_White%20background.png" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&ampdisplay=swap" rel="stylesheet" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/fonts/iconify-icons.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/node-waves/node-waves.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/pickr/pickr-themes.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/css/core.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/css/demo.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/datatables-bs5/datatables.bootstrap5.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css" />
    <script src="${adminAssetsPath}/vendor/js/helpers.js"></script>
    <script src="${adminAssetsPath}/vendor/js/template-customizer.js"></script>
    <script src="${adminAssetsPath}/js/config.js"></script>
</head>
<body>
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <jsp:include page="../layout/sidebar.jsp" />
        <div class="layout-page">
            <jsp:include page="../layout/navbar.jsp" />
            <div class="content-wrapper">
                <div class="container-xxl flex-grow-1 container-p-y">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Quản lý Newsletter</h5>
                            <div class="d-flex gap-2">
                                <a href="?includeUnsubscribed=<%= !includeUnsubscribed %>" class="btn btn-outline-primary btn-sm">
                                    <%= includeUnsubscribed ? "Chỉ hiển thị đang đăng ký" : "Hiển thị tất cả" %>
                                </a>
                                <button type="button" class="btn btn-primary btn-sm" onclick="exportEmails()">
                                    <i class="iconify" data-icon="mdi:download"></i> Xuất danh sách
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <% if (request.getParameter("success") != null) { %>
                            <div class="alert alert-success alert-dismissible" role="alert">
                                <span id="alert-message">Thao tác thành công!</span>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <% } %>
                            <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger alert-dismissible" role="alert">
                                <span id="alert-message">Đã xảy ra lỗi!</span>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <% } %>
                            
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Email</th>
                                            <th>Trạng thái</th>
                                            <th>Ngày đăng ký</th>
                                            <th>Ngày hủy đăng ký</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if (subscriptions.isEmpty()) { %>
                                        <tr>
                                            <td colspan="6" class="text-center">Không có dữ liệu</td>
                                        </tr>
                                        <% } else { %>
                                        <% for (NewsletterDAO sub : subscriptions) { %>
                                        <tr>
                                            <td><%= sub.getId() %></td>
                                            <td><%= sub.getEmail() %></td>
                                            <td>
                                                <% if ("active".equals(sub.getStatus())) { %>
                                                <span class="badge bg-success">Đang đăng ký</span>
                                                <% } else { %>
                                                <span class="badge bg-secondary">Đã hủy</span>
                                                <% } %>
                                            </td>
                                            <td>
                                                <%= sub.getSubscribed_at() != null ? dateFormat.format(sub.getSubscribed_at()) : "-" %>
                                            </td>
                                            <td>
                                                <%= sub.getUnsubscribed_at() != null ? dateFormat.format(sub.getUnsubscribed_at()) : "-" %>
                                            </td>
                                            <td>
                                                <button type="button" class="btn btn-sm btn-danger" 
                                                        onclick="deleteSubscription(<%= sub.getId() %>, '<%= sub.getEmail() %>')">
                                                    <i class="iconify" data-icon="mdi:delete"></i> Xóa
                                                </button>
                                            </td>
                                        </tr>
                                        <% } %>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                            
                            <div class="mt-3">
                                <p class="text-muted">
                                    <strong>Tổng số:</strong> <%= subscriptions.size() %> email
                                    <% 
                                        long activeCount = subscriptions.stream()
                                            .filter(s -> "active".equals(s.getStatus()))
                                            .count();
                                    %>
                                    (<%= activeCount %> đang đăng ký)
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="../layout/footer.jsp" />
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

<script>
function deleteSubscription(id, email) {
    if (confirm('Bạn có chắc chắn muốn xóa email "' + email + '" khỏi danh sách newsletter?')) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '<%= contextPath %>/admin/newsletter';
        
        const actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'delete';
        form.appendChild(actionInput);
        
        const idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = 'id';
        idInput.value = id;
        form.appendChild(idInput);
        
        document.body.appendChild(form);
        form.submit();
    }
}

function exportEmails() {
    const activeEmails = [];
    <% for (NewsletterDAO sub : subscriptions) { %>
        <% if ("active".equals(sub.getStatus())) { %>
        activeEmails.push('<%= sub.getEmail() %>');
        <% } %>
    <% } %>
    
    if (activeEmails.length === 0) {
        alert('Không có email nào để xuất!');
        return;
    }
    
    const csvContent = 'data:text/csv;charset=utf-8,' + activeEmails.join('\n');
    const encodedUri = encodeURI(csvContent);
    const link = document.createElement('a');
    link.setAttribute('href', encodedUri);
    link.setAttribute('download', 'newsletter_emails_' + new Date().getTime() + '.csv');
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}
</script>
</body>
</html>

