<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.UserDAO" %>
<%
    String activeMenu = (String) request.getAttribute("activeMenu");
    String contextPath = request.getContextPath();
    UserDAO currentUser = (UserDAO) request.getAttribute("currentUser");
    String sessionRole = currentUser.getRole();
%>
        <aside id="layout-menu" class="layout-menu menu-vertical menu">
            <div class="menu-inner-shadow"></div>
            <ul class="menu-inner py-1">
                <li class="menu-item <%= "profile".equals(activeMenu) ? "active" : "" %>">
                    <a href="<%= contextPath %>/user?action=profile" class="menu-link">
                        <i class="menu-icon icon-base ri ri-user-3-line"></i>
                        <div data-i18n="Account">Tài khoản</div>
                    </a>
                </li>
                <%
                    if(sessionRole.equalsIgnoreCase("ADMIN")){
                %>
                    <li class="menu-item <%= "orders".equals(activeMenu) ? "active" : "" %>">
                        <a href="<%= contextPath %>/admin?tab=overview" class="menu-link">
                            <i class="menu-icon icon-base ri ri-file-list-3-line"></i>
                            <div data-i18n="Orders">Tổng quan</div>
                        </a>
                    </li>
                    <li class="menu-item <%= "orders".equals(activeMenu) ? "active" : "" %>">
                        <a href="<%= contextPath %>/admin?tab=users" class="menu-link">
                            <i class="menu-icon icon-base ri ri-file-list-3-line"></i>
                            <div data-i18n="Orders">Quản lý tài khoản</div>
                        </a>
                    </li>
                    <li class="menu-item <%= "orders".equals(activeMenu) ? "active" : "" %>">
                        <a href="<%= contextPath %>/admin?tab=product-sales" class="menu-link">
                            <i class="menu-icon icon-base ri ri-file-list-3-line"></i>
                            <div data-i18n="Orders">Thống kê sản phẩm</div>
                        </a>
                    </li>
                <%
                } else if(sessionRole.equalsIgnoreCase("STAFF")){ %>
                    <li class="menu-item <%= "orders".equals(activeMenu) ? "active" : "" %>">
                        <a href="<%= contextPath %>/staff?action=orders" class="menu-link">
                            <i class="menu-icon icon-base ri ri-file-list-3-line"></i>
                            <div data-i18n="Orders">Đơn hàng</div>
                        </a>
                    </li>

                    <li class="menu-item <%= "products".equals(activeMenu) ? "active" : "" %>">
                        <a href="<%= contextPath %>/staff?action=products" class="menu-link">
                            <i class="menu-icon icon-base ri ri-box-3-line"></i>
                            <div data-i18n="Products">Sản phẩm</div>
                        </a>
                    </li>

                    <li class="menu-item <%= "brands".equals(activeMenu) ? "active" : "" %>">
                        <a href="<%= contextPath %>/staff?action=brands" class="menu-link">
                            <i class="menu-icon icon-base ri ri-price-tag-3-line"></i>
                            <div data-i18n="Brands">Thương hiệu</div>
                        </a>
                    </li>

                    <li class="menu-item <%= "categories".equals(activeMenu) ? "active" : "" %>">
                        <a href="<%= contextPath %>/staff?action=categories" class="menu-link">
                            <i class="menu-icon icon-base ri ri-layout-grid-line"></i>
                            <div data-i18n="Categories">Danh mục</div>
                        </a>
                    </li>
                <% } %>
            </ul>
        </aside>

        <div class="menu-mobile-toggler d-xl-none rounded-1">
            <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large text-bg-secondary p-2 rounded-1">
                <i class="ri ri-menu-line icon-base"></i>
                <i class="ri ri-arrow-right-s-line icon-base"></i>
            </a>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var menuItems = document.querySelectorAll('#layout-menu .menu-item');
                var storageKey = 'adminSidebarActiveHref';

                // Nếu chưa có item nào active (server không set), thử khôi phục từ localStorage
                var hasServerActive = document.querySelector('#layout-menu .menu-item.active');
                if (!hasServerActive) {
                    var savedHref = localStorage.getItem(storageKey);
                    if (savedHref) {
                        menuItems.forEach(function (item) {
                            var link = item.querySelector('a.menu-link');
                            if (link && link.getAttribute('href') === savedHref) {
                                item.classList.add('active');
                            } else {
                                item.classList.remove('active');
                            }
                        });
                    }
                }

                // Khi click: set active ngay và lưu lại để trang khác khôi phục
                menuItems.forEach(function (item) {
                    var link = item.querySelector('a.menu-link');
                    if (!link) return;

                    link.addEventListener('click', function () {
                        var href = link.getAttribute('href');
                        localStorage.setItem(storageKey, href);

                        menuItems.forEach(function (el) {
                            el.classList.remove('active');
                        });
                        item.classList.add('active');
                    });
                });
            });
        </script>

