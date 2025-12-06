<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.UserDAO" %>
<%@ page import="service.UserService" %>
<%@ page import="serviceimpl.UserServiceImpl" %>
<%@ page import="utilities.DataSourceUtil" %>
<%
    String sessionUsername = (String) session.getAttribute("username");
    UserDAO currentUser = null;
    if (sessionUsername != null && !sessionUsername.isBlank()) {
        try {
            javax.sql.DataSource ds = DataSourceUtil.getDataSource();
            UserService userService = new UserServiceImpl(ds);
            currentUser = userService.findByUsername(sessionUsername);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    String displayName = currentUser != null && currentUser.getFullname() != null && !currentUser.getFullname().isBlank()
            ? currentUser.getFullname()
            : (sessionUsername != null ? sessionUsername : "Khách");
    String displayEmail = currentUser != null && currentUser.getEmail() != null ? currentUser.getEmail() : "";
    String displayPhone = currentUser != null && currentUser.getPhone() != null ? currentUser.getPhone() : "Chưa cập nhật";
    String displayAddress = currentUser != null && currentUser.getAddress() != null ? currentUser.getAddress() : "Chưa cập nhật";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <title>Tài khoản của tôi | HCMUTE Computer Store</title>

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
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/account.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/highlights.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/footer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/responsive.css" rel="stylesheet">
</head>

<body>
<div class="boxed_wrapper ltr">

    <!-- <jsp:include page="../../common/preloader.jsp" /> -->

    <!-- page-direction -->
    <div class="page_direction">
        <div class="demo-rtl direction_switch"><button class="rtl">RTL</button></div>
        <div class="demo-ltr direction_switch"><button class="ltr">LTR</button></div>
    </div>
    <!-- page-direction end -->

    <!-- main header -->
    <jsp:include page="../../common/header.jsp" />
    <!-- main-header end -->

    <jsp:include page="../../common/mobile-menu.jsp" />
    <jsp:include page="../../common/category-menu.jsp" />

    <!-- page-title -->
    <section class="page-title pt_20 pb_18">
        <div class="large-container">
            <ul class="bread-crumb clearfix">
                <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li>Tài khoản của tôi</li>
            </ul>
        </div>
    </section>
    <!-- page-title end -->

    <!-- account-section -->
    <section class="account-section pb_80">
        <div class="large-container">
            <div class="sec-title centred pb_20">
                <h2>Tài khoản của tôi</h2>
            </div>
            <div class="inner-container">
                <div class="tabs-box">
                    <div class="account-info">
                        <div class="upper-box centred mb_40">
                            <figure class="image-box">
                                <img src="${pageContext.request.contextPath}/assets/client/images/resource/account-1.png" alt="Ảnh đại diện">
                            </figure>
                            <h4><%= displayName %></h4>
                            <%
                                if (displayEmail != null && !displayEmail.isBlank()) {
                            %>
                            <a href="mailto:<%= displayEmail %>"><%= displayEmail %></a>
                            <%
                                } else {
                            %>
                            <span>Chưa cập nhật email</span>
                            <%
                                }
                            %>
                        </div>
                        <ul class="tab-btns tab-buttons clearfix">
                            <li class="tab-btn active-btn" data-tab="#tab-1">Thông tin cá nhân</li>
                            <li class="tab-btn" data-tab="#tab-2">Thanh toán & hoá đơn</li>
                            <li class="tab-btn" data-tab="#tab-3">Lịch sử đơn hàng</li>
                            <li class="tab-btn" data-tab="#tab-4">Danh sách yêu thích</li>
                        </ul>
                    </div>
                    <div class="tabs-content">
                        <div class="tab active-tab" id="tab-1">
                            <div class="personal-info">
                                <h3>Thông tin cá nhân</h3>
                                <p>Quản lý thông tin cơ bản, số điện thoại và email liên hệ của bạn.</p>
                                <div class="row clearfix">
                                    <div class="col-lg-3 col-md-6 col-sm-12 single-column">
                                        <div class="single-item">
                                            <h6>Họ và tên</h6>
                                            <span><%= displayName %></span>
                                            <button type="button">Chỉnh sửa</button>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-12 single-column">
                                        <div class="single-item">
                                            <h6>Số điện thoại</h6>
                                            <span><%= displayPhone %></span>
                                            <button type="button">Chỉnh sửa</button>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-12 single-column">
                                        <div class="single-item">
                                            <h6>Địa chỉ</h6>
                                            <span><%= displayAddress %></span>
                                            <button type="button">Chỉnh sửa</button>
                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6 col-sm-12 single-column">
                                        <div class="single-item">
                                            <h6>Email</h6>
                                            <%
                                                if (displayEmail != null && !displayEmail.isBlank()) {
                                            %>
                                            <span><a href="mailto:<%= displayEmail %>"><%= displayEmail %></a></span>
                                            <%
                                                } else {
                                            %>
                                            <span>Chưa cập nhật</span>
                                            <%
                                                }
                                            %>
                                            <button type="button">Chỉnh sửa</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab" id="tab-2">
                            <h3>Thanh toán & hoá đơn</h3>
                            <div class="payment-option">
                                <div class="bank-payment">
                                    <div class="check-box mb_12">
                                        <input class="check" type="radio" id="payment-bank" name="payment" checked>
                                        <label for="payment-bank">Chuyển khoản ngân hàng</label>
                                    </div>
                                    <p>Vui lòng ghi rõ mã đơn hàng ở phần nội dung chuyển khoản để chúng tôi xác nhận nhanh chóng.</p>
                                </div>
                                <ul class="other-payment">
                                    <li>
                                        <div class="check-box mb_12">
                                            <input class="check" type="radio" id="payment-cod" name="payment">
                                            <label for="payment-cod">Thanh toán khi nhận hàng</label>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="check-box mb_12">
                                            <input class="check" type="radio" id="payment-card" name="payment">
                                            <label for="payment-card">Thẻ tín dụng/Ghi nợ hoặc Paypal</label>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="tab" id="tab-3">
                            <h3>Lịch sử đơn hàng</h3>
                            <div class="history-box">
                                <div class="single-history">
                                    <div class="product-box">
                                        <figure class="image-box">
                                            <img src="${pageContext.request.contextPath}/assets/client/images/resource/history-1.png" alt="Máy ảnh Canon">
                                        </figure>
                                        <div class="product-info">
                                            <h6>CANON EOS 750D 24.2 MP</h6>
                                            <span>#X469626</span>
                                            <h4>$999.99</h4>
                                        </div>
                                    </div>
                                    <span class="text">Đã giao</span>
                                </div>
                                <div class="single-history">
                                    <div class="product-box">
                                        <figure class="image-box">
                                            <img src="${pageContext.request.contextPath}/assets/client/images/resource/history-2.png" alt="VR Box">
                                        </figure>
                                        <div class="product-info">
                                            <h6>Box Shinecon 3D Glass with Remote</h6>
                                            <span>#X469625</span>
                                            <h4>$149.99</h4>
                                        </div>
                                    </div>
                                    <span class="text">Đã giao</span>
                                </div>
                                <div class="single-history">
                                    <div class="product-box">
                                        <figure class="image-box">
                                            <img src="${pageContext.request.contextPath}/assets/client/images/resource/history-3.png" alt="Máy giặt">
                                        </figure>
                                        <div class="product-info">
                                            <h6>Máy giặt 8KG Front Loading</h6>
                                            <span>#X469629</span>
                                            <h4>$999.99</h4>
                                        </div>
                                    </div>
                                    <span class="text">Đã giao</span>
                                </div>
                            </div>
                        </div>
                        <div class="tab" id="tab-4">
                            <h3>Danh sách yêu thích</h3>
                            <p>Chưa có sản phẩm nào trong danh sách yêu thích.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- account-section end -->

    <!-- highlights-section -->
    <section class="highlights-section inner-highlights">
        <div class="large-container">
            <div class="inner-container clearfix">
                <div class="shape" style="background-image: url(${pageContext.request.contextPath}/assets/client/images/shape/shape-5.png);"></div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-23"></i></div>
                        <h5>Giao hàng trong ngày</h5>
                    </div>
                </div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-17"></i></div>
                        <h5>100% khách hàng hài lòng</h5>
                    </div>
                </div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-25"></i></div>
                        <h5>Hỗ trợ tận tâm</h5>
                    </div>
                </div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-38"></i></div>
                        <h5>Sản phẩm chính hãng</h5>
                    </div>
                </div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-27"></i></div>
                        <h5>Hỗ trợ 24/7</h5>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- highlights-section end -->

    <jsp:include page="../../common/footer.jsp" />

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

<!-- main-js -->
<script src="${pageContext.request.contextPath}/assets/client/js/script.js"></script>
</body>
</html>

