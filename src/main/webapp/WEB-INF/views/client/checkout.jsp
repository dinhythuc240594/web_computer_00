<%--
  Created by IntelliJ IDEA.
  User: Windows
  Date: 25/11/2025
  Time: 1:45 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.ProductDAO" %>
<%@ page import="model.UserDAO" %>
<%@ page import="service.UserService" %>
<%@ page import="serviceimpl.UserServiceImpl" %>
<%@ page import="utilities.DataSourceUtil" %>
<%
    // Lấy giỏ hàng từ session
    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
    if (cartItems == null) {
        cartItems = java.util.Collections.emptyList();
    }

    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    double subtotal = 0.0;
    for (CartItem item : cartItems) {
        ProductDAO p = item.getProduct();
        if (p != null && p.getPrice() != null) {
            subtotal += p.getPrice() * item.getQuantity();
        }
    }

    double freeShipThreshold = 500000; // 500.000đ để được miễn phí vận chuyển
    double shippingFee = subtotal >= freeShipThreshold || subtotal == 0 ? 0 : 30000;
    double total = subtotal + shippingFee;

    // Lấy thông tin user từ database nếu đã đăng nhập
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

    String billingName = currentUser != null && currentUser.getFullname() != null
            ? currentUser.getFullname() : "";
    String billingEmail = currentUser != null && currentUser.getEmail() != null
            ? currentUser.getEmail() : "";
    String billingPhone = currentUser != null && currentUser.getPhone() != null
            ? currentUser.getPhone() : "";
    String billingAddress = currentUser != null && currentUser.getAddress() != null
            ? currentUser.getAddress() : "";
    String empty = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <title>Thanh toán | HCMUTE Computer Store</title>

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
    <link href="${pageContext.request.contextPath}/assets/client/css/color.css" id="jssDefault" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/rtl.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/page-title.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/checkout.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/highlights.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/footer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/responsive.css" rel="stylesheet">

</head>


<!-- page wrapper -->
<body>

<div class="boxed_wrapper ltr">


    <!-- <jsp:include page="../common/preloader.jsp" /> -->

    <!-- main header -->
    <jsp:include page="../common/header.jsp" />
    <!-- main-header end -->


    <jsp:include page="../common/mobile-menu.jsp" />


    <jsp:include page="../common/category-menu.jsp" />

    <!-- checkout-section -->
    <section class="checkout-section pb_80">
        <div class="large-container">
            <div class="sec-title centred pb_30">
                <h2>Thanh toán</h2>
            </div>
            
            <% 
                String errorMessage = (String) request.getAttribute("error");
                String successMessage = (String) request.getAttribute("success");
            %>
            
            <% if (errorMessage != null && !errorMessage.isBlank()) { %>
            <div class="alert alert-danger" style="padding: 15px; margin-bottom: 20px; border: 1px solid #f5c6cb; border-radius: 4px; background-color: #f8d7da; color: #721c24;">
                <strong>Lỗi!</strong> <%= errorMessage %>
            </div>
            <% } %>
            
            <% if (successMessage != null && !successMessage.isBlank()) { %>
            <div class="alert alert-success" style="padding: 15px; margin-bottom: 20px; border: 1px solid #c3e6cb; border-radius: 4px; background-color: #d4edda; color: #155724;">
                <strong>Thành công!</strong> <%= successMessage %>
            </div>
            <% } %>
            
            <form method="post" action="<%= request.getContextPath() %>/checkout">
            <div class="row clearfix">
                <div class="col-lg-8 col-md-12 col-sm-12 billing-column">
                    <div class="billing-content mr_30">
                        <h3>Thông tin thanh toán</h3>
                        <div class="form-inner">
                                <div class="row clearfix">
                                    <div class="col-lg-6 col-md-6 col-sm-12 field-column">
                                        <div class="form-group">
                                            <label>Họ và tên<span>*</span></label>
                                            <input type="text" name="fullName" value="<%= billingName %>">
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-12 field-column">
                                        <div class="form-group">
                                            <label>Email<span>*</span></label>
                                            <input type="email" name="email" value="<%= billingEmail %>">
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-12 field-column">
                                        <div class="form-group">
                                            <label>Số điện thoại<span>*</span></label>
                                            <input type="text" name="phone" value="<%= billingPhone %>">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 col-md-12 col-sm-12 field-column">
                                        <div class="form-group">
                                            <label>Địa chỉ<span>*</span></label>
                                            <input type="text" name="address" value="<%= billingAddress %>">
                                        </div>
                                    </div>
                                </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-12 col-sm-12 order-column">
                    <div class="order-box">
                        <h3>Tóm tắt đơn hàng</h3>
                        <div class="order-info">
                            <div class="title-box">
                                <span class="text">Sản phẩm</span>
                                <span class="text">Thành tiền</span>
                            </div>
                            <div class="order-product" id="checkout-order-products">
                                <%
                                    if (!cartItems.isEmpty()) {
                                        for (CartItem item : cartItems) {
                                            ProductDAO product = item.getProduct();
                                            if (product == null) continue;
                                            String productImage = product.getImage();
                                            if (productImage == null || productImage.isBlank()) {
                                                productImage = request.getContextPath() + "/assets/client/images/shop/checkout-1.png";
                                            } else if (!productImage.startsWith("http")) {
                                                if (!productImage.startsWith("/")) {
                                                    productImage = "/" + productImage;
                                                }
                                                productImage = request.getContextPath() + productImage;
                                            }
                                            String productName = product.getName();
                                            int quantity = item.getQuantity();
                                            double price = product.getPrice() != null ? product.getPrice() : 0.0;
                                            double lineTotal = price * quantity;
                                %>
                                <div class="single-item">
                                    <div class="product-box">
                                        <figure class="image-box">
                                            <img src="<%= productImage %>" alt="<%= productName %>">
                                        </figure>
                                        <div>
                                            <h6><%= productName %></h6>
                                            <span>Số lượng: <%= quantity %></span>
                                        </div>
                                    </div>
                                    <h4><%= currencyFormat.format(lineTotal) %></h4>
                                </div>
                                <%
                                        }
                                    } else {
                                %>
                                <div class="single-item">
                                    <p>Giỏ hàng của bạn đang trống.</p>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <ul class="cost-box">
                                <li>
                                    <h4><span>Tạm tính</span></h4>
                                    <h4 id="checkout-subtotal"><%= currencyFormat.format(subtotal) %></h4>
                                </li>
                                <li>
                                    <h4><span>Phí vận chuyển</span></h4>
                                    <h4><span id="checkout-shipping"><%= currencyFormat.format(shippingFee) %></span></h4>
                                </li>
                            </ul>
                            <div class="total-box">
                                <h4><span>Tổng cộng</span></h4>
                                <h4 id="checkout-total"><%= currencyFormat.format(total) %></h4>
                            </div>
                            <div class="payment-option">
                                <div class="bank-payment">
                                    <div class="check-box mb_12">
                                        <input class="check" type="radio" id="checkbox3" name="payment" value="bank_transfer" checked>
                                        <label for="checkbox3">Chuyển khoản ngân hàng</label>
                                    </div>
                                    <p>Vui lòng sử dụng mã đơn hàng làm nội dung chuyển khoản để chúng tôi xác nhận nhanh chóng.</p>
                                </div>
                                <ul class="other-payment">
                                    <li>
                                        <div class="check-box mb_12">
                                            <input class="check" type="radio" id="checkbox4" name="payment" value="cod">
                                            <label for="checkbox4">Thanh toán khi nhận hàng (COD)</label>
                                        </div>
                                    </li>
                                    <!-- <li>
                                        <div class="check-box mb_12">
                                            <input class="check" type="radio" id="checkbox5" name="payment" value="card_paypal">
                                            <label for="checkbox5">Thẻ tín dụng/Ghi nợ hoặc Paypal</label>
                                        </div>
                                    </li> -->
                                </ul>
                            </div>
                            <div class="btn-box pt_30">
                                <button type="submit" class="theme-btn">Thanh toán<span></span><span></span><span></span><span></span></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </form>
        </div>
    </section>
    <!-- checkout-section end -->


    <!-- highlights-section -->
    <section class="highlights-section inner-highlights">
        <div class="large-container">
            <div class="inner-container clearfix">
                <div class="shape" style="background-image: url(${pageContext.request.contextPath}/assets/client/images/shape/shape-5.png);"></div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-23"></i></div>
                        <h5>Same day Product Delivery</h5>
                    </div>
                </div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-17"></i></div>
                        <h5>100% Customer Satisfaction</h5>
                    </div>
                </div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-25"></i></div>
                        <h5>Help and access is our mission</h5>
                    </div>
                </div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-38"></i></div>
                        <h5>100% quality Car Accessories</h5>
                    </div>
                </div>
                <div class="highlights-block-one">
                    <div class="inner-box">
                        <div class="icon-box"><i class="icon-27"></i></div>
                        <h5>24/7 Support for Clients</h5>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- highlights-section end -->


    <!-- main-footer -->
    <jsp:include page="../common/footer.jsp" />
    <!-- main-footer end -->



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
<script src="${pageContext.request.contextPath}/assets/client/js/bxslider.js"></script>

<!-- main-js -->
<script src="${pageContext.request.contextPath}/assets/client/js/script.js"></script>

<!-- Cart Management Script -->
<script src="${pageContext.request.contextPath}/assets/client/js/cart.js"></script>
<script>
(function() {
    const contextPath = '<%= request.getContextPath() %>';
    const freeShipThreshold = 500000;
    const shippingFee = 30000;
    
    function formatCurrency(amount) {
        return new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND'
        }).format(amount);
    }
    
    function updateCheckoutFromLocalStorage() {
        if (typeof CartManager === 'undefined') {
            console.error('CartManager is not defined');
            return;
        }
        
        const cartItems = CartManager.getCartItems();
        const subtotal = CartManager.getSubtotal();
        const shipping = subtotal >= freeShipThreshold || subtotal === 0 ? 0 : shippingFee;
        const total = subtotal + shipping;
        
        // Update order products
        const orderProducts = document.getElementById('checkout-order-products');
        if (orderProducts) {
            if (cartItems.length === 0) {
                orderProducts.innerHTML = '<div class="single-item"><p>Giỏ hàng của bạn đang trống.</p></div>';
            } else {
                let html = '';
                cartItems.forEach(item => {
                    let productImage = item.image_url || '';
                    if (!productImage || productImage === '') {
                        productImage = contextPath + '/assets/client/images/shop/checkout-1.png';
                    }
                    
                    const price = item.price || 0;
                    const quantity = item.quantity || 1;
                    const lineTotal = price * quantity;
                    
                    html += '';
                    html += '<div class="single-item">';
                    html += '<div class="product-box">';
                    html += '<figure class="image-box">';
                    html += '<img src="' + productImage + '" alt="'+ item.name +'">';
                    html += '</figure>';
                    html += '<div>';
                    html += '<h6>'+ item.name +'</h6>';
                    html += '<span>Số lượng: '+ quantity +'</span>';
                    html += '</div>';
                    html += '</div>';
                    html += '<h4>'+ formatCurrency(lineTotal) +'</h4>';
                    html += '</div>';
                });
                orderProducts.innerHTML = html;
            }
        }
        
        // Update subtotal
        const checkoutSubtotal = document.getElementById('checkout-subtotal');
        if (checkoutSubtotal) {
            checkoutSubtotal.textContent = formatCurrency(subtotal);
        }
        
        // Update shipping
        const checkoutShipping = document.getElementById('checkout-shipping');
        if (checkoutShipping) {
            checkoutShipping.textContent = formatCurrency(shipping);
        }
        
        // Update total
        const checkoutTotal = document.getElementById('checkout-total');
        if (checkoutTotal) {
            checkoutTotal.textContent = formatCurrency(total);
        }
        
        // Disable form submission if cart is empty
        const checkoutForm = document.querySelector('form[action*="checkout"]');
        if (checkoutForm) {
            const submitBtn = checkoutForm.querySelector('button[type="submit"]');
            if (cartItems.length === 0) {
                if (submitBtn) {
                    submitBtn.disabled = true;
                    submitBtn.style.opacity = '0.5';
                    submitBtn.style.cursor = 'not-allowed';
                }
            } else {
                if (submitBtn) {
                    submitBtn.disabled = false;
                    submitBtn.style.opacity = '1';
                    submitBtn.style.cursor = 'pointer';
                }
            }
        }
    }
    
    // Initialize on page load
    document.addEventListener('DOMContentLoaded', function() {
        // Update checkout display first from localStorage
        updateCheckoutFromLocalStorage();
        
        // Sync localStorage to server session in background (non-blocking)
        if (typeof CartManager !== 'undefined') {
            setTimeout(function() {
                CartManager.syncToServer(function(success) {
                    if (success) {
                        // Optionally refresh display after sync
                        // updateCheckoutFromLocalStorage();
                    }
                });
            }, 100);
        }
        
        // Sync before form submission
        const checkoutForm = document.querySelector('form[action*="checkout"]');
        if (checkoutForm) {
            checkoutForm.addEventListener('submit', function(e) {
                if (typeof CartManager !== 'undefined') {
                    const cartItems = CartManager.getCartItems();
                    if (cartItems.length === 0) {
                        e.preventDefault();
                        alert('Giỏ hàng của bạn đang trống. Vui lòng thêm sản phẩm trước khi thanh toán.');
                        return false;
                    }
                    
                    // Prevent default first
                    e.preventDefault();
                    
                    // Sync before submit (synchronous for form submission)
                    CartManager.syncToServer(function(success) {
                        if (success) {
                            // Submit form after successful sync
                            checkoutForm.submit();
                        } else {
                            alert('Có lỗi xảy ra khi đồng bộ giỏ hàng. Vui lòng thử lại.');
                        }
                    });
                    
                    return false;
                }
            });
        }
    });
    
    // Listen for storage events to sync across tabs
    window.addEventListener('storage', function(e) {
        if (e.key === 'shopping_cart') {
            updateCheckoutFromLocalStorage();
        }
    });
})();
</script>

</body><!-- End of .page_wrapper -->
</html>

