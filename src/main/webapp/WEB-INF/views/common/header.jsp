<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.ProductDAO" %>
<%@ page import="model.UserDAO" %>
<%@ page import="model.CategoryDAO" %>
<%@ page import="service.UserService" %>
<%@ page import="service.CategoryService" %>
<%@ page import="serviceimpl.UserServiceImpl" %>
<%@ page import="serviceimpl.CategoryServiceImpl" %>
<%@ page import="utilities.DataSourceUtil" %>
    <style>
        .cart-menu-two .cart-action {
            display: flex;
            gap: 12px;
            flex-wrap: nowrap;
        }

        .cart-menu-two .cart-action .theme-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            white-space: nowrap;
            padding: 12px 28px;
            flex: 1 1 0;
            text-align: center;
        }

        .cart-menu-two .cart-action .theme-btn span {
            display: none;
        }
        
        /* CSS cho thanh tìm kiếm - đảm bảo các phần tử nằm cùng hàng */
        .header-upper .search-area form {
            display: flex;
            align-items: center;
            width: 100%;
            flex-wrap: nowrap;
        }
        
        .header-upper .search-area .category-inner {
            flex-shrink: 0;
            min-width: 200px;
        }
        
        .header-upper .search-area .search-box {
            flex: 1;
            min-width: 0;
        }
        
        @media only screen and (max-width: 499px) {
            .header-upper .search-area form {
                flex-direction: column;
            }
            
            .header-upper .search-area .category-inner {
                width: 100%;
                min-width: 100%;
            }
            
            .header-upper .search-area .search-box {
                width: 100%;
            }
        }
    </style>
    <!-- main header -->
    <header class="main-header">
        <!-- header-upper -->
        <div class="header-upper">
            <div class="large-container">
                <div class="upper-inner">
                    <figure class="logo-box"><a href="index.html"><img src="${pageContext.request.contextPath}/assets/client/images/Logo%20HCMUTE_Color%20background.png" alt="" style="height: 70px; width: 70px;"></a></figure>
                    <div class="search-area">
                        <%
                            // Load categories từ database
                            List<CategoryDAO> headerCategories = null;
                            try {
                                javax.sql.DataSource ds = DataSourceUtil.getDataSource();
                                CategoryService categoryService = new CategoryServiceImpl(ds);
                                headerCategories = categoryService.getAll();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            
                            // Lấy tham số từ request để giữ trạng thái
                            String currentKeyword = request.getParameter("keyword");
                            if (currentKeyword == null) {
                                currentKeyword = "";
                            }
                            String currentCategoryId = request.getParameter("categoryId");
                            if (currentCategoryId == null) {
                                currentCategoryId = "";
                            }
                        %>
                        <form method="get" action="${pageContext.request.contextPath}/shop" id="header-search-form">
                            <div class="category-inner">
                                <div class="select-box">
                                    <select class="wide" name="categoryId" id="header-category-select">
                                        <option value="" data-display="Danh Mục">Danh Mục</option>
                                        <%
                                            if (headerCategories != null && !headerCategories.isEmpty()) {
                                                for (CategoryDAO category : headerCategories) {
                                                    if (category.getIs_active() != null && category.getIs_active()) {
                                                        String selected = currentCategoryId.equals(String.valueOf(category.getId())) ? "selected" : "";
                                        %>
                                        <option value="<%= category.getId() %>" <%= selected %>><%= category.getName() %></option>
                                        <%
                                                    }
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="search-box">
                                <div class="form-group">
                                    <input type="search" name="keyword" id="header-search-keyword" placeholder="Tìm kiếm sản phẩm..." value="<%= currentKeyword %>">
                                    <button type="submit"><i class="icon-2"></i></button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="right-column">
                        <div class="support-box">
<%--                            <div class="icon-box"><i class="icon-3"></i></div>--%>
<%--                            <a href="tel:912345678">091 2345 678</a>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- header-lower -->
        <div class="header-lower">
            <div class="large-container">
                <div class="outer-box">
                    <div style="position: relative;
    display: inline-block;
    left: 0px;
    top: 4px;
    /*width: 300px;*/
padding: 15px 20px;"></div>
                    <div class="menu-area">
                        <!--Mobile Navigation Toggler-->
                        <div class="mobile-nav-toggler">
                            <i class="icon-bar"></i>
                            <i class="icon-bar"></i>
                            <i class="icon-bar"></i>
                        </div>
                        <nav class="main-menu navbar-expand-md navbar-light clearfix">
                            <div class="collapse navbar-collapse show clearfix" id="navbarSupportedContent">
                                <ul class="navigation clearfix">
                                    <li class="current"><a href="home">Home</a>
                                    </li>
                                    <li><a href="category">Danh Mục</a>
                                    </li>
                                    <li><a href="contact">Contact</a></li>
                                    <li></li>
                                    <li></li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <div class="menu-right-content" style="padding: 15px 20px;">
                        <ul class="info-list">
                            <li class="cart-box">
                                <%
                                    // Lấy giỏ hàng từ session
                                    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
                                    if (cartItems == null) {
                                        cartItems = java.util.Collections.emptyList();
                                    }
                                    
                                    // Tính tổng số lượng sản phẩm
                                    int totalQuantity = 0;
                                    double subtotal = 0.0;
                                    for (CartItem item : cartItems) {
                                        ProductDAO p = item.getProduct();
                                        if (p != null) {
                                            totalQuantity += item.getQuantity();
                                            if (p.getPrice() != null) {
                                                subtotal += p.getPrice() * item.getQuantity();
                                            }
                                        }
                                    }
                                    
                                    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                    
                                    // Lấy thông tin đăng nhập từ session
                                    Boolean isLogin = (Boolean) request.getAttribute("is_login");
                                    String username = (String) request.getAttribute("username");
                                    String typeUser = (String) request.getAttribute("type_user");
                                    String userAvatar = (String) request.getAttribute("userAvatar");
                                    
                                    // Lấy thông tin user đầy đủ từ database
                                    UserDAO currentUser = null;
                                    if (isLogin != null && isLogin && username != null && !username.isBlank()) {
                                        try {
                                            javax.sql.DataSource ds = DataSourceUtil.getDataSource();
                                            UserService userService = new UserServiceImpl(ds);
                                            currentUser = userService.findByUsername(username);
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                    }
                                    
                                    // Xác định tên hiển thị và link profile
                                    String displayName = "";
                                    String profileLink = "";
                                    if (currentUser != null) {
                                        displayName = currentUser.getFullname() != null && !currentUser.getFullname().isBlank()
                                                ? currentUser.getFullname() : currentUser.getUsername();
                                        // Xác định link profile dựa trên role
                                        if (currentUser.getRole() != null && 
                                            (currentUser.getRole().equalsIgnoreCase("STAFF") || 
                                             currentUser.getRole().equalsIgnoreCase("ADMIN"))) {
                                            profileLink = request.getContextPath() + "/staff";
                                        } else {
                                            profileLink = request.getContextPath() + "/user";
                                        }
                                    }
                                %>
                                <a class="shopping-cart shopping-cart-two" href="#" data-bs-toggle="offcanvas" data-bs-target="offcanvasRight"><i class="icon-7"></i><span><%= totalQuantity %></span></a>
                                <div class="cart-menu cart-menu-two">
                                    <div class="close-icon close-icon-two"><a href="javascript:void(0);"><i class="icon-9"></i></a></div>
                                    <div class="cart-products">
                                        <%
                                            if (!cartItems.isEmpty()) {
                                                for (CartItem item : cartItems) {
                                                    ProductDAO product = item.getProduct();
                                                    if (product == null) continue;
                                                    
                                                    String productImage = product.getImage_url();
                                                    if (productImage == null || productImage.isBlank()) {
                                                        productImage = request.getContextPath() + "/assets/client/images/shop/cart-4.png";
                                                    } else if (!productImage.startsWith("http")) {
                                                        if (!productImage.startsWith("/")) {
                                                            productImage = "/" + productImage;
                                                        }
                                                        productImage = request.getContextPath() + productImage;
                                                    }
                                                    
                                                    String productLink = product.getSlug() != null && !product.getSlug().isBlank()
                                                            ? request.getContextPath() + "/product?slug=" + product.getSlug()
                                                            : request.getContextPath() + "/product?id=" + product.getId();
                                                    
                                                    int quantity = item.getQuantity();
                                                    double price = product.getPrice() != null ? product.getPrice() : 0.0;
                                        %>
                                        <div class="product">
                                            <figure class="image-box"><a href="<%= productLink %>"><img src="<%= productImage %>" alt="<%= product.getName() %>"></a></figure>
                                            <h5><a href="<%= productLink %>"><%= product.getName() %></a></h5>
                                            <span><%= currencyFormat.format(price) %> <span class="quentity">x <%= quantity %></span></span>
                                            <button type="button" class="remove-btn" data-product-id="<%= product.getId() %>">
                                                <i class="icon-9"></i>
                                            </button>
                                        </div>
                                        <%
                                                }
                                            } else {
                                        %>
                                        <div class="product">
                                            <p style="text-align: center; padding: 20px;">Giỏ hàng của bạn đang trống.</p>
                                        </div>
                                        <%
                                            }
                                        %>
                                    </div>
                                    <div class="cart-total">
                                        <span>Tạm tính</span>
                                        <span class="cart-total-price"><%= currencyFormat.format(subtotal) %></span>
                                    </div>
                                    <div class="cart-action">
                                        <a href="<%= request.getContextPath() %>/cart" class="theme-btn btn-two">Xem giỏ hàng <span></span><span></span><span></span><span></span></a>
                                        <%
                                            if (!cartItems.isEmpty()) {
                                        %>
                                        <a href="<%= request.getContextPath() %>/checkout" class="theme-btn btn-one">Thanh toán <span></span><span></span><span></span><span></span></a>
                                        <%
                                            } else {
                                        %>
                                        <a href="<%= request.getContextPath() %>/cart" class="theme-btn btn-one" style="opacity: 0.5; cursor: not-allowed;">Thanh toán <span></span><span></span><span></span><span></span></a>
                                        <%
                                            }
                                        %>
                                    </div>
                                </div>
                            </li>
                            <%
                                if (isLogin != null && isLogin && currentUser != null) {
                                    // Hiển thị avatar, tên và nút logout khi đã đăng nhập
                                    String avatarUrl = userAvatar;
                                    boolean hasAvatar = false;
                                    if (avatarUrl != null && !avatarUrl.isBlank()) {
                                        hasAvatar = true;
                                        if (!avatarUrl.startsWith("http") && !avatarUrl.startsWith("/")) {
                                            avatarUrl = request.getContextPath() + "/" + avatarUrl;
                                        } else if (!avatarUrl.startsWith("http") && avatarUrl.startsWith("/")) {
                                            avatarUrl = request.getContextPath() + avatarUrl;
                                        }
                                    }
                            %>
                            <li class="user-info" style="display: flex; align-items: center; gap: 10px; margin-right: 10px;">
                                <a href="<%= profileLink %>" style="display: flex; align-items: center; gap: 8px; text-decoration: none; color: inherit;">
                                    <% if (hasAvatar) { %>
                                    <img src="<%= avatarUrl %>" 
                                         alt="Avatar" 
                                         onerror="this.onerror=null; var div = document.createElement('div'); div.style.cssText='width: 40px; height: 40px; border-radius: 50%; background-color: #ddd; display: flex; align-items: center; justify-content: center; border: 2px solid #ddd;'; div.innerHTML='<i class=&quot;fas fa-user&quot; style=&quot;color: #666; font-size: 18px;&quot;></i>'; this.parentElement.replaceChild(div, this);"
                                         style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover; border: 2px solid #ddd;">
                                    <% } else { %>
                                    <div style="width: 40px; height: 40px; border-radius: 50%; background-color: #ddd; display: flex; align-items: center; justify-content: center; border: 2px solid #ddd;">
                                        <i class="fas fa-user" style="color: #666; font-size: 18px;"></i>
                                    </div>
                                    <% } %>
                                    <span style="font-weight: 500;"><%= displayName %></span>
                                </a>
                            </li>
                            <li>
                                <a href="<%= request.getContextPath() %>/logout" style="color: #dc3545;">Đăng xuất</a>
                            </li>
                            <%
                                } else {
                                    // Hiển thị nút đăng nhập và đăng ký khi chưa đăng nhập
                            %>
                            <li><a href="<%= request.getContextPath() %>/login">Đăng nhập</a></li>
                            <li><a href="<%= request.getContextPath() %>/register">Đăng ký</a></li>
                            <%
                                }
                            %>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- main-header end -->
    
    <!-- Set context path for JavaScript -->
    <script>
        window.APP_CONTEXT_PATH = '<%= request.getContextPath() %>';
    </script>
    
    <!-- Cart Management Script -->
    <script src="${pageContext.request.contextPath}/assets/client/js/cart.js"></script>
    <script>
        // Handle remove button clicks
        document.addEventListener('DOMContentLoaded', function() {
            // Add event listeners for remove buttons
            document.addEventListener('click', function(e) {
                if (e.target.closest('.remove-btn')) {
                    const btn = e.target.closest('.remove-btn');
                    const productId = btn.getAttribute('data-product-id');
                    if (productId && typeof CartManager !== 'undefined') {
                        CartManager.removeFromCart(parseInt(productId));
                    }
                }
            });
            
            // Override cart display with localStorage data when page loads
            if (typeof CartManager !== 'undefined') {
                CartManager.updateCartDisplay();
            } else {
                // Retry if cart.js hasn't loaded yet
                setTimeout(function() {
                    if (typeof CartManager !== 'undefined') {
                        CartManager.updateCartDisplay();
                    }
                }, 100);
            }
        });
    </script>

