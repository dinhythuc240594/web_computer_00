<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin/layout/init.jspf" %>
<%@ page import="model.BrandDAO" %>
<%
    BrandDAO brand = (BrandDAO) request.getAttribute("brand");
%>
<!doctype html>
<html lang="en" class="layout-navbar-fixed layout-menu-fixed layout-compact" dir="ltr"
      data-skin="default" data-bs-theme="light" data-assets-path="${adminAssetsPath}/"
      data-template="vertical-menu-template">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <meta name="robots" content="noindex, nofollow"/>
    <title><%= brand != null ? "Chỉnh sửa" : "Thêm" %> Thương hiệu - Staff</title>
    <link rel="icon" type="image/x-icon" href="${adminAssetsPath}/img/favicon/Logo%20HCMUTE_White%20background.png"/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&ampdisplay=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/fonts/iconify-icons.css"/>
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/node-waves/node-waves.css"/>
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/pickr/pickr-themes.css"/>
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/css/core.css"/>
    <link rel="stylesheet" href="${adminAssetsPath}/css/demo.css"/>
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.css"/>
    <script src="${adminAssetsPath}/vendor/js/helpers.js"></script>
    <script src="${adminAssetsPath}/vendor/js/template-customizer.js"></script>
    <script src="${adminAssetsPath}/js/config.js"></script>
</head>
<body>
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <jsp:include page="../admin/layout/sidebar.jsp"/>
        <div class="layout-page">
            <jsp:include page="../admin/layout/navbar.jsp"/>
            <div class="content-wrapper">
                <div class="container-xxl flex-grow-1 container-p-y">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h4 class="fw-bold py-3 mb-4"><%= brand != null ? "Chỉnh sửa" : "Thêm" %> Thương hiệu</h4>
                        <a href="${contextPath}/staff?action=brands" class="btn btn-outline-secondary">
                            <i class="icon-base ri ri-arrow-left-line me-2"></i>Quay lại
                        </a>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <form method="post" action="${contextPath}/staff">
                                <input type="hidden" name="action" value="<%= brand != null ? "brand-update" : "brand-create" %>"/>
                                <%
                                    if (brand != null) {
                                %>
                                    <input type="hidden" name="id" value="<%= brand.getId() %>"/>
                                <%
                                    }
                                %>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Tên thương hiệu <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="name" 
                                               value="<%= brand != null && brand.getName() != null ? brand.getName() : "" %>" required/>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Mã thương hiệu <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="code" 
                                               value="<%= brand != null && brand.getCode() != null ? brand.getCode() : "" %>" required/>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">URL Logo</label>
                                    <input type="text" class="form-control" name="logo_url" 
                                           value="<%= brand != null && brand.getLogo_url() != null ? brand.getLogo_url() : "" %>" 
                                           placeholder="https://example.com/logo.png"/>
                                </div>

                                <%
                                    if (brand != null) {
                                %>
                                    <div class="mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="is_active" value="true" 
                                                   id="is_active" <%= brand.getIs_active() != null && brand.getIs_active() ? "checked" : "" %>/>
                                            <label class="form-check-label" for="is_active">
                                                Hoạt động
                                            </label>
                                        </div>
                                    </div>
                                <%
                                    }
                                %>

                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="icon-base ri ri-save-line me-2"></i>Lưu
                                    </button>
                                    <a href="${contextPath}/staff?action=brands" class="btn btn-outline-secondary">
                                        Hủy
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <jsp:include page="../admin/layout/footer.jsp"/>
            </div>
        </div>
    </div>
</div>

<script src="${adminAssetsPath}/vendor/libs/jquery/jquery.js"></script>
<script src="${adminAssetsPath}/vendor/libs/popper/popper.js"></script>
<script src="${adminAssetsPath}/vendor/js/bootstrap.js"></script>
<script src="${adminAssetsPath}/vendor/libs/node-waves/node-waves.js"></script>
<script src="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="${adminAssetsPath}/vendor/js/menu.js"></script>
<script src="${adminAssetsPath}/js/main.js"></script>
</body>
</html>
