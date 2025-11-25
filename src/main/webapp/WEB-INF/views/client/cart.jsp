<%--
  Created by IntelliJ IDEA.
  User: Windows
  Date: 25/11/2025
  Time: 1:45 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <title>Shared on THEMELOCK.COM - Nexmart - HTML 5 Template Preview</title>

    <!-- Fav Icon -->
    <link rel="icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico" type="image/x-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Rethink+Sans:ital,wght@0,400..800;1,400..800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link href="${pageContext.request.contextPath}/assets/css/font-awesome-all.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/flaticon.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/owl.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/jquery.fancybox.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/animate.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/nice-select.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/elpath.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/jquery-ui.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/color.css" id="jssDefault" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/rtl.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/module-css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/module-css/page-title.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/module-css/cart.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/module-css/shop-two.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/module-css/highlights.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/module-css/footer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/responsive.css" rel="stylesheet">

</head>


<!-- page wrapper -->
<body>

<div class="boxed_wrapper ltr">


    <!-- preloader -->
    <div class="loader-wrap">
        <div class="preloader">
            <div class="preloader-close"><i class="icon-9"></i></div>
            <div id="handle-preloader" class="handle-preloader">
                <div class="animation-preloader">
                    <div class="spinner"></div>
                    <div class="txt-loading">
                            <span data-text-preloader="n" class="letters-loading">
                                n
                            </span>
                        <span data-text-preloader="e" class="letters-loading">
                                e
                            </span>
                        <span data-text-preloader="x" class="letters-loading">
                                x
                            </span>
                        <span data-text-preloader="m" class="letters-loading">
                                m
                            </span>
                        <span data-text-preloader="a" class="letters-loading">
                                a
                            </span>
                        <span data-text-preloader="r" class="letters-loading">
                                r
                            </span>
                        <span data-text-preloader="t" class="letters-loading">
                                t
                            </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- preloader end -->


    <!-- page-direction -->
    <div class="page_direction">
        <div class="demo-rtl direction_switch"><button class="rtl">RTL</button></div>
        <div class="demo-ltr direction_switch"><button class="ltr">LTR</button></div>
    </div>
    <!-- page-direction end -->


    <!-- main header -->
    <jsp:include page="../common/header.jsp" />
    <!-- main-header end -->


    <!-- Mobile Menu  -->
    <div class="mobile-menu">
        <div class="menu-backdrop"></div>
        <div class="close-btn"><i class="fas fa-times"></i></div>
        <nav class="menu-box">
            <div class="nav-logo"><a href="index.html"><img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="" title=""></a></div>
            <div class="menu-outer"><!--Here Menu Will Come Automatically Via Javascript / Same Menu as in Header--></div>
            <div class="contact-info">
                <h4>Contact Info</h4>
                <ul>
                    <li>Chicago 12, Melborne City, USA</li>
                    <li><a href="tel:+8801682648101">+88 01682648101</a></li>
                    <li><a href="mailto:info@example.com">info@example.com</a></li>
                </ul>
            </div>
            <div class="social-links">
                <ul class="clearfix">
                    <li><a href="index.html"><span class="fab fa-twitter"></span></a></li>
                    <li><a href="index.html"><span class="fab fa-facebook-square"></span></a></li>
                    <li><a href="index.html"><span class="fab fa-pinterest-p"></span></a></li>
                    <li><a href="index.html"><span class="fab fa-instagram"></span></a></li>
                    <li><a href="index.html"><span class="fab fa-youtube"></span></a></li>
                </ul>
            </div>
        </nav>
    </div>
    <!-- End Mobile Menu -->


    <!-- Category Menu  -->
    <div class="category-menu">
        <div class="menu-backdrop"></div>
        <div class="outer-box">
            <div class="upper-box">
                <div class="nav-logo"><a href="index.html"><img src="${pageContext.request.contextPath}/assets/images/logo-2.png" alt="" title=""></a></div>
                <div class="close-btn"><i class="icon-9"></i></div>
            </div>
            <p>BROWSE CATEGORIES</p>
            <div class="category-box">
                <ul class="category-list clearfix">
                    <li class="category-dropdown"><a href="#">Phone and Tablets</a>
                        <ul>
                            <li><a href="shop-details.html">Android</a></li>
                            <li><a href="shop-details.html">IOS</a></li>
                            <li><a href="shop-details.html">Microsoft</a></li>
                            <li><a href="shop-details.html">Java</a></li>
                            <li><a href="shop-details.html">Touch Screen</a></li>
                        </ul>
                    </li>
                    <li class="category-dropdown"><a href="#">Laptop & Desktop</a>
                        <ul>
                            <li><a href="shop-details.html">Gaming</a></li>
                            <li><a href="shop-details.html">MacBook</a></li>
                            <li><a href="shop-details.html">Ultrabook</a></li>
                            <li><a href="shop-details.html">iMac</a></li>
                            <li><a href="shop-details.html">Touch Screen</a></li>
                        </ul>
                    </li>
                    <li class="category-dropdown"><a href="#">Sound Equipment</a>
                        <ul>
                            <li><a href="shop-details.html">Airport sounds</a></li>
                            <li><a href="shop-details.html">Amphibians and reptiles</a></li>
                            <li><a href="shop-details.html">Animal sounds</a></li>
                            <li><a href="shop-details.html">Bell sounds</a></li>
                            <li><a href="shop-details.html">Birdsong</a></li>
                        </ul>
                    </li>
                    <li><a href="shop-details.html">Power & Accessories</a></li>
                    <li><a href="shop-details.html">Fitness & Wearable</a></li>
                    <li class="category-dropdown"><a href="#">Peripherals</a>
                        <ul>
                            <li><a href="shop-details.html">Mouse</a></li>
                            <li><a href="shop-details.html">Keyboard</a></li>
                            <li><a href="shop-details.html">Monitor</a></li>
                            <li><a href="shop-details.html">RAM</a></li>
                            <li><a href="shop-details.html">DVD</a></li>
                        </ul>
                    </li>
                    <li class="category-dropdown"><a href="#">Cover & Glass</a>
                        <ul>
                            <li><a href="shop-details.html">Clear Tempered Glass</a></li>
                            <li><a href="shop-details.html">Anti-Glare Tempered Glass</a></li>
                            <li><a href="shop-details.html">Privacy Tempered Glass</a></li>
                            <li><a href="shop-details.html">Full-coverage Tempered Glass</a></li>
                            <li><a href="shop-details.html">Colored Tempered Glass</a></li>
                        </ul>
                    </li>
                    <li class="category-dropdown"><a href="#">Smart Electronics</a>
                        <ul>
                            <li><a href="shop-details.html">smart lights</a></li>
                            <li><a href="shop-details.html">security camera</a></li>
                            <li><a href="shop-details.html">smart plug</a></li>
                            <li><a href="shop-details.html">video doorbell</a></li>
                            <li><a href="shop-details.html">smart display</a></li>
                        </ul>
                    </li>
                    <li><a href="shop-details.html">Home Appliance</a></li>
                    <li><a href="shop-details.html">Drone & Camera</a></li>
                </ul>
                <ul class="category-list clearfix">
                    <li><a href="index.html">New Products <span>New</span></a></li>
                    <li><a href="index.html">Discounted Goods</a></li>
                    <li><a href="index.html">Best Selling Products <span>For You</span></a></li>
                </ul>
            </div>
            <p>BLONWE HELPS</p>
            <ul class="category-list pb_30 clearfix">
                <li><a href="index.html">Wishlist</a></li>
                <li><a href="index.html">Compare</a></li>
                <li><a href="account.html">My account</a></li>
                <li><a href="contact.html">Contact</a></li>
            </ul>
        </div>
    </div>
    <!-- End Category Menu -->


    <!-- page-title -->
    <section class="page-title pt_20 pb_18">
        <div class="large-container">
            <ul class="bread-crumb clearfix">
                <li><a href="index.html">Home</a></li>
                <li>Cart</li>
            </ul>
        </div>
    </section>
    <!-- page-title end -->


    <!-- cart section -->
    <section class="cart-section pb_80">
        <div class="large-container">
            <div class="sec-title centred pb_30">
                <h2>Your Cart</h2>
            </div>
            <div class="row clearfix">
                <div class="col-lg-9 col-md-12 col-sm-12 content-side">
                    <div class="target-price mb_30">
                        <p>Add <span>$89.99</span> to cart and get free shiping</p>
                        <div class="progress-box">
                            <div class="bar"><div class="bar-inner count-bar" data-percent="70%"></div></div>
                        </div>
                    </div>
                    <div class="table-outer mb_30">
                        <table class="cart-table">
                            <thead class="cart-header">
                            <tr>
                                <th>product</th>
                                <th>price</th>
                                <th>quantity</th>
                                <th>total</th>
                                <th>&nbsp;</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td class="product-column">
                                    <div class="product-box">
                                        <figure class="image-box"><img src="${pageContext.request.contextPath}/assets/images/shop/cart-4.png" alt=""></figure>
                                        <h6><a href="shop-details.html">CANON EOS 750D 24.2 MP</a></h6>
                                    </div>
                                </td>
                                <td>$133</td>
                                <td class="qty">
                                    <div class="item-quantity">
                                        <input class="quantity-spinner" type="text" value="2" name="quantity">
                                    </div>
                                </td>
                                <td>$266</td>
                                <td><button class="cancel-btn"><i class="icon-9"></i></button></td>
                            </tr>
                            <tr>
                                <td class="product-column">
                                    <div class="product-box">
                                        <figure class="image-box"><img src="${pageContext.request.contextPath}/assets/images/shop/cart-5.png" alt=""></figure>
                                        <h6><a href="shop-details.html">Box Shinecon 3D Glass with Remote</a></h6>
                                    </div>
                                </td>
                                <td>$167.98</td>
                                <td class="qty">
                                    <div class="item-quantity">
                                        <input class="quantity-spinner" type="text" value="1" name="quantity">
                                    </div>
                                </td>
                                <td>$167.98</td>
                                <td><button class="cancel-btn"><i class="icon-9"></i></button></td>
                            </tr>
                            <tr>
                                <td class="product-column">
                                    <div class="product-box">
                                        <figure class="image-box"><img src="${pageContext.request.contextPath}/assets/images/shop/cart-6.png" alt=""></figure>
                                        <h6><a href="shop-details.html">8 KG Front Loading Washing</a></h6>
                                    </div>
                                </td>
                                <td>$143</td>
                                <td class="qty">
                                    <div class="item-quantity">
                                        <input class="quantity-spinner" type="text" value="1" name="quantity">
                                    </div>
                                </td>
                                <td>$143</td>
                                <td><button class="cancel-btn"><i class="icon-9"></i></button></td>
                            </tr>
                            <tr>
                                <td class="product-column">
                                    <div class="product-box">
                                        <figure class="image-box"><img src="${pageContext.request.contextPath}/assets/images/shop/cart-7.png" alt=""></figure>
                                        <h6><a href="shop-details.html">Sony Bluetooth-compatible Speaker</a></h6>
                                    </div>
                                </td>
                                <td>$150</td>
                                <td class="qty">
                                    <div class="item-quantity">
                                        <input class="quantity-spinner" type="text" value="1" name="quantity">
                                    </div>
                                </td>
                                <td>$150</td>
                                <td><button class="cancel-btn"><i class="icon-9"></i></button></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12 sidebar-side">
                    <div class="total-cart mb_30">
                        <div class="title-box">
                            <h4>Subtotal</h4>
                            <h5>$726.98</h5>
                        </div>
                        <div class="shipping-cost mb_40">
                            <h4>Shipping</h4>
                            <ul class="cost-list">
                                <li>
                                    <div class="check-box">
                                        <input class="check" type="radio" id="checkbox1" name="same" checked>
                                        <label for="checkbox1">Free Shipping</label>
                                    </div>
                                    <span class="price">+$00.00</span>
                                </li>
                                <li>
                                    <div class="check-box">
                                        <input class="check" type="radio" id="checkbox2" name="same">
                                        <label for="checkbox2">Flat Rate</label>
                                    </div>
                                    <span class="price">+$10.00</span>
                                </li>
                                <li>
                                    <div class="check-box">
                                        <input class="check" type="radio" id="checkbox3" name="same">
                                        <label for="checkbox3">Local Delivery</label>
                                    </div>
                                    <span class="price">+$20.00</span>
                                </li>
                            </ul>
                        </div>
                        <div class="shipping-calculator">
                            <h4>Calculate Shipping</h4>
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
                                <button class="theme-btn cart-btn" type="button">Update Cart <span></span><span></span><span></span><span></span></button>
                            </div>
                        </div>
                        <div class="total-box">
                            <h4>Total</h4>
                            <h5>$756.98</h5>
                        </div>
                        <div class="btn-box">
                            <button class="theme-btn" type="button">Proceed to Checkout<span></span><span></span><span></span><span></span></button>
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
                                <li><a href="${pageContext.request.contextPath}/assets/images/shop/shop-10.png" class="lightbox-image" data-fancybox="gallery"><i class="far fa-eye"></i></a></li>
                                <li><a href="shop-details.html"><i class="icon-5"></i></a></li>
                                <li><button type="button"><i class="icon-6"></i></button></li>
                            </ul>
                            <figure class="image"><img src="${pageContext.request.contextPath}/assets/images/shop/shop-10.png" alt=""></figure>
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
                            <span class="product-stock"><img src="${pageContext.request.contextPath}/assets/images/icons/icon-1.png" alt=""> In Stock</span>
                            <div class="cart-btn"><button type="button" class="theme-btn">Add to Cart<span></span><span></span><span></span><span></span></button></div>
                        </div>
                    </div>
                </div>
                <div class="shop-block-two">
                    <div class="inner-box">
                        <div class="image-box">
                            <span class="hot-product p_absolute l_0 t_7">Hot</span>
                            <ul class="option-list">
                                <li><a href="${pageContext.request.contextPath}/assets/images/shop/shop-11.png" class="lightbox-image" data-fancybox="gallery"><i class="far fa-eye"></i></a></li>
                                <li><a href="shop-details.html"><i class="icon-5"></i></a></li>
                                <li><button type="button"><i class="icon-6"></i></button></li>
                            </ul>
                            <figure class="image"><img src="${pageContext.request.contextPath}/assets/images/shop/shop-11.png" alt=""></figure>
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
                            <span class="product-stock"><img src="${pageContext.request.contextPath}/assets/images/icons/icon-1.png" alt=""> In Stock</span>
                            <div class="cart-btn"><button type="button" class="theme-btn">Add to Cart<span></span><span></span><span></span><span></span></button></div>
                        </div>
                    </div>
                </div>
                <div class="shop-block-two">
                    <div class="inner-box">
                        <div class="image-box">
                            <ul class="option-list">
                                <li><a href="${pageContext.request.contextPath}/assets/images/shop/shop-12.png" class="lightbox-image" data-fancybox="gallery"><i class="far fa-eye"></i></a></li>
                                <li><a href="shop-details.html"><i class="icon-5"></i></a></li>
                                <li><button type="button"><i class="icon-6"></i></button></li>
                            </ul>
                            <figure class="image"><img src="${pageContext.request.contextPath}/assets/images/shop/shop-12.png" alt=""></figure>
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
                            <span class="product-stock-out"><img src="${pageContext.request.contextPath}/assets/images/icons/icon-2.png" alt=""> Stock Out</span>
                            <div class="cart-btn"><button type="button" class="theme-btn not">Not Available<span></span><span></span><span></span><span></span></button></div>
                        </div>
                    </div>
                </div>
                <div class="shop-block-two">
                    <div class="inner-box">
                        <div class="image-box">
                            <span class="hot-product p_absolute l_0 t_7">Hot</span>
                            <ul class="option-list">
                                <li><a href="${pageContext.request.contextPath}/assets/images/shop/shop-13.png" class="lightbox-image" data-fancybox="gallery"><i class="far fa-eye"></i></a></li>
                                <li><a href="shop-details.html"><i class="icon-5"></i></a></li>
                                <li><button type="button"><i class="icon-6"></i></button></li>
                            </ul>
                            <figure class="image"><img src="${pageContext.request.contextPath}/assets/images/shop/shop-13.png" alt=""></figure>
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
                            <span class="product-stock"><img src="${pageContext.request.contextPath}/assets/images/icons/icon-1.png" alt=""> In Stock</span>
                            <div class="cart-btn"><button type="button" class="theme-btn">Add to Cart<span></span><span></span><span></span><span></span></button></div>
                        </div>
                    </div>
                </div>
                <div class="shop-block-two">
                    <div class="inner-box">
                        <div class="image-box">
                            <ul class="option-list">
                                <li><a href="${pageContext.request.contextPath}/assets/images/shop/shop-14.png" class="lightbox-image" data-fancybox="gallery"><i class="far fa-eye"></i></a></li>
                                <li><a href="shop-details.html"><i class="icon-5"></i></a></li>
                                <li><button type="button"><i class="icon-6"></i></button></li>
                            </ul>
                            <figure class="image"><img src="${pageContext.request.contextPath}/assets/images/shop/shop-14.png" alt=""></figure>
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
                            <span class="product-stock"><img src="${pageContext.request.contextPath}/assets/images/icons/icon-1.png" alt=""> In Stock</span>
                            <div class="cart-btn"><button type="button" class="theme-btn">Add to Cart<span></span><span></span><span></span><span></span></button></div>
                        </div>
                    </div>
                </div>
                <div class="shop-block-two">
                    <div class="inner-box">
                        <div class="image-box">
                            <ul class="option-list">
                                <li><a href="${pageContext.request.contextPath}/assets/images/shop/shop-15.png" class="lightbox-image" data-fancybox="gallery"><i class="far fa-eye"></i></a></li>
                                <li><a href="shop-details.html"><i class="icon-5"></i></a></li>
                                <li><button type="button"><i class="icon-6"></i></button></li>
                            </ul>
                            <figure class="image"><img src="${pageContext.request.contextPath}/assets/images/shop/shop-15.png" alt=""></figure>
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
                            <span class="product-stock"><img src="${pageContext.request.contextPath}/assets/images/icons/icon-1.png" alt=""> In Stock</span>
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
                <div class="shape" style="background-image: url(${pageContext.request.contextPath}/assets/images/shape/shape-5.png);"></div>
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
<script src="${pageContext.request.contextPath}/assets/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/owl.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/wow.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/validation.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.fancybox.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/appear.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/isotope.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/parallax-scroll.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.nice-select.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/scrolltop.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/language.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/countdown.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery-ui.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/product-filter.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.bootstrap-touchspin.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bxslider.js"></script>

<!-- main-js -->
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>

</body><!-- End of .page_wrapper -->
</html>

