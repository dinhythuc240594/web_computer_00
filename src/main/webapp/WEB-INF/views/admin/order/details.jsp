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
    <title>Demo: Order Details - eCommerce | Materialize - Bootstrap Dashboard PRO</title>

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
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/tagify/tagify.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/sweetalert2/sweetalert2.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/@form-validation/form-validation.css" />
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/select2/select2.css" />

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
                    <div
                            class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-6 gap-6">
                        <div class="d-flex flex-column justify-content-center">
                            <div class="d-flex align-items-center mb-1">
                                <h5 class="mb-0">Order #${order.id}</h5>
                                <span class="badge bg-label-info me-2 ms-2 rounded-pill">
                                    ${order.status}
                                </span>
                            </div>
                            <p class="mb-0">
                                Ngày đặt: ${order.orderDate}
                            </p>
                        </div>
                        <!-- <div class="d-flex align-content-center flex-wrap gap-2">
                            <button class="btn btn-outline-danger delete-order">Delete Order</button>
                        </div> -->
                    </div>

                    <!-- Order Details Table -->

                    <div class="row">
                        <div class="col-12 col-lg-8">
                            <div class="card mb-6">
                                <div class="card-datatable">
                                    <table class="datatables-order-details table mb-0">
                                        <thead>
                                        <tr>
                                            <th></th>
                                            <th></th>
                                            <th class="w-50">products</th>
                                            <th>price</th>
                                            <th>qty</th>
                                            <th>total</th>
                                        </tr>
                                        </thead>
                                    </table>
                                    <div class="d-flex justify-content-end align-items-center m-4 p-1 mb-0 pb-0">
                                        <div class="order-calculations">
                                            <div class="d-flex justify-content-start gap-4">
                                                <span class="w-px-100 text-heading">Subtotal:</span>
                                                <h6 class="mb-0">${order.totalPrice}</h6>
                                            </div>
                                            <div class="d-flex justify-content-start gap-4">
                                                <span class="w-px-100 text-heading">Discount:</span>
                                                <h6 class="mb-0">0</h6>
                                            </div>
                                            <div class="d-flex justify-content-start gap-4">
                                                <span class="w-px-100 text-heading">Tax:</span>
                                                <h6 class="mb-0">0</h6>
                                            </div>
                                            <div class="d-flex justify-content-start gap-4">
                                                <h6 class="w-px-100 mb-0">Total:</h6>
                                                <h6 class="mb-0">${order.totalPrice}</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card mb-6">
                                <div class="card-header">
                                    <h5 class="card-title m-0">Shipping activity</h5>
                                </div>
                                <div class="card-body mt-3">
                                    <ul class="timeline pb-0 mb-0">
                                        <li class="timeline-item timeline-item-transparent border-primary">
                                            <span class="timeline-point timeline-point-primary"></span>
                                            <div class="timeline-event">
                                                <div class="timeline-header mb-2">
                                                    <h6 class="mb-0">Order was placed (Order ID: #32543)</h6>
                                                    <small class="text-body-secondary">Tuesday 11:29 AM</small>
                                                </div>
                                                <p class="mt-1 mb-2">Your order has been placed successfully</p>
                                            </div>
                                        </li>
                                        <li class="timeline-item timeline-item-transparent border-primary">
                                            <span class="timeline-point timeline-point-primary"></span>
                                            <div class="timeline-event">
                                                <div class="timeline-header mb-2">
                                                    <h6 class="mb-0">Pick-up</h6>
                                                    <small class="text-body-secondary">Wednesday 11:29 AM</small>
                                                </div>
                                                <p class="mt-1 mb-2">Pick-up scheduled with courier</p>
                                            </div>
                                        </li>
                                        <li class="timeline-item timeline-item-transparent border-primary">
                                            <span class="timeline-point timeline-point-primary"></span>
                                            <div class="timeline-event">
                                                <div class="timeline-header mb-2">
                                                    <h6 class="mb-0">Dispatched</h6>
                                                    <small class="text-body-secondary">Thursday 11:29 AM</small>
                                                </div>
                                                <p class="mt-1 mb-2">Item has been picked up by courier</p>
                                            </div>
                                        </li>
                                        <li class="timeline-item timeline-item-transparent border-primary">
                                            <span class="timeline-point timeline-point-primary"></span>
                                            <div class="timeline-event">
                                                <div class="timeline-header mb-2">
                                                    <h6 class="mb-0">Package arrived</h6>
                                                    <small class="text-body-secondary">Saturday 15:20 AM</small>
                                                </div>
                                                <p class="mt-1 mb-2">Package arrived at an Amazon facility, NY</p>
                                            </div>
                                        </li>
                                        <li class="timeline-item timeline-item-transparent border-dashed">
                                            <span class="timeline-point timeline-point-primary"></span>
                                            <div class="timeline-event">
                                                <div class="timeline-header mb-2">
                                                    <h6 class="mb-0">Dispatched for delivery</h6>
                                                    <small class="text-body-secondary">Today 14:12 PM</small>
                                                </div>
                                                <p class="mt-1 mb-2">Package has left an Amazon facility, NY</p>
                                            </div>
                                        </li>
                                        <li class="timeline-item timeline-item-transparent border-transparent pb-0">
                                            <span class="timeline-point timeline-point-primary"></span>
                                            <div class="timeline-event pb-0">
                                                <div class="timeline-header mb-2">
                                                    <h6 class="mb-0">Delivery</h6>
                                                </div>
                                                <p class="mt-1 mb-2">Package will be delivered by tomorrow</p>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-lg-4">
                            <div class="card mb-6">
                                <div class="card-body">
                                    <h5 class="card-title mb-6">Customer details</h5>
                                    <div class="d-flex justify-content-start align-items-center mb-6">
                                        <div class="avatar me-3">
                                            <img src="${adminAssetsPath}/img/avatars/1.png" alt="Avatar" class="rounded-circle" />
                                        </div>
                                        <div class="d-flex flex-column">
                                            <a href="app-user-view-account.html">
                                                <h6 class="mb-0">Shamus Tuttle</h6>
                                            </a>
                                            <span>Customer ID: #58909</span>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-start align-items-center mb-6">
                        <span
                                class="avatar rounded-circle bg-label-success me-3 d-flex align-items-center justify-content-center"
                        ><i class="icon-base ri ri-shopping-cart-line icon-24px"></i
                        ></span>
                                        <h6 class="text-nowrap mb-0">12 Orders</h6>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <h6 class="mb-1">Contact info</h6>
                                        <h6 class="mb-1">
                                            <a href="" data-bs-toggle="modal" data-bs-target="#editUser">Edit</a>
                                        </h6>
                                    </div>
                                    <p class="mb-1">Email: Shamus889@yahoo.com</p>
                                    <p class="mb-0">Mobile: +1 (609) 972-22-22</p>
                                </div>
                            </div>

                            <div class="card mb-6">
                                <div class="card-header d-flex justify-content-between">
                                    <h5 class="card-title mb-1">Shipping address</h5>
                                    <h6 class="m-0">
                                        <a href="" data-bs-toggle="modal" data-bs-target="#addNewAddress">Edit</a>
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <p class="mb-0">
                                        ${order.address}
                                    </p>
                                </div>
                            </div>
                            <div class="card mb-6">
                                <div class="card-header d-flex justify-content-between pb-0">
                                    <h5 class="card-title mb-1">Billing address</h5>
                                    <h6 class="m-0">
                                        <a href="" data-bs-toggle="modal" data-bs-target="#addNewAddress">Edit</a>
                                    </h6>
                                </div>
                                <div class="card-body">
                                    <p class="mb-6">
                                        ${order.address}
                                    </p>
                                    <h5 class="mb-1">${order.payment}</h5>
                                    <p class="mb-0">${order.note}</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Edit User Modal -->
                    <!-- <div class="modal fade" id="editUser" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-lg modal-simple modal-edit-user">
                            <div class="modal-content">
                                <div class="modal-body p-0">
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    <div class="text-center mb-6">
                                        <h4 class="mb-2">Edit User Information</h4>
                                        <p class="mb-6">Updating user details will receive a privacy audit.</p>
                                    </div>
                                    <form id="editUserForm" class="row g-5" onsubmit="return false">
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline">
                                                <input
                                                        type="text"
                                                        id="modalEditUserFirstName"
                                                        name="modalEditUserFirstName"
                                                        class="form-control"
                                                        value="Oliver"
                                                        placeholder="Oliver" />
                                                <label for="modalEditUserFirstName">First Name</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline">
                                                <input
                                                        type="text"
                                                        id="modalEditUserLastName"
                                                        name="modalEditUserLastName"
                                                        class="form-control"
                                                        value="Queen"
                                                        placeholder="Queen" />
                                                <label for="modalEditUserLastName">Last Name</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating form-floating-outline">
                                                <input
                                                        type="text"
                                                        id="modalEditUserName"
                                                        name="modalEditUserName"
                                                        class="form-control"
                                                        value="oliver.queen"
                                                        placeholder="oliver.queen" />
                                                <label for="modalEditUserName">Username</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline">
                                                <input
                                                        type="text"
                                                        id="modalEditUserEmail"
                                                        name="modalEditUserEmail"
                                                        class="form-control"
                                                        value="oliverqueen@gmail.com"
                                                        placeholder="oliverqueen@gmail.com" />
                                                <label for="modalEditUserEmail">Email</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline">
                                                <select
                                                        id="modalEditUserStatus"
                                                        name="modalEditUserStatus"
                                                        class="form-select"
                                                        aria-label="Default select example">
                                                    <option value="1" selected>Active</option>
                                                    <option value="2">Inactive</option>
                                                    <option value="3">Suspended</option>
                                                </select>
                                                <label for="modalEditUserStatus">Status</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline">
                                                <input
                                                        type="text"
                                                        id="modalEditTaxID"
                                                        name="modalEditTaxID"
                                                        class="form-control modal-edit-tax-id"
                                                        placeholder="123 456 7890" />
                                                <label for="modalEditTaxID">Tax ID</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="input-group input-group-merge">
                                                <span class="input-group-text">US (+1)</span>
                                                <div class="form-floating form-floating-outline">
                                                    <input
                                                            type="text"
                                                            id="modalEditUserPhone"
                                                            name="modalEditUserPhone"
                                                            class="form-control phone-number-mask"
                                                            value="+1 609 933 4422"
                                                            placeholder="+1 609 933 4422" />
                                                    <label for="modalEditUserPhone">Phone Number</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline">
                                                <input
                                                        id="modalEditUserLanguage"
                                                        name="modalEditUserLanguage"
                                                        class="form-control h-auto"
                                                        placeholder="select technologies"
                                                        value="English" />
                                                <label for="modalEditUserLanguage">Custom List Suggestions</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline">
                                                <select
                                                        id="modalEditUserCountry"
                                                        name="modalEditUserCountry"
                                                        class="select2 form-select"
                                                        data-allow-clear="true">
                                                    <option value="">Select</option>
                                                    <option value="Australia">Australia</option>
                                                    <option value="Bangladesh">Bangladesh</option>
                                                    <option value="Belarus">Belarus</option>
                                                    <option value="Brazil">Brazil</option>
                                                    <option value="Canada">Canada</option>
                                                    <option value="China">China</option>
                                                    <option value="France">France</option>
                                                    <option value="Germany">Germany</option>
                                                    <option value="India" selected>India</option>
                                                    <option value="Indonesia">Indonesia</option>
                                                    <option value="Israel">Israel</option>
                                                    <option value="Italy">Italy</option>
                                                    <option value="Japan">Japan</option>
                                                    <option value="Korea">Korea, Republic of</option>
                                                    <option value="Mexico">Mexico</option>
                                                    <option value="Philippines">Philippines</option>
                                                    <option value="Russia">Russian Federation</option>
                                                    <option value="South Africa">South Africa</option>
                                                    <option value="Thailand">Thailand</option>
                                                    <option value="Turkey">Turkey</option>
                                                    <option value="Ukraine">Ukraine</option>
                                                    <option value="United Arab Emirates">United Arab Emirates</option>
                                                    <option value="United Kingdom">United Kingdom</option>
                                                    <option value="United States">United States</option>
                                                </select>
                                                <label for="modalEditUserCountry">Country</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-check form-switch">
                                                <input type="checkbox" class="form-check-input" id="editBillingAddress" />
                                                <label for="editBillingAddress" class="text-heading">Use as a billing address?</label>
                                            </div>
                                        </div>
                                        <div class="col-12 text-center">
                                            <button type="submit" class="btn btn-primary me-3">Submit</button>
                                            <button
                                                    type="reset"
                                                    class="btn btn-outline-secondary"
                                                    data-bs-dismiss="modal"
                                                    aria-label="Close">
                                                Cancel
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div> -->
                    <!--/ Edit User Modal -->

                    <!-- Add New Address Modal -->
                    <!-- <div class="modal fade" id="addNewAddress" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-lg modal-simple modal-add-new-address">
                            <div class="modal-content">
                                <div class="modal-body p-0">
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    <div class="text-center mb-6">
                                        <h4 class="address-title mb-2">Add New Address</h4>
                                        <p class="address-subtitle">Add new address for express delivery</p>
                                    </div>
                                    <form id="addNewAddressForm" class="row g-5" onsubmit="return false">
                                        <div class="col-12 form-control-validation">
                                            <div class="row g-5">
                                                <div class="col-md mb-md-0">
                                                    <div class="form-check custom-option custom-option-basic">
                                                        <label class="form-check-label custom-option-content" for="customRadioHome">
                                                            <input
                                                                    name="customRadioTemp"
                                                                    class="form-check-input"
                                                                    type="radio"
                                                                    value=""
                                                                    id="customRadioHome"
                                                                    checked />
                                                            <span class="custom-option-header">
                                    <span class="h6 mb-0 d-flex align-items-center"
                                    ><i class="icon-base ri ri-home-smile-2-line icon-20px me-1"></i>Home</span
                                    >
                                  </span>
                                                            <span class="custom-option-body">
                                    <small>Delivery time (9am â€“ 9pm)</small>
                                  </span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col-md mb-md-0">
                                                    <div class="form-check custom-option custom-option-basic">
                                                        <label class="form-check-label custom-option-content" for="customRadioOffice">
                                                            <input
                                                                    name="customRadioTemp"
                                                                    class="form-check-input"
                                                                    type="radio"
                                                                    value=""
                                                                    id="customRadioOffice" />
                                                            <span class="custom-option-header">
                                    <span class="h6 mb-0 d-flex align-items-center"
                                    ><i class="icon-base ri ri-building-line icon-20px me-1"></i>Office</span
                                    >
                                  </span>
                                                            <span class="custom-option-body">
                                    <small>Delivery time (9am â€“ 5pm) </small>
                                  </span>
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 form-control-validation col-md-6">
                                            <div class="form-floating form-floating-outline">
                                                <input
                                                        type="text"
                                                        id="modalAddressFirstName"
                                                        name="modalAddressFirstName"
                                                        class="form-control"
                                                        placeholder="John" />
                                                <label for="modalAddressFirstName">First Name</label>
                                            </div>
                                        </div>
                                        <div class="col-12 form-control-validation col-md-6">
                                            <div class="form-floating form-floating-outline">
                                                <input
                                                        type="text"
                                                        id="modalAddressLastName"
                                                        name="modalAddressLastName"
                                                        class="form-control"
                                                        placeholder="Doe" />
                                                <label for="modalAddressLastName">Last Name</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating form-floating-outline">
                                                <select
                                                        id="modalAddressCountry"
                                                        name="modalAddressCountry"
                                                        class="select2 form-select"
                                                        data-allow-clear="true">
                                                    <option value="">Select</option>
                                                    <option value="Australia">Australia</option>
                                                    <option value="Bangladesh">Bangladesh</option>
                                                    <option value="Belarus">Belarus</option>
                                                    <option value="Brazil">Brazil</option>
                                                    <option value="Canada">Canada</option>
                                                    <option value="China">China</option>
                                                    <option value="France">France</option>
                                                    <option value="Germany">Germany</option>
                                                    <option value="India">India</option>
                                                    <option value="Indonesia">Indonesia</option>
                                                    <option value="Israel">Israel</option>
                                                    <option value="Italy">Italy</option>
                                                    <option value="Japan">Japan</option>
                                                    <option value="Korea">Korea, Republic of</option>
                                                    <option value="Mexico">Mexico</option>
                                                    <option value="Philippines">Philippines</option>
                                                    <option value="Russia">Russian Federation</option>
                                                    <option value="South Africa">South Africa</option>
                                                    <option value="Thailand">Thailand</option>
                                                    <option value="Turkey">Turkey</option>
                                                    <option value="Ukraine">Ukraine</option>
                                                    <option value="United Arab Emirates">United Arab Emirates</option>
                                                    <option value="United Kingdom">United Kingdom</option>
                                                    <option value="United States">United States</option>
                                                </select>
                                                <label for="modalAddressCountry">Country</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating form-floating-outline">
                                                <input
                                                        type="text"
                                                        id="modalAddressAddress1"
                                                        name="modalAddressAddress1"
                                                        class="form-control"
                                                        placeholder="12, Business Park" />
                                                <label for="modalAddressAddress1">Address Line 1</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating form-floating-outline">
                                                <input
                                                        type="text"
                                                        id="modalAddressAddress2"
                                                        name="modalAddressAddress2"
                                                        class="form-control"
                                                        placeholder="Mall Road" />
                                                <label for="modalAddressAddress2">Address Line 2</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline">
                                                <input
                                                        type="text"
                                                        id="modalAddressLandmark"
                                                        name="modalAddressLandmark"
                                                        class="form-control"
                                                        placeholder="Nr. Hard Rock Cafe" />
                                                <label for="modalAddressLandmark">Landmark</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline">
                                                <input
                                                        type="text"
                                                        id="modalAddressCity"
                                                        name="modalAddressCity"
                                                        class="form-control"
                                                        placeholder="Los Angeles" />
                                                <label for="modalAddressCity">City</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline">
                                                <input
                                                        type="text"
                                                        id="modalAddressState"
                                                        name="modalAddressState"
                                                        class="form-control"
                                                        placeholder="California" />
                                                <label for="modalAddressLandmark">State</label>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6">
                                            <div class="form-floating form-floating-outline">
                                                <input
                                                        type="text"
                                                        id="modalAddressZipCode"
                                                        name="modalAddressZipCode"
                                                        class="form-control"
                                                        placeholder="99950" />
                                                <label for="modalAddressZipCode">Zip Code</label>
                                            </div>
                                        </div>
                                        <div class="col-12 mt-6">
                                            <div class="form-check form-switch">
                                                <input type="checkbox" class="form-check-input" id="billingAddress" />
                                                <label for="billingAddress">Use as a billing address?</label>
                                            </div>
                                        </div>
                                        <div class="col-12 mt-6 d-flex flex-wrap justify-content-center gap-4 row-gap-4">
                                            <button type="submit" class="btn btn-primary">Submit</button>
                                            <button
                                                    type="reset"
                                                    class="btn btn-outline-secondary"
                                                    data-bs-dismiss="modal"
                                                    aria-label="Close">
                                                Cancel
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div> -->
                    <!--/ Add New Address Modal -->
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
<script src="${adminAssetsPath}/vendor/libs/datatables-bs5/datatables-bootstrap5.js"></script>
<script src="${adminAssetsPath}/vendor/libs/sweetalert2/sweetalert2.js"></script>
<script src="${adminAssetsPath}/vendor/libs/cleave-zen/cleave-zen.js"></script>
<script src="${adminAssetsPath}/vendor/libs/tagify/tagify.js"></script>
<script src="${adminAssetsPath}/vendor/libs/@form-validation/popular.js"></script>
<script src="${adminAssetsPath}/vendor/libs/@form-validation/bootstrap5.js"></script>
<script src="${adminAssetsPath}/vendor/libs/@form-validation/auto-focus.js"></script>
<script src="${adminAssetsPath}/vendor/libs/select2/select2.js"></script>

<!-- Main JS -->

<script src="${adminAssetsPath}/js/main.js"></script>

<!-- Page JS -->
<script src="${adminAssetsPath}/js/app-ecommerce-order-details.js"></script>
<script src="${adminAssetsPath}/js/modal-add-new-address.js"></script>
<script src="${adminAssetsPath}/js/modal-edit-user.js"></script>
</body>
</html>


