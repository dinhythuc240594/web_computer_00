<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.UserDAO" %>
<%@ include file="../layout/init.jspf" %>
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
    <title>Quản lý tài khoản hệ thống</title>

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

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/fonts/flag-icons.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/datatables-bs5/datatables.bootstrap5.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/select2/select2.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/@form-validation/form-validation.css" />

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="${adminAssetsPath}/vendor/js/helpers.js"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->

    <!--? Template customizer: To hide customizer set displayCustomizer value false in config.js. -->
    <script src="${adminAssetsPath}/vendor/js/template-customizer.js"></script>

    <!--? Config: Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file. -->

    <script src="${adminAssetsPath}/js/config.js"></script>
</head>

<body>
<!-- Layout wrapper -->
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <!-- Menu -->
        <jsp:include page="../layout/sidebar.jsp" />
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">
            <!-- Navbar -->
            <jsp:include page="../layout/navbar.jsp" />
            <!-- / Navbar -->

            <!-- Content wrapper -->
            <div class="content-wrapper">
                <!-- Content -->
                <div class="container-xxl flex-grow-1 container-p-y">
                    <!-- User Management Table -->
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="card-title mb-1">Quản lý tài khoản</h5>
                                <small class="text-muted">Danh sách tài khoản ADMIN / STAFF trong hệ thống</small>
                            </div>
                            <a href="${pageContext.request.contextPath}/admin/user/add" class="btn btn-primary">
                                <i class="ri-add-line me-1"></i> Thêm tài khoản
                            </a>
                        </div>

                        <div class="card-datatable table-responsive">
                            <table class="table table-striped table-hover align-middle">
                                <thead class="table-light">
                                <tr>
                                    <th class="text-nowrap">ID</th>
                                    <th class="text-nowrap">Username</th>
                                    <th class="text-nowrap">Họ tên</th>
                                    <th class="text-nowrap">Email</th>
                                    <th class="text-nowrap">Số điện thoại</th>
                                    <th class="text-nowrap">Vai trò</th>
                                    <th class="text-nowrap text-center">Trạng thái</th>
                                    <th class="text-nowrap text-center">Hành động</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    List<UserDAO> adminUsers = (List<UserDAO>) request.getAttribute("adminUsers");
                                    if (adminUsers != null && !adminUsers.isEmpty()) {
                                        for (UserDAO u : adminUsers) {
                                            String fullname = (u.getFullname() != null && !u.getFullname().isEmpty())
                                                    ? u.getFullname() : "(Chưa có tên)";
                                            String email = (u.getEmail() != null && !u.getEmail().isEmpty())
                                                    ? u.getEmail() : "-";
                                            String phone = (u.getPhone() != null && !u.getPhone().isEmpty())
                                                    ? u.getPhone() : "-";
                                            String role = (u.getRole() != null && !u.getRole().isEmpty())
                                                    ? u.getRole() : "USER";
                                            boolean isActive = Boolean.TRUE.equals(u.getIsActive());
                                %>
                                            <tr>
                                                <td><%= u.getId() %></td>
                                                <td><%= u.getUsername() %></td>
                                                <td><%= fullname %></td>
                                                <td><%= email %></td>
                                                <td><%= phone %></td>
                                                <td>
                                                    <span class="badge bg-label-primary text-uppercase">
                                                        <%= role %>
                                                    </span>
                                                </td>
                                                <td class="text-center">
                                                    <% if (isActive) { %>
                                                        <span class="badge bg-label-success">Hoạt động</span>
                                                    <% } else { %>
                                                        <span class="badge bg-label-danger">Bị khóa</span>
                                                    <% } %>
                                                </td>
                                                <td class="text-center">
                                                    <div class="btn-group" role="group">
                                                        <a href="<%= request.getContextPath() %>/admin/user/edit?id=<%= u.getId() %>"
                                                           class="btn btn-sm btn-outline-primary">
                                                            <i class="ri-edit-2-line"></i> Sửa
                                                        </a>
                                                        <a href="<%= request.getContextPath() %>/admin/user/toggle-status?id=<%= u.getId() %>"
                                                           class="btn btn-sm btn-outline-warning"
                                                           onclick="return confirm('Bạn có chắc muốn thay đổi trạng thái tài khoản này?');">
                                                            <% if (isActive) { %>Khóa<% } else { %>Mở khóa<% } %>
                                                        </a>
                                                        <a href="<%= request.getContextPath() %>/admin/user/delete?id=<%= u.getId() %>"
                                                           class="btn btn-sm btn-outline-danger"
                                                           onclick="return confirm('Bạn có chắc muốn xóa tài khoản này?');">
                                                            <i class="ri-delete-bin-line"></i> Xóa
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                <%
                                        }
                                    } else {
                                %>
                                    <tr>
                                        <td colspan="8" class="text-center text-muted py-4">
                                            Không có tài khoản nào để hiển thị.
                                        </td>
                                    </tr>
                                <%
                                    }
                                %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- / Content -->

                <!-- Footer -->
                <jsp:include page="../layout/footer.jsp" />
                <!-- / Footer -->

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
<script src="${adminAssetsPath}/vendor/libs/moment/moment.js"></script>
<script src="${adminAssetsPath}/vendor/libs/datatables-bs5/datatables-bootstrap5.js"></script>
<script src="${adminAssetsPath}/vendor/libs/select2/select2.js"></script>
<script src="${adminAssetsPath}/vendor/libs/@form-validation/popular.js"></script>
<script src="${adminAssetsPath}/vendor/libs/@form-validation/bootstrap5.js"></script>
<script src="${adminAssetsPath}/vendor/libs/@form-validation/auto-focus.js"></script>
<script src="${adminAssetsPath}/vendor/libs/cleave-zen/cleave-zen.js"></script>

<!-- Main JS -->

<script src="${adminAssetsPath}/js/main.js"></script>

<!-- Page JS -->
<script src="${adminAssetsPath}/js/app-ecommerce-customer-all.js"></script>
</body>
</html>





