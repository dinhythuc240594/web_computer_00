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
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/checkout.css" rel="stylesheet">
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
                <li><a href="index.html">Home</a></li>
                <li>Checkout</li>
            </ul>
        </div>
    </section>
    <!-- page-title end -->


    <!-- checkout-section -->
    <section class="checkout-section pb_80">
        <div class="large-container">
            <div class="sec-title centred pb_30">
                <h2>Checkout</h2>
            </div>
            <div class="row clearfix">
                <div class="col-lg-8 col-md-12 col-sm-12 billing-column">
                    <div class="billing-content mr_30">
                        <h3>Billing Details</h3>
                        <div class="form-inner">
                            <form method="post" action="checkout.html">
                                <div class="row clearfix">
                                    <div class="col-lg-6 col-md-6 col-sm-12 field-column">
                                        <div class="form-group">
                                            <label>First Name<span>*</span></label>
                                            <input type="text" name="fname">
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-12 field-column">
                                        <div class="form-group">
                                            <label>Last Name<span>*</span></label>
                                            <input type="text" name="lname">
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-12 field-column">
                                        <div class="form-group">
                                            <label>Email Address<span>*</span></label>
                                            <input type="email" name="email">
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-12 field-column">
                                        <div class="form-group">
                                            <label>Phone Number<span>*</span></label>
                                            <input type="text" name="phone">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 field-column">
                                        <div class="form-group">
                                            <label>Country<span>*</span></label>
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
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 field-column">
                                        <div class="form-group">
                                            <label>Address<span>*</span></label>
                                            <input type="text" name="address">
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-12 field-column">
                                        <div class="form-group">
                                            <label>Town / City<span>*</span></label>
                                            <input type="text" name="city">
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-12 field-column">
                                        <div class="form-group">
                                            <label>Postcode / ZIP<span>*</span></label>
                                            <input type="text" name="zip">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 field-column">
                                        <div class="form-group">
                                            <div class="check-box">
                                                <input class="check" type="checkbox" id="checkbox1">
                                                <label for="checkbox1">Create an account?</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="other-address">
                            <h3>Shipping Address</h3>
                            <div class="check-box">
                                <input class="check" type="checkbox" id="checkbox2">
                                <label for="checkbox2">Ship to a different address</label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-12 col-sm-12 order-column">
                    <div class="order-box">
                        <h3>Order Summary</h3>
                        <div class="order-info">
                            <div class="title-box">
                                <span class="text">PROduct</span>
                                <span class="text">total</span>
                            </div>
                            <div class="order-product">
                                <div class="single-item">
                                    <div class="product-box">
                                        <figure class="image-box"><img src="${pageContext.request.contextPath}/assets/client/images/shop/checkout-1.png" alt=""></figure>
                                        <h6>CANON EOS 750D 24.2 MP In Best Price</h6>
                                    </div>
                                    <h4>$999.99</h4>
                                </div>
                                <div class="single-item">
                                    <div class="product-box">
                                        <figure class="image-box"><img src="${pageContext.request.contextPath}/assets/client/images/shop/checkout-2.png" alt=""></figure>
                                        <h6>Box Shinecon 3D Glass with Remote</h6>
                                    </div>
                                    <h4>$149.99</h4>
                                </div>
                                <div class="single-item">
                                    <div class="product-box">
                                        <figure class="image-box"><img src="${pageContext.request.contextPath}/assets/client/images/shop/checkout-3.png" alt=""></figure>
                                        <h6>8 KG Front Loading Washing </h6>
                                    </div>
                                    <h4>$999.99</h4>
                                </div>
                            </div>
                            <ul class="cost-box">
                                <li><h4><span>Subtotal</span></h4><h4>$2149.97</h4></li>
                                <li><h4><span>Free Shipping</span></h4><h4><span>$0</span></h4></li>
                            </ul>
                            <div class="total-box">
                                <h4><span>Total</span></h4>
                                <h4>$2149.98</h4>
                            </div>
                            <div class="payment-option">
                                <div class="bank-payment">
                                    <div class="check-box mb_12">
                                        <input class="check" type="radio" id="checkbox3" name="same" checked>
                                        <label for="checkbox3">Direct Bank Transfer</label>
                                    </div>
                                    <p>Make your payment directly into our bank account. Please use your Order ID as payment reference.</p>
                                </div>
                                <ul class="other-payment">
                                    <li>
                                        <div class="check-box mb_12">
                                            <input class="check" type="radio" id="checkbox4" name="same">
                                            <label for="checkbox4">Cash on Delivery</label>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="check-box mb_12">
                                            <input class="check" type="radio" id="checkbox5" name="same">
                                            <label for="checkbox5">Credit/Debit Cards or Paypal</label>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="btn-box pt_30">
                                <button type="submit" class="theme-btn">Make Payment<span></span><span></span><span></span><span></span></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- checkout-section end -->


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

