<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.ProductDAO" %>
<%@ page import="model.BrandDAO" %>
<%@ page import="model.Page" %>
<%
    String contextPath = request.getContextPath();
    
    String searchKeyword = (String) request.getAttribute("searchKeyword");
    Integer selectedBrandId = (Integer) request.getAttribute("selectedBrandId");
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    BrandDAO selectedBrand = (BrandDAO) request.getAttribute("selectedBrand");
    
    if (selectedBrandId == null) selectedBrandId = 0;
    if (currentPage == null) currentPage = 1;
    
    List<BrandDAO> brands = (List<BrandDAO>) request.getAttribute("brands");
    Page<ProductDAO> productPage = (Page<ProductDAO>) request.getAttribute("productPage");
    List<ProductDAO> products = (List<ProductDAO>) request.getAttribute("products");
    
    if (products == null) {
        products = java.util.Collections.emptyList();
    }
    if (brands == null) {
        brands = java.util.Collections.emptyList();
    }
    
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    
    String pageTitle = "Tất cả thương hiệu";
    if (selectedBrand != null) {
        pageTitle = "Thương hiệu: " + selectedBrand.getName();
    } else if (selectedBrandId > 0) {
        pageTitle = "Thương hiệu #" + selectedBrandId;
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
    <style>
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
        .brand-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .brand-list li {
            margin-bottom: 6px;
        }
        .brand-list li:last-child {
            margin-bottom: 0;
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

    <!-- brand-page-section -->
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

            <div class="row clearfix">
                <!-- Sidebar -->
                <div class="col-lg-3 col-md-12 col-sm-12 sidebar-side">
                    <div class="shop-sidebar">
                        <!-- Brands Widget -->
                        <div class="brand-widget sidebar-widget">
                            <div class="widget-title">
                                <h4>Thương hiệu</h4>
                            </div>
                            <div class="widget-content">
                                <ul class="brand-list">
                                    <li>
                                        <%
                                            // Khi click "Tất cả", reset brandId, chỉ giữ keyword nếu có
                                            String allUrl = contextPath + "/brand";
                                            if (searchKeyword != null && !searchKeyword.isBlank()) {
                                                allUrl += "?keyword=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8");
                                            }
                                            // Chỉ active khi không có brand nào được chọn
                                            boolean isAllActive = selectedBrandId == 0;
                                        %>
                                        <a href="<%= allUrl %>" 
                                           class="sidebar-nav-link <%= isAllActive ? "active" : "" %>">
                                            Tất cả thương hiệu
                                        </a>
                                    </li>
                                    <%
                                        for (BrandDAO brand : brands) {
                                            // Active brand khi brandId được chọn
                                            boolean isActive = brand.getId() == selectedBrandId;
                                            // Khi click vào brand, filter theo brandId
                                            String brandUrl = contextPath + "/brand?brandId=" + brand.getId();
                                            if (searchKeyword != null && !searchKeyword.isBlank()) {
                                                brandUrl += "&keyword=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8");
                                            }
                                    %>
                                    <li>
                                        <a href="<%= brandUrl %>" 
                                           class="sidebar-nav-link <%= isActive ? "active" : "" %>">
                                            <%= brand.getName() %>
                                        </a>
                                    </li>
                                    <%
                                        }
                                    %>
                                </ul>
                            </div>
                        </div>
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

                        String priceDisplay = product.getPrice() != null
                                ? currencyFormat.format(product.getPrice())
                                : "Đang cập nhật";

                        boolean inStock = product.getStock_quantity() > 0;
                %>
                <div class="col-lg-3 col-md-4 col-sm-6 shop-block-three">
                    <div class="inner-box">
                        <div class="image-box">
                            <figure class="image">
                                <a href="<%= productLink %>">
                                    <img src="<%= productImage %>" alt="<%= product.getName() %>">
                                </a>
                            </figure>
                        </div>
                        <div class="lower-content">
                            <span class="text">Thương hiệu #<%= product.getBrand_id() %></span>
                            <h4>
                                <a href="<%= productLink %>"><%= product.getName() %></a>
                            </h4>
                            <h5><%= priceDisplay %></h5>
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
                    String baseUrl = contextPath + "/brand?";
                    if (searchKeyword != null && !searchKeyword.isBlank()) {
                        baseUrl += "keyword=" + java.net.URLEncoder.encode(searchKeyword, "UTF-8") + "&";
                    }
                    if (selectedBrandId > 0) {
                        baseUrl += "brandId=" + selectedBrandId + "&";
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
                        <p>Vui lòng thử lại với từ khóa hoặc thương hiệu khác.</p>
                        <a href="<%= contextPath %>/brand" class="theme-btn btn-one">Xem tất cả thương hiệu</a>
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
    <!-- brand-page-section end -->

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


