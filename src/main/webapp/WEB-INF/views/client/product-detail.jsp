<%--
  Created by IntelliJ IDEA.
  User: Windows
  Date: 25/11/2025
  Time: 1:45 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="model.ReviewDAO" %>
<%@ page import="model.CategoryDAO" %>
<%@ page import="model.BrandDAO" %>
<%@ page import="model.ProductSpecDAO" %>
<%@ page import="model.UserDAO" %>
<%@ page import="utilities.DataSourceUtil" %>
<%@ page import="serviceimpl.UserServiceImpl" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <title>Shared on THEMELOCK.COM - Nexmart - HTML 5 Template Preview</title>

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
    <link href="${pageContext.request.contextPath}/assets/client/css/jquery-ui.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/color.css" id="jssDefault" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/rtl.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/page-title.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/shop-details.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/shop-one.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/shop-two.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/highlights.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/footer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/responsive.css" rel="stylesheet">
    
    <style>
        /* Review Form Styles */
        #review-comment:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
        }
        
        .star-icon:hover {
            transform: scale(1.1);
        }
        
        .customer-review {
            transition: box-shadow 0.3s;
        }
        
        .customer-review:hover {
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        
        .single-review:hover {
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s;
        }
    </style>

</head>


<!-- page wrapper -->
<body>

<div class="boxed_wrapper ltr">


    <!-- <jsp:include page="../common/preloader.jsp" /> -->

    <!-- main header -->
    <jsp:include page="../common/header.jsp" />
    <!-- main-header end -->


    <jsp:include page="../common/mobile-menu.jsp" />


    <jsp:include page="../common/category-menu.jsp" />

    <!-- shop-details -->
    <section class="shop-details pb_70">
        <div class="large-container">
            <%
                model.ProductDAO product = (model.ProductDAO) request.getAttribute("product");
                List<ReviewDAO> reviews = (List<ReviewDAO>) request.getAttribute("reviews");
                CategoryDAO category = (CategoryDAO) request.getAttribute("category");
                BrandDAO brand = (BrandDAO) request.getAttribute("brand");
                List<ProductSpecDAO> productSpecs = (List<ProductSpecDAO>) request.getAttribute("productSpecs");
                Boolean isLogin = (Boolean) request.getAttribute("is_login");
                if (isLogin == null) {
                    isLogin = Boolean.FALSE;
                }
                String contextPath = request.getContextPath();
                Integer totalReviews = (reviews != null) ? reviews.size() : 0;
                
                // Lấy tên người dùng cho các review
                Map<Integer, String> userNameMap = new HashMap<>();
                if (reviews != null && !reviews.isEmpty()) {
                    try {
                        javax.sql.DataSource ds = DataSourceUtil.getDataSource();
                        UserServiceImpl userService = new UserServiceImpl(ds);
                        for (ReviewDAO r : reviews) {
                            if (!userNameMap.containsKey(r.getUserId())) {
                                UserDAO user = userService.findById(r.getUserId());
                                if (user != null) {
                                    String displayName = (user.getFullname() != null && !user.getFullname().isBlank()) 
                                            ? user.getFullname() 
                                            : (user.getUsername() != null ? user.getUsername() : "Người dùng #" + r.getUserId());
                                    userNameMap.put(r.getUserId(), displayName);
                                } else {
                                    userNameMap.put(r.getUserId(), "Người dùng #" + r.getUserId());
                                }
                            }
                        }
                    } catch (Exception e) {
                        // Nếu có lỗi, sử dụng tên mặc định
                        for (ReviewDAO r : reviews) {
                            if (!userNameMap.containsKey(r.getUserId())) {
                                userNameMap.put(r.getUserId(), "Người dùng #" + r.getUserId());
                            }
                        }
                    }
                }
            %>
            <div class="product-details-content mb_70">
                <div class="row clearfix">
                    <div class="col-lg-6 col-md-12 col-sm-12 image-column">
                        <div class="bxslider">
                            <div class="slider-content">
                                <div class="image-inner">
                                    <div class="image-box">
                                        <%
                                            String imageUrl = (product != null && product.getImage() != null && !product.getImage().isBlank())
                                                    ? product.getImage()
                                                    : contextPath + "/assets/client/images/shop/shop-details-1.png";
                                            if (!imageUrl.startsWith("http") && !imageUrl.startsWith("/")) {
                                                imageUrl = contextPath + "/" + imageUrl;
                                            } else if (!imageUrl.startsWith("http") && imageUrl.startsWith("/") && !imageUrl.startsWith(contextPath)) {
                                                imageUrl = contextPath + imageUrl;
                                            }
                                        %>
                                        <figure class="image"><a href="<%= imageUrl %>" class="lightbox-image" data-fancybox="gallery"><img src="<%= imageUrl %>" alt="<%= product != null ? product.getName() : "" %>"></a></figure>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-12 col-sm-12 content-column">
                        <div class="content-box ml_30">
                            <span class="upper-text">
                                
                            </span>
                            <h2><%= product != null ? product.getName() : "Sản phẩm" %></h2>
                            <h3>
                                <%
                                    if (product != null && product.getPrice() != null) {
                                        double price = product.getPrice();
                                        // Format với dấu chấm phân cách hàng nghìn và đuôi VNĐ
                                        java.text.DecimalFormat df = new java.text.DecimalFormat("#,###");
                                        out.print(df.format(price) + " VNĐ");
                                    } else {
                                        out.print("0 VNĐ");
                                    }
                                %>
                            </h3>

                            <ul class="discription-box mb_30 clearfix">
                                <%
                                    int stockQty = (product != null) ? product.getStock_quantity() : 0;
                                    boolean inStock = stockQty > 0;
                                    Boolean isActive = (product != null) ? product.getIs_active() : null;
                                %>
                                <% if (brand != null && brand.getName() != null) { %>
                                <li><strong>Thương hiệu :</strong><%= brand.getName() %></li>
                                <% } %>
                                <% if (category != null && category.getName() != null) { %>
                                <li><strong>Danh mục :</strong><%= category.getName() %></li>
                                <% } %>
                                <li>
                                    <strong>Tình trạng :</strong>
                                    <% if (inStock) { %>
                                    <span class="product-stock">
                                        <img src="${pageContext.request.contextPath}/assets/client/images/icons/icon-1.png" alt="">
                                        Còn hàng (<%= stockQty %>)
                                    </span>
                                    <% } else { %>
                                    <span class="product-stock-out">
                                        <img src="${pageContext.request.contextPath}/assets/client/images/icons/icon-2.png" alt="">
                                        Hết hàng
                                    </span>
                                    <% } %>
                                </li>
                                <% if (isActive != null && isActive) { %>
                                <li><strong>Trạng thái :</strong><span style="color: green;">Hoạt động</span></li>
                                <% } %>
                            </ul>

                            <div class="addto-cart-box mb_40">
                                <ul class="clearfix">
                                    <li class="item-quantity">
                                        <input id="product-quantity" class="quantity-spinner" type="number" 
                                               min="1" max="<%= stockQty %>" value="1" 
                                               data-max-stock="<%= stockQty %>"
                                               <%= inStock ? "" : "disabled" %>>
                                    </li>
                                    <% if (inStock) { %>
                                    <li class="cart-btn">
                                        <button type="button" id="add-to-cart-btn" class="theme-btn btn-one" 
                                                data-product-id="<%= product != null ? product.getId() : 0 %>"
                                                data-product-name="<%= product != null && product.getName() != null ? product.getName().replace("\"", "&quot;") : "" %>"
                                                data-product-price="<%= product != null && product.getPrice() != null ? product.getPrice() : 0 %>"
                                                data-product-image="<%= product != null && product.getImage() != null ? product.getImage() : "" %>"
                                                data-product-slug="<%= product != null && product.getSlug() != null ? product.getSlug() : "" %>">
                                            Thêm vào giỏ hàng<span></span><span></span><span></span><span></span>
                                        </button>
                                    </li>
                                    <% } else { %>
                                    <li class="cart-btn">
                                        <button type="button" class="theme-btn btn-one not" disabled>
                                            Hết hàng<span></span><span></span><span></span><span></span>
                                        </button>
                                    </li>
                                    <% } %>

                                </ul>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <div class="product-discription">
                <div class="tabs-box">
                    <div class="tab-btn-box">
                        <ul class="tab-btns tab-buttons clearfix">
                            <li class="tab-btn active-btn" data-tab="#tab-1">Mô tả</li>
                            <li class="tab-btn" data-tab="#tab-2">Nhận xét</li>
                            <li class="tab-btn" data-tab="#tab-3">Thông số kỹ thuật</li>
                        </ul>
                    </div>
                    <div class="tabs-content">
                        <div class="tab active-tab" id="tab-1">
                            <div class="discription-content pt_35">
                                <h3><%= product != null ? product.getName() : "Sản phẩm" %></h3>
                                <p><%= (product != null && product.getDescription() != null && !product.getDescription().isBlank())
                                        ? product.getDescription()
                                        : "Mô tả sản phẩm đang được cập nhật." %></p>
                            </div>
                        </div>
                        <div class="tab" id="tab-2">
                            <div class="review-content pt_40">
                                <h3>Nhận xét của khách hàng (<%= totalReviews %>)</h3>
                                <hr/>
                                <%
                                    if (reviews != null && !reviews.isEmpty()) {
                                        for (ReviewDAO r : reviews) {
                                %>
                                <div class="single-review" style="margin-bottom: 30px; padding: 20px; border-bottom: 1px solid #e0e0e0; background-color: #f9f9f9; border-radius: 8px;">
                                    <div class="upper-box" style="display: flex; align-items: center; margin-bottom: 15px;">
                                        <div class="info-box" style="display: flex; align-items: center; gap: 15px;">
                                            <figure class="image" style="margin: 0;">
                                                <img src="<%= contextPath %>/assets/client/images/resource/review-1.png" alt="" style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover;">
                                            </figure>
                                            <div class="inner">
                                                <h4 style="margin: 0; font-size: 16px; font-weight: 600; color: #333;"><%= userNameMap.getOrDefault(r.getUserId(), "Người dùng #" + r.getUserId()) %></h4>
                                            </div>
                                        </div>
                                    </div>
                                    <ul class="rating" style="margin: 10px 0; padding: 0; list-style: none; display: flex; gap: 5px;">
                                        <%
                                            int stars = r.getRating();
                                            for (int i = 0; i < 5; i++) {
                                                boolean filled = i < stars;
                                                String starColor = filled ? "#ffc107" : "#ddd";
                                        %>
                                        <li style="display: inline-block;">
                                            <i class="icon-11" style="color: <%= starColor %>; font-size: 18px;"></i>
                                        </li>
                                        <%
                                            }
                                        %>
                                    </ul>
                                    <p style="margin-top: 15px; line-height: 1.8; color: #555; font-size: 14px;"><%= (r.getComment() != null && !r.getComment().isBlank())
                                            ? r.getComment()
                                            : "Người dùng không để lại nội dung nhận xét." %></p>
                                </div>
                                <%
                                        }
                                    } else {
                                %>
                                <p>Chưa có đánh giá nào cho sản phẩm này. Hãy là người đầu tiên đánh giá!</p>
                                <%
                                    }
                                %>

                                <div class="customer-review mt_40" style="background-color: #f9f9f9; padding: 30px; border-radius: 8px; border: 1px solid #e0e0e0;">
                                    <h3 style="margin-bottom: 20px; color: #333; font-size: 22px;">Viết đánh giá của bạn</h3>
                                    <%
                                        if (!isLogin) {
                                    %>
                                    <p style="color: #666; font-size: 14px;">Bạn cần <a href="<%= contextPath %>/login" style="color: #007bff; text-decoration: none;">đăng nhập</a> để gửi đánh giá.</p>
                                    <%
                                        } else {
                                    %>
                                    <div class="rating-box mb_25">
                                        <p style="margin-bottom: 15px; font-weight: 600; color: #333; font-size: 15px;">Đánh giá của bạn <span style="color: red;">*</span></p>
                                        <div class="rating-inner">
                                            <form method="post" action="<%= contextPath %>/review" id="review-form">
                                                <input type="hidden" name="productId" value="<%= product != null ? product.getId() : 0 %>"/>
                                                <input type="hidden" name="slug" value="<%= product != null ? product.getSlug() : "" %>"/>
                                                <input type="hidden" name="rating" id="rating-input" value="5" required>
                                                
                                                <!-- Star Rating -->
                                                <div class="star-rating-container" style="margin-bottom: 25px;">
                                                    <div class="star-rating" id="star-rating" style="display: flex; gap: 8px; align-items: center;">
                                                        <span style="font-size: 14px; color: #666; margin-right: 10px;">Chọn số sao:</span>
                                                        <div class="stars" style="display: flex; gap: 5px; direction: ltr;">
                                                            <i class="icon-11 star-icon" data-rating="1" style="font-size: 28px; color: #ffc107; cursor: pointer; transition: all 0.2s;"></i>
                                                            <i class="icon-11 star-icon" data-rating="2" style="font-size: 28px; color: #ffc107; cursor: pointer; transition: all 0.2s;"></i>
                                                            <i class="icon-11 star-icon" data-rating="3" style="font-size: 28px; color: #ffc107; cursor: pointer; transition: all 0.2s;"></i>
                                                            <i class="icon-11 star-icon" data-rating="4" style="font-size: 28px; color: #ffc107; cursor: pointer; transition: all 0.2s;"></i>
                                                            <i class="icon-11 star-icon" data-rating="5" style="font-size: 28px; color: #ffc107; cursor: pointer; transition: all 0.2s;"></i>
                                                        </div>
                                                        <span id="rating-text" style="margin-left: 15px; font-size: 14px; color: #666; font-weight: 500;">Tuyệt vời</span>
                                                    </div>
                                                </div>
                                                
                                                <div class="form-inner mt_20">
                                                    <div class="form-group" style="margin-bottom: 20px;">
                                                        <label style="display: block; margin-bottom: 10px; font-weight: 600; color: #333; font-size: 15px;">Nội dung đánh giá <span style="color: red;">*</span></label>
                                                        <textarea name="comment" id="review-comment" required 
                                                                  style="width: 100%; height: 150px; padding: 12px; border: 1px solid #ddd; border-radius: 6px; font-size: 14px; font-family: inherit; resize: none; transition: border-color 0.3s;"
                                                                  placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm này..."></textarea>
                                                    </div>
                                                    <div class="message-btn">
                                                        <button type="submit" class="theme-btn btn-one" style="padding: 12px 30px; font-size: 15px; font-weight: 600;">
                                                            Gửi đánh giá<span></span><span></span><span></span><span></span>
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                        <div class="tab" id="tab-3">
                            <div class="specification-content pt_40">
                                <%
                                    if (productSpecs != null && !productSpecs.isEmpty()) {
                                %>
                                <ul class="specification-list clean">
                                    <%
                                        for (ProductSpecDAO spec : productSpecs) {
                                    %>
                                    <li><strong><%= spec.getName() != null ? spec.getName() : "N/A" %></strong><%= spec.getvalueSpec() != null ? spec.getvalueSpec() : "N/A" %></li>
                                    <%
                                        }
                                    %>
                                </ul>
                                <%
                                    } else {
                                %>
                                <p>Chưa có thông số kỹ thuật cho sản phẩm này.</p>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- shop-details end -->

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
<script src="${pageContext.request.contextPath}/assets/client/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/owl.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/wow.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/validation.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/jquery.fancybox.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/appear.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/isotope.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/parallax-scroll.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/jquery.nice-select.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/scrolltop.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/language.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/countdown.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/jquery-ui.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/product-filter.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/jquery.bootstrap-touchspin.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/bxslider.js"></script>

<!-- main-js -->
<script src="${pageContext.request.contextPath}/assets/client/js/script.js"></script>
<!-- Cart Management Script -->
<script src="${pageContext.request.contextPath}/assets/client/js/cart.js"></script>
<script>
    // Set context path for JavaScript
    window.APP_CONTEXT_PATH = '<%= contextPath %>';
    
    // Star Rating Handler
    document.addEventListener('DOMContentLoaded', function() {
        var starIcons = document.querySelectorAll('.star-icon');
        var ratingInput = document.getElementById('rating-input');
        var ratingText = document.getElementById('rating-text');
        var currentRating = 5; // Default rating
        
        var ratingLabels = {
            1: 'Rất tệ',
            2: 'Tệ',
            3: 'Bình thường',
            4: 'Tốt',
            5: 'Tuyệt vời'
        };
        
        // Initialize stars
        function updateStars(rating) {
            starIcons.forEach(function(star, index) {
                if (index < rating) {
                    star.style.color = '#ffc107';
                    star.style.opacity = '1';
                } else {
                    star.style.color = '#ddd';
                    star.style.opacity = '0.5';
                }
            });
            
            if (ratingInput) {
                ratingInput.value = rating;
            }
            if (ratingText) {
                ratingText.textContent = ratingLabels[rating] || '';
            }
            currentRating = rating;
        }
        
        // Click event for stars
        starIcons.forEach(function(star) {
            star.addEventListener('click', function() {
                var rating = parseInt(this.getAttribute('data-rating'));
                updateStars(rating);
            });
            
            star.addEventListener('mouseenter', function() {
                var rating = parseInt(this.getAttribute('data-rating'));
                starIcons.forEach(function(s, index) {
                    if (index < rating) {
                        s.style.color = '#ffc107';
                        s.style.opacity = '1';
                    } else {
                        s.style.color = '#ddd';
                        s.style.opacity = '0.5';
                    }
                });
                if (ratingText) {
                    ratingText.textContent = ratingLabels[rating] || '';
                }
            });
        });
        
        // Reset to current rating when mouse leaves
        var starContainer = document.querySelector('.stars');
        if (starContainer) {
            starContainer.addEventListener('mouseleave', function() {
                updateStars(currentRating);
            });
        }
        
        // Initialize with default rating
        updateStars(5);
    });
    
    // Cập nhật quantity và xử lý thêm vào giỏ hàng
    document.addEventListener('DOMContentLoaded', function() {
        var quantityInput = document.getElementById('product-quantity');
        var addToCartBtn = document.getElementById('add-to-cart-btn');
        
        if (quantityInput) {
            var maxStockQty = parseInt(quantityInput.getAttribute('data-max-stock')) || parseInt(quantityInput.getAttribute('max')) || 1;
            
            // Validate quantity khi người dùng thay đổi
            quantityInput.addEventListener('change', function() {
                var qty = parseInt(this.value) || 1;
                var maxQty = parseInt(this.getAttribute('max')) || maxStockQty;
                
                // Đảm bảo quantity không vượt quá stock
                if (qty > maxQty) {
                    qty = maxQty;
                    this.value = qty;
                }
                if (qty < 1) {
                    qty = 1;
                    this.value = qty;
                }
            });
        }
        
        // Xử lý click button "Thêm vào giỏ hàng"
        if (addToCartBtn) {
            addToCartBtn.addEventListener('click', function() {
                // Kiểm tra CartManager đã load chưa
                if (typeof CartManager === 'undefined') {
                    alert('Hệ thống đang tải, vui lòng thử lại sau.');
                    return;
                }
                
                // Lấy thông tin sản phẩm từ data attributes
                var productId = parseInt(this.getAttribute('data-product-id')) || 0;
                var productName = this.getAttribute('data-product-name') || '';
                var productPrice = parseFloat(this.getAttribute('data-product-price')) || 0;
                var productImage = this.getAttribute('data-product-image') || '';
                var productSlug = this.getAttribute('data-product-slug') || '';
                
                // Lấy số lượng
                var quantity = 1;
                if (quantityInput) {
                    quantity = parseInt(quantityInput.value) || 1;
                    var maxQty = parseInt(quantityInput.getAttribute('max')) || 999;
                    
                    // Validate quantity
                    if (quantity > maxQty) {
                        alert('Số lượng không được vượt quá số lượng tồn kho (' + maxQty + ')');
                        quantityInput.value = maxQty;
                        quantity = maxQty;
                        return;
                    }
                    
                    if (quantity < 1) {
                        alert('Số lượng phải lớn hơn 0');
                        quantityInput.value = 1;
                        quantity = 1;
                        return;
                    }
                }
                
                // Tạo object product
                var product = {
                    id: productId,
                    name: productName,
                    price: productPrice,
                    image_url: productImage,
                    slug: productSlug
                };
                
                // Thêm vào giỏ hàng
                var success = CartManager.addToCart(product, quantity);
                
                if (success) {
                    // Hiển thị thông báo thành công
                    var btnText = this.innerHTML;
                    this.innerHTML = 'Đã thêm!<span></span><span></span><span></span><span></span>';
                    this.style.backgroundColor = '#28a745';
                    
                    // Khôi phục button sau 2 giây
                    var self = this;
                    setTimeout(function() {
                        self.innerHTML = btnText;
                        self.style.backgroundColor = '';
                    }, 2000);
                } else {
                    alert('Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng. Vui lòng thử lại.');
                }
            });
        }
    });
</script>

</body><!-- End of .page_wrapper -->
</html>

