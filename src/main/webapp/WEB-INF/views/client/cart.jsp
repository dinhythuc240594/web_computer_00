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
<%
    // Không load từ session nữa, sẽ load từ localStorage bằng JavaScript
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    double subtotal = 0.0;
    double freeShipThreshold = 500000; // 500.000đ để được miễn phí vận chuyển
    double shippingFee = 0;
    double total = 0.0;
    double remainingForFreeShip = freeShipThreshold;
    int progressPercent = 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <title>Cửa hàng máy tính HCMUTE</title>

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
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/cart.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/shop-two.css" rel="stylesheet">
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

    <!-- cart section -->
    <section class="cart-section pb_80" style="padding-top: 40px;">
        <div class="large-container">
            <div class="sec-title centred pb_30">
                <h2>Giỏ hàng của bạn</h2>
            </div>
            <div class="row clearfix">
                <div class="col-lg-9 col-md-12 col-sm-12 content-side">
                    <div class="target-price mb_30" id="target-price-section">
                        <p>Giỏ hàng đang trống. Thêm sản phẩm để bắt đầu.</p>
                        <div class="progress-box">
                            <div class="bar">
                                <div class="bar-inner count-bar" id="progress-bar" data-percent="0%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="table-outer mb_30">
                        <table class="cart-table">
                            <thead class="cart-header">
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                                <th>&nbsp;</th>
                            </tr>
                            </thead>
                            <tbody id="cart-table-body">
                            <tr>
                                <td colspan="5" class="text-center">
                                    Hiện chưa có sản phẩm nào trong giỏ hàng.
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-sm-12 sidebar-side">
                    <div class="total-cart mb_30">
                        <!-- <div class="form-group mb_20">
                            <label for="customer-email">Email</label>
                            <input type="email" id="customer-email" name="email" placeholder="Nhập email của bạn" class="form-control">
                        </div>
                        <div class="form-group mb_20">
                            <label for="customer-address">Địa chỉ</label>
                            <input type="text" id="customer-address" name="address" placeholder="Nhập địa chỉ của bạn" class="form-control">
                        </div>
                        <div class="form-group mb_20">
                            <label for="customer-phone">Số Điện Thoại</label>
                            <input type="tel" id="customer-phone" name="phone" placeholder="Nhập số điện thoại của bạn" class="form-control">
                        </div> -->
                        <div class="total-box mb_20">
                            <h4>Tổng cộng</h4>
                            <h5 id="cart-total"><%= currencyFormat.format(0) %></h5>
                        </div>
                        <div class="btn-box">
                            <a href="<%= request.getContextPath() %>/checkout" class="theme-btn" id="checkout-btn">Thanh toán<span></span><span></span><span></span><span></span></a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- <div class="coupon-box">
                <div class="form-group">
                    <input type="text" name="coupon" placeholder="Apply Coupon">
                    <button type="button"><i class="icon-22"></i></button>
                </div>
            </div> -->
        </div>
    </section>
    <!-- cart section end -->

    <!-- highlights-section -->
    <jsp:include page="../common/highlight-section.jsp" />
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
    
    function updateCartFromLocalStorage() {
        if (typeof CartManager === 'undefined') {
            console.error('CartManager is not defined');
            // Show empty cart if CartManager not available
            const tbody = document.getElementById('cart-table-body');
            if (tbody) {
                tbody.innerHTML = '<tr><td colspan="5" class="text-center">Hiện chưa có sản phẩm nào trong giỏ hàng.</td></tr>';
            }
            return;
        }
        
        const cartItems = CartManager.getCartItems();
        const subtotal = CartManager.getSubtotal();
        const shipping = subtotal >= freeShipThreshold || subtotal === 0 ? 0 : shippingFee;
        const total = subtotal + shipping;
        const remainingForFreeShip = Math.max(0, freeShipThreshold - subtotal);
        const progressPercent = subtotal <= 0 ? 0 : Math.min(100, Math.round(subtotal / freeShipThreshold * 100));
        
        // Update cart table
        const tbody = document.getElementById('cart-table-body');
        if (tbody) {
            if (cartItems.length === 0) {
                tbody.innerHTML = '<tr><td colspan="5" class="text-center">Hiện chưa có sản phẩm nào trong giỏ hàng.</td></tr>';
            } else {
                let html = '';
                cartItems.forEach(item => {
                    let productImage = item.image_url || '';
                    if (!productImage || productImage === '') {
                        productImage = contextPath + '/assets/client/images/shop/cart-4.png';
                    }
                    
                    const productLink = item.slug 
                        ? contextPath + '/product?slug=' + item.slug
                        : contextPath + '/product?id=' + item.id;
                    
                    const price = item.price || 0;
                    const quantity = item.quantity || 1;
                    const lineTotal = price * quantity;
                    
                    // Escape HTML to prevent XSS
                    const escapeHtml = (text) => {
                        const map = {
                            '&': '&amp;',
                            '<': '&lt;',
                            '>': '&gt;',
                            '"': '&quot;',
                            "'": '&#039;'
                        };
                        return text ? text.replace(/[&<>"']/g, m => map[m]) : '';
                    };
                    
                    html += '';
                    html += '<tr>';
                    html += '<td class="product-column">';
                    html += '<div class="product-box">';
                    html += '<figure class="image-box">';
                    html += '<img src="' + escapeHtml(productImage) + '" alt="'+ escapeHtml(item.name || '') +'">';
                    html += '</figure>';
                    html += '<h6><a href="' + escapeHtml(productLink) + '">'+ escapeHtml(item.name || '') +'</a></h6>';
                    html += '</div>';
                    html += '</td>';
                    html += '<td>'+ formatCurrency(price) +'</td>';
                    html += '<td class="qty">';
                    html += '<div class="item-quantity">';
                    html += '<input class="quantity-spinner" type="text" value="'+ quantity +'" name="quantity" data-product-id="'+ item.id +'">';
                    html += '</div>';
                    html += '</td>';
                    html += '<td>'+ formatCurrency(lineTotal) +'</td>';
                    html += '<td>';
                    html += '<button type="button" class="cancel-btn remove-cart-item" data-product-id="'+ item.id +'"><i class="icon-9"></i></button>';
                    html += '</td>';
                    html += '</tr>';
                });
                tbody.innerHTML = html;
                
                // Reinitialize quantity spinners
                if (typeof $ !== 'undefined' && $.fn.TouchSpin) {
                    $('.quantity-spinner').each(function() {
                        const $this = $(this);
                        if (!$this.data('bootstrap-touchspin')) {
                            $this.TouchSpin({
                                min: 1,
                                max: 1000,
                                step: 1
                            }).on('change', function() {
                                const productId = parseInt($this.data('product-id'));
                                const newQuantity = parseInt($this.val()) || 1;
                                CartManager.updateQuantity(productId, newQuantity);
                                updateCartFromLocalStorage();
                            });
                        }
                    });
                }
            }
        }
        
        // Update target price section
        const targetPriceSection = document.getElementById('target-price-section');
        if (targetPriceSection) {
            let message = '';
            if (subtotal > 0 && remainingForFreeShip > 0) {
                message = '<p>Thêm <span id="remaining-amount">'+ formatCurrency(remainingForFreeShip) +'</span> để được miễn phí vận chuyển</p>';
            } else if (subtotal >= freeShipThreshold) {
                message = '<p>Bạn đã đủ điều kiện <span>miễn phí vận chuyển</span>.</p>';
            } else {
                message = '<p>Giỏ hàng đang trống. Thêm sản phẩm để bắt đầu.</p>';
            }
            targetPriceSection.innerHTML = message + '<div class="progress-box"><div class="bar"><div class="bar-inner count-bar" id="progress-bar" data-percent="'+ progressPercent +'%"></div></div></div>';
        }
        
        // Update subtotal
        const cartSubtotal = document.getElementById('cart-subtotal');
        if (cartSubtotal) {
            cartSubtotal.textContent = formatCurrency(subtotal);
        }
        
        // Update total
        const cartTotal = document.getElementById('cart-total');
        if (cartTotal) {
            cartTotal.textContent = formatCurrency(total);
        }
        
        // Update checkout button
        const checkoutBtn = document.getElementById('checkout-btn');
        if (checkoutBtn) {
            if (cartItems.length === 0) {
                checkoutBtn.style.opacity = '0.5';
                checkoutBtn.style.cursor = 'not-allowed';
                checkoutBtn.href = contextPath + '/cart';
                checkoutBtn.onclick = function(e) {
                    e.preventDefault();
                    return false;
                };
            } else {
                checkoutBtn.style.opacity = '1';
                checkoutBtn.style.cursor = 'pointer';
                checkoutBtn.href = contextPath + '/checkout';
                checkoutBtn.onclick = null;
            }
        }
    }
    
    // Initialize on page load
    document.addEventListener('DOMContentLoaded', function() {
        // Update cart display first from localStorage
        // Wait a bit to ensure CartManager is loaded
        if (typeof CartManager === 'undefined') {
            // If CartManager not loaded yet, wait and retry
            setTimeout(function() {
                if (typeof CartManager !== 'undefined') {
                    updateCartFromLocalStorage();
                } else {
                    // If still not loaded, show empty cart
                    console.warn('CartManager not found, showing empty cart');
                }
            }, 100);
        } else {
            updateCartFromLocalStorage();
        }
        
        // Sync localStorage to server session in background (non-blocking)
        if (typeof CartManager !== 'undefined') {
            // Delay sync a bit to avoid conflicts
            setTimeout(function() {
                CartManager.syncToServer(function(success) {
                    if (success) {
                        // Optionally refresh display after sync
                        // updateCartFromLocalStorage();
                    }
                });
            }, 100);
        }
        
        // Handle remove button clicks (using event delegation)
        document.addEventListener('click', function(e) {
            if (e.target.closest('.remove-cart-item')) {
                const btn = e.target.closest('.remove-cart-item');
                const productId = parseInt(btn.getAttribute('data-product-id'));
                if (productId && typeof CartManager !== 'undefined') {
                    CartManager.removeFromCart(productId);
                    updateCartFromLocalStorage();
                    // Sync after remove (non-blocking)
                    setTimeout(function() {
                        CartManager.syncToServer();
                    }, 50);
                }
            }
        });
        
        // Handle quantity updates (using event delegation)
        document.addEventListener('change', function(e) {
            if (e.target.classList.contains('quantity-spinner')) {
                const input = e.target;
                const productId = parseInt(input.getAttribute('data-product-id'));
                const newQuantity = parseInt(input.value) || 1;
                if (productId && typeof CartManager !== 'undefined') {
                    CartManager.updateQuantity(productId, newQuantity);
                    updateCartFromLocalStorage();
                    // Sync after update (non-blocking)
                    setTimeout(function() {
                        CartManager.syncToServer();
                    }, 50);
                }
            }
        });
    });
    
    // Listen for storage events to sync across tabs
    window.addEventListener('storage', function(e) {
        if (e.key === 'shopping_cart') {
            updateCartFromLocalStorage();
        }
    });
})();
</script>

</body><!-- End of .page_wrapper -->
</html>

