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
    <link rel="icon" href="${pageContext.request.contextPath}/assets/client/images/favicon.ico" type="image/x-icon">

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
            <div class="nav-logo"><a href="index.html"><img src="${pageContext.request.contextPath}/assets/client/images/logo.png" alt="" title=""></a></div>
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
                <div class="nav-logo"><a href="index.html"><img src="${pageContext.request.contextPath}/assets/client/images/logo-2.png" alt="" title=""></a></div>
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
                <li>Shop Details</li>
            </ul>
        </div>
    </section>
    <!-- page-title end -->


    <!-- shop-details -->
    <section class="shop-details pb_70">
        <div class="large-container">
            <div class="product-details-content mb_70">
                <div class="row clearfix">
                    <div class="col-lg-6 col-md-12 col-sm-12 image-column">
                        <div class="bxslider">
                            <div class="slider-content">
                                <div class="image-inner">
                                    <div class="image-box">
                                        <figure class="image"><a href="${pageContext.request.contextPath}/assets/client/images/shop/shop-details-1.png" class="lightbox-image" data-fancybox="gallery"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-details-1.png" alt=""></a></figure>
                                    </div>
                                    <div class="slider-pager">
                                        <ul class="thumb-box">
                                            <li>
                                                <a class="active" data-slide-index="0" href="#"><figure><img src="${pageContext.request.contextPath}/assets/client/images/shop/thumb-5.png" alt=""></figure></a>
                                            </li>
                                            <li>
                                                <a data-slide-index="1" href="#"><figure><img src="${pageContext.request.contextPath}/assets/client/images/shop/thumb-6.png" alt=""></figure></a>
                                            </li>
                                            <li>
                                                <a data-slide-index="2" href="#"><figure><img src="${pageContext.request.contextPath}/assets/client/images/shop/thumb-7.png" alt=""></figure></a>
                                            </li>
                                            <li>
                                                <a data-slide-index="3" href="#"><figure><img src="${pageContext.request.contextPath}/assets/client/images/shop/thumb-8.png" alt=""></figure></a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="slider-content">
                                <div class="image-inner">
                                    <div class="image-box">
                                        <figure class="image"><a href="${pageContext.request.contextPath}/assets/client/images/shop/shop-details-2.png" class="lightbox-image" data-fancybox="gallery"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-details-2.png" alt=""></a></figure>
                                    </div>
                                    <div class="slider-pager">
                                        <ul class="thumb-box">
                                            <li>
                                                <a class="active" data-slide-index="0" href="#"><figure><img src="${pageContext.request.contextPath}/assets/client/images/shop/thumb-5.png" alt=""></figure></a>
                                            </li>
                                            <li>
                                                <a data-slide-index="1" href="#"><figure><img src="${pageContext.request.contextPath}/assets/client/images/shop/thumb-6.png" alt=""></figure></a>
                                            </li>
                                            <li>
                                                <a data-slide-index="2" href="#"><figure><img src="${pageContext.request.contextPath}/assets/client/images/shop/thumb-7.png" alt=""></figure></a>
                                            </li>
                                            <li>
                                                <a data-slide-index="3" href="#"><figure><img src="${pageContext.request.contextPath}/assets/client/images/shop/thumb-8.png" alt=""></figure></a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="slider-content">
                                <div class="image-inner">
                                    <div class="image-box">
                                        <figure class="image"><a href="${pageContext.request.contextPath}/assets/client/images/shop/shop-details-3.png" class="lightbox-image" data-fancybox="gallery"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-details-3.png" alt=""></a></figure>
                                    </div>
                                    <div class="slider-pager">
                                        <ul class="thumb-box">
                                            <li>
                                                <a class="active" data-slide-index="0" href="#"><figure><img src="${pageContext.request.contextPath}/assets/client/images/shop/thumb-5.png" alt=""></figure></a>
                                            </li>
                                            <li>
                                                <a data-slide-index="1" href="#"><figure><img src="${pageContext.request.contextPath}/assets/client/images/shop/thumb-6.png" alt=""></figure></a>
                                            </li>
                                            <li>
                                                <a data-slide-index="2" href="#"><figure><img src="${pageContext.request.contextPath}/assets/client/images/shop/thumb-7.png" alt=""></figure></a>
                                            </li>
                                            <li>
                                                <a data-slide-index="3" href="#"><figure><img src="${pageContext.request.contextPath}/assets/client/images/shop/thumb-8.png" alt=""></figure></a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="slider-content">
                                <div class="image-inner">
                                    <div class="image-box">
                                        <figure class="image"><a href="${pageContext.request.contextPath}/assets/client/images/shop/shop-details-4.png" class="lightbox-image" data-fancybox="gallery"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-details-4.png" alt=""></a></figure>
                                    </div>
                                    <div class="slider-pager">
                                        <ul class="thumb-box">
                                            <li>
                                                <a class="active" data-slide-index="0" href="#"><figure><img src="${pageContext.request.contextPath}/assets/client/images/shop/thumb-5.png" alt=""></figure></a>
                                            </li>
                                            <li>
                                                <a data-slide-index="1" href="#"><figure><img src="${pageContext.request.contextPath}/assets/client/images/shop/thumb-6.png" alt=""></figure></a>
                                            </li>
                                            <li>
                                                <a data-slide-index="2" href="#"><figure><img src="${pageContext.request.contextPath}/assets/client/images/shop/thumb-7.png" alt=""></figure></a>
                                            </li>
                                            <li>
                                                <a data-slide-index="3" href="#"><figure><img src="${pageContext.request.contextPath}/assets/client/images/shop/thumb-8.png" alt=""></figure></a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-12 col-sm-12 content-column">
                        <div class="content-box ml_30">
                            <span class="upper-text">Washing Machine</span>
                            <h2>Sharp Full Auto Front Loading Inverter Washing Machine ES-FW105D7PS | 10.5 KG</h2>
                            <h3>$500.99</h3>
                            <ul class="rating mb_25">
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><span>(05)</span></li>
                            </ul>
                            <div class="text-box mb_30">
                                <p>This powerful front loading washing machine will gently clean your laundry so your favorite clothes can remain as good as new. Now, washing clothes is much easier and more fun with the help of this powerful washing machine.</p>
                                <p>This would help you in the decision making process. Your purchase decision should depend upon what features and functions you require.</p>
                            </div>
                            <ul class="discription-box mb_30 clearfix">
                                <li><strong>Brand :</strong>Toshiba</li>
                                <li><strong>Product SKU :</strong>#KKLW30</li>
                                <li><strong>Category :</strong>front-load washing machines</li>
                                <li><strong>Availability :</strong><span class="product-stock"><img src="${pageContext.request.contextPath}/assets/client/images/icons/icon-1.png" alt=""> In Stock</span></li>
                            </ul>
                            <div class="color-box mb_30">
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
                            </div>
                            <div class="size-box mb_40">
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
                            </div>
                            <div class="addto-cart-box mb_40">
                                <ul class="clearfix">
                                    <li class="item-quantity"><input class="quantity-spinner" type="text" value="1" name="quantity"></li>
                                    <li class="cart-btn"><button type="button" class="theme-btn btn-one">Add To Cart<span></span><span></span><span></span><span></span></button></li>
                                    <li><a href="shop-details.html"><i class="icon-5"></i></a></li>
                                    <li class="like-btn"><button><i class="icon-6"></i></button></li>
                                </ul>
                            </div>
                            <ul class="other-option clearfix">
                                <li><strong>Seller :</strong>Daniel Macron</li>
                                <li><strong>Tag :</strong><span>Best sellers</span>, New Arrivals, On Sale</li>
                                <li class="social-links"><strong>Share :</strong><a href="shop-details.html"><i class="icon-13"></i></a><a href="shop-details.html"><i class="icon-14"></i></a><a href="shop-details.html"><i class="icon-15"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="product-discription">
                <div class="tabs-box">
                    <div class="tab-btn-box">
                        <ul class="tab-btns tab-buttons clearfix">
                            <li class="tab-btn active-btn" data-tab="#tab-1">Description</li>
                            <li class="tab-btn" data-tab="#tab-2">Reviews (08)</li>
                            <li class="tab-btn" data-tab="#tab-3">Specification</li>
                        </ul>
                    </div>
                    <div class="tabs-content">
                        <div class="tab active-tab" id="tab-1">
                            <div class="discription-content pt_35">
                                <p>Our washing machine boasts a spacious drum capacity, allowing you to tackle large loads with ease. Say goodbye to stubborn stains with customizable temperature settings and specialized stain-fighting options, ensuring your clothes come out fresh and pristine.</p>
                                <p>Equipped with a powerful yet energy-efficient motor, our machine ensures thorough cleaning while minimizing water and electricity consumption. Choose from a variety of wash cycles tailored to your specific needs, from delicate fabrics to heavy-duty loads, guaranteeing optimal results every time.Experience peace of mind with our built-in safety features, including child lock and overflow protection, keeping your household safe during operation. Plus, with its sleek and modern design, our washing machine seamlessly blends into any home decor.</p>
                                <h5>Features :</h5>
                                <ul class="list-style-one clearfix">
                                    <li>It takes only 15-18 minutes to wash 1 to 1.5 kg of clothes</li>
                                    <li>Adjustable spin speed for better water extraction</li>
                                    <li>Water-saving features or certifications</li>
                                    <li>Indicates the maximum weight of laundry the machine</li>
                                    <li>Automatically adjusts water levels based</li>
                                    <li>A fast cycle for lightly soiled clothes that need a quick refresh.</li>
                                </ul>
                            </div>
                        </div>
                        <div class="tab" id="tab-2">
                            <div class="review-content pt_40">
                                <div class="single-review">
                                    <div class="upper-box">
                                        <div class="info-box">
                                            <figure class="image"><img src="${pageContext.request.contextPath}/assets/client/images/resource/review-1.png" alt=""></figure>
                                            <div class="inner">
                                                <h4>Dania Monjur</h4>
                                                <span class="date">June 12, 2023</span>
                                            </div>
                                        </div>
                                        <ul class="option-btn">
                                            <li><button><i class="icon-46"></i></button>12</li>
                                            <li><button><i class="icon-47"></i></button>0</li>
                                        </ul>
                                    </div>
                                    <ul class="rating">
                                        <li><i class="icon-11"></i></li>
                                        <li><i class="icon-11"></i></li>
                                        <li><i class="icon-11"></i></li>
                                        <li><i class="icon-11"></i></li>
                                        <li><i class="icon-11"></i></li>
                                    </ul>
                                    <p>To provide a review of a specific washing machine, I would need to know the brand and model of the washing machine you're interested in reviewing. If you have a particular washing machine in mind, please provide its details, and I can help you create a comprehensive review. Alternatively, if you're looking for a general review of washing machines.</p>
                                    <ul class="image-list">
                                        <li><img src="${pageContext.request.contextPath}/assets/client/images/resource/review-img-1.jpg" alt=""></li>
                                        <li><img src="${pageContext.request.contextPath}/assets/client/images/resource/review-img-2.jpg" alt=""></li>
                                        <li><img src="${pageContext.request.contextPath}/assets/client/images/resource/review-img-3.jpg" alt=""></li>
                                        <li><img src="${pageContext.request.contextPath}/assets/client/images/resource/review-img-4.jpg" alt=""></li>
                                    </ul>
                                    <div class="reply-review mt_30">
                                        <div class="upper-box">
                                            <div class="info-box">
                                                <figure class="image"><img src="${pageContext.request.contextPath}/assets/client/images/resource/review-2.png" alt=""></figure>
                                                <div class="inner">
                                                    <h4>Seller</h4>
                                                </div>
                                            </div>
                                            <ul class="option-btn">
                                                <li><button><i class="icon-46"></i></button>12</li>
                                                <li><button><i class="icon-47"></i></button>0</li>
                                            </ul>
                                        </div>
                                        <p>Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.</p>
                                    </div>
                                </div>
                                <div class="single-review">
                                    <div class="upper-box">
                                        <div class="info-box">
                                            <figure class="image"><img src="${pageContext.request.contextPath}/assets/client/images/resource/review-3.png" alt=""></figure>
                                            <div class="inner">
                                                <h4>Dania Monjur</h4>
                                                <span class="date">June 08, 2023</span>
                                            </div>
                                        </div>
                                        <ul class="option-btn">
                                            <li><button><i class="icon-46"></i></button>12</li>
                                            <li><button><i class="icon-47"></i></button>0</li>
                                        </ul>
                                    </div>
                                    <ul class="rating">
                                        <li><i class="icon-11"></i></li>
                                        <li><i class="icon-11"></i></li>
                                        <li><i class="icon-11"></i></li>
                                        <li><i class="icon-11"></i></li>
                                        <li><i class="icon-11"></i></li>
                                    </ul>
                                    <p>To provide a review of a specific washing machine, I would need to know the brand and model of the washing machine you're interested in reviewing. If you have a particular washing machine in mind, please provide its details, and I can help you create a comprehensive review. Alternatively, if you're looking for a general review of washing machines.</p>
                                    <ul class="image-list">
                                        <li><img src="${pageContext.request.contextPath}/assets/client/images/resource/review-img-5.jpg" alt=""></li>
                                        <li><img src="${pageContext.request.contextPath}/assets/client/images/resource/review-img-6.jpg" alt=""></li>
                                    </ul>
                                </div>
                                <div class="customer-review">
                                    <h3>Write Your Rating</h3>
                                    <div class="rating-box mb_25">
                                        <p>Your Rating <span>*</span></p>
                                        <div class="rating-inner">
                                            <ul class="rating-list">
                                                <li><button><i class="icon-11"></i></button></li>
                                                <li><button><i class="icon-11"></i><i class="icon-11"></i></button></li>
                                                <li><button><i class="icon-11"></i><i class="icon-11"></i><i class="icon-11"></i></button></li>
                                                <li><button><i class="icon-11"></i><i class="icon-11"></i><i class="icon-11"></i><i class="icon-11"></i></button></li>
                                                <li><button><i class="icon-11"></i><i class="icon-11"></i><i class="icon-11"></i><i class="icon-11"></i><i class="icon-11"></i></button></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="form-inner">
                                        <form method="post" action="shop-details.html">
                                            <div class="form-group">
                                                <label>Write Your Review <span>*</span></label>
                                                <textarea name="message"></textarea>
                                            </div>
                                            <div class="form-group upload-field">
                                                <label>Add Photos and Video</label>
                                                <div class="upload-box">
                                                    <input name="files[]" id="filer_input2" multiple="multiple" type="file">
                                                    <div class="upload-content">
                                                        <i class="icon-48"></i>
                                                        <span>Upload Image</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label>Your Name <span>*</span></label>
                                                <input type="text" name="name">
                                            </div>
                                            <div class="form-group">
                                                <label>Email Address <span>*</span></label>
                                                <input type="email" name="email">
                                            </div>
                                            <div class="form-group">
                                                <div class="check-box">
                                                    <input class="check" type="checkbox" id="checkbox1">
                                                    <label for="checkbox1">Save my name, email, and website in this browser for the next time I comment.</label>
                                                </div>
                                            </div>
                                            <div class="message-btn">
                                                <button type="submit" class="theme-btn btn-one">Submit Review<span></span><span></span><span></span><span></span></button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab" id="tab-3">
                            <div class="specification-content pt_40">
                                <ul class="specification-list clean">
                                    <li><strong>Model Name</strong>Sharp Full Auto Front-10.5 KG</li>
                                    <li><strong>Display</strong>LCD</li>
                                    <li><strong>Brand</strong>Toshiba</li>
                                    <li><strong>Condition</strong>Brand New</li>
                                    <li><strong>Voltage</strong>120V or 220-240V</li>
                                    <li><strong>Made in</strong>Japan</li>
                                    <li><strong>Warranty</strong>01 Year</li>
                                    <li><strong>Frequency</strong>50Hz or 60Hz</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- shop-details end -->


    <!-- shop-one -->
    <section class="shop-one pb_30">
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
    </section>
    <!-- shop-one end -->

    <!-- shop-two -->
    <section class="shop-two pb_50">
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

