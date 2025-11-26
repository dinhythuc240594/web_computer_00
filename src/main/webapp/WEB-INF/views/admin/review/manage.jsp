<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../layout/init.jspf" %>
<!doctype html>

<html
        lang="en"
        class="layout-navbar-fixed layout-menu-fixed layout-compact"
        dir="ltr"
        data-skin="default"
        data-bs-theme="light"
        data-assets-path="${adminAssetsPath}/"
        data-template="vertical-menu-template">
<head>
    <meta charset="utf-8" />
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
    <meta name="robots" content="noindex, nofollow" />
    <title>Demo: eCommerce Manage reviews - App | Materialize - Bootstrap Dashboard PRO</title>

    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="${adminAssetsPath}/img/favicon/Logo%20HCMUTE_White%20background.png" />

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

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/pickr/pickr-themes.css" />

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/css/core.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/css/demo.css" />

    <!-- Vendors CSS -->

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- endbuild -->

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/datatables-bs5/datatables.bootstrap5.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/apex-charts/apex-charts.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/raty-js/raty-js.css" />

    <!-- Page CSS -->

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/css/pages/app-ecommerce.css" />

    <!-- Helpers -->
    <script src="${adminAssetsPath}/vendor/js/helpers.js"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->

    <!--? Template customizer: To hide customizer set displayCustomizer value false in config.js. -->
    <script src="${adminAssetsPath}/vendor/js/template-customizer.js"></script>

    <!--? Config: Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file. -->

    <script src="${adminAssetsPath}/js/config.js"></script>
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
                    <div class="row mb-6 g-6">
                        <div class="col-md-6">
                            <div class="card h-100">
                                <div class="card-body row widget-separator">
                                    <div class="col-sm-5 border-shift border-end">
                                        <div class="d-flex align-items-center mb-2">
                                            <span class="text-primary fs-3 fw-medium">4.89</span>
                                            <span class="icon-base ri ri-star-smile-line icon-32px ms-2 text-primary"></span>
                                        </div>
                                        <h6 class="mb-2">Total 187 reviews</h6>
                                        <p class="mb-2">All reviews are from genuine customers</p>
                                        <span class="badge bg-label-primary rounded-pill mb-4 mb-sm-0">+5 This week</span>
                                        <hr class="d-sm-none" />
                                    </div>

                                    <div class="col-sm-7 g-2 text-nowrap d-flex flex-column justify-content-between px-6 gap-3">
                                        <div class="d-flex align-items-center gap-2">
                                            <small>5 Star</small>
                                            <div class="progress w-100 bg-label-primary rounded-pill" style="height: 8px">
                                                <div
                                                        class="progress-bar bg-primary"
                                                        role="progressbar"
                                                        style="width: 61.5%"
                                                        aria-valuenow="61.50"
                                                        aria-valuemin="0"
                                                        aria-valuemax="100"></div>
                                            </div>
                                            <small class="w-px-20 text-end">124</small>
                                        </div>
                                        <div class="d-flex align-items-center gap-2">
                                            <small>4 Star</small>
                                            <div class="progress w-100 bg-label-primary rounded-pill" style="height: 8px">
                                                <div
                                                        class="progress-bar bg-primary"
                                                        role="progressbar"
                                                        style="width: 24%"
                                                        aria-valuenow="24"
                                                        aria-valuemin="0"
                                                        aria-valuemax="100"></div>
                                            </div>
                                            <small class="w-px-20 text-end">40</small>
                                        </div>
                                        <div class="d-flex align-items-center gap-2">
                                            <small>3 Star</small>
                                            <div class="progress w-100 bg-label-primary rounded-pill" style="height: 8px">
                                                <div
                                                        class="progress-bar bg-primary"
                                                        role="progressbar"
                                                        style="width: 12%"
                                                        aria-valuenow="12"
                                                        aria-valuemin="0"
                                                        aria-valuemax="100"></div>
                                            </div>
                                            <small class="w-px-20 text-end">12</small>
                                        </div>
                                        <div class="d-flex align-items-center gap-2">
                                            <small>2 Star</small>
                                            <div class="progress w-100 bg-label-primary rounded-pill" style="height: 8px">
                                                <div
                                                        class="progress-bar bg-primary"
                                                        role="progressbar"
                                                        style="width: 7%"
                                                        aria-valuenow="7"
                                                        aria-valuemin="0"
                                                        aria-valuemax="100"></div>
                                            </div>
                                            <small class="w-px-20 text-end">7</small>
                                        </div>
                                        <div class="d-flex align-items-center gap-2">
                                            <small>1 Star</small>
                                            <div class="progress w-100 bg-label-primary rounded-pill" style="height: 8px">
                                                <div
                                                        class="progress-bar bg-primary"
                                                        role="progressbar"
                                                        style="width: 2%"
                                                        aria-valuenow="2"
                                                        aria-valuemin="0"
                                                        aria-valuemax="100"></div>
                                            </div>
                                            <small class="w-px-20 text-end">2</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card h-100">
                                <div class="card-body row">
                                    <div class="col-sm-5">
                                        <div class="mb-12">
                                            <h5 class="mb-2 text-nowrap">Reviews statistics</h5>
                                            <p class="mb-0">
                                                <span class="me-2">12 New reviews</span>
                                                <span class="badge bg-label-success rounded-pill">+8.4%</span>
                                            </p>
                                        </div>

                                        <div>
                                            <h6 class="mb-2 fw-normal"><span class="text-success me-1">87%</span>Positive reviews</h6>
                                            <small>Weekly Report</small>
                                        </div>
                                    </div>
                                    <div class="col-sm-7 d-flex justify-content-end align-items-end">
                                        <div id="reviewsChart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- review List Table -->
                    <div class="card">
                        <div class="card-datatable table-responsive">
                            <table class="datatables-review table">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <th>Product</th>
                                    <th class="text-nowrap">Reviewer</th>
                                    <th>Review</th>
                                    <th>Date</th>
                                    <th class="text-nowrap">Status</th>
                                    <th>Actions</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- / Content -->

                <!-- Footer -->
                <jsp:include page="../layout/footer.jsp" />
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

<script src="${adminAssetsPath}/vendor/libs/jquery/jquery.js"></script>

<script src="${adminAssetsPath}/vendor/libs/popper/popper.js"></script>
<script src="${adminAssetsPath}/vendor/js/bootstrap.js"></script>
<script src="${adminAssetsPath}/vendor/libs/node-waves/node-waves.js"></script>

<script src="${adminAssetsPath}/vendor/libs/@algolia/autocomplete-js.js"></script>

<script src="${adminAssetsPath}/vendor/libs/pickr/pickr.js"></script>

<script src="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

<script src="${adminAssetsPath}/vendor/libs/hammer/hammer.js"></script>

<script src="${adminAssetsPath}/vendor/libs/i18n/i18n.js"></script>

<script src="${adminAssetsPath}/vendor/js/menu.js"></script>

<!-- endbuild -->

<!-- Vendors JS -->
<script src="${adminAssetsPath}/vendor/libs/moment/moment.js"></script>
<script src="${adminAssetsPath}/vendor/libs/datatables-bs5/datatables-bootstrap5.js"></script>
<script src="${adminAssetsPath}/vendor/libs/apex-charts/apexcharts.js"></script>
<script src="${adminAssetsPath}/vendor/libs/raty-js/raty-js.js"></script>

<!-- Main JS -->

<script src="${adminAssetsPath}/js/main.js"></script>

<!-- Page JS -->
<script src="${adminAssetsPath}/js/app-ecommerce-reviews.js"></script>
</body>
</html>





