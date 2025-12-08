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

    <title>Đổi mật khẩu | HCMUTE Computer Store</title>

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
    <style>
        .password-wrapper {
            position: relative;
        }
        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            color: #666;
            font-size: 16px;
            padding: 5px 10px;
            z-index: 10;
        }
        .password-toggle:hover {
            color: #333;
        }
        .form-group input[type="password"],
        .form-group input[type="text"] {
            padding-right: 45px;
        }
        .error-message {
            color: #dc2626;
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }
        .error-message.show {
            display: block;
        }
        .form-group input.error {
            border-color: #dc2626;
        }
        .form-group input.success {
            border-color: #16a34a;
        }
    </style>
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
                <h2>Đổi mật khẩu</h2>
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
                                    <div class="alert alert-info" role="alert">
                                        <i class="fas fa-info-circle"></i> Thay đổi mật khẩu của bạn để bảo mật tài khoản. Sau khi đổi mật khẩu, bạn sẽ cần đăng nhập lại.
                                    </div>
                                    
                                    <form method="post" action="${pageContext.request.contextPath}/user?action=changePassword" class="needs-validation" novalidate id="changePasswordForm">
                                        <div class="mb-3">
                                            <label for="currentPassword" class="form-label">Mật khẩu hiện tại <span class="text-danger">*</span></label>
                                            <div class="password-wrapper">
                                                <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                                <button type="button" class="password-toggle" id="toggle-currentPassword" data-target="currentPassword" aria-label="Hiển thị/ẩn mật khẩu hiện tại">
                                                    <i id="currentPassword-eye-icon" class="fa fa-eye"></i>
                                                </button>
                                            </div>
                                            <span class="error-message" id="currentPassword-error"></span>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="newPassword" class="form-label">Mật khẩu mới <span class="text-danger">*</span></label>
                                            <div class="password-wrapper">
                                                <input type="password" class="form-control" id="newPassword" name="newPassword" required minlength="7">
                                                <button type="button" class="password-toggle" id="toggle-newPassword" data-target="newPassword" aria-label="Hiển thị/ẩn mật khẩu mới">
                                                    <i id="newPassword-eye-icon" class="fa fa-eye"></i>
                                                </button>
                                            </div>
                                            <span class="error-message" id="newPassword-error"></span>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                                            <div class="password-wrapper">
                                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required minlength="7">
                                                <button type="button" class="password-toggle" id="toggle-confirmPassword" data-target="confirmPassword" aria-label="Hiển thị/ẩn xác nhận mật khẩu">
                                                    <i id="confirmPassword-eye-icon" class="fa fa-eye"></i>
                                                </button>
                                            </div>
                                            <span class="error-message" id="confirmPassword-error"></span>
                                        </div>
                                        
                                        <div class="d-flex gap-2 mt-4">
                                            <button type="submit" class="btn btn-warning">
                                                <i class="fas fa-key"></i> Đổi mật khẩu
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

$(document).ready(function() {
        // Password toggle functionality
        $('#toggle-currentPassword').on('click', function() {
            const passwordInput = $('#currentPassword');
            const icon = $('#currentPassword-eye-icon');
            if (passwordInput.attr('type') === 'password') {
                passwordInput.attr('type', 'text');
                icon.removeClass('fa-eye').addClass('fa-eye-slash');
            } else {
                passwordInput.attr('type', 'password');
                icon.removeClass('fa-eye-slash').addClass('fa-eye');
            }
        });

        $('#toggle-newPassword').on('click', function() {
            const newpasswordInput = $('#newPassword');
            const icon = $('#newPassword-eye-icon');
            if (newpasswordInput.attr('type') === 'password') {
                newpasswordInput.attr('type', 'text');
                icon.removeClass('fa-eye').addClass('fa-eye-slash');
            } else {
                newpasswordInput.attr('type', 'password');
                icon.removeClass('fa-eye-slash').addClass('fa-eye');
            }
        });

        $('#toggle-confirmPassword').on('click', function() {
            const confirmPasswordInput = $('#confirmPassword');
            const icon = $('#confirmPassword-eye-icon');
            if (confirmPasswordInput.attr('type') === 'password') {
                confirmPasswordInput.attr('type', 'text');
                icon.removeClass('fa-eye').addClass('fa-eye-slash');
            } else {
                confirmPasswordInput.attr('type', 'password');
                icon.removeClass('fa-eye-slash').addClass('fa-eye');
            }
        });

        function validatePassword(password) {
            // At least 6 characters
            if (password.length < 6) {
                return {
                    valid: false,
                    message: 'Mật khẩu phải có ít nhất 6 ký tự'
                };
            }
            // Check for uppercase
            if (!/[A-Z]/.test(password)) {
                return {
                    valid: false,
                    message: 'Mật khẩu phải có ít nhất một chữ hoa'
                };
            }
            // Check for lowercase
            if (!/[a-z]/.test(password)) {
                return {
                    valid: false,
                    message: 'Mật khẩu phải có ít nhất một chữ thường'
                };
            }
            // Check for number
            if (!/[0-9]/.test(password)) {
                return {
                    valid: false,
                    message: 'Mật khẩu phải có ít nhất một số'
                };
            }
            // Check for special character (!@#)
            if (!/[!@#]/.test(password)) {
                return {
                    valid: false,
                    message: 'Mật khẩu phải có ít nhất một ký tự đặc biệt (!@#)'
                };
            }
            return { valid: true };
        }

        function showError(inputId, errorId, message) {
            $('#' + inputId).addClass('error').removeClass('success');
            $('#' + errorId).text(message).addClass('show');
        }

        function showSuccess(inputId, errorId) {
            $('#' + inputId).addClass('success').removeClass('error');
            $('#' + errorId).removeClass('show').text('');
        }

        $('#newPassword').on('blur', function() {
            const password = $(this).val();
            if (password === '') {
                showError('newPassword', 'newPassword-error', 'Mật khẩu không được để trống');
            } else {
                const result = validatePassword(password);
                if (!result.valid) {
                    showError('newPassword', 'newPassword-error', result.message);
                } else {
                    showSuccess('newPassword', 'newPassword-error');
                    // Re-check confirm password if it has value
                    if ($('#confirmPassword').val() !== '') {
                        $('#confirmPassword').trigger('blur');
                    }
                }
            }
        });

        $('#confirmPassword').on('blur', function() {
            const confirmPassword = $(this).val();
            const newpassword = $('#newPassword').val();
            if (confirmPassword === '') {
                showError('confirmPassword', 'confirmPassword-error', 'Xác nhận mật khẩu không được để trống');
            } else if (confirmPassword !== newpassword) {
                showError('confirmPassword', 'confirmPassword-error', 'Mật khẩu xác nhận không khớp');
            } else {
                showSuccess('confirmPassword', 'confirmPassword-error');
            }
        });

        // Form submission validation
        $('#changePasswordForm').on('submit', function(e) {
            let isValid = true;

            // Validate password
            const newpassword = $('#newPassword').val();
            if (newpassword === '') {
                showError('newPassword', 'newPassword-error', 'Mật khẩu không được để trống');
                isValid = false;
            } else {
                const result = validatePassword(newpassword);
                if (!result.valid) {
                    showError('newPassword', 'newPassword-error', result.message);
                    isValid = false;
                } else {
                    showSuccess('newPassword', 'newPassword-error');
                }
            }

            // Validate confirm password
            const confirmPassword = $('#confirmPassword').val();
            if (confirmPassword === '') {
                showError('confirmPassword', 'confirmPassword-error', 'Xác nhận mật khẩu không được để trống');
                isValid = false;
            } else if (confirmPassword !== newpassword) {
                showError('confirmPassword', 'confirmPassword-error', 'Mật khẩu xác nhận không khớp');
                isValid = false;
            } else {
                showSuccess('confirmPassword', 'confirmPassword-error');
            }

            if (!isValid) {
                e.preventDefault();
                // Scroll to first error
                $('html, body').animate({
                    scrollTop: $('.error-message.show').first().offset().top - 100
                }, 500);
            }
        });
    });
</script>
</body>
</html>

