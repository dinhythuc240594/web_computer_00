<%--
  Created by IntelliJ IDEA.
  User: Windows
  Date: 25/11/2025
  Time: 1:45 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.ProductDAO" %>
<%
    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
    if (cartItems == null) {
        cartItems = java.util.Collections.emptyList();
    }

    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    double subtotal = 0.0;
    for (CartItem item : cartItems) {
        ProductDAO p = item.getProduct();
        if (p != null && p.getPrice() != null) {
            subtotal += p.getPrice() * item.getQuantity();
        }
    }

    double freeShipThreshold = 500000; // 500.000đ để được miễn phí vận chuyển
    double shippingFee = subtotal >= freeShipThreshold || subtotal == 0 ? 0 : 30000;
    double total = subtotal + shippingFee;

    double remainingForFreeShip = freeShipThreshold - subtotal;
    if (remainingForFreeShip < 0) {
        remainingForFreeShip = 0;
    }

    int progressPercent = subtotal <= 0 ? 0 : (int) Math.min(100, Math.round(subtotal / freeShipThreshold * 100));
%>
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
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/cart.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/shop-two.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/highlights.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/footer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/responsive.css" rel="stylesheet">

</head>


<!-- page wrapper -->
<body>

<div class="boxed_wrapper ltr">


    <jsp:include page="../common/preloader.jsp" />


    <!-- page-direction -->
    <div class="page_direction">
        <div class="demo-rtl direction_switch"><button class="rtl">RTL</button></div>
        <div class="demo-ltr direction_switch"><button class="ltr">LTR</button></div>
    </div>
    <!-- page-direction end -->


    <!-- main header -->
    <jsp:include page="../common/header.jsp" />
    <!-- main-header end -->


    <jsp:include page="../common/mobile-menu.jsp" />


    <jsp:include page="../common/category-menu.jsp" />


    <!-- page-title -->
    <section class="page-title pt_20 pb_18">
        <div class="large-container">
            <ul class="bread-crumb clearfix">
                <li><a href="<%= request.getContextPath() %>/home">Trang chủ</a></li>
                <li>Giỏ hàng</li>
            </ul>
        </div>
    </section>
    <!-- page-title end -->


    <!-- cart section -->
    <section class="cart-section pb_80">
        <div class="large-container">
            <div class="sec-title centred pb_30">
                <h2>Giỏ hàng của bạn</h2>
            </div>
            <div class="row clearfix">
                <div class="col-lg-9 col-md-12 col-sm-12 content-side">
                    <div class="target-price mb_30">
                        <%
                            if (subtotal > 0 && remainingForFreeShip > 0) {
                        %>
                        <p>Thêm <span><%= currencyFormat.format(remainingForFreeShip) %></span> để được miễn phí vận chuyển</p>
                        <%
                            } else if (subtotal >= freeShipThreshold) {
                        %>
                        <p>Bạn đã đủ điều kiện <span>miễn phí vận chuyển</span>.</p>
                        <%
                            } else {
                        %>
                        <p>Giỏ hàng đang trống. Thêm sản phẩm để bắt đầu.</p>
                        <%
                            }
                        %>
                        <div class="progress-box">
                            <div class="bar">
                                <div class="bar-inner count-bar" data-percent="<%= progressPercent %>%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="table-outer mb_30">
                        <table class="cart-table">
                            <thead class="cart-header">
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                                <th>&nbsp;</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                if (!cartItems.isEmpty()) {
                                    for (CartItem item : cartItems) {
                                        ProductDAO product = item.getProduct();
                                        if (product == null) {
                                            continue;
                                        }
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
                                        double lineTotal = price * quantity;
                            %>
                            <tr>
                                <td class="product-column">
                                    <div class="product-box">
                                        <figure class="image-box">
                                            <img src="<%= productImage %>" alt="<%= product.getName() %>">
                                        </figure>
                                        <h6><a href="<%= productLink %>"><%= product.getName() %></a></h6>
                                    </div>
                                </td>
                                <td><%= currencyFormat.format(price) %></td>
                                <td class="qty">
                                    <div class="item-quantity">
                                        <input class="quantity-spinner" type="text" value="<%= quantity %>" name="quantity">
                                    </div>
                                </td>
                                <td><%= currencyFormat.format(lineTotal) %></td>
                                <td>
                                    <form action="<%= request.getContextPath() %>/cart" method="post">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                                        <button type="submit" class="cancel-btn"><i class="icon-9"></i></button>
                                    </form>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="5" class="text-center">
                                    Hiện chưa có sản phẩm nào trong giỏ hàng.
                                </td>
                            </tr>
                            <%
                                }
                            %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12 sidebar-side">
                    <div class="total-cart mb_30">
                        <div class="title-box">
                            <h4>Tạm tính</h4>
                            <h5><%= currencyFormat.format(subtotal) %></h5>
                        </div>
                        <div class="shipping-cost mb_40">
                            <h4>Vận chuyển</h4>
                            <ul class="cost-list">
                                <li>
                                    <div class="check-box">
                                        <input class="check" type="radio" id="checkbox1" name="same" checked>
                                        <label for="checkbox1">Miễn phí vận chuyển</label>
                                    </div>
                                    <span class="price">+$00.00</span>
                                </li>
                                <li>
                                    <div class="check-box">
                                        <input class="check" type="radio" id="checkbox2" name="same">
                                        <label for="checkbox2">Phí cố định</label>
                                    </div>
                                    <span class="price">+$10.00</span>
                                </li>
                                <li>
                                    <div class="check-box">
                                        <input class="check" type="radio" id="checkbox3" name="same">
                                        <label for="checkbox3">Giao hàng nội thành</label>
                                    </div>
                                    <span class="price">+$20.00</span>
                                </li>
                            </ul>
                        </div>
                        <div class="shipping-calculator">
                            <h4>Tính phí vận chuyển</h4>
                            <div class="form-group">
                                <div class="select-box">
                                    <select class="wide">
                                        <option data-display="Select Country">Select Country</option>
                                        <option value="1">Australia</option>
                                        <option value="2">Belgium</option>
                                        <option value="3">Canada</option>
                                        <option value="4">China</option>
                                        <option value="5">France</option>
                                        <option value="6">Germany</option>
                                        <option value="7">Malaysia</option>
                                        <option value="8">Mexico</option>
                                        <option value="9">Russia</option>
                                        <option value="10">Switzerland</option>
                                        <option value="11">Turkey</option>
                                        <option value="12">United Kingdom</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <input type="text" name="zip" placeholder="Postcode / ZIP">
                            </div>
                            <div class="form-group">
                                <button class="theme-btn cart-btn" type="button">Cập nhật giỏ hàng <span></span><span></span><span></span><span></span></button>
                            </div>
                        </div>
                        <div class="total-box">
                            <h4>Tổng cộng</h4>
                            <h5><%= currencyFormat.format(total) %></h5>
                        </div>
                        <div class="btn-box">
                            <button class="theme-btn" type="button">Thanh toán<span></span><span></span><span></span><span></span></button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="coupon-box">
                <div class="form-group">
                    <input type="text" name="coupon" placeholder="Apply Coupon">
                    <button type="button"><i class="icon-22"></i></button>
                </div>
            </div>
        </div>
    </section>
    <!-- cart section end -->


    <!-- shop-two -->
    <section class="shop-two pb_50">
        <div class="large-container">
            <div class="sec-title">
                <h2 class="title-animation">You may also like these</h2>
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
    </section>
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

