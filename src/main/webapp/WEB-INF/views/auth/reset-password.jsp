<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <title>Đặt lại mật khẩu | Cửa hàng máy tính HCMUTE</title>

    <!-- Fav Icon -->
    <link rel="icon" href="${pageContext.request.contextPath}/assets/client/images/Logo%20HCMUTE_White%20background.png" type="image/x-icon">

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
    <link href="${pageContext.request.contextPath}/assets/client/css/odometer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/color.css" id="jssDefault" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/rtl.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/page-title.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/login.css" rel="stylesheet">
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

<!-- page wrapper -->
<body>
<div class="boxed_wrapper ltr">

    <!-- main header -->
    <jsp:include page="../common/header.jsp" />
    <!-- main-header end -->

    <jsp:include page="../common/mobile-menu.jsp" />
    <jsp:include page="../common/category-menu.jsp" />

    <!-- sign-section -->
    <section class="sign-section pb_80">
        <div class="large-container pt_45">
            <div class="sec-title centred pb_30">
                <h2>Đặt lại mật khẩu</h2>
                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null && !error.isBlank()) {
                %>
                <p style="color:#dc2626;margin-top:10px;"><%= error %></p>
                <%
                    }
                    String token = (String) request.getAttribute("token");
                    if (token == null || token.isBlank()) {
                        token = request.getParameter("token");
                    }
                %>
            </div>
            <div class="form-inner">
                <%
                    if (token != null && !token.isBlank()) {
                %>
                <form method="post" action="${pageContext.request.contextPath}/reset-password" id="resetPasswordForm">
                    <input type="hidden" name="token" value="<%= token %>">
                    <div class="form-group">
                        <label>Mật khẩu mới <span class="text-danger">*</span></label>
                        <div class="password-wrapper">
                            <input type="password" name="newPassword" id="newPassword" required minlength="6">
                            <button type="button" class="password-toggle" id="toggle-newPassword" aria-label="Hiển thị mật khẩu">
                                <i class="fa fa-eye" id="newPassword-eye-icon"></i>
                            </button>
                        </div>
                        <span class="error-message" id="newPassword-error"></span>
                    </div>
                    <div class="form-group">
                        <label>Xác nhận mật khẩu <span class="text-danger">*</span></label>
                        <div class="password-wrapper">
                            <input type="password" name="confirmPassword" id="confirmPassword" required minlength="6">
                            <button type="button" class="password-toggle" id="toggle-confirmPassword" aria-label="Hiển thị mật khẩu">
                                <i class="fa fa-eye" id="confirmPassword-eye-icon"></i>
                            </button>
                        </div>
                        <span class="error-message" id="confirmPassword-error"></span>
                    </div>
                    <div class="form-group message-btn">
                        <button type="submit" class="theme-btn">Đặt lại mật khẩu<span></span><span></span><span></span><span></span></button>
                    </div>
                </form>
                <%
                    } else {
                %>
                <div class="alert alert-danger">
                    <p>Token không hợp lệ hoặc đã hết hạn. Vui lòng yêu cầu đặt lại mật khẩu mới.</p>
                </div>
                <%
                    }
                %>
                <div class="lower-text centred">
                    <p><a href="${pageContext.request.contextPath}/login">Quay lại đăng nhập</a></p>
                </div>
            </div>
        </div>
    </section>
    <!-- sign-section end -->

    <!-- highlights-section -->
    <jsp:include page="../common/highlight-section.jsp" />
    <!-- highlights-section end -->

    <jsp:include page="../common/footer.jsp" />

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
<script src="${pageContext.request.contextPath}/assets/client/js/odometer.js"></script>

<!-- main-js -->
<script src="${pageContext.request.contextPath}/assets/client/js/script.js"></script>
<script>

    $(document).ready(function() {
        // Password toggle functionality
        $('#toggle-newPassword').on('click', function() {
            const newPasswordInput = $('#newPassword');
            const icon = $('#newPassword-eye-icon');
            if (newPasswordInput.attr('type') === 'password') {
                newPasswordInput.attr('type', 'text');
                icon.removeClass('fa-eye').addClass('fa-eye-slash');
            } else {
                newPasswordInput.attr('type', 'password');
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
            const newPassword = $(this).val();
            if (newPassword === '') {
                showError('newPassword', 'newPassword-error', 'Mật khẩu không được để trống');
            } else {
                const result = validatePassword(newPassword);
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
            const newPassword = $('#newPassword').val();
            if (confirmPassword === '') {
                showError('confirm-password', 'confirm-password-error', 'Xác nhận mật khẩu không được để trống');
            } else if (confirmPassword !== newPassword) {
                showError('confirmPassword', 'confirmPassword-error', 'Mật khẩu xác nhận không khớp');
            } else {
                showSuccess('confirmPassword', 'confirmPassword-error');
            }
        });

        // Form submission validation
        $('#resetPasswordForm').on('submit', function(e) {
            let isValid = true;

            // Validate password
            const newPassword = $('#newPassword').val();
            if (newPassword === '') {
                showError('newPassword', 'newPassword-error', 'Mật khẩu không được để trống');
                isValid = false;
            } else {
                const result = validatePassword(newPassword);
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
            } else if (confirmPassword !== newPassword) {
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

