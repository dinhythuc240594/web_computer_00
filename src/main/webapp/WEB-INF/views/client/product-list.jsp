<%--
  Created by IntelliJ IDEA.
  User: Windows
  Date: 25/11/2025
  Time: 10:54 SA
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
    <link href="${pageContext.request.contextPath}/assets/css/module-css/shop.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/module-css/shop-two.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/module-css/shop-sidebar.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/module-css/shop-page.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/module-css/cta.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/module-css/highlights.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/module-css/footer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/responsive.css" rel="stylesheet">

</head>


<!-- page wrapper -->
<body>

<div class="boxed_wrapper ltr">


    <!-- preloader -->
    <jsp:include page="../common/preloader.jsp" />
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
    <jsp:include page="../common/mobile-menu.jsp" />
    <!-- End Mobile Menu -->


    <!-- Category Menu  -->
    <jsp:include page="../common/category-menu.jsp" />
    <!-- End Category Menu -->

    <jsp:include page="fragments/product-list/page-title.jsp" />

    <jsp:include page="fragments/product-list/shop-page.jsp" />

    <jsp:include page="fragments/product-list/highlights.jsp" />



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

<!-- main-js -->
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>

</body><!-- End of .page_wrapper -->
</html>

