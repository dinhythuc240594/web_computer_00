<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.UserDAO" %>
<%
    String activeMenu = (String) request.getAttribute("activeMenu");
    String contextPath = request.getContextPath();
    UserDAO currentUser = (UserDAO) request.getAttribute("currentUser");
    String sessionRole = (currentUser != null && currentUser.getRole() != null) 
            ? currentUser.getRole() 
            : "CUSTOMER";
%>
        <sidebar id="layout-menu" class="layout-menu menu-vertical menu">
            <div class="menu-inner-shadow"></div>
            <ul class="menu-inner py-1">
                <!-- Menu-item cha: Quản lý -->
                <li class="menu-item open">
                    <a href="javascript:void(0);" class="menu-link menu-toggle">
                        <i class="menu-icon icon-base ri ri-settings-3-line"></i>
                        <div data-i18n="Management">Quản lý</div>
                        <i class="ri ri-arrow-right-s-line menu-arrow"></i>
                    </a>
                    <ul class="menu-sub">
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
                            <li class="menu-item <%= "newsletter".equals(activeMenu) ? "active" : "" %>">
                                <a href="<%= contextPath %>/admin/newsletter" class="menu-link">
                                    <i class="menu-icon icon-base ri ri-mail-line"></i>
                                    <div data-i18n="Newsletter">Quản lý Newsletter</div>
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
                </li>
                
                <!-- Menu-item cha: Truy cập nhanh -->
                <li class="menu-item">
                    <a href="javascript:void(0);" class="menu-link menu-toggle">
                        <i class="menu-icon icon-base ri ri-external-link-line"></i>
                        <div data-i18n="Quick Access">Truy cập nhanh</div>
                        <i class="ri ri-arrow-right-s-line menu-arrow"></i>
                    </a>
                    <ul class="menu-sub">
                        <li class="menu-item">   
                            <a class="menu-link"
                                href="<%= contextPath %>/home" target="_blank" rel="noopener">
                                <i class="menu-icon icon-base ri ri-home-4-line"></i>
                                <div data-i18n="Home">Trang chủ</div>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a class="menu-link"
                                href="<%= contextPath %>/brand" target="_blank" rel="noopener">
                                <i class="menu-icon icon-base ri ri-star-line"></i>
                                <div data-i18n="Brands">Thương hiệu</div>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a class="menu-link"
                                href="<%= contextPath %>/category" target="_blank" rel="noopener">
                                <i class="menu-icon icon-base ri ri-layout-grid-line"></i>
                                <div data-i18n="Categories">Danh mục</div>
                            </a>
                        </li>
                        <li class="menu-item">
                            <a class="menu-link"
                                href="<%= contextPath %>/product?action=list" target="_blank" rel="noopener">
                                <i class="menu-icon icon-base ri ri-shopping-bag-3-line"></i>
                                <div data-i18n="Products">Danh sách sản phẩm</div>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </sidebar>

        <style>
            #layout-menu .menu-sub {
                display: none;
                list-style: none;
                padding-left: 0;
                margin: 0;
            }
            #layout-menu .menu-item.open > .menu-sub {
                display: block;
            }
            #layout-menu .menu-sub .menu-item {
                padding-left: 1.5rem;
            }
            #layout-menu .menu-toggle {
                position: relative;
            }
            #layout-menu .menu-arrow {
                position: absolute;
                right: 1rem;
                transition: transform 0.3s ease;
            }
            #layout-menu .menu-item.open > .menu-link.menu-toggle .menu-arrow {
                transform: rotate(90deg);
            }
        </style>

        <div class="menu-mobile-toggler d-xl-none rounded-1">
            <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large text-bg-secondary p-2 rounded-1">
                <i class="ri ri-menu-line icon-base"></i>
                <i class="ri ri-arrow-right-s-line icon-base"></i>
            </a>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var menuItems = document.querySelectorAll('#layout-menu .menu-item');

                function setActive(targetItem) {
                    menuItems.forEach(function (el) {
                        el.classList.remove('active');
                    });
                    targetItem.classList.add('active');
                }

                // // Xử lý toggle cho menu-item cha
                // var menuToggles = document.querySelectorAll('#layout-menu .menu-toggle');
                // menuToggles.forEach(function (toggle) {
                //     toggle.addEventListener('click', function (e) {
                //         e.preventDefault();
                //         var parentItem = this.closest('.menu-item');
                //         var isOpen = parentItem.classList.contains('open');
                        
                //         // Đóng tất cả menu-item cha khác
                //         document.querySelectorAll('#layout-menu .menu-item').forEach(function (item) {
                //             if (item !== parentItem) {
                //                 item.classList.remove('open');
                //             }
                //         });
                        
                //         // Toggle menu-item cha hiện tại
                //         parentItem.classList.toggle('open', !isOpen);
                //     });
                // });

                var currentUrl = window.location.pathname + window.location.search;
                menuItems.forEach(function (item) {
                    var link = item.querySelector('a.menu-link:not(.menu-toggle)');
                    if (!link) return;

                    // Bỏ qua các link javascript:void(0)
                    if (link.href && !link.href.includes('javascript:')) {
                        try {
                            var linkUrl = new URL(link.href);
                            var isMatch = (linkUrl.pathname + linkUrl.search) === currentUrl;

                            if (isMatch && !item.classList.contains('active')) {
                                setActive(item);
                                // Mở menu-item cha nếu có
                                var parentMenu = item.closest('.menu-item');
                                if (parentMenu && parentMenu.querySelector('.menu-sub')) {
                                    parentMenu.classList.add('open');
                                }
                            }
                        } catch (e) {
                            // Bỏ qua lỗi URL
                        }
                    }

                    link.addEventListener('click', function (e) {
                        // Không preventDefault cho các link thực sự
                        if (!this.href || this.href.includes('javascript:')) {
                            return;
                        }
                        setActive(item);
                    });
                });
            });
        </script>

