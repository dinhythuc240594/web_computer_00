<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Boolean dbStatusOk = (Boolean) request.getAttribute("dbStatusOk");
    String dbStatusMessage = (String) request.getAttribute("dbStatusMessage");
    String dbStatusDetails = (String) request.getAttribute("dbStatusDetails");
    boolean isDbOk = Boolean.TRUE.equals(dbStatusOk);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <title>Cửa hàng máy tính HCMUTE</title>

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
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/banner.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/featured.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/category.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/shop-one.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/shop-two.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/shop-three.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/clients.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/cta.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/shop-four.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/news.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/footer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/responsive.css" rel="stylesheet">
    <style>
        .db-status{max-width:1200px;margin:20px auto;padding:18px;border-radius:10px;color:#111;}
        .db-status--ok{border:1px solid #22c55e;background:#ecfdf5;}
        .db-status--error{border:1px solid #f87171;background:#fef2f2;}
    </style>
</head>

<!-- page wrapper -->
<body>

<div class="boxed_wrapper ltr">
    <!-- preloader -->
    <jsp:include page="../common/preloader.jsp" />
    <!-- preloader end -->

    <jsp:include page="../common/header.jsp" />

    <!-- Mobile Menu  -->
    <jsp:include page="../common/mobile-menu.jsp" />
    <!-- End Mobile Menu -->

    <!-- Category Menu  -->
    <jsp:include page="../common/category-menu.jsp" />
    <!-- End Category Menu -->

    <jsp:include page="fragments/home/featured.jsp" />

    <jsp:include page="fragments/home/slider.jsp" />

    <jsp:include page="fragments/home/categories.jsp" />

    <jsp:include page="fragments/home/shop-flash.jsp" />

    <jsp:include page="fragments/home/shop-popular.jsp" />

    <jsp:include page="fragments/home/shop-mixed.jsp" />

    <jsp:include page="fragments/home/brands.jsp" />

    <jsp:include page="fragments/home/shop-tabs.jsp" />

    <jsp:include page="fragments/home/cta.jsp" />

    <jsp:include page="fragments/home/shop-top-sold.jsp" />

    <jsp:include page="fragments/home/news.jsp" />

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
