<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin/layout/init.jspf" %>
<%@ page import="model.BrandDAO" %>
<%@ page import="java.util.Base64" %>
<%
    BrandDAO brand = (BrandDAO) request.getAttribute("brand");
    String previewImg = brand != null && brand.getImage() != null && !brand.getImage().isEmpty() ? brand.getImage():"";
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
                            <form method="post" id="updateBrandForm" enctype="multipart/form-data">
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
                                    <label class="form-label">Hình ảnh thương hiệu</label>
                                    <div id="imagePreview" class="mb-3 w-full h-48 border-2 border-dashed border-gray-300 rounded-lg flex items-center justify-center overflow-hidden bg-gray-50">
                                        <% if(previewImg == "") { %>
                                        <img src="${pageContext.request.contextPath}/assets/client/images/resource/category-2.png" alt="Xem trước ảnh" id="previewImg" class="max-w-full max-h-full object-contain">
                                        <% } else { %>
                                        <img src="<%= previewImg  %>" alt="Xem trước ảnh" id="previewImg" class="max-w-full max-h-full object-contain">
                                        <% } %>
                                    </div>
                                    <input type="file" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent" id="image" name="image" accept="image/*" />
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
<style>
    .cke_notification_warning {
        display: none !important;
    }
</style>
<script src="${adminAssetsPath}/vendor/libs/jquery/jquery.js"></script>
<script src="${adminAssetsPath}/vendor/libs/popper/popper.js"></script>
<script src="${adminAssetsPath}/vendor/js/bootstrap.js"></script>
<script src="${adminAssetsPath}/vendor/libs/node-waves/node-waves.js"></script>
<script src="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="${adminAssetsPath}/vendor/js/menu.js"></script>
<script src="${adminAssetsPath}/js/main.js"></script>
<script>
    CKEDITOR.replace('description', {
        toolbar: [
            { name: 'document', items: [ 'Source', '-', 'Preview' ] },
            { name: 'clipboard', items: [ 'Cut', 'Copy', 'Paste', '-', 'Undo', 'Redo' ] },
            { name: 'styles', items: [ 'Format', 'Font', 'FontSize' ] },
            { name: 'colors', items: [ 'TextColor', 'BGColor' ] },
            { name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike', '-', 'RemoveFormat' ] },
            { name: 'paragraph', items: [ 'NumberedList', 'BulletedList', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight' ] },
            { name: 'insert', items: [ 'Image', 'Table', 'Link', 'Unlink' ] }
        ],
        contentsCss: [
            'https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css',
            'body { font-family: "Roboto", "Helvetica Neue", Arial, sans-serif; padding: 15px; }'
        ],
        filebrowserUploadUrl: '${pageContext.request.contextPath}/upload-image',
        imageUploadUrl: '${pageContext.request.contextPath}/upload-image',

        extraPlugins: 'uploadimage',
        removePlugins: 'imagebase64, elementspath',
        height: 300,
        resize_enabled: false,
        image2_alignClasses: ['image-align-left', 'image-align-center', 'image-align-right'],
    });

    $(document).ready(function() {

        $('#image').on('change', function() {
            if (this.files && this.files[0]) {
                var reader = new FileReader();

                reader.onload = function(e) {
                    $('#previewImg').attr('src', e.target.result).show();
                };

                reader.readAsDataURL(this.files[0]);
            } else {
                $('#previewImg').attr('src', "<%= previewImg %>");
            }
        });

        $('#updateBrandForm').on('submit', function(e) {
            // e.preventDefault();

            for (instance in CKEDITOR.instances) {
                CKEDITOR.instances[instance].updateElement();
            }

            var editorData = CKEDITOR.instances['description'].getData();
            // formData.append("description", editorData);

            var formData = new FormData(this);

            if (!formData.has('is_available')) {
                formData.append('is_available', '0');
            }

            $.ajax({
                url: 'staff',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                dataType: 'json',

                // beforeSend: function() {
                //     $('#responseMessage').html('<div class="bg-blue-100 border border-blue-400 text-blue-700 px-4 py-3 rounded mb-4">Đang cập nhật món ăn...</div>');
                // },
                // success: function(response) {
                //     if (response.success) {
                //         $('#responseMessage').html('<div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">' + response.message + '</div>');
                //         setTimeout(function() {
                //             window.location.href = 'foods?action=list';
                //         }, 1500);
                //     } else {
                //         $('#responseMessage').html('<div class="bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-3 rounded mb-4">Lỗi: ' + response.message + '</div>');
                //     }
                // },
                // error: function(jqXHR, textStatus, errorThrown) {
                //     console.log(jqXHR.responseText);
                //     $('#responseMessage').html('<div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">Đã xảy ra lỗi khi gửi dữ liệu. Vui lòng thử lại.</div>');
                // }
            });
        });
    });
</script>
</body>
</html>
