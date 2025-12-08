<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <title>Đăng ký | Cửa hàng máy tính HCMUTE</title>

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

<%--    <jsp:include page="../common/preloader.jsp" />--%>

    <!-- main header -->
    <jsp:include page="../common/header.jsp" />
    <!-- main-header end -->

    <jsp:include page="../common/mobile-menu.jsp" />
    <jsp:include page="../common/category-menu.jsp" />

    <!-- sign-section -->
    <section class="sign-section pb_80">
        <div class="large-container">
            <div class="sec-title centred pb_30">
                <h2>Tạo tài khoản mới</h2>
                <%
                    String registerError = (String) request.getAttribute("registerError");
                    String registerSuccess = (String) request.getAttribute("registerSuccess");
                    if (registerError != null && !registerError.isBlank()) {
                %>
                <p style="color:#dc2626;margin-top:10px;"><%= registerError %></p>
                <%
                    } else if (registerSuccess != null && !registerSuccess.isBlank()) {
                %>
                <p style="color:#16a34a;margin-top:10px;"><%= registerSuccess %></p>
                <%
                    }
                %>
            </div>
            <div class="form-inner">
                <form method="post" action="${pageContext.request.contextPath}/register" id="register-form">
                    <div class="form-group">
                        <label>Họ và tên</label>
                        <input type="text" name="name" required>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" id="email" required>
                        <span class="error-message" id="email-error"></span>
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại</label>
                        <input type="text" name="phone" id="phone" required>
                        <span class="error-message" id="phone-error"></span>
                    </div>
                    <div class="form-group">
                        <label>Mật khẩu</label>
                        <div class="password-wrapper">
                            <input type="password" name="password" id="password" required>
                            <button type="button" class="password-toggle" id="toggle-password" aria-label="Hiển thị mật khẩu">
                                <i class="fa fa-eye" id="password-eye-icon"></i>
                            </button>
                        </div>
                        <span class="error-message" id="password-error"></span>
                    </div>
                    <div class="form-group">
                        <label>Xác nhận mật khẩu</label>
                        <div class="password-wrapper">
                            <input type="password" name="confirm-password" id="confirm-password" required>
                            <button type="button" class="password-toggle" id="toggle-confirm-password" aria-label="Hiển thị mật khẩu">
                                <i class="fa fa-eye" id="confirm-password-eye-icon"></i>
                            </button>
                        </div>
                        <span class="error-message" id="confirm-password-error"></span>
                    </div>
                    <div class="other-option">
                        <div class="check-box">
                            <input class="check" type="checkbox" id="agree-term" name="agree-term" value="true">
                            <label for="agree-term">Tôi đồng ý với điều khoản sử dụng</label>
                        </div>
                    </div>
                    <div class="form-group message-btn">
                        <button type="submit" class="theme-btn">Đăng ký<span></span><span></span><span></span><span></span></button>
                    </div>
<%--                    <span class="text">hoặc</span>--%>
<%--                    <ul class="social-links clearfix">--%>
<%--                        <li>--%>
<%--                            <a href="#"><img src="${pageContext.request.contextPath}/assets/client/images/icons/icon-8.png" alt="">Tiếp tục với Google</a>--%>
<%--                        </li>--%>
<%--                        <li>--%>
<%--                            <a href="#"><img src="${pageContext.request.contextPath}/assets/client/images/icons/icon-9.png" alt="">Tiếp tục với Facebook</a>--%>
<%--                        </li>--%>
<%--                    </ul>--%>
                </form>
                <div class="lower-text centred">
                    <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
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

<!-- Register Form Validation -->
<script>
    $(document).ready(function() {
        // Password toggle functionality
        $('#toggle-password').on('click', function() {
            const passwordInput = $('#password');
            const icon = $('#password-eye-icon');
            if (passwordInput.attr('type') === 'password') {
                passwordInput.attr('type', 'text');
                icon.removeClass('fa-eye').addClass('fa-eye-slash');
            } else {
                passwordInput.attr('type', 'password');
                icon.removeClass('fa-eye-slash').addClass('fa-eye');
            }
        });

        $('#toggle-confirm-password').on('click', function() {
            const confirmPasswordInput = $('#confirm-password');
            const icon = $('#confirm-password-eye-icon');
            if (confirmPasswordInput.attr('type') === 'password') {
                confirmPasswordInput.attr('type', 'text');
                icon.removeClass('fa-eye').addClass('fa-eye-slash');
            } else {
                confirmPasswordInput.attr('type', 'password');
                icon.removeClass('fa-eye-slash').addClass('fa-eye');
            }
        });

        // Validation functions
        function validateEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }

        function validatePhone(phone) {
            const phoneRegex = /^\d{10}$/;
            return phoneRegex.test(phone);
        }

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

        // Real-time validation
        $('#email').on('blur', function() {
            const email = $(this).val().trim();
            if (email === '') {
                showError('email', 'email-error', 'Email không được để trống');
            } else if (!validateEmail(email)) {
                showError('email', 'email-error', 'Email không đúng định dạng');
            } else {
                showSuccess('email', 'email-error');
            }
        });

        $('#phone').on('blur', function() {
            const phone = $(this).val().trim();
            if (phone === '') {
                showError('phone', 'phone-error', 'Số điện thoại không được để trống');
            } else if (!validatePhone(phone)) {
                showError('phone', 'phone-error', 'Số điện thoại phải là 10 chữ số');
            } else {
                showSuccess('phone', 'phone-error');
            }
        });

        $('#phone').on('input', function() {
            // Only allow digits
            $(this).val($(this).val().replace(/\D/g, ''));
        });

        $('#password').on('blur', function() {
            const password = $(this).val();
            if (password === '') {
                showError('password', 'password-error', 'Mật khẩu không được để trống');
            } else {
                const result = validatePassword(password);
                if (!result.valid) {
                    showError('password', 'password-error', result.message);
                } else {
                    showSuccess('password', 'password-error');
                    // Re-check confirm password if it has value
                    if ($('#confirm-password').val() !== '') {
                        $('#confirm-password').trigger('blur');
                    }
                }
            }
        });

        $('#confirm-password').on('blur', function() {
            const confirmPassword = $(this).val();
            const password = $('#password').val();
            if (confirmPassword === '') {
                showError('confirm-password', 'confirm-password-error', 'Xác nhận mật khẩu không được để trống');
            } else if (confirmPassword !== password) {
                showError('confirm-password', 'confirm-password-error', 'Mật khẩu xác nhận không khớp');
            } else {
                showSuccess('confirm-password', 'confirm-password-error');
            }
        });

        // Form submission validation
        $('#register-form').on('submit', function(e) {
            let isValid = true;

            // Validate email
            const email = $('#email').val().trim();
            if (email === '' || !validateEmail(email)) {
                showError('email', 'email-error', email === '' ? 'Email không được để trống' : 'Email không đúng định dạng');
                isValid = false;
            } else {
                showSuccess('email', 'email-error');
            }

            // Validate phone
            const phone = $('#phone').val().trim();
            if (phone === '' || !validatePhone(phone)) {
                showError('phone', 'phone-error', phone === '' ? 'Số điện thoại không được để trống' : 'Số điện thoại phải là 10 chữ số');
                isValid = false;
            } else {
                showSuccess('phone', 'phone-error');
            }

            // Validate password
            const password = $('#password').val();
            if (password === '') {
                showError('password', 'password-error', 'Mật khẩu không được để trống');
                isValid = false;
            } else {
                const result = validatePassword(password);
                if (!result.valid) {
                    showError('password', 'password-error', result.message);
                    isValid = false;
                } else {
                    showSuccess('password', 'password-error');
                }
            }

            // Validate confirm password
            const confirmPassword = $('#confirm-password').val();
            if (confirmPassword === '') {
                showError('confirm-password', 'confirm-password-error', 'Xác nhận mật khẩu không được để trống');
                isValid = false;
            } else if (confirmPassword !== password) {
                showError('confirm-password', 'confirm-password-error', 'Mật khẩu xác nhận không khớp');
                isValid = false;
            } else {
                showSuccess('confirm-password', 'confirm-password-error');
            }

            // Check terms agreement
            if (!$('#agree-term').is(':checked')) {
                alert('Vui lòng đồng ý với điều khoản sử dụng');
                isValid = false;
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

