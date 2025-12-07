<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="content-footer footer bg-footer-theme">
    <div class="container-xxl">
        <div
                class="footer-container d-flex align-items-center justify-content-between py-4 flex-md-row flex-column">
            <div class="mb-2 mb-md-0">
                &#169;
                <script>
                    document.write(new Date().getFullYear());
                </script>
                , làm bởi Nhóm 6
                <!-- <a href="https://pixinvent.com" target="_blank" class="footer-link fw-medium">Pixinvent</a> -->
            </div>
            <!-- <div class="d-none d-lg-inline-block">
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
            </div> -->
        </div>
    </div>
</footer>
<script src="https://cdn.ckeditor.com/4.22.1/full-all/ckeditor.js"></script>
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

        $('#updateProductForm').on('submit', function(e) {
            e.preventDefault();

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
                url: 'foods?action=update',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                dataType: 'json',

                beforeSend: function() {
                    $('#responseMessage').html('<div class="bg-blue-100 border border-blue-400 text-blue-700 px-4 py-3 rounded mb-4">Đang cập nhật món ăn...</div>');
                },
                success: function(response) {
                    if (response.success) {
                        $('#responseMessage').html('<div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">' + response.message + '</div>');
                        setTimeout(function() {
                            window.location.href = 'foods?action=list';
                        }, 1500);
                    } else {
                        $('#responseMessage').html('<div class="bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-3 rounded mb-4">Lỗi: ' + response.message + '</div>');
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                    $('#responseMessage').html('<div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">Đã xảy ra lỗi khi gửi dữ liệu. Vui lòng thử lại.</div>');
                }
            });
        });
    });
</script>

