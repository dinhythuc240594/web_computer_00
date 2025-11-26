<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/init.jspf" %>
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
    <title>Lỗi máy chủ | Bảng quản trị</title>

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

<!-- Server Error -->
<div class="misc-wrapper">
    <h1 class="mb-2 mx-2" style="font-size: 6rem; line-height: 6rem">500</h1>
    <h4 class="mb-2">Lỗi máy chủ 🔐</h4>
    <p class="mb-3 mx-2">Đã có sự cố xảy ra. Vui lòng thử lại trong giây lát.</p>
    <div class="d-flex justify-content-center mt-12">
        <img
                src="${adminAssetsPath}/img/illustrations/misc-error-object.png"
                alt="misc-server-error"
                class="img-fluid misc-object d-none d-lg-inline-block"
                width="160" />
        <img
                src="${adminAssetsPath}/img/illustrations/misc-bg-light.png"
                alt="misc-server-error"
                class="misc-bg d-none d-lg-inline-block z-n1"
                data-app-light-img="illustrations/misc-bg-light.png"
                data-app-dark-img="illustrations/misc-bg-dark.png" />
        <div class="d-flex flex-column align-items-center">
            <img
                    src="${adminAssetsPath}/img/illustrations/misc-server-error-illustration.png"
                    alt="misc-server-error"
                    class="img-fluid z-1"
                    width="230" />
            <div>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-primary text-center my-10">Về trang chủ</a>
            </div>
        </div>
    </div>
</div>
<!-- /Server Error -->

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

