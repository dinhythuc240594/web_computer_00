<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>

<html
        lang="en"
        class="layout-navbar-fixed layout-menu-fixed layout-compact"
        dir="ltr"
        data-skin="default"
        data-bs-theme="light"
        data-assets-path="../../assets/"
        data-template="vertical-menu-template">
<head>
    <meta charset="utf-8" />
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
    <meta name="robots" content="noindex, nofollow" />
    <title>Demo: Order List - eCommerce | Materialize - Bootstrap Dashboard PRO</title>

    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../../assets/img/favicon/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&ampdisplay=swap"
            rel="stylesheet" />

    <link rel="stylesheet" href="../../assets/vendor/fonts/iconify-icons.css" />

    <!-- Core CSS -->
    <!-- build:css assets/vendor/css/theme.css -->

    <link rel="stylesheet" href="../../assets/vendor/libs/node-waves/node-waves.css" />

    <script src="../../assets/vendor/libs/@algolia/autocomplete-js.js"></script>

    <link rel="stylesheet" href="../../assets/vendor/libs/pickr/pickr-themes.css" />

    <link rel="stylesheet" href="../../assets/vendor/css/core.css" />
    <link rel="stylesheet" href="../../assets/css/demo.css" />

    <!-- Vendors CSS -->

    <link rel="stylesheet" href="../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- endbuild -->

    <link rel="stylesheet" href="../../assets/vendor/libs/datatables-bs5/datatables.bootstrap5.css" />
    <link rel="stylesheet" href="../../assets/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css" />
    <link rel="stylesheet" href="../../assets/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css" />

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="../../assets/vendor/js/helpers.js"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->

    <!--? Template customizer: To hide customizer set displayCustomizer value false in config.js. -->
    <script src="../../assets/vendor/js/template-customizer.js"></script>

    <!--? Config: Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file. -->

    <script src="../../assets/js/config.js"></script>
</head>

<body>
<!-- Layout wrapper -->
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <!-- Menu -->
        <jsp:include page="../layout/sidebar.jsp" />
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">
            <!-- Navbar -->
            <jsp:include page="../layout/navbar.jsp" />
            <!-- / Navbar -->

            <!-- Content wrapper -->
            <div class="content-wrapper">
                <!-- Content -->
                <div class="container-xxl flex-grow-1 container-p-y">
                    <!-- Order List Widget -->

                    <div class="card mb-6">
                        <div class="card-widget-separator-wrapper">
                            <div class="card-body card-widget-separator">
                                <div class="row gy-4 gy-sm-1">
                                    <div class="col-sm-6 col-lg-3">
                                        <div
                                                class="d-flex justify-content-between align-items-start card-widget-1 border-end pb-4 pb-sm-0">
                                            <div>
                                                <h4 class="mb-0">56</h4>
                                                <p class="mb-0">Pending Payment</p>
                                            </div>
                                            <div class="avatar me-sm-6">
                            <span class="avatar-initial rounded-3 text-heading">
                              <i class="icon-base ri ri-calendar-2-line icon-26px"></i>
                            </span>
                                            </div>
                                        </div>
                                        <hr class="d-none d-sm-block d-lg-none me-6" />
                                    </div>
                                    <div class="col-sm-6 col-lg-3">
                                        <div
                                                class="d-flex justify-content-between align-items-start card-widget-2 border-end pb-4 pb-sm-0">
                                            <div>
                                                <h4 class="mb-0">12,689</h4>
                                                <p class="mb-0">Completed</p>
                                            </div>
                                            <div class="avatar me-lg-6">
                            <span class="avatar-initial rounded-3 text-heading">
                              <i class="icon-base ri ri-check-double-line icon-26px"></i>
                            </span>
                                            </div>
                                        </div>
                                        <hr class="d-none d-sm-block d-lg-none" />
                                    </div>
                                    <div class="col-sm-6 col-lg-3">
                                        <div
                                                class="d-flex justify-content-between align-items-start border-end pb-4 pb-sm-0 card-widget-3">
                                            <div>
                                                <h4 class="mb-0">124</h4>
                                                <p class="mb-0">Refunded</p>
                                            </div>
                                            <div class="avatar me-sm-6">
                            <span class="avatar-initial rounded-3 text-heading">
                              <i class="icon-base ri ri-wallet-3-line icon-26px"></i>
                            </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 col-lg-3">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <h4 class="mb-0">32</h4>
                                                <p class="mb-0">Failed</p>
                                            </div>
                                            <div class="avatar">
                            <span class="avatar-initial rounded-3 text-heading">
                              <i class="icon-base ri ri-error-warning-line icon-26px"></i>
                            </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Order List Table -->
                    <div class="card">
                        <div class="card-datatable table-responsive">
                            <table class="datatables-order table">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <th>order</th>
                                    <th>date</th>
                                    <th>customers</th>
                                    <th>payment</th>
                                    <th>status</th>
                                    <th>method</th>
                                    <th>actions</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- / Content -->

                <!-- Footer -->
                <footer class="content-footer footer bg-footer-theme">
                    <div class="container-xxl">
                        <div
                                class="footer-container d-flex align-items-center justify-content-between py-4 flex-md-row flex-column">
                            <div class="mb-2 mb-md-0">
                                &#169;
                                <script>
                                    document.write(new Date().getFullYear());
                                </script>
                                , made with ❤️ by
                                <a href="https://pixinvent.com" target="_blank" class="footer-link fw-medium">Pixinvent</a>
                            </div>
                            <div class="d-none d-lg-inline-block">
                                <a href="https://themeforest.net/licenses/standard" class="footer-link me-4" target="_blank"
                                >License</a
                                >

                                <a href="https://themeforest.net/user/pixinvent/portfolio" target="_blank" class="footer-link me-4"
                                >More Themes</a
                                >
                                <a
                                        href="https://demos.pixinvent.com/materialize-html-admin-template/documentation/"
                                        target="_blank"
                                        class="footer-link me-4"
                                >Documentation</a
                                >

                                <a href="https://pixinvent.ticksy.com/" target="_blank" class="footer-link d-none d-sm-inline-block"
                                >Support</a
                                >
                            </div>
                        </div>
                    </div>
                </footer>
                <!-- / Footer -->

                <div class="content-backdrop fade"></div>
            </div>
            <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
    </div>

    <!-- Overlay -->
    <div class="layout-overlay layout-menu-toggle"></div>

    <!-- Drag Target Area To SlideIn Menu On Small Screens -->
    <div class="drag-target"></div>
</div>
<!-- / Layout wrapper -->

<!-- Core JS -->

<!-- build:js assets/vendor/js/theme.js  -->

<script src="../../assets/vendor/libs/jquery/jquery.js"></script>

<script src="../../assets/vendor/libs/popper/popper.js"></script>
<script src="../../assets/vendor/js/bootstrap.js"></script>
<script src="../../assets/vendor/libs/node-waves/node-waves.js"></script>

<script src="../../assets/vendor/libs/@algolia/autocomplete-js.js"></script>

<script src="../../assets/vendor/libs/pickr/pickr.js"></script>

<script src="../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

<script src="../../assets/vendor/libs/hammer/hammer.js"></script>

<script src="../../assets/vendor/libs/i18n/i18n.js"></script>

<script src="../../assets/vendor/js/menu.js"></script>

<!-- endbuild -->

<!-- Vendors JS -->
<script src="../../assets/vendor/libs/datatables-bs5/datatables-bootstrap5.js"></script>

<!-- Main JS -->

<script src="../../assets/js/main.js"></script>

<!-- Page JS -->
<script src="../../assets/js/app-ecommerce-order-list.js"></script>
</body>
</html>

