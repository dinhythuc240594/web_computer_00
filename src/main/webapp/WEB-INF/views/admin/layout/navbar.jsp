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
                
                // Lấy avatar URL
                if (currentUser.getAvatar() != null && currentUser.getAvatar().length > 0) {
                    avatarUrl = request.getContextPath() + "/avatar?username=" + java.net.URLEncoder.encode(currentUser.getUsername(), "UTF-8");
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

                <div class="navbar-nav-right d-flex align-items-center justify-content-end" id="navbar-collapse">
                    <ul class="navbar-nav flex-row align-items-center ms-md-auto">
                        
                        <li class="nav-item navbar-dropdown dropdown-user dropdown">
                            <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                                <div class="avatar avatar-online">
                                    <img src="<%= avatarUrl %>" alt="avatar" class="rounded-circle" />
                                </div>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end mt-3 py-2">
                                <li>
                                    <a class="dropdown-item" href="pages-account-settings-account.html">
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0 me-2">
                                                <div class="avatar avatar-online">
                                                    <img
                                                            src="<%= avatarUrl %>"
                                                            alt="avatar"
                                                            class="w-px-40 h-auto rounded-circle" />
                                                </div>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h6 class="mb-0 small"><%= displayName %></h6>
                                                <small class="text-body-secondary"><%= displayRole %></small>
                                            </div>
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <div class="dropdown-divider"></div>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="pages-profile-user.html">
                                        <i class="icon-base ri ri-user-3-line icon-22px me-3"></i
                                        ><span class="align-middle">My Profile</span>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="pages-account-settings-account.html">
                                        <i class="icon-base ri ri-settings-4-line icon-22px me-3"></i
                                        ><span class="align-middle">Settings</span>
                                    </a>
                                </li>
                                <!-- <li>
                                    <a class="dropdown-item" href="pages-account-settings-billing.html">
                        <span class="d-flex align-items-center align-middle">
                          <i class="flex-shrink-0 icon-base ri ri-file-text-line icon-22px me-3"></i>
                          <span class="flex-grow-1 align-middle">Billing Plan</span>
                          <span class="flex-shrink-0 badge badge-center rounded-pill bg-danger">4</span>
                        </span>
                                    </a>
                                </li> -->
                                <!-- <li>
                                    <div class="dropdown-divider"></div>
                                </li> -->
                                <!-- <li>
                                    <a class="dropdown-item" href="pages-pricing.html">
                                        <i class="icon-base ri ri-money-dollar-circle-line icon-22px me-3"></i
                                        ><span class="align-middle">Pricing</span>
                                    </a>
                                </li> -->
                                <!-- <li>
                                    <a class="dropdown-item" href="pages-faq.html">
                                        <i class="icon-base ri ri-question-line icon-22px me-3"></i
                                        ><span class="align-middle">FAQ</span>
                                    </a>
                                </li> -->
                                <li>
                                    <div class="d-grid px-4 pt-2 pb-1">
                                        <a class="btn btn-sm btn-danger d-flex" href="${pageContext.request.contextPath}/logout">
                                            <small class="align-middle">Logout</small>
                                            <i class="icon-base ri ri-logout-box-r-line ms-2 icon-16px"></i>
                                        </a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        
                    </ul>
                </div>
            </nav>

