<%--
  Created by IntelliJ IDEA.
  User: Windows
  Date: 25/11/2025
  Time: 1:45 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ReviewDAO" %>
<%@ page import="model.CategoryDAO" %>
<%@ page import="model.BrandDAO" %>
<%@ page import="model.ProductSpecDAO" %>
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
            %>
            <div class="product-details-content mb_70">
                <div class="row clearfix">
                    <div class="col-lg-6 col-md-12 col-sm-12 image-column">
                        <div class="bxslider">
                            <div class="slider-content">
                                <div class="image-inner">
                                    <div class="image-box">
                                        <%
                                            String imageUrl = (product != null && product.getImage_url() != null && !product.getImage_url().isBlank())
                                                    ? product.getImage_url()
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
                                <%= (category != null && category.getName() != null) ? category.getName() : "Product" %>
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
                            <!-- <ul class="rating mb_25">
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><span>(05)</span></li>
                            </ul> -->
                            <div class="text-box mb_30">
                                <p>
                                    <%= (product != null && product.getDescription() != null && !product.getDescription().isBlank())
                                            ? product.getDescription()
                                            : "Mô tả sản phẩm đang được cập nhật." %>
                                </p>
                            </div>
                            <ul class="discription-box mb_30 clearfix">
                                <%
                                    int stockQty = (product != null) ? product.getStock_quantity() : 0;
                                    boolean inStock = stockQty > 0;
                                    Boolean isActive = (product != null) ? product.getIs_active() : null;
                                %>
                                <% if (brand != null && brand.getName() != null) { %>
                                <li><strong>Brand :</strong><%= brand.getName() %></li>
                                <% } %>
                                <% if (category != null && category.getName() != null) { %>
                                <li><strong>Category :</strong><%= category.getName() %></li>
                                <% } %>
                                <li>
                                    <strong>Availability :</strong>
                                    <% if (inStock) { %>
                                    <span class="product-stock">
                                        <img src="${pageContext.request.contextPath}/assets/client/images/icons/icon-1.png" alt="">
                                        In Stock (<%= stockQty %>)
                                    </span>
                                    <% } else { %>
                                    <span class="product-stock-out">
                                        <img src="${pageContext.request.contextPath}/assets/client/images/icons/icon-2.png" alt="">
                                        Out of Stock
                                    </span>
                                    <% } %>
                                </li>
                                <% if (isActive != null && isActive) { %>
                                <li><strong>Status :</strong><span style="color: green;">Active</span></li>
                                <% } %>
                            </ul>
                            <!-- <div class="color-box mb_30">
                                <h6>Color<span>*</span></h6>
                                <ul class="color-list">
                                    <li>
                                        <div class="check-box">
                                            <input class="check" type="radio" id="color1" name="same" checked>
                                            <label for="color1"></label>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="check-box">
                                            <input class="check" type="radio" id="color2" name="same">
                                            <label for="color2"></label>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="check-box">
                                            <input class="check" type="radio" id="color3" name="same">
                                            <label for="color3"></label>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="check-box">
                                            <input class="check" type="radio" id="color4" name="same">
                                            <label for="color4"></label>
                                        </div>
                                    </li>
                                </ul>
                            </div> -->
                            <!-- <div class="size-box mb_40">
                                <h6>Size<span>*</span></h6>
                                <ul class="size-list">
                                    <li>
                                        <div class="check-box">
                                            <input class="check" type="radio" id="size1" name="same2" checked>
                                            <label for="size1">10.5 KG</label>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="check-box">
                                            <input class="check" type="radio" id="size2" name="same2">
                                            <label for="size2">11 KG</label>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="check-box">
                                            <input class="check" type="radio" id="size3" name="same2">
                                            <label for="size3">08 KG</label>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="check-box">
                                            <input class="check" type="radio" id="size4" name="same2">
                                            <label for="size4">09 KG</label>
                                        </div>
                                    </li>
                                </ul>
                            </div> -->
                            <div class="addto-cart-box mb_40">
                                <ul class="clearfix">
                                    <li class="item-quantity">
                                        <input class="quantity-spinner" type="text" value="1" name="quantity"
                                               <%= inStock ? "" : "disabled" %>>
                                    </li>
                                    <% if (inStock) { %>
                                    <li class="cart-btn">
                                        <form method="post" action="<%= contextPath %>/cart">
                                            <input type="hidden" name="action" value="add"/>
                                            <input type="hidden" name="productId" value="<%= product != null ? product.getId() : 0 %>"/>
                                            <button type="submit" class="theme-btn btn-one">
                                                Add To Cart<span></span><span></span><span></span><span></span>
                                            </button>
                                        </form>
                                    </li>
                                    <% } else { %>
                                    <li class="cart-btn">
                                        <button type="button" class="theme-btn btn-one not" disabled>
                                            Out of Stock<span></span><span></span><span></span><span></span>
                                        </button>
                                    </li>
                                    <% } %>
                                    <!-- <li><a href="javascript:void(0)"><i class="icon-5"></i></a></li>
                                    <li class="like-btn"><button type="button"><i class="icon-6"></i></button></li> -->
                                </ul>
                            </div>
                            <!-- <ul class="other-option clearfix">
                                <li><strong>Seller :</strong>Daniel Macron</li>
                                <li><strong>Tag :</strong><span>Best sellers</span>, New Arrivals, On Sale</li>
                                <li class="social-links"><strong>Share :</strong><a href="shop-details.html"><i class="icon-13"></i></a><a href="shop-details.html"><i class="icon-14"></i></a><a href="shop-details.html"><i class="icon-15"></i></a></li>
                            </ul> -->
                        </div>
                    </div>
                </div>
            </div>
            <div class="product-discription">
                <div class="tabs-box">
                    <div class="tab-btn-box">
                        <ul class="tab-btns tab-buttons clearfix">
                            <li class="tab-btn active-btn" data-tab="#tab-1">Description</li>
                            <li class="tab-btn" data-tab="#tab-2">Reviews</li>
                            <li class="tab-btn" data-tab="#tab-3">Specification</li>
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
                                <h3>Customer Reviews (<%= totalReviews %>)</h3>
                                <hr/>
                                <%
                                    if (reviews != null && !reviews.isEmpty()) {
                                        for (ReviewDAO r : reviews) {
                                %>
                                <div class="single-review" style="margin-bottom: 30px; padding-bottom: 20px; border-bottom: 1px solid #e0e0e0;">
                                    <div class="upper-box">
                                        <div class="info-box">
                                            <figure class="image">
                                                <img src="<%= contextPath %>/assets/client/images/resource/review-1.png" alt="">
                                            </figure>
                                            <div class="inner">
                                                <h4>Người dùng #<%= r.getUserId() %></h4>
                                            </div>
                                        </div>
                                    </div>
                                    <ul class="rating" style="margin: 10px 0;">
                                        <%
                                            int stars = r.getRating();
                                            for (int i = 0; i < 5; i++) {
                                                boolean filled = i < stars;
                                        %>
                                        <li>
                                            <i class="icon-11"<%= filled ? "" : " style=\"opacity:0.3;\"" %>></i>
                                        </li>
                                        <%
                                            }
                                        %>
                                    </ul>
                                    <p style="margin-top: 10px; line-height: 1.6;"><%= (r.getComment() != null && !r.getComment().isBlank())
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

                                <div class="customer-review mt_40">
                                    <h3>Viết đánh giá của bạn</h3>
                                    <%
                                        if (!isLogin) {
                                    %>
                                    <p>Bạn cần <a href="<%= contextPath %>/login">đăng nhập</a> để gửi đánh giá.</p>
                                    <%
                                        } else {
                                    %>
                                    <div class="rating-box mb_25">
                                        <p>Your Rating <span>*</span></p>
                                        <div class="rating-inner">
                                            <form method="post" action="<%= contextPath %>/review">
                                                <input type="hidden" name="productId" value="<%= product != null ? product.getId() : 0 %>"/>
                                                <input type="hidden" name="slug" value="<%= product != null ? product.getSlug() : "" %>"/>
                                                <select name="rating" class="form-select" style="max-width: 200px;">
                                                    <option value="5" selected>5 - Excellent</option>
                                                    <option value="4">4 - Good</option>
                                                    <option value="3">3 - Average</option>
                                                    <option value="2">2 - Poor</option>
                                                    <option value="1">1 - Very bad</option>
                                                </select>
                                                <div class="form-inner mt_20">
                                                    <div class="form-group">
                                                        <label>Write Your Review <span>*</span></label>
                                                        <textarea name="comment" required></textarea>
                                                    </div>
                                                    <div class="message-btn">
                                                        <button type="submit" class="theme-btn btn-one">
                                                            Submit Review<span></span><span></span><span></span><span></span>
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


    <!-- shop-one -->
    <!-- <section class="shop-one pb_30">
        <div class="large-container">
            <div class="row clearfix">
                <div class="col-lg-4 col-md-6 col-sm-12 feature-block">
                    <div class="shop-block-one">
                        <div class="inner-box">
                            <span class="text">Featured</span>
                            <h2>Smart TV’s</h2>
                            <h4><span>From</span> $99.99</h4>
                            <div class="link-box"><a href="shop-details.html">Shop now</a></div>
                            <figure class="image r_0 b_10"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-7.png" alt=""></figure>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-12 feature-block">
                    <div class="shop-block-one">
                        <div class="inner-box">
                            <span class="text">Hot Sale</span>
                            <h2>Kitchen Kits</h2>
                            <h4><span>From</span> $50 Only</h4>
                            <div class="link-box"><a href="shop-details.html">Shop now</a></div>
                            <figure class="image r_0 b_10"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-8.png" alt=""></figure>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-12 feature-block">
                    <div class="shop-block-one">
                        <div class="inner-box">
                            <span class="text">Latest Deals</span>
                            <h2>Smart Device</h2>
                            <h4><span>From</span> $499.99</h4>
                            <div class="link-box"><a href="shop-details.html">Shop now</a></div>
                            <figure class="image r_0 b_10"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-9.png" alt=""></figure>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section> -->
    <!-- shop-one end -->

    <!-- shop-two -->
    <!-- <section class="shop-two pb_50">
        <div class="large-container">
            <div class="sec-title">
                <h2>You may also like these</h2>
            </div>
            <div class="shop-carousel owl-carousel owl-theme owl-dots-none owl-nav-none">
                <div class="shop-block-two">
                    <div class="inner-box">
                        <div class="image-box">
                            <span class="discount-product p_absolute l_0 t_7">-6%</span>
                            <ul class="option-list">
                                <li><a href="${pageContext.request.contextPath}/assets/client/images/shop/shop-10.png" class="lightbox-image" data-fancybox="gallery"><i class="far fa-eye"></i></a></li>
                                <li><a href="shop-details.html"><i class="icon-5"></i></a></li>
                                <li><button type="button"><i class="icon-6"></i></button></li>
                            </ul>
                            <figure class="image"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-10.png" alt=""></figure>
                        </div>
                        <div class="lower-content">
                            <span class="text">Mobile</span>
                            <h4><a href="shop-details.html">Iphone 12 Red Color Veriant</a></h4>
                            <h5>$92.99<del>$83.99</del></h5>
                            <ul class="rating">
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><span>(2)</span></li>
                            </ul>
                            <span class="product-stock"><img src="${pageContext.request.contextPath}/assets/client/images/icons/icon-1.png" alt=""> In Stock</span>
                            <div class="cart-btn"><button type="button" class="theme-btn">Add to Cart<span></span><span></span><span></span><span></span></button></div>
                        </div>
                    </div>
                </div>
                <div class="shop-block-two">
                    <div class="inner-box">
                        <div class="image-box">
                            <span class="hot-product p_absolute l_0 t_7">Hot</span>
                            <ul class="option-list">
                                <li><a href="${pageContext.request.contextPath}/assets/client/images/shop/shop-11.png" class="lightbox-image" data-fancybox="gallery"><i class="far fa-eye"></i></a></li>
                                <li><a href="shop-details.html"><i class="icon-5"></i></a></li>
                                <li><button type="button"><i class="icon-6"></i></button></li>
                            </ul>
                            <figure class="image"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-11.png" alt=""></figure>
                        </div>
                        <div class="lower-content">
                            <span class="text">Gaming</span>
                            <h4><a href="shop-details.html">Video Game Stick Lite 4K Console</a></h4>
                            <h5>$29.99</h5>
                            <ul class="rating">
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><span>(4)</span></li>
                            </ul>
                            <span class="product-stock"><img src="${pageContext.request.contextPath}/assets/client/images/icons/icon-1.png" alt=""> In Stock</span>
                            <div class="cart-btn"><button type="button" class="theme-btn">Add to Cart<span></span><span></span><span></span><span></span></button></div>
                        </div>
                    </div>
                </div>
                <div class="shop-block-two">
                    <div class="inner-box">
                        <div class="image-box">
                            <ul class="option-list">
                                <li><a href="${pageContext.request.contextPath}/assets/client/images/shop/shop-12.png" class="lightbox-image" data-fancybox="gallery"><i class="far fa-eye"></i></a></li>
                                <li><a href="shop-details.html"><i class="icon-5"></i></a></li>
                                <li><button type="button"><i class="icon-6"></i></button></li>
                            </ul>
                            <figure class="image"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-12.png" alt=""></figure>
                        </div>
                        <div class="lower-content">
                            <span class="text">Storage</span>
                            <h4><a href="shop-details.html">32GB Camera CCTV Micro SD Memory Card</a></h4>
                            <h5>$12.99</h5>
                            <ul class="rating">
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><span>(5)</span></li>
                            </ul>
                            <span class="product-stock-out"><img src="${pageContext.request.contextPath}/assets/client/images/icons/icon-2.png" alt=""> Stock Out</span>
                            <div class="cart-btn"><button type="button" class="theme-btn not">Not Available<span></span><span></span><span></span><span></span></button></div>
                        </div>
                    </div>
                </div>
                <div class="shop-block-two">
                    <div class="inner-box">
                        <div class="image-box">
                            <span class="hot-product p_absolute l_0 t_7">Hot</span>
                            <ul class="option-list">
                                <li><a href="${pageContext.request.contextPath}/assets/client/images/shop/shop-13.png" class="lightbox-image" data-fancybox="gallery"><i class="far fa-eye"></i></a></li>
                                <li><a href="shop-details.html"><i class="icon-5"></i></a></li>
                                <li><button type="button"><i class="icon-6"></i></button></li>
                            </ul>
                            <figure class="image"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-13.png" alt=""></figure>
                        </div>
                        <div class="lower-content">
                            <span class="text">Music</span>
                            <h4><a href="shop-details.html">Sony Bluetooth-compatible Speaker Extra</a></h4>
                            <h5>$45.99</h5>
                            <ul class="rating">
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><span>(2)</span></li>
                            </ul>
                            <span class="product-stock"><img src="${pageContext.request.contextPath}/assets/client/images/icons/icon-1.png" alt=""> In Stock</span>
                            <div class="cart-btn"><button type="button" class="theme-btn">Add to Cart<span></span><span></span><span></span><span></span></button></div>
                        </div>
                    </div>
                </div>
                <div class="shop-block-two">
                    <div class="inner-box">
                        <div class="image-box">
                            <ul class="option-list">
                                <li><a href="${pageContext.request.contextPath}/assets/client/images/shop/shop-14.png" class="lightbox-image" data-fancybox="gallery"><i class="far fa-eye"></i></a></li>
                                <li><a href="shop-details.html"><i class="icon-5"></i></a></li>
                                <li><button type="button"><i class="icon-6"></i></button></li>
                            </ul>
                            <figure class="image"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-14.png" alt=""></figure>
                        </div>
                        <div class="lower-content">
                            <span class="text">Music</span>
                            <h4><a href="shop-details.html">JBL Speaker with Bluetooth Built-in Battery</a></h4>
                            <h5>$59.99</h5>
                            <ul class="rating">
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><span>(5)</span></li>
                            </ul>
                            <span class="product-stock"><img src="${pageContext.request.contextPath}/assets/client/images/icons/icon-1.png" alt=""> In Stock</span>
                            <div class="cart-btn"><button type="button" class="theme-btn">Add to Cart<span></span><span></span><span></span><span></span></button></div>
                        </div>
                    </div>
                </div>
                <div class="shop-block-two">
                    <div class="inner-box">
                        <div class="image-box">
                            <ul class="option-list">
                                <li><a href="${pageContext.request.contextPath}/assets/client/images/shop/shop-15.png" class="lightbox-image" data-fancybox="gallery"><i class="far fa-eye"></i></a></li>
                                <li><a href="shop-details.html"><i class="icon-5"></i></a></li>
                                <li><button type="button"><i class="icon-6"></i></button></li>
                            </ul>
                            <figure class="image"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-15.png" alt=""></figure>
                        </div>
                        <div class="lower-content">
                            <span class="text">Power</span>
                            <h4><a href="shop-details.html">Boss Inverter Welding Machine</a></h4>
                            <h5>$359.99</h5>
                            <ul class="rating">
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><span>(4)</span></li>
                            </ul>
                            <span class="product-stock"><img src="${pageContext.request.contextPath}/assets/client/images/icons/icon-1.png" alt=""> In Stock</span>
                            <div class="cart-btn"><button type="button" class="theme-btn">Add to Cart<span></span><span></span><span></span><span></span></button></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section> -->
    <!-- shop-two end -->


    <!-- highlights-section -->
    <section class="highlights-section inner-highlights">
        <div class="large-container">
            <div class="inner-container clearfix">
                <div class="shape" style="background-image: url(${pageContext.request.contextPath}/assets/client/images/shape/shape-5.png);"></div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-23"></i></div>
                        <h5>Same day Product Delivery</h5>
                    </div>
                </div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-17"></i></div>
                        <h5>100% Customer Satisfaction</h5>
                    </div>
                </div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-25"></i></div>
                        <h5>Help and access is our mission</h5>
                    </div>
                </div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-38"></i></div>
                        <h5>100% quality Car Accessories</h5>
                    </div>
                </div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-27"></i></div>
                        <h5>24/7 Support for Clients</h5>
                    </div>
                </div>
            </div>
        </div>
    </section>
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

</body><!-- End of .page_wrapper -->
</html>

