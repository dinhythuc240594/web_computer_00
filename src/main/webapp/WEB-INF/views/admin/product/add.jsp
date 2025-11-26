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
    <title>Demo: eCommerce Add Product - Apps | Materialize - Bootstrap Dashboard PRO</title>

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

    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/quill/typography.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/quill/katex.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/quill/editor.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/select2/select2.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/dropzone/dropzone.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/flatpickr/flatpickr.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/tagify/tagify.css" />

    <!-- Page CSS -->

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
                    <div class="app-ecommerce">
                        <!-- Add Product -->
                        <div
                                class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-6 row-gap-4">
                            <div class="d-flex flex-column justify-content-center">
                                <h4 class="mb-1">Add a new Product</h4>
                                <p class="mb-0">Orders placed across your store</p>
                            </div>
                            <div class="d-flex align-content-center flex-wrap gap-4">
                                <button class="btn btn-outline-secondary">Discard</button>
                                <button class="btn btn-outline-primary">Save draft</button>
                                <button type="submit" class="btn btn-primary">Publish product</button>
                            </div>
                        </div>

                        <div class="row">
                            <!-- First column-->
                            <div class="col-12 col-lg-8">
                                <!-- Product Information -->
                                <div class="card mb-6">
                                    <div class="card-header">
                                        <h5 class="card-tile mb-0">Product information</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="form-floating form-floating-outline mb-5">
                                            <input
                                                    type="text"
                                                    class="form-control"
                                                    id="ecommerce-product-name"
                                                    placeholder="Product title"
                                                    name="productTitle"
                                                    aria-label="Product title" />
                                            <label for="ecommerce-product-name">Name</label>
                                        </div>

                                        <div class="row gx-5 mb-5">
                                            <div class="col">
                                                <div class="form-floating form-floating-outline">
                                                    <input
                                                            type="number"
                                                            class="form-control"
                                                            id="ecommerce-product-sku"
                                                            placeholder="00000"
                                                            name="productSku"
                                                            aria-label="Product SKU" />
                                                    <label for="ecommerce-product-sku">SKU</label>
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div class="form-floating form-floating-outline">
                                                    <input
                                                            type="text"
                                                            class="form-control"
                                                            id="ecommerce-product-barcode"
                                                            placeholder="0123-4567"
                                                            name="productBarcode"
                                                            aria-label="Product barcode" />
                                                    <label for="ecommerce-product-name">Barcode</label>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Comment -->
                                        <div>
                                            <p class="mb-1">Description (Optional)</p>
                                            <div class="form-control p-0 pt-1">
                                                <div class="comment-toolbar border-0 border-bottom">
                                                    <div class="d-flex justify-content-start">
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
                                                <div class="comment-editor border-0 pb-1" id="ecommerce-category-description"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Product Information -->
                                <!-- Media -->
                                <div class="card mb-6">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0 card-title">Product Image</h5>
                                        <a href="javascript:void(0);" class="fw-medium">Add media from URL</a>
                                    </div>
                                    <div class="card-body">
                                        <form action="/upload" class="dropzone needsclick" id="dropzone-basic">
                                            <div class="dz-message needsclick my-12">
                                                <div class="d-flex justify-content-center">
                                                    <div class="avatar">
                                <span class="avatar-initial rounded-3 bg-label-secondary">
                                  <i class="icon-base ri ri-upload-2-line icon-24px"></i>
                                </span>
                                                    </div>
                                                </div>
                                                <p class="h4 needsclick my-2">Drag and drop your image here</p>
                                                <small class="note text-body-secondary d-block fs-6 my-2">or</small>
                                                <span class="needsclick btn btn-sm btn-outline-primary" id="btnBrowse">Browse image</span>
                                            </div>
                                            <div class="fallback">
                                                <input name="file" type="file" />
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <!-- /Media -->
                                <!-- Variants -->
                                <div class="card mb-6">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Variants</h5>
                                    </div>
                                    <div class="card-body">
                                        <form class="form-repeater">
                                            <div data-repeater-list="group-a">
                                                <div data-repeater-item>
                                                    <div class="row gx-5">
                                                        <div class="mb-6 col-sm-4">
                                                            <div class="form-floating form-floating-outline">
                                                                <select
                                                                        id="select2Basic"
                                                                        class="form-select form-select-sm"
                                                                        data-placeholder="Option"
                                                                        data-allow-clear="true">
                                                                    <option value="size" selected>Size</option>
                                                                    <option value="color">Color</option>
                                                                    <option value="weight">Weight</option>
                                                                    <option value="smell">Smell</option>
                                                                </select>
                                                                <label for="select2Basic">Option</label>
                                                            </div>
                                                        </div>
                                                        <div class="mb-6 col-sm-8">
                                                            <div class="form-floating form-floating-outline">
                                                                <input
                                                                        type="text"
                                                                        id="form-repeater-1-2"
                                                                        class="form-control"
                                                                        placeholder="Enter size" />
                                                                <label for="form-repeater-1-2">Value</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div>
                                                <button class="btn btn-primary" data-repeater-create>
                                                    <i class="icon-base ri ri-add-line icon-16px me-2"></i>
                                                    Add another option
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <!-- /Variants -->
                                <!-- Inventory -->
                                <div class="card mb-6">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Inventory</h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <!-- Navigation -->
                                            <div class="col-12 col-md-4 mx-auto card-separator">
                                                <div class="nav-align-left d-flex justify-content-between flex-column mb-4 mb-md-0 pe-md-3">
                                                    <ul class="nav nav-pills flex-column">
                                                        <li class="nav-item">
                                                            <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#restock">
                                                                <i class="icon-base ri ri-add-line icon-sm me-2"></i>
                                                                <span class="align-middle">Restock</span>
                                                            </button>
                                                        </li>
                                                        <li class="nav-item">
                                                            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#shipping">
                                                                <i class="icon-base ri ri-car-line icon-sm me-2"></i>
                                                                <span class="align-middle">Shipping</span>
                                                            </button>
                                                        </li>
                                                        <li class="nav-item">
                                                            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#global-delivery">
                                                                <i class="icon-base ri ri-global-line icon-sm me-2"></i>
                                                                <span class="align-middle">Global Delivery</span>
                                                            </button>
                                                        </li>
                                                        <li class="nav-item">
                                                            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#attributes">
                                                                <i class="icon-base ri ri-link-m icon-sm me-2"></i>
                                                                <span class="align-middle">Attributes</span>
                                                            </button>
                                                        </li>
                                                        <li class="nav-item">
                                                            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#advanced">
                                                                <i class="icon-base ri ri-lock-unlock-line icon-sm me-2"></i>
                                                                <span class="align-middle">Advanced</span>
                                                            </button>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <!-- /Navigation -->
                                            <!-- Options -->
                                            <div class="col-12 col-md-8 pt-6 pt-md-0">
                                                <div class="tab-content p-0 pe-xl-0 ps-md-4">
                                                    <!-- Restock Tab -->
                                                    <div class="tab-pane fade show active" id="restock" role="tabpanel">
                                                        <h6 class="text-body">Options</h6>
                                                        <div class="row mb-4 g-4">
                                                            <div class="col-12 col-sm-8 col-lg-12 col-xxl-8">
                                                                <div class="form-floating form-floating-outline">
                                                                    <input
                                                                            type="number"
                                                                            class="form-control form-control-sm"
                                                                            id="ecommerce-product-stock"
                                                                            placeholder="Quantity"
                                                                            name="quantity"
                                                                            aria-label="Quantity" />
                                                                    <label for="ecommerce-product-stock">Add to Stock</label>
                                                                </div>
                                                            </div>
                                                            <div class="col-6 col-sm-4 col-lg-6 col-xxl-4">
                                                                <button class="btn btn-primary">
                                                                    <i class="icon-base ri ri-check-line icon-16px me-2"></i>Confirm
                                                                </button>
                                                            </div>
                                                        </div>
                                                        <div>
                                                            <h6 class="mb-2 fw-normal">
                                                                Product in stock now: <span class="fw-medium">54</span>
                                                            </h6>
                                                            <h6 class="mb-2 fw-normal">Product in transit: <span class="fw-medium">390</span></h6>
                                                            <h6 class="mb-2 fw-normal">
                                                                Last time restocked: <span class="fw-medium">24th June, 2023</span>
                                                            </h6>
                                                            <h6 class="mb-0 fw-normal">
                                                                Total stock over lifetime: <span class="fw-medium">2430</span>
                                                            </h6>
                                                        </div>
                                                    </div>
                                                    <!-- Shipping Tab -->
                                                    <div class="tab-pane fade" id="shipping" role="tabpanel">
                                                        <h6 class="mb-3 text-body">Shipping Type</h6>
                                                        <div>
                                                            <div class="form-check mb-4">
                                                                <input class="form-check-input" type="radio" name="shippingType" id="seller" />
                                                                <label class="form-check-label d-flex flex-column gap-1" for="seller">
                                                                    <span class="h6 mb-0">Fulfilled by Seller</span>
                                                                    <small
                                                                    >You'll be responsible for product delivery. Any damage or delay during shipping
                                                                        may cost you a Damage fee.</small
                                                                    >
                                                                </label>
                                                            </div>
                                                            <div class="form-check mb-6">
                                                                <input
                                                                        class="form-check-input"
                                                                        type="radio"
                                                                        name="shippingType"
                                                                        id="companyName"
                                                                        checked />
                                                                <label class="form-check-label d-flex flex-column gap-1" for="companyName">
                                      <span class="h6 mb-0"
                                      >Fulfilled by Company name &nbsp;<span
                                              class="badge rounded-pill rounded-2 badge-warning bg-label-warning fs-tiny py-1"
                                      >RECOMMENDED</span
                                      ></span
                                      >
                                                                    <small
                                                                    >Your product, Our responsibility. For a measly fee, we will handle the delivery
                                                                        process for you.</small
                                                                    >
                                                                </label>
                                                            </div>
                                                            <p class="mb-0">
                                                                See our <a href="javascript:void(0);">Delivery terms and conditions</a> for details
                                                            </p>
                                                        </div>
                                                    </div>
                                                    <!-- Global Delivery Tab -->
                                                    <div class="tab-pane fade" id="global-delivery" role="tabpanel">
                                                        <h6 class="mb-3 text-body">Global Delivery</h6>
                                                        <!-- Worldwide delivery -->
                                                        <div class="form-check mb-4">
                                                            <input class="form-check-input" type="radio" name="globalDel" id="worldwide" />
                                                            <label class="form-check-label d-flex flex-column gap-1" for="worldwide">
                                                                <span class="h6 mb-0">Worldwide delivery</span>
                                                                <small
                                                                >Only available with Shipping method:
                                                                    <a href="javascript:void(0);">Fulfilled by Company name</a></small
                                                                >
                                                            </label>
                                                        </div>
                                                        <!-- Global delivery -->
                                                        <div class="form-check mb-4">
                                                            <input class="form-check-input" type="radio" name="globalDel" checked />
                                                            <label class="form-check-label w-75 pe-12 mb-3" for="country-selected">
                                                                <span class="h6">Selected Countries</span>
                                                            </label>
                                                            <div class="form-floating form-floating-outline">
                                                                <input
                                                                        type="text"
                                                                        class="form-control form-control-sm"
                                                                        placeholder="Type Country name"
                                                                        id="country-selected" />
                                                                <label for="ecommerce-product-name">Countries</label>
                                                            </div>
                                                        </div>
                                                        <!-- Local delivery -->
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="globalDel" id="local" />
                                                            <label class="form-check-label d-flex flex-column gap-1" for="local">
                                                                <span class="h6 mb-0">Local delivery</span>
                                                                <small
                                                                >Deliver to your country of residence :
                                                                    <a href="javascript:void(0);">Change profile address</a></small
                                                                >
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <!-- Attributes Tab -->
                                                    <div class="tab-pane fade" id="attributes" role="tabpanel">
                                                        <h6 class="mb-2 text-body">Attributes</h6>
                                                        <div>
                                                            <!-- Fragile Product -->
                                                            <div class="form-check mb-4">
                                                                <input class="form-check-input" type="checkbox" value="fragile" id="fragile" />
                                                                <label class="form-check-label" for="fragile">
                                                                    <span>Fragile Product</span>
                                                                </label>
                                                            </div>
                                                            <!-- Biodegradable -->
                                                            <div class="form-check mb-4">
                                                                <input
                                                                        class="form-check-input"
                                                                        type="checkbox"
                                                                        value="biodegradable"
                                                                        id="biodegradable" />
                                                                <label class="form-check-label" for="biodegradable">
                                                                    <span>Biodegradable</span>
                                                                </label>
                                                            </div>
                                                            <!-- Frozen Product -->
                                                            <div class="form-check mb-4">
                                                                <input
                                                                        class="form-check-input"
                                                                        type="checkbox"
                                                                        id="frozen"
                                                                        value="frozen"
                                                                        checked />
                                                                <label class="form-check-label w-75 pe-12 mb-3" for="frozen">
                                                                    <span class="mb-1">Frozen Product</span>
                                                                </label>
                                                                <div class="form-floating form-floating-outline">
                                                                    <input
                                                                            type="number"
                                                                            class="form-control form-control-sm"
                                                                            placeholder="In Celsius"
                                                                            id="temp" />
                                                                    <label for="temp">Max. allowed Temperature</label>
                                                                </div>
                                                            </div>
                                                            <!-- Exp Date -->
                                                            <div class="form-check">
                                                                <input
                                                                        class="form-check-input"
                                                                        type="checkbox"
                                                                        value="expDate"
                                                                        id="expDate"
                                                                        checked />
                                                                <label class="form-check-label w-75 pe-12 mb-3" for="expDate">
                                                                    <span class="mb-1">Expiry Date of Product</span>
                                                                </label>
                                                                <div class="form-floating form-floating-outline">
                                                                    <input type="date" class="product-date form-control" id="flatpickr-date" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- /Attributes Tab -->
                                                    <!-- Advanced Tab -->
                                                    <div class="tab-pane fade" id="advanced" role="tabpanel">
                                                        <h6 class="mb-3 text-body">Advanced</h6>
                                                        <div class="row">
                                                            <!-- Product Id Type -->
                                                            <div class="col">
                                                                <h6 class="mb-2">Product ID Type</h6>
                                                                <div class="form-floating form-floating-outline">
                                                                    <select
                                                                            id="product-id"
                                                                            class="form-select form-select-sm"
                                                                            data-placeholder="ISBN"
                                                                            data-allow-clear="true">
                                                                        <option value="">ISBN</option>
                                                                        <option value="ISBN">ISBN</option>
                                                                        <option value="UPC">UPC</option>
                                                                        <option value="EAN">EAN</option>
                                                                        <option value="JAN">JAN</option>
                                                                    </select>
                                                                    <label for="product-id">Id</label>
                                                                </div>
                                                            </div>
                                                            <!-- Product Id -->
                                                            <div class="col">
                                                                <h6 class="mb-2">Product ID</h6>
                                                                <div class="form-floating form-floating-outline">
                                                                    <input
                                                                            type="number"
                                                                            id="product-id-1"
                                                                            class="form-control form-control-sm"
                                                                            placeholder="ISBN Number" />
                                                                    <label for="product-id-1">Id Number</label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- /Advanced Tab -->
                                                </div>
                                            </div>
                                            <!-- /Options-->
                                        </div>
                                    </div>
                                </div>
                                <!-- /Inventory -->
                            </div>
                            <!-- /Second column -->

                            <!-- Second column -->
                            <div class="col-12 col-lg-4">
                                <!-- Pricing Card -->
                                <div class="card mb-6">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Pricing</h5>
                                    </div>
                                    <div class="card-body">
                                        <!-- Base Price -->
                                        <div class="form-floating form-floating-outline mb-5">
                                            <input
                                                    type="number"
                                                    class="form-control"
                                                    id="ecommerce-product-price"
                                                    placeholder="Price"
                                                    name="productPrice"
                                                    aria-label="Product price" />
                                            <label for="ecommerce-product-price">Best Price</label>
                                        </div>

                                        <!-- Discounted Price -->
                                        <div class="form-floating form-floating-outline mb-5">
                                            <input
                                                    type="number"
                                                    class="form-control"
                                                    id="ecommerce-product-discount-price"
                                                    placeholder="Discounted Price"
                                                    name="productDiscountedPrice"
                                                    aria-label="Product discounted price" />
                                            <label for="ecommerce-product-discount-price">Discounted Price</label>
                                        </div>
                                        <!-- Charge tax check box -->
                                        <div class="form-check m-2 me-0 pb-2">
                                            <input class="form-check-input" type="checkbox" value="" id="price-charge-tax" checked />
                                            <label class="form-check-label" for="price-charge-tax"> Charge tax on this product </label>
                                        </div>
                                        <!-- Instock switch -->
                                        <div class="d-flex justify-content-between align-items-center border-top pt-4">
                                            <p class="mb-0">In stock</p>
                                            <div class="w-25 d-flex justify-content-end">
                                                <div class="form-check form-switch me-n3 mb-0">
                                                    <input type="checkbox" class="form-check-input" checked />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Pricing Card -->
                                <!-- Organize Card -->
                                <div class="card mb-6">
                                    <div class="card-header">
                                        <h5 class="card-title mb-0">Organize</h5>
                                    </div>
                                    <div class="card-body">
                                        <!-- Vendor -->
                                        <div class="mb-5 col ecommerce-select2-dropdown">
                                            <div class="form-floating form-floating-outline">
                                                <select id="vendor" class="form-select form-select-sm" data-placeholder="Select Vendor">
                                                    <option value="">Select Vendor</option>
                                                    <option value="men-clothing">Men's Clothing</option>
                                                    <option value="women-clothing">Women's-clothing</option>
                                                    <option value="kid-clothing">Kid's-clothing</option>
                                                </select>
                                                <label for="vendor">Vendor</label>
                                            </div>
                                        </div>
                                        <!-- Category -->
                                        <div
                                                class="mb-5 col ecommerce-select2-dropdown d-flex justify-content-between align-items-center">
                                            <div class="form-floating form-floating-outline w-100 me-4">
                                                <select
                                                        id="category-org"
                                                        class="form-select form-select-sm"
                                                        data-placeholder="Select Category">
                                                    <option value="">Select Category</option>
                                                    <option value="Household">Household</option>
                                                    <option value="Management">Management</option>
                                                    <option value="Electronics">Electronics</option>
                                                    <option value="Office">Office</option>
                                                    <option value="Automotive">Automotive</option>
                                                </select>
                                                <label for="category-org">Category</label>
                                            </div>
                                            <div>
                                                <button class="btn btn-outline-primary btn-icon">
                                                    <i class="icon-base ri ri-add-line"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <!-- Collection -->
                                        <div class="mb-5 col ecommerce-select2-dropdown">
                                            <div class="form-floating form-floating-outline">
                                                <select id="collection" class="form-select form-select-sm" data-placeholder="Collection">
                                                    <option value="">Collection</option>
                                                    <option value="men-clothing">Men's Clothing</option>
                                                    <option value="women-clothing">Women's-clothing</option>
                                                    <option value="kid-clothing">Kid's-clothing</option>
                                                </select>
                                                <label for="collection">Collection</label>
                                            </div>
                                        </div>
                                        <!-- Status -->
                                        <div class="mb-5 col ecommerce-select2-dropdown">
                                            <div class="form-floating form-floating-outline">
                                                <select id="status-org" class="form-select form-select-sm" data-placeholder="Select Status">
                                                    <option value="">Select Status</option>
                                                    <option value="Published">Published</option>
                                                    <option value="Scheduled">Scheduled</option>
                                                    <option value="Inactive">Inactive</option>
                                                </select>
                                                <label for="status-org">Status</label>
                                            </div>
                                        </div>
                                        <!-- Tags -->
                                        <div>
                                            <div class="form-floating form-floating-outline">
                                                <input
                                                        id="ecommerce-product-tags"
                                                        class="form-control h-auto"
                                                        name="ecommerce-product-tags"
                                                        value="Normal,Standard,Premium"
                                                        aria-label="Product Tags" />
                                                <label for="ecommerce-product-tags">Tags</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Organize Card -->
                            </div>
                            <!-- /Second column -->
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
<script src="${adminAssetsPath}/vendor/libs/quill/katex.js"></script>
<script src="${adminAssetsPath}/vendor/libs/quill/quill.js"></script>
<script src="${adminAssetsPath}/vendor/libs/select2/select2.js"></script>
<script src="${adminAssetsPath}/vendor/libs/dropzone/dropzone.js"></script>
<script src="${adminAssetsPath}/vendor/libs/jquery-repeater/jquery-repeater.js"></script>
<script src="${adminAssetsPath}/vendor/libs/flatpickr/flatpickr.js"></script>
<script src="${adminAssetsPath}/vendor/libs/tagify/tagify.js"></script>

<!-- Main JS -->

<script src="${adminAssetsPath}/js/main.js"></script>

<!-- Page JS -->
<script src="${adminAssetsPath}/js/app-ecommerce-product-add.js"></script>
</body>
</html>

