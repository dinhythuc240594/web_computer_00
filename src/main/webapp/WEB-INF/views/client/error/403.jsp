<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../admin/layout/init.jspf" %>
<!doctype html>

<html
        lang="en"
        class="layout-wide customizer-hide"
        dir="ltr"
        data-skin="default"
        data-bs-theme="light"
        data-assets-path="${adminAssetsPath}/"
        data-template="vertical-menu-template-no-customizer">
<head>
    <meta charset="utf-8" />
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
    <meta name="robots" content="noindex, nofollow" />
    <title>403 | HCMUTE Computer Store</title>

    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="${adminAssetsPath}/img/favicon/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&ampdisplay=swap"
            rel="stylesheet" />

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/fonts/iconify-icons.css" />

    <!-- Core CSS -->
    <!-- build:css assets/vendor/css/theme.css -->

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/node-waves/node-waves.css" />

    <script src="${adminAssetsPath}/vendor/libs/@algolia/autocomplete-js.js"></script>

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/css/core.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/css/demo.css" />

    <!-- Vendors CSS -->

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- endbuild -->

    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/css/pages/page-misc.css" />

    <!-- Helpers -->
    <script src="${adminAssetsPath}/vendor/js/helpers.js"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->

    <!--? Config: Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file. -->

    <script src="${adminAssetsPath}/js/config.js"></script>
</head>

<body>
<!-- Content -->

<!-- Access Denied -->
<div class="misc-wrapper">
    <h1 class="mb-2 mx-2" style="font-size: 6rem; line-height: 6rem">403</h1>
    <h4 class="mb-2">Lỗi 403 | Bạn không có quyền truy cập trang này</h4>
    <p class="mb-3 mx-2">Vui lòng đăng nhập với tài khoản có quyền phù hợp hoặc quay lại trang chủ.</p>
    <div class="d-flex justify-content-center mt-12">
        <img
                src="${adminAssetsPath}/img/illustrations/misc-error-object.png"
                alt="misc-access-denied"
                class="img-fluid misc-object d-none d-lg-inline-block"
                width="160" />
        <img
                src="${adminAssetsPath}/img/illustrations/misc-bg-light.png"
                alt="misc-access-denied"
                class="misc-bg d-none d-lg-inline-block z-n1"
                data-app-light-img="illustrations/misc-bg-light.png"
                data-app-dark-img="illustrations/misc-bg-dark.png" />
        <div class="d-flex flex-column align-items-center">
            <!-- <img
                    src="${adminAssetsPath}/img/illustrations/misc-not-authorized-illustration.png"
                    alt="misc-access-denied"
                    class="img-fluid z-1"
                    width="230" /> -->
            <div class="d-flex gap-2 mt-4">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">Về trang chủ</a>
            </div>
        </div>
    </div>
</div>
<!-- /Access Denied -->

<!-- / Content -->

<!-- Core JS -->

<!-- build:js assets/vendor/js/theme.js  -->
<script src="${adminAssetsPath}/vendor/libs/jquery/jquery.js"></script>
<script src="${adminAssetsPath}/vendor/libs/popper/popper.js"></script>
<script src="${adminAssetsPath}/vendor/js/bootstrap.js"></script>
<script src="${adminAssetsPath}/vendor/libs/node-waves/node-waves.js"></script>
<script src="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="${adminAssetsPath}/vendor/js/menu.js"></script>
<!-- endbuild -->

<!-- Vendors JS -->

<!-- Main JS -->
<script src="${adminAssetsPath}/js/main.js"></script>

</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../admin/layout/init.jspf" %>
<!doctype html>

<html
        lang="en"
        class="layout-wide customizer-hide"
        dir="ltr"
        data-skin="default"
        data-bs-theme="light"
        data-assets-path="${adminAssetsPath}/"
        data-template="vertical-menu-template-no-customizer">
<head>
    <meta charset="utf-8" />
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
    <meta name="robots" content="noindex, nofollow" />
    <title>Không tìm thấy trang | Bảng quản trị</title>

    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="${adminAssetsPath}/img/favicon/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&ampdisplay=swap"
            rel="stylesheet" />

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/fonts/iconify-icons.css" />

    <!-- Core CSS -->
    <!-- build:css assets/vendor/css/theme.css -->

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/node-waves/node-waves.css" />

    <script src="${adminAssetsPath}/vendor/libs/@algolia/autocomplete-js.js"></script>

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/css/core.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/css/demo.css" />

    <!-- Vendors CSS -->

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- endbuild -->

    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/css/pages/page-misc.css" />

    <!-- Helpers -->
    <script src="${adminAssetsPath}/vendor/js/helpers.js"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->

    <!--? Config: Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file. -->

    <script src="${adminAssetsPath}/js/config.js"></script>
</head>

<body>
<!-- Content -->

<!-- Error -->
<!-- <div class="misc-wrapper">
    <h1 class="mb-2 mx-2" style="font-size: 6rem; line-height: 6rem">404</h1>
    <h4 class="mb-2">Lỗi 403 | Không tìm thấy trang ⚠️</h4>
    <p class="mb-6 mx-2">Chúng tôi không thể tìm thấy nội dung bạn yêu cầu.</p>
    <div class="d-flex justify-content-center mt-9">
        <img
                src="${adminAssetsPath}/img/illustrations/misc-error-object.png"
                alt="misc-error"
                class="img-fluid misc-object d-none d-lg-inline-block"
                width="160" />
        <img
                src="${adminAssetsPath}/img/illustrations/misc-bg-light.png"
                alt="misc-error"
                class="misc-bg d-none d-lg-inline-block"
                data-app-light-img="illustrations/misc-bg-light.png"
                data-app-dark-img="illustrations/misc-bg-dark.png" />
        <div class="d-flex flex-column align-items-center">
            <img
                src="${adminAssetsPath}/img/illustrations/misc-error-illustration.png"
                    alt="misc-error"
                    class="img-fluid z-1"
                    width="190" />
            <div>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-primary text-center my-10">Về trang chủ</a>
            </div>
        </div>
    </div>
</div> -->
<!-- /Error -->

<!-- / Content -->

<!-- Core JS -->

<!-- build:js assets/vendor/js/theme.js  -->

<script src="${adminAssetsPath}/vendor/libs/jquery/jquery.js"></script>

<script src="${adminAssetsPath}/vendor/libs/popper/popper.js"></script>
<script src="${adminAssetsPath}/vendor/js/bootstrap.js"></script>
<script src="${adminAssetsPath}/vendor/libs/node-waves/node-waves.js"></script>

<script src="${adminAssetsPath}/vendor/libs/@algolia/autocomplete-js.js"></script>

<script src="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

<script src="${adminAssetsPath}/vendor/libs/hammer/hammer.js"></script>

<script src="${adminAssetsPath}/vendor/libs/i18n/i18n.js"></script>

<script src="${adminAssetsPath}/vendor/js/menu.js"></script>

<!-- endbuild -->

<!-- Vendors JS -->

<!-- Main JS -->

<script src="${adminAssetsPath}/js/main.js"></script>

<!-- Page JS -->
</body>
</html>

