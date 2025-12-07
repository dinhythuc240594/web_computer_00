<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin/layout/init.jspf" %>
<%@ page import="model.BrandDAO" %>
<%@ page import="java.util.Base64" %>
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
    <!-- <script src="${adminAssetsPath}/vendor/js/template-customizer.js"></script> -->
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
                            <form method="post" action="${contextPath}/brand" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="<%= brand != null ? "update" : "create" %>"/>
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
                                    <label class="form-label">Logo thương hiệu</label>
                                    <input type="file" class="form-control" id="image" name="image" accept="image/jpeg,image/jpg,image/png,image/gif,image/webp"/>
                                    <small class="form-text text-muted">Chỉ chấp nhận file ảnh (JPG, PNG, GIF, WebP). Kích thước tối đa: 5MB.</small>
                                    <div id="imagePreview" class="mb-3 mt-3 w-full h-48 border-2 border-dashed border-gray-300 rounded-lg flex items-center justify-center overflow-hidden bg-gray-50">
                                        <%
                                            // Ưu tiên hiển thị logo_blob, sau đó mới đến logo_url
                                            if (brand != null && brand.getLogo_blob() != null && brand.getLogo_blob().length > 0) {
                                        %>
                                            <img src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(brand.getLogo_blob()) %>" 
                                                 alt="Logo hiện tại" id="previewImg" 
                                                 class="max-w-full max-h-full object-contain"/>
                                        <%
                                            } else if (brand != null && brand.getLogo_url() != null && !brand.getLogo_url().isBlank()) {
                                        %>
                                            <img src="<%= brand.getLogo_url() %>" alt="Logo hiện tại" id="previewImg" 
                                                 class="max-w-full max-h-full object-contain"/>
                                        <%
                                            } else {
                                        %>
                                            <img src="${pageContext.request.contextPath}/assets/client/images/resource/category-4.png" 
                                                 alt="Xem trước ảnh" id="previewImg" 
                                                 class="max-w-full max-h-full object-contain"/>
                                        <%
                                            }
                                        %>
                                    </div>
                                    <div class="mb-2">
                                        <label class="form-label">Hoặc nhập URL logo</label>
                                        <input type="text" class="form-control" name="logo_url" 
                                               value="<%= brand != null && brand.getLogo_url() != null ? brand.getLogo_url() : "" %>" 
                                               placeholder="https://example.com/logo.png"/>
                                        <small class="form-text text-muted">Nếu không upload file, có thể nhập URL logo</small>
                                    </div>
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
<script>
    // Preview image when file is selected
    $(document).ready(function() {
        $('#image').on('change', function() {
            if (this.files && this.files[0]) {
                var file = this.files[0];
                
                // Validate file size (5MB)
                if (file.size > 5 * 1024 * 1024) {
                    alert('Kích thước file vượt quá 5MB. Vui lòng chọn file nhỏ hơn.');
                    this.value = '';
                    return;
                }
                
                // Validate file type
                var validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/webp'];
                if (!validTypes.includes(file.type)) {
                    alert('Chỉ chấp nhận file ảnh (JPG, PNG, GIF, WebP).');
                    this.value = '';
                    return;
                }
                
                var reader = new FileReader();
                reader.onload = function(e) {
                    $('#previewImg').attr('src', e.target.result).show();
                };
                reader.readAsDataURL(file);
            }
        });
    });
</script>
</body>
</html>
