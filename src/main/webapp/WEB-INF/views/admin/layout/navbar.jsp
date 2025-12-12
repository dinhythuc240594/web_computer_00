<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.UserDAO" %>
<%@ page import="service.UserService" %>
<%@ page import="serviceimpl.UserServiceImpl" %>
<%@ page import="utilities.DataSourceUtil" %>
<%
    // Lấy thông tin user từ session
    String sessionUsername = (String) session.getAttribute("username");
    String sessionRole = (String) session.getAttribute("type_user");
    UserDAO currentUser = null;
    String avatarUrl = request.getContextPath() + "/assets/admin/img/avatars/1.png";
    String displayName = "User";
    String displayRole = "Admin";
    String pageTitle = (String) request.getAttribute("pageTitle");
    if (pageTitle == null || pageTitle.isBlank()) {
        // Thử lấy từ attribute khác hoặc fallback
        pageTitle = (String) request.getAttribute("title");
    }
    if (pageTitle == null || pageTitle.isBlank()) {
        pageTitle = "Quản lý đơn hàng";
    }
    
    if (sessionUsername != null && !sessionUsername.isBlank()) {
        try {
            javax.sql.DataSource ds = DataSourceUtil.getDataSource();
            UserService userService = new UserServiceImpl(ds);
            currentUser = userService.findByUsername(sessionUsername);
            
            if (currentUser != null) {
                // Lấy tên hiển thị
                if (currentUser.getFullname() != null && !currentUser.getFullname().isBlank()) {
                    displayName = currentUser.getFullname();
                } else {
                    displayName = currentUser.getUsername();
                }
                
                // Lấy role và format hiển thị
                String role = null;
                if (currentUser.getRole() != null && !currentUser.getRole().isBlank()) {
                    role = currentUser.getRole();
                } else if (sessionRole != null && !sessionRole.isBlank()) {
                    role = sessionRole;
                }
                
                if (role != null) {
                    // Format role để hiển thị đẹp hơn
                    if (role.equalsIgnoreCase("ADMIN")) {
                        displayRole = "Admin";
                    } else if (role.equalsIgnoreCase("STAFF")) {
                        displayRole = "Staff";
                    } else if (role.equalsIgnoreCase("CUSTOMER")) {
                        displayRole = "Customer";
                    } else {
                        displayRole = role;
                    }
                }
                
                // Lấy avatar URL cho admin/staff nếu có ảnh
                if (role != null
                        && (role.equalsIgnoreCase("ADMIN") || role.equalsIgnoreCase("STAFF"))
                        && currentUser.getAvatar() != null
                        && currentUser.getAvatar().length > 0) {
                    avatarUrl = request.getContextPath()
                            + "/avatar?username="
                            + java.net.URLEncoder.encode(currentUser.getUsername(), "UTF-8");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
            <nav
                    class="layout-navbar container-xxl navbar-detached navbar navbar-expand-xl align-items-center bg-navbar-theme"
                    id="layout-navbar">
                <div class="layout-menu-toggle navbar-nav align-items-xl-center me-4 me-xl-0 d-xl-none">
                </div>

                <div class="navbar-nav-right d-flex align-items-center justify-content-between flex-grow-1" id="navbar-collapse">
                    <div class="d-flex align-items-center">
                        <h5 class="mb-0 fw-semibold text-primary"><%= pageTitle %></h5>
                    </div>
                    <div class="d-flex align-items-center gap-3">
                        <div class="d-flex align-items-center">
                            <div class="avatar avatar-online me-2">
                                <img src="<%= avatarUrl %>" alt="avatar" class="rounded-circle" />
                            </div>
                            <div class="d-flex flex-column">
                                <span class="fw-semibold small"><%= displayName %></span>
                                <span class="text-body-secondary small"><%= displayRole %></span>
                            </div>
                        </div>
                        <a class="btn btn-sm btn-danger d-flex align-items-center" href="${pageContext.request.contextPath}/logout">
                            <small class="align-middle">Đăng xuất</small>
                            <i class="icon-base ri ri-logout-box-r-line ms-2 icon-16px"></i>
                        </a>
                    </div>
                </div>
            </nav>

