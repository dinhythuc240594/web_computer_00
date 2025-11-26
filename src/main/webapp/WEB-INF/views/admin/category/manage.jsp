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
    <title>Demo: eCommerce Category List - Apps | Materialize - Bootstrap Dashboard PRO</title>

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

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/pickr/pickr-themes.css" />

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/css/core.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/css/demo.css" />

    <!-- Vendors CSS -->

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- endbuild -->

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/datatables-bs5/datatables.bootstrap5.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/select2/select2.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/@form-validation/form-validation.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/quill/typography.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/quill/katex.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/quill/editor.css" />

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
                    <div class="app-ecommerce-category">
                        <!-- Category List Table -->
                        <div class="card">
                            <div class="card-datatable table-responsive">
                                <table class="datatables-category-list table">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th></th>
                                        <th>Categories</th>
                                        <th class="text-nowrap text-sm-end">Total Products &nbsp;</th>
                                        <th class="text-nowrap text-sm-end">Total Earning</th>
                                        <th class="text-lg-center">Actions</th>
                                    </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                        <!-- Offcanvas to add new customer -->
                        <div
                                class="offcanvas offcanvas-end"
                                tabindex="-1"
                                id="offcanvasEcommerceCategoryList"
                                aria-labelledby="offcanvasEcommerceCategoryListLabel">
                            <!-- Offcanvas Header -->
                            <div class="offcanvas-header">
                                <h5 id="offcanvasEcommerceCategoryListLabel" class="offcanvas-title">Add Category</h5>
                                <button
                                        type="button"
                                        class="btn-close text-reset"
                                        data-bs-dismiss="offcanvas"
                                        aria-label="Close"></button>
                            </div>
                            <!-- Offcanvas Body -->
                            <div class="offcanvas-body border-top">
                                <form class="pt-0" id="eCommerceCategoryListForm" onsubmit="return false">
                                    <!-- Title -->

                                    <div class="form-floating form-floating-outline mb-5 form-control-validation">
                                        <input
                                                type="text"
                                                class="form-control"
                                                id="ecommerce-category-title"
                                                placeholder="Enter category title"
                                                name="categoryTitle"
                                                aria-label="category title" />
                                        <label for="ecommerce-category-title">Title</label>
                                    </div>

                                    <!-- Slug -->
                                    <div class="form-floating form-floating-outline mb-5 form-control-validation">
                                        <input
                                                type="text"
                                                id="ecommerce-category-slug"
                                                class="form-control"
                                                placeholder="Enter slug"
                                                aria-label="slug"
                                                name="slug" />
                                        <label for="ecommerce-category-slug">Slug</label>
                                    </div>

                                    <!-- Image -->
                                    <div class="form-floating form-floating-outline mb-5">
                                        <input class="form-control" type="file" id="ecommerce-category-image" />
                                        <label for="ecommerce-category-image">Attachment</label>
                                    </div>
                                    <!-- Parent category -->
                                    <div class="mb-5 ecommerce-select2-dropdown">
                                        <div class="form-floating form-floating-outline">
                                            <select
                                                    id="ecommerce-category-parent-category"
                                                    class="select2 form-select"
                                                    data-placeholder="Select parent category"
                                                    data-allow-clear="true">
                                                <option value="">Select parent Category</option>
                                                <option value="Household">Household</option>
                                                <option value="Management">Management</option>
                                                <option value="Electronics">Electronics</option>
                                                <option value="Office">Office</option>
                                                <option value="Automotive">Automotive</option>
                                            </select>
                                            <label for="ecommerce-category-parent-category">Parent category</label>
                                        </div>
                                    </div>
                                    <!-- Description -->
                                    <div class="mb-5">
                                        <div class="form-control p-0 pt-1">
                                            <div class="comment-editor border-0" id="ecommerce-category-description"></div>
                                            <div class="comment-toolbar border-0 rounded">
                                                <div class="d-flex justify-content-end">
                              <span class="ql-formats me-0">
                                <button class="ql-bold"></button>
                                <button class="ql-italic"></button>
                                <button class="ql-underline"></button>
                                <button class="ql-list" value="ordered"></button>
                                <button class="ql-list" value="bullet"></button>
                                <button class="ql-link"></button>
                                <button class="ql-image"></button>
                              </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Status -->
                                    <div class="mb-5 ecommerce-select2-dropdown">
                                        <div class="form-floating form-floating-outline">
                                            <select
                                                    id="ecommerce-category-status"
                                                    class="select2 form-select"
                                                    data-placeholder="Select category status">
                                                <option value="">Select category status</option>
                                                <option value="Scheduled">Scheduled</option>
                                                <option value="Publish">Publish</option>
                                                <option value="Inactive">Inactive</option>
                                            </select>
                                            <label for="ecommerce-category-status">Parent status</label>
                                        </div>
                                    </div>
                                    <!-- Submit and reset -->
                                    <div>
                                        <button type="submit" class="btn btn-primary me-3 data-submit">Add</button>
                                        <button type="reset" class="btn btn-outline-danger" data-bs-dismiss="offcanvas">Discard</button>
                                    </div>
                                </form>
                            </div>
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
                                , made with â¤ï¸ by
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
<script src="${adminAssetsPath}/vendor/libs/select2/select2.js"></script>
<script src="${adminAssetsPath}/vendor/libs/@form-validation/popular.js"></script>
<script src="${adminAssetsPath}/vendor/libs/@form-validation/bootstrap5.js"></script>
<script src="${adminAssetsPath}/vendor/libs/@form-validation/auto-focus.js"></script>
<script src="${adminAssetsPath}/vendor/libs/quill/katex.js"></script>
<script src="${adminAssetsPath}/vendor/libs/quill/quill.js"></script>

<!-- Main JS -->

<script src="${adminAssetsPath}/js/main.js"></script>

<!-- Page JS -->
<script src="${adminAssetsPath}/js/app-ecommerce-category-list.js"></script>
</body>
</html>


