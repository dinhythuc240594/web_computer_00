<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <title>Đặt lại mật khẩu | Cửa hàng máy tính HCMUTE</title>

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
    <link href="${pageContext.request.contextPath}/assets/client/css/odometer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/color.css" id="jssDefault" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/rtl.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/page-title.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/login.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/highlights.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/footer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/responsive.css" rel="stylesheet">
</head>

<!-- page wrapper -->
<body>
<div class="boxed_wrapper ltr">

    <!-- main header -->
    <jsp:include page="../common/header.jsp" />
    <!-- main-header end -->

    <jsp:include page="../common/mobile-menu.jsp" />
    <jsp:include page="../common/category-menu.jsp" />

    <!-- sign-section -->
    <section class="sign-section pb_80">
        <div class="large-container">
            <div class="sec-title centred pb_30">
                <h2>Đặt lại mật khẩu</h2>
                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null && !error.isBlank()) {
                %>
                <p style="color:#dc2626;margin-top:10px;"><%= error %></p>
                <%
                    }
                    String token = (String) request.getAttribute("token");
                    if (token == null || token.isBlank()) {
                        token = request.getParameter("token");
                    }
                %>
            </div>
            <div class="form-inner">
                <%
                    if (token != null && !token.isBlank()) {
                %>
                <form method="post" action="${pageContext.request.contextPath}/reset-password" id="resetPasswordForm">
                    <input type="hidden" name="token" value="<%= token %>">
                    <div class="form-group">
                        <label>Mật khẩu mới <span class="text-danger">*</span></label>
                        <input type="password" name="newPassword" id="newPassword" required minlength="6">
                        <small class="form-text text-muted">Mật khẩu phải có ít nhất 6 ký tự</small>
                    </div>
                    <div class="form-group">
                        <label>Xác nhận mật khẩu <span class="text-danger">*</span></label>
                        <input type="password" name="confirmPassword" id="confirmPassword" required minlength="6">
                    </div>
                    <div class="form-group message-btn">
                        <button type="submit" class="theme-btn">Đặt lại mật khẩu<span></span><span></span><span></span><span></span></button>
                    </div>
                </form>
                <%
                    } else {
                %>
                <div class="alert alert-danger">
                    <p>Token không hợp lệ hoặc đã hết hạn. Vui lòng yêu cầu đặt lại mật khẩu mới.</p>
                </div>
                <%
                    }
                %>
                <div class="lower-text centred">
                    <p><a href="${pageContext.request.contextPath}/login">Quay lại đăng nhập</a></p>
                </div>
            </div>
        </div>
    </section>
    <!-- sign-section end -->

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

    <jsp:include page="../common/footer.jsp" />

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
<script src="${pageContext.request.contextPath}/assets/client/js/odometer.js"></script>

<!-- main-js -->
<script src="${pageContext.request.contextPath}/assets/client/js/script.js"></script>
<script>
    // Validate password match
    document.getElementById('resetPasswordForm')?.addEventListener('submit', function(e) {
        var newPassword = document.getElementById('newPassword').value;
        var confirmPassword = document.getElementById('confirmPassword').value;
        
        if (newPassword !== confirmPassword) {
            e.preventDefault();
            alert('Mật khẩu mới và xác nhận mật khẩu không khớp.');
            return false;
        }
        
        if (newPassword.length < 6) {
            e.preventDefault();
            alert('Mật khẩu phải có ít nhất 6 ký tự.');
            return false;
        }
    });
</script>
</body>
</html>

