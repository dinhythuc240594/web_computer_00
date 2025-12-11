<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../admin/layout/init.jspf" %>
<%@ page import="model.UserDAO" %>
<%@ page import="model.NewsletterDAO" %>
<%@ page import="service.UserService" %>
<%@ page import="serviceimpl.UserServiceImpl" %>
<%@ page import="utilities.DataSourceUtil" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    String sessionUsername = (String) session.getAttribute("username");
    String sessionRole = (String) session.getAttribute("type_user");

    UserDAO currentUser = null;
    String displayName = "Người dùng";
    String displayEmail = "Chưa cập nhật";
    String displayPhone = "Chưa cập nhật";
    String displayAddress = "Chưa cập nhật";
    String displayRole = "Staff";
    String avatarUrl = request.getContextPath() + "/assets/admin/img/avatars/1.png";

    if (sessionUsername != null && !sessionUsername.isBlank()) {
        try {
            javax.sql.DataSource ds = DataSourceUtil.getDataSource();
            UserService userService = new UserServiceImpl(ds);
            currentUser = userService.findByUsername(sessionUsername);

            if (currentUser != null) {
                displayName = (currentUser.getFullname() != null && !currentUser.getFullname().isBlank())
                        ? currentUser.getFullname()
                        : currentUser.getUsername();

                if (currentUser.getEmail() != null && !currentUser.getEmail().isBlank()) {
                    displayEmail = currentUser.getEmail();
                }
                if (currentUser.getPhone() != null && !currentUser.getPhone().isBlank()) {
                    displayPhone = currentUser.getPhone();
                }
                if (currentUser.getAddress() != null && !currentUser.getAddress().isBlank()) {
                    displayAddress = currentUser.getAddress();
                }

                String role = null;
                if (currentUser.getRole() != null && !currentUser.getRole().isBlank()) {
                    role = currentUser.getRole();
                } else if (sessionRole != null && !sessionRole.isBlank()) {
                    role = sessionRole;
                }
                if (role != null) {
                    if (role.equalsIgnoreCase("ADMIN")) {
                        displayRole = "Admin";
                    } else if (role.equalsIgnoreCase("STAFF")) {
                        displayRole = "Staff";
                    } else {
                        displayRole = role;
                    }
                }

                if (currentUser.getAvatar() != null && currentUser.getAvatar().length > 0) {
                    avatarUrl = request.getContextPath() + "/avatar?userId=" + currentUser.getId();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    request.setAttribute("activeMenu", "profile");
    String contextPath = request.getContextPath();
    String success = request.getParameter("success");
    String message = request.getParameter("message");
%>
<!doctype html>
<html lang="en" class="layout-navbar-fixed layout-menu-fixed layout-compact" dir="ltr"
      data-skin="default" data-bs-theme="light" data-assets-path="${adminAssetsPath}/"
      data-template="vertical-menu-template">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <meta name="robots" content="noindex, nofollow"/>
    <title>Thông tin tài khoản - Admin/Staff</title>
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
    <script src="${adminAssetsPath}/js/config.js"></script>
</head>
<body>
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <jsp:include page="../../admin/layout/sidebar.jsp"/>
        <div class="layout-page">
            <jsp:include page="../../admin/layout/navbar.jsp"/>
            <div class="content-wrapper">
                <div class="container-xxl flex-grow-1 container-p-y">
                    <h4 class="fw-bold py-3 mb-4">Tài khoản</h4>

                    <% if ("updated".equals(success)) { %>
                    <div class="alert alert-success">Cập nhật thông tin cá nhân thành công!</div>
                    <% } else if ("password_changed".equals(success)) { %>
                    <div class="alert alert-success">Đổi mật khẩu thành công!</div>
                    <% } %>

                    <% if (message != null) { %>
                        <% if ("error".equals(message)) { %>
                        <div class="alert alert-danger mb-4">Có lỗi xảy ra. Vui lòng thử lại.</div>
                        <% } else if ("unauthorized".equals(message)) { %>
                        <div class="alert alert-warning mb-4">Bạn không có quyền truy cập trang này.</div>
                        <% } %>
                    <% } %>

                    <div class="row gy-4">
                        <div class="col-lg-4">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <div class="avatar avatar-xl mb-3">
                                        <img src="<%= avatarUrl %>" alt="avatar" class="rounded-circle w-px-80 h-px-80">
                                    </div>
                                    <h5 class="mb-1"><%= displayName %></h5>
                                    <p class="text-muted mb-0"><%= displayRole %></p>
                                    <div class="d-grid gap-2 mt-3">
                                        <a class="btn btn-primary" href="<%= contextPath %>/user?action=edit-profile">
                                            <i class="ri ri-edit-2-line me-2"></i>Chỉnh sửa thông tin
                                        </a>
                                        <a class="btn btn-warning" href="<%= contextPath %>/user?action=change-password">
                                            <i class="ri ri-key-2-line me-2"></i>Đổi mật khẩu
                                        </a>
                                        <a class="btn btn-outline-danger" href="<%= contextPath %>/logout">
                                            <i class="ri ri-logout-box-r-line me-2"></i>Đăng xuất
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-8">
                            <div class="card h-100">
                                <div class="card-header d-flex align-items-center justify-content-between">
                                    <div>
                                        <p class="text-muted mb-1">Thông tin cá nhân</p>
                                        <h5 class="mb-0">Hồ sơ tài khoản</h5>
                                    </div>
                                    <span class="badge bg-label-info text-uppercase"><%= displayRole %></span>
                                </div>
                                <div class="card-body">
                                    <dl class="row mb-0">
                                        <dt class="col-sm-4 text-muted">Họ và tên</dt>
                                        <dd class="col-sm-8 mb-3"><%= displayName %></dd>

                                        <dt class="col-sm-4 text-muted">Email</dt>
                                        <dd class="col-sm-8 mb-3"><%= displayEmail %></dd>

                                        <dt class="col-sm-4 text-muted">Số điện thoại</dt>
                                        <dd class="col-sm-8 mb-3"><%= displayPhone %></dd>

                                        <dt class="col-sm-4 text-muted">Địa chỉ</dt>
                                        <dd class="col-sm-8 mb-3"><%= displayAddress %></dd>

                                        <dt class="col-sm-4 text-muted">Tên đăng nhập</dt>
                                        <dd class="col-sm-8 mb-3"><%= sessionUsername != null ? sessionUsername : "N/A" %></dd>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>

<%--                    <%--%>
<%--                        NewsletterDAO newsletterSubscription = (NewsletterDAO) request.getAttribute("newsletterSubscription");--%>
<%--                        boolean isSubscribed = newsletterSubscription != null && "active".equals(newsletterSubscription.getStatus());--%>
<%--                    %>--%>
<%--                    <div class="row gy-4 mt-2">--%>
<%--                        <div class="col-lg-8 offset-lg-4">--%>
<%--                            <div class="card h-100">--%>
<%--                                <div class="card-header d-flex align-items-center justify-content-between">--%>
<%--                                    <div>--%>
<%--                                        <p class="text-muted mb-1">Bản tin</p>--%>
<%--                                        <h5 class="mb-0">Quản lý Newsletter</h5>--%>
<%--                                    </div>--%>
<%--                                    <span class="badge bg-label-primary text-uppercase">Newsletter</span>--%>
<%--                                </div>--%>
<%--                                <div class="card-body">--%>
<%--                                    <p class="text-muted mb-3">--%>
<%--                                        Nhận thông tin sản phẩm mới, khuyến mãi và tin tức công nghệ. Bạn có thể hủy đăng ký bất cứ lúc nào.--%>
<%--                                    </p>--%>
<%--                                    <% if (isSubscribed) { %>--%>
<%--                                    <div class="alert alert-success d-flex align-items-start">--%>
<%--                                        <i class="ri ri-checkbox-circle-line me-2 fs-5"></i>--%>
<%--                                        <div>--%>
<%--                                            <strong>Bạn đang đăng ký nhận tin</strong><br>--%>
<%--                                            <small>Email: <%= currentUser != null ? currentUser.getEmail() : displayEmail %></small>--%>
<%--                                            <% if (newsletterSubscription.getSubscribed_at() != null) { %>--%>
<%--                                            <br>--%>
<%--                                            <small>Đăng ký từ: <%= new SimpleDateFormat("dd/MM/yyyy").format(newsletterSubscription.getSubscribed_at()) %></small>--%>
<%--                                            <% } %>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <form method="post" action="<%= contextPath %>/user"--%>
<%--                                          onsubmit="return confirm('Bạn có chắc chắn muốn hủy đăng ký newsletter? Bạn sẽ không nhận được thông tin về sản phẩm mới và khuyến mãi nữa.');">--%>
<%--                                        <input type="hidden" name="action" value="unsubscribeNewsletter">--%>
<%--                                        <button type="submit" class="btn btn-danger">--%>
<%--                                            <i class="ri ri-close-circle-line me-1"></i> Hủy đăng ký Newsletter--%>
<%--                                        </button>--%>
<%--                                    </form>--%>
<%--                                    <% } else { %>--%>
<%--                                    <div class="alert alert-secondary d-flex align-items-start">--%>
<%--                                        <i class="ri ri-information-line me-2 fs-5"></i>--%>
<%--                                        <div>--%>
<%--                                            <strong>Bạn chưa đăng ký nhận tin</strong><br>--%>
<%--                                            <% if (newsletterSubscription != null && "unsubscribed".equals(newsletterSubscription.getStatus())) { %>--%>
<%--                                            <small>Bạn đã hủy đăng ký trước đó. Đăng ký lại từ form ở footer trang chủ.</small>--%>
<%--                                            <% } else { %>--%>
<%--                                            <small>Đăng ký ngay từ form ở footer trang chủ để nhận thông tin mới nhất!</small>--%>
<%--                                            <% } %>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <a href="<%= contextPath %>/home" class="btn btn-primary">--%>
<%--                                        <i class="ri ri-send-plane-2-line me-1"></i> Đăng ký Newsletter--%>
<%--                                    </a>--%>
<%--                                    <% } %>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
                    </div>
                </div>
                <jsp:include page="../../admin/layout/footer.jsp"/>
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