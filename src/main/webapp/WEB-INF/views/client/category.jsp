<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.ProductDAO" %>
<%@ page import="model.CategoryDAO" %>
<%@ page import="model.BrandDAO" %>
<%@ page import="model.Page" %>
<%
    String contextPath = request.getContextPath();
    
    String searchKeyword = (String) request.getAttribute("searchKeyword");
    Integer selectedCategoryId = (Integer) request.getAttribute("selectedCategoryId");
    Integer selectedBrandId = (Integer) request.getAttribute("selectedBrandId");
    String selectedSort = (String) request.getAttribute("selectedSort");
    String selectedOrder = (String) request.getAttribute("selectedOrder");
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    CategoryDAO selectedCategory = (CategoryDAO) request.getAttribute("selectedCategory");
    
    if (selectedCategoryId == null) selectedCategoryId = 0;
    if (selectedBrandId == null) selectedBrandId = 0;
    if (selectedSort == null) selectedSort = "created_at";
    if (selectedOrder == null) selectedOrder = "DESC";
    if (currentPage == null) currentPage = 1;
    
    List<CategoryDAO> categories = (List<CategoryDAO>) request.getAttribute("categories");
    List<BrandDAO> brands = (List<BrandDAO>) request.getAttribute("brands");
    Page<ProductDAO> productPage = (Page<ProductDAO>) request.getAttribute("productPage");
    List<ProductDAO> products = (List<ProductDAO>) request.getAttribute("products");
    
    if (products == null) {
        products = java.util.Collections.emptyList();
    }
    if (categories == null) {
        categories = java.util.Collections.emptyList();
    }
    if (brands == null) {
        brands = java.util.Collections.emptyList();
    }
    
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    
    String pageTitle = "Tất cả sản phẩm";
    if (selectedCategory != null) {
        pageTitle = selectedCategory.getName();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <title><%= pageTitle %> - Cửa hàng máy tính HCMUTE</title>

    <!-- Fav Icon -->
    <link rel="icon" href="${pageContext.request.contextPath}/assets/client/images/Logo%20HCMUTE_White%20background.png" type="image/x-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Rethink+Sans:ital,wght@0,400..800;1,400..800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link href="${pageContext.request.contextPath}/assets/client/css/font-awesome-all.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/flaticon.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/owl.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/jquery.fancybox.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/animate.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/nice-select.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/elpath.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/color.css" id="jssDefault" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/rtl.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/page-title.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/shop-three.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/shop-sidebar.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/footer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/responsive.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/highlights.css" rel="stylesheet">
    <style>
        .category-filter-section {
            background: #f8f9fa;
            padding: 30px 0;
            margin-bottom: 30px;
        }
        .filter-form {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            align-items: flex-end;
        }
        .filter-group {
            flex: 1;
            min-width: 200px;
        }
        .filter-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
        }
        .filter-group select,
        .filter-group input[type="text"] {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .filter-group button {
            padding: 10px 30px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            white-space: nowrap;
        }
        .filter-group button:hover {
            background: #0056b3;
        }
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin: 30px 0;
        }
        .pagination a, .pagination span {
            display: inline-block;
            padding: 8px 16px;
            text-decoration: none;
            border: 1px solid #ddd;
            border-radius: 4px;
            color: #333;
        }
        .pagination a:hover {
            background-color: #f5f5f5;
        }
        .pagination .active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
        .pagination .disabled {
            color: #ccc;
            cursor: not-allowed;
            pointer-events: none;
        }
        .page-header {
            margin-bottom: 20px;
        }
        .page-header h2 {
            margin-bottom: 10px;
        }
        .sidebar-nav-link {
            display: block;
            padding: 12px 18px;
            color: #333;
            text-decoration: none;
            border-radius: 6px;
            transition: all 0.3s ease;
            position: relative;
            font-size: 15px;
            border-left: 3px solid transparent;
        }
        .sidebar-nav-link:hover {
            background-color: #e8f4fd;
            color: #007bff;
            border-left-color: #007bff;
            transform: translateX(5px);
            box-shadow: 0 2px 8px rgba(0, 123, 255, 0.15);
        }
        .sidebar-nav-link.active {
            background-color: #007bff;
            color: white;
            font-weight: 600;
            border-left-color: #0056b3;
            box-shadow: 0 2px 12px rgba(0, 123, 255, 0.3);
            transform: translateX(0);
        }
        .sidebar-nav-link.active:hover {
            background-color: #0056b3;
            color: white;
            transform: translateX(3px);
            box-shadow: 0 3px 15px rgba(0, 123, 255, 0.4);
        }
        .sidebar-widget {
            margin-bottom: 30px;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            width: 1000px;
        }
        .widget-title {
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 2px solid #eee;
        }
        .widget-title h4 {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin: 0;
        }
        .category-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .category-list li {
            margin-bottom: 6px;
        }
        .category-list li:last-child {
            margin-bottom: 0;
        }
        .filter-select {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #d9d9d9;
            border-radius: 6px;
            font-size: 14px;
            background: #fff;
            color: #111;
            margin-bottom: 15px;
            appearance: none;
        }
        .filter-select:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
        }
        .filter-btn {
            width: 100%;
            padding: 12px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .filter-btn:hover {
            background: #0056b3;
        }
        .filter-btn-reset {
            width: 100%;
            padding: 12px;
            background: #6c757d;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            margin-top: 10px;
            transition: background 0.3s ease;
            display: block;
            text-align: center;
            text-decoration: none;
        }
        .filter-btn-reset:hover {
            background: #5a6268;
        }
    </style>
</head>

<!-- page wrapper -->
<body>

<div class="boxed_wrapper ltr">

    <jsp:include page="../common/header.jsp" />

    <!-- Category Menu  -->
    <jsp:include page="../common/category-menu.jsp" />
    <!-- End Category Menu -->

    <!-- category-page-section -->
    <section class="shop-three pt_40 pb_80">
        <div class="large-container">
            <!-- Page Header -->
            <div class="page-header">
                <h2><%= pageTitle %></h2>
                <%
                    if (productPage != null) {
                %>
                <p>Tìm thấy <%= productPage.getTotalItem() %> sản phẩm
                    <% if (searchKeyword != null && !searchKeyword.isBlank()) { %>
                    với từ khóa "<%= searchKeyword %>"
                    <% } %>
                </p>
                <%
                    }
                %>
            </div>

            <!-- Filter Section -->
            <!-- <div class="category-filter-section">
                <div class="large-container">
                    <form method="GET" action="<%= contextPath %>/category" class="filter-form">
                        <div class="filter-group">
                            <label for="categoryId">Danh mục:</label>
                            <select name="categoryId" id="categoryId">
                                <option value="0">Tất cả danh mục</option>
                                <%
                                    for (CategoryDAO category : categories) {
                                        boolean isSelected = category.getId() == selectedCategoryId;
                                %>
                                <option value="<%= category.getId() %>" <%= isSelected ? "selected" : "" %>>
                                    <%= category.getName() %>
                                </option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label for="keyword">Tìm kiếm:</label>
                            <input type="text" 
                                   name="keyword" 
                                   id="keyword" 
                                   placeholder="Nhập tên sản phẩm hoặc giá..."
                                   value="<%= searchKeyword != null ? searchKeyword : "" %>">
                        </div>
                        <div class="filter-group">
                            <button type="submit">Tìm kiếm</button>
                        </div>
                    </form>
                </div>
            </div> -->

            <div class="row clearfix">
                <!-- Sidebar -->
                <div class="col-lg-3 col-md-12 col-sm-12 sidebar-side">
                    <div class="shop-sidebar">
                        <!-- Filter Form -->
                        <form method="GET" action="<%= contextPath %>/category" class="filter-form">

                            <!-- Categories Widget -->
                            <div class="category-widget sidebar-widget">
                                <div class="widget-title">
                                    <h4>Danh mục sản phẩm</h4>
                                </div>
                                <div class="widget-content">
                                    <select name="categoryId" id="categoryId" class="filter-select">
                                        <option value="0" <%= selectedCategoryId == 0 ? "selected" : "" %>>Tất cả danh mục</option>
                                        <%
                                            for (CategoryDAO category : categories) {
                                        %>
                                        <option value="<%= category.getId() %>" <%= selectedCategoryId == category.getId() ? "selected" : "" %>>
                                            <%= category.getName() %>
                                        </option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>

                            <!-- Brands Widget -->
                            <div class="brand-widget sidebar-widget">
                                <div class="widget-title">
                                    <h4>Thương hiệu</h4>
                                </div>
                                <div class="widget-content">
                                    <select name="brandId" id="brandId" class="filter-select">
                                        <option value="0" <%= selectedBrandId == 0 ? "selected" : "" %>>Tất cả thương hiệu</option>
                                        <%
                                            for (BrandDAO brand : brands) {
                                        %>
                                        <option value="<%= brand.getId() %>" <%= selectedBrandId == brand.getId() ? "selected" : "" %>>
                                            <%= brand.getName() %>
                                        </option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>

                            <!-- Sort Widget -->
                            <div class="sort-widget sidebar-widget">
                                <div class="widget-title">
                                    <h4>Sắp xếp</h4>
                                </div>
                                <div class="widget-content">
                                    <select name="sort" id="sort" class="filter-select">
                                        <option value="created_at" <%= "created_at".equals(selectedSort) ? "selected" : "" %>>Mới nhất</option>
                                        <option value="name" <%= "name".equals(selectedSort) ? "selected" : "" %>>Tên A-Z</option>
                                        <option value="price" <%= "price".equals(selectedSort) ? "selected" : "" %>>Giá</option>
                                        <option value="stock_quantity" <%= "stock_quantity".equals(selectedSort) ? "selected" : "" %>>Tồn kho</option>
                                    </select>
                                    <select name="order" id="order" class="filter-select">
                                        <option value="DESC" <%= "DESC".equals(selectedOrder) ? "selected" : "" %>>Giảm dần</option>
                                        <option value="ASC" <%= "ASC".equals(selectedOrder) ? "selected" : "" %>>Tăng dần</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Filter Buttons -->
                            <div class="sidebar-widget">
                                <button type="submit" class="filter-btn">Áp dụng bộ lọc</button>
                                <a href="<%= contextPath %>/category" class="filter-btn-reset" style="display: block; text-align: center; text-decoration: none;">Đặt lại</a>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Content -->
                <div class="col-lg-9 col-md-12 col-sm-12 content-side">
            <%
                if (products != null && !products.isEmpty()) {
            %>
            <div class="row clearfix">
                <%
                    for (ProductDAO product : products) {
                        String productImage = product.getImage();
                        if (productImage == null || productImage.isBlank()) {
                            productImage = contextPath + "/assets/client/images/shop/shop-10.png";
                        }

                        String productLink = product.getSlug() != null && !product.getSlug().isBlank()
                                ? contextPath + "/product?slug=" + product.getSlug()
                                : contextPath + "/product?id=" + product.getId();

                        // Kiểm tra sản phẩm có đang giảm giá không
                        boolean isOnSale = product.getIs_on_sale() != null && product.getIs_on_sale() && product.isCurrentlyOnSale();
                        Double originalPrice = product.getOriginalPrice();
                        Double currentPrice = product.getCurrentPrice();
                        // Tính phần trăm giảm giá (tự động tính nếu discount_percentage null)
                        Double discountPercent = product.getCalculatedDiscountPercentage();

                        boolean inStock = product.getStock_quantity() > 0;
                        
                        // Giới hạn tên sản phẩm 6 từ
                        String productName = product.getName();
                        if (productName != null && !productName.isBlank()) {
                            String[] words = productName.trim().split("\\s+");
                            if (words.length > 6) {
                                productName = String.join(" ", java.util.Arrays.copyOf(words, 6)) + "...";
                            }
                        }
                %>
                <div class="col-lg-3 col-md-4 col-sm-6 shop-block-three">
                    <div class="inner-box">
                        <div class="image-box" style="position: relative;">
                            <% if (product.isNewProduct()) { %>
                            <span class="new-badge" style="position: absolute; top: 10px; right: 10px; background: #28a745; color: white; padding: 5px 10px; border-radius: 5px; font-weight: bold; z-index: 10;">
                                New
                            </span>
                            <% if (isOnSale && discountPercent != null) { %>
                            <span class="sale-badge" style="position: absolute; top: 48px; right: 10px; background: #ff4444; color: white; padding: 5px 10px; border-radius: 5px; font-weight: bold; z-index: 10;">
                                -<%= Math.round(discountPercent) %>%
                            </span>
                            <% } %>
                            <% } else if (isOnSale && discountPercent != null) { %>
                            <span class="sale-badge" style="position: absolute; top: 10px; right: 10px; background: #ff4444; color: white; padding: 5px 10px; border-radius: 5px; font-weight: bold; z-index: 10;">
                                -<%= Math.round(discountPercent) %>%
                            </span>
                            <% } %>
                            <figure class="image">
                                <a href="<%= productLink %>">
                                    <img src="<%= productImage %>" alt="<%= product.getName() %>">
                                </a>
                            </figure>
                        </div>
                        <div class="lower-content">

                            <% for (CategoryDAO category : categories) {
                                if(product.getCategory_id() == category.getId()){ %>
                            <!-- <span class="text">Danh mục <%= category.getName() %></span> -->
                            <%      }
                            }
                            %>
                            <h4>
                                <a href="<%= productLink %>"><%= productName %></a>
                            </h4>
                            <div class="price-box">
                                <% if (isOnSale && originalPrice != null && currentPrice != null && originalPrice > currentPrice) { %>
                                    <h5 style="color: #ff4444; font-weight: bold; margin-bottom: 5px;">
                                        <%= currencyFormat.format(currentPrice) %>
                                    </h5>
                                    <h6 style="color: #999; text-decoration: line-through; font-size: 0.9em; margin: 0;">
                                        <%= currencyFormat.format(originalPrice) %>
                                    </h6>
                                <% } else { %>
                                    <h5>
                                        <%= currentPrice != null ? currencyFormat.format(currentPrice) : "Đang cập nhật" %>
                                    </h5>
                                <% } %>
                            </div>
                            <%
                                if (inStock) {
                            %>
                            <span class="product-stock">
                                <img src="<%= contextPath %>/assets/client/images/icons/icon-1.png" alt="">
                                Còn <%= product.getStock_quantity() %> sản phẩm
                            </span>
                            <%
                                } else {
                            %>
                            <span class="product-stock-out">
                                <img src="<%= contextPath %>/assets/client/images/icons/icon-2.png" alt="">
                                Tạm hết hàng
                            </span>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>

            <%
                // Hiển thị phân trang
                if (productPage != null && productPage.getTotalPage() > 1) {
                    int totalPages = productPage.getTotalPage();
                    int current = productPage.getCurrentPage();
                    
                    // Xây dựng URL base
                    String baseUrl = contextPath + "/category?";
                    if (searchKeyword != null && !searchKeyword.isBlank()) {
                        baseUrl += "keyword=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8") + "&";
                    }
                    if (selectedCategoryId > 0) {
                        baseUrl += "categoryId=" + selectedCategoryId + "&";
                    }
                    if (selectedBrandId > 0) {
                        baseUrl += "brandId=" + selectedBrandId + "&";
                    }
                    if (selectedSort != null && !selectedSort.equals("created_at")) {
                        baseUrl += "sort=" + selectedSort + "&";
                    }
                    if (selectedOrder != null && !selectedOrder.equals("DESC")) {
                        baseUrl += "order=" + selectedOrder + "&";
                    }
            %>
            <div class="pagination">
                <%
                    // Nút Previous
                    if (current > 1) {
                %>
                <a href="<%= baseUrl %>page=<%= current - 1 %>">&laquo; Trước</a>
                <%
                    } else {
                %>
                <span class="disabled">&laquo; Trước</span>
                <%
                    }
                    
                    // Hiển thị số trang
                    int startPage = Math.max(1, current - 2);
                    int endPage = Math.min(totalPages, current + 2);
                    
                    if (startPage > 1) {
                %>
                <a href="<%= baseUrl %>page=1">1</a>
                <%
                        if (startPage > 2) {
                %>
                <span>...</span>
                <%
                        }
                    }
                    
                    for (int i = startPage; i <= endPage; i++) {
                        if (i == current) {
                %>
                <span class="active"><%= i %></span>
                <%
                        } else {
                %>
                <a href="<%= baseUrl %>page=<%= i %>"><%= i %></a>
                <%
                        }
                    }
                    
                    if (endPage < totalPages) {
                        if (endPage < totalPages - 1) {
                %>
                <span>...</span>
                <%
                        }
                %>
                <a href="<%= baseUrl %>page=<%= totalPages %>"><%= totalPages %></a>
                <%
                    }
                    
                    // Nút Next
                    if (current < totalPages) {
                %>
                <a href="<%= baseUrl %>page=<%= current + 1 %>">Sau &raquo;</a>
                <%
                    } else {
                %>
                <span class="disabled">Sau &raquo;</span>
                <%
                    }
                %>
            </div>
            <%
                }
            %>
            <%
                } else {
            %>
            <div class="row clearfix">
                <div class="col-lg-12">
                    <div style="text-align: center; padding: 60px 20px;">
                        <h3>Không tìm thấy sản phẩm phù hợp</h3>
                        <p>Vui lòng thử lại với từ khóa hoặc danh mục khác.</p>
                        <a href="<%= contextPath %>/category" class="theme-btn btn-one">Xem tất cả sản phẩm</a>
                    </div>
                </div>
            </div>
            <%
                }
            %>
                </div>
            </div>
        </div>
    </section>
    <!-- category-page-section end -->

    <!-- highlights-section -->
    <jsp:include page="../common/highlight-section.jsp" />
    <!-- highlights-section end -->

    <!-- main-footer -->
    <jsp:include page="../common/footer.jsp" />
    <!-- main-footer end -->

    <!--Scroll to top-->
    <div class="scroll-to-top">
        <svg class="scroll-top-inner" viewBox="-1 -1 102 102">
            <path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98" />
        </svg>
    </div>

</div>

<!-- jequery plugins -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/client/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/client/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/client/js/owl.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/client/js/wow.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/client/js/validation.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/client/js/jquery.fancybox.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/client/js/appear.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/client/js/isotope.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/client/js/parallax-scroll.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/client/js/jquery.nice-select.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/client/js/scrolltop.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/client/js/language.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/client/js/countdown.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/client/js/jquery-ui.js"></script>

<!-- main-js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/client/js/script.js"></script>

</body><!-- End of .page_wrapper -->
</html>

