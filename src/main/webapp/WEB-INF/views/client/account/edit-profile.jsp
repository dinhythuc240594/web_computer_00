<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.UserDAO" %>
<%@ page import="service.UserService" %>
<%@ page import="serviceimpl.UserServiceImpl" %>
<%@ page import="utilities.DataSourceUtil" %>
<%
    String sessionUsername = (String) session.getAttribute("username");
    UserDAO currentUser = null;
    if (sessionUsername != null && !sessionUsername.isBlank()) {
        try {
            javax.sql.DataSource ds = DataSourceUtil.getDataSource();
            UserService userService = new UserServiceImpl(ds);
            currentUser = userService.findByUsername(sessionUsername);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <title>Chỉnh sửa thông tin | HCMUTE Computer Store</title>

    <!-- Fav Icon -->
    <link rel="icon" href="${pageContext.request.contextPath}/assets/client/images/favicon.ico" type="image/x-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Rethink+Sans:ital,wght@0,400..800;1,400..800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">

    <!-- Stylesheets -->
    <link href="${pageContext.request.contextPath}/assets/client/css/font-awesome-all.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/flaticon.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/owl.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/jquery.fancybox.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/animate.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/nice-select.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/elpath.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/jquery-ui.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/color.css" id="jssDefault" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/rtl.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/page-title.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/account.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/highlights.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/footer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/responsive.css" rel="stylesheet">
</head>

<body>
<div class="boxed_wrapper ltr">

    <!-- main header -->
    <jsp:include page="../../common/header.jsp" />
    <!-- main-header end -->

    <jsp:include page="../../common/mobile-menu.jsp" />
    <jsp:include page="../../common/category-menu.jsp" />

    <!-- account-section -->
    <section class="account-section pb_80">
        <div class="large-container">
            <div class="sec-title centred pb_20">
                <h2>Chỉnh sửa thông tin cá nhân</h2>
                <%
                    String successMessage = (String) request.getAttribute("successMessage");
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (successMessage != null && !successMessage.isBlank()) {
                %>
                <p style="color: #28a745; margin-top: 10px;"><%= successMessage %></p>
                <%
                    }
                    if (errorMessage != null && !errorMessage.isBlank()) {
                %>
                <p style="color: #dc2626; margin-top: 10px;"><%= errorMessage %></p>
                <%
                    }
                %>
            </div>
            <div class="">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <div class="card shadow-sm">
                                <div class="card-body p-4">
                                    <form method="post" action="${pageContext.request.contextPath}/user?action=updateProfile" 
                                          enctype="multipart/form-data" class="needs-validation" novalidate>
                                        <div class="mb-3 text-center">
                                            <label class="form-label d-block">Ảnh đại diện</label>
                                            <%
                                                String avatarUrl = request.getContextPath() + "/assets/client/images/default-avatar.svg";
                                                if (currentUser != null && currentUser.getAvatar() != null && currentUser.getAvatar().length > 0) {
                                                    avatarUrl = request.getContextPath() + "/avatar?userId=" + currentUser.getId();
                                                }
                                            %>
                                            <img id="avatarPreview" src="<%= avatarUrl %>" 
                                                 alt="Ảnh đại diện" 
                                                 style="width: 150px; height: 150px; object-fit: cover; border-radius: 50%; border: 2px solid #ddd; margin-bottom: 10px; cursor: pointer;"
                                                 onclick="document.getElementById('avatar').click();">
                                            <input type="file" id="avatar" name="avatar" accept="image/jpeg,image/jpg,image/png,image/gif,image/webp" 
                                                   style="display: none;" onchange="previewAvatar(this);">
                                            <div class="mt-2">
                                                <button type="button" class="btn btn-sm btn-outline-primary" onclick="document.getElementById('avatar').click();">
                                                    <i class="fas fa-camera"></i> Chọn ảnh
                                                </button>
                                                <small class="d-block text-muted mt-2">Chỉ chấp nhận file ảnh (JPG, PNG, GIF, WebP), tối đa 5MB</small>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="fullname" class="form-label">Họ và tên <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="fullname" name="fullname" 
                                                   value="<%= currentUser.getFullname() != null ? currentUser.getFullname() : "" %>" 
                                                   required>
                                            <div class="invalid-feedback">
                                                Vui lòng nhập họ và tên.
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="phone" class="form-label">Số điện thoại</label>
                                            <input type="text" class="form-control" id="phone" name="phone" 
                                                   value="<%= currentUser.getPhone() != null ? currentUser.getPhone() : "" %>"
                                                   placeholder="Nhập số điện thoại">
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="email" class="form-label">Email</label>
                                            <input type="email" class="form-control" id="email" name="email" 
                                                   value="<%= currentUser.getEmail() != null ? currentUser.getEmail() : "" %>"
                                                   placeholder="Nhập email">
                                            <div class="invalid-feedback">
                                                Vui lòng nhập email hợp lệ.
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="address" class="form-label">Địa chỉ</label>
                                            <textarea class="form-control" id="address" name="address" rows="3" 
                                                      placeholder="Nhập địa chỉ"><%= currentUser.getAddress() != null ? currentUser.getAddress() : "" %></textarea>
                                        </div>
                                        
                                        <div class="d-flex gap-2 mt-4">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-save"></i> Cập nhật
                                            </button>
                                            <a href="${pageContext.request.contextPath}/user" class="btn btn-secondary">
                                                <i class="fas fa-times"></i> Hủy
                                            </a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- account-section end -->

    <!-- highlights-section -->
    <jsp:include page="../../common/highlight-section.jsp" />
    <!-- highlights-section end -->

    <jsp:include page="../../common/footer.jsp" />

    <!--Scroll to top-->
    <div class="scroll-to-top">
        <svg class="scroll-top-inner" viewBox="-1 -1 102 102">
            <path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98" />
        </svg>
    </div>
</div>

<!-- jequery plugins -->
<script src="${pageContext.request.contextPath}/assets/client/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/owl.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/wow.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/validation.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/jquery.fancybox.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/appear.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/isotope.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/parallax-scroll.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/jquery.nice-select.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/scrolltop.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/language.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/countdown.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/jquery-ui.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/product-filter.js"></script>
<script src="${pageContext.request.contextPath}/assets/client/js/jquery.bootstrap-touchspin.js"></script>

<!-- main-js -->
<script src="${pageContext.request.contextPath}/assets/client/js/script.js"></script>
<script>
// Bootstrap form validation
(function() {
    'use strict';
    var forms = document.querySelectorAll('.needs-validation');
    Array.prototype.slice.call(forms).forEach(function(form) {
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
})();

// Preview avatar before upload
function previewAvatar(input) {
    if (input.files && input.files[0]) {
        var file = input.files[0];
        
        // Validate file size (5MB)
        if (file.size > 5 * 1024 * 1024) {
            alert('Kích thước file vượt quá 5MB. Vui lòng chọn file nhỏ hơn.');
            input.value = '';
            return;
        }
        
        // Validate file type
        var validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/webp'];
        if (!validTypes.includes(file.type)) {
            alert('Chỉ chấp nhận file ảnh (JPG, PNG, GIF, WebP).');
            input.value = '';
            return;
        }
        
        var reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('avatarPreview').src = e.target.result;
        };
        reader.readAsDataURL(file);
    }
}
</script>
</body>
</html>

