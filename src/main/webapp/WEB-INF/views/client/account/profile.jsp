<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.UserDAO" %>
<%@ page import="model.OrderDAO" %>
<%@ page import="model.OrderItemDAO" %>
<%@ page import="model.WishlistDAO" %>
<%@ page import="model.ProductDAO" %>
<%@ page import="model.NewsletterDAO" %>
<%@ page import="service.UserService" %>
<%@ page import="service.OrderService" %>
<%@ page import="service.OrderItemService" %>
<%@ page import="service.WishlistService" %>
<%@ page import="service.ProductService" %>
<%@ page import="serviceimpl.UserServiceImpl" %>
<%@ page import="serviceimpl.OrderServiceImpl" %>
<%@ page import="serviceimpl.OrderItemServiceImpl" %>
<%@ page import="serviceimpl.WishlistServiceImpl" %>
<%@ page import="serviceimpl.ProductServiceImpl" %>
<%@ page import="utilities.DataSourceUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    String sessionUsername = (String) session.getAttribute("username");
    UserDAO currentUser = null;
    List<OrderDAO> userOrders = new ArrayList<>();
    List<WishlistDAO> userWishlist = new ArrayList<>();
    
    // Pagination parameters
    int ordersPage = 1;
    int ordersPageSize = 10;
    int ordersTotalPages = 1;
    int ordersTotal = 0;
    
    if (sessionUsername != null && !sessionUsername.isBlank()) {
        try {
            javax.sql.DataSource ds = DataSourceUtil.getDataSource();
            UserService userService = new UserServiceImpl(ds);
            OrderService orderService = new OrderServiceImpl(ds);
            WishlistService wishlistService = new WishlistServiceImpl(ds);
            OrderItemService orderItemService = new OrderItemServiceImpl(ds);
            ProductService productService = new ProductServiceImpl(ds);
            
            currentUser = userService.findByUsername(sessionUsername);
            if (currentUser != null) {
                // Get pagination parameters from request or use defaults
                try {
                    String pageParam = request.getParameter("page");
                    if (pageParam != null && !pageParam.isBlank()) {
                        ordersPage = Integer.parseInt(pageParam);
                        if (ordersPage < 1) ordersPage = 1;
                    }
                } catch (NumberFormatException e) {
                    ordersPage = 1;
                }
                
                // Get pagination info from servlet if available, otherwise calculate
                Object ordersPageObj = request.getAttribute("ordersPage");
                Object ordersTotalPagesObj = request.getAttribute("ordersTotalPages");
                Object ordersTotalObj = request.getAttribute("ordersTotal");
                Object ordersPageSizeObj = request.getAttribute("ordersPageSize");
                
                if (ordersPageObj != null) ordersPage = (Integer) ordersPageObj;
                if (ordersTotalPagesObj != null) ordersTotalPages = (Integer) ordersTotalPagesObj;
                if (ordersTotalObj != null) ordersTotal = (Integer) ordersTotalObj;
                if (ordersPageSizeObj != null) ordersPageSize = (Integer) ordersPageSizeObj;
                
                // Load orders with pagination
                int offset = (ordersPage - 1) * ordersPageSize;
                if (ordersTotal == 0) {
                    ordersTotal = orderService.countByUserId(currentUser.getId());
                    ordersTotalPages = (int) Math.ceil((double) ordersTotal / ordersPageSize);
                }
                userOrders = orderService.findByUserIdWithPagination(currentUser.getId(), offset, ordersPageSize);
                userWishlist = wishlistService.findByUserId(currentUser.getId());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    String displayName = currentUser != null && currentUser.getFullname() != null && !currentUser.getFullname().isBlank()
            ? currentUser.getFullname()
            : (sessionUsername != null ? sessionUsername : "Khách");
    String displayEmail = currentUser != null && currentUser.getEmail() != null ? currentUser.getEmail() : "";
    String displayPhone = currentUser != null && currentUser.getPhone() != null ? currentUser.getPhone() : "Chưa cập nhật";
    String displayAddress = currentUser != null && currentUser.getAddress() != null ? currentUser.getAddress() : "Chưa cập nhật";
    
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm");
    dateFormat.setTimeZone(java.util.TimeZone.getTimeZone("GMT+7"));
    
    String tab = request.getParameter("tab");
    String message = request.getParameter("message");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <title>Tài khoản của tôi | HCMUTE Computer Store</title>

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
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/account.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/highlights.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/module-css/footer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/client/css/responsive.css" rel="stylesheet">
</head>

<body>
<div class="boxed_wrapper ltr">

    <!-- <jsp:include page="../../common/preloader.jsp" /> -->

    <!-- main header -->
    <jsp:include page="../../common/header.jsp" />
    <!-- main-header end -->

    <jsp:include page="../../common/mobile-menu.jsp" />
    <jsp:include page="../../common/category-menu.jsp" />


    <!-- account-section -->
    <section class="account-section pb_80">
        <div class="large-container">
            <div class="sec-title centred pb_20">
                <h2>Tài khoản của tôi</h2>
                <%
                    String success = request.getParameter("success");
                    if ("updated".equals(success)) {
                %>
                <p style="color: #28a745; margin-top: 10px;">Cập nhật thông tin cá nhân thành công!</p>
                <%
                    } else if ("password_changed".equals(success)) {
                %>
                <p style="color: #28a745; margin-top: 10px;">Đổi mật khẩu thành công!</p>
                <%
                    } else if ("newsletter_unsubscribed".equals(success)) {
                %>
                <p style="color: #28a745; margin-top: 10px;">Đã hủy đăng ký newsletter thành công!</p>
                <%
                    }
                    String error = request.getParameter("error");
                    if ("newsletter_unsubscribe_failed".equals(error)) {
                %>
                <p style="color: #dc3545; margin-top: 10px;">Không thể hủy đăng ký newsletter. Vui lòng thử lại sau.</p>
                <%
                    } else if ("no_email".equals(error)) {
                %>
                <p style="color: #dc3545; margin-top: 10px;">Không tìm thấy email để hủy đăng ký newsletter.</p>
                <%
                    }
                    if (message != null) {
                        if ("added".equals(message)) {
                %>
                <p style="color: #28a745; margin-top: 10px;">Đã thêm vào danh sách yêu thích!</p>
                <%
                        } else if ("removed".equals(message)) {
                %>
                <p style="color: #28a745; margin-top: 10px;">Đã xóa khỏi danh sách yêu thích!</p>
                <%
                        } else if ("already_exists".equals(message)) {
                %>
                <p style="color: #ffc107; margin-top: 10px;">Sản phẩm đã có trong danh sách yêu thích!</p>
                <%
                        } else if ("error".equals(message)) {
                %>
                <p style="color: #dc2626; margin-top: 10px;">Có lỗi xảy ra. Vui lòng thử lại!</p>
                <%
                        }
                    }
                %>
            </div>
            <div class="inner-container">
                <div class="tabs-box">
                    <div class="account-info">
                        <div class="upper-box centred mb_40">
                            <figure class="image-box">
                                <%
                                    String avatarUrl = "${pageContext.request.contextPath}/assets/client/images/default-avatar.svg";
                                    if (currentUser != null && currentUser.getAvatar() != null && currentUser.getAvatar().length > 0) {
                                        avatarUrl = request.getContextPath() + "/avatar?userId=" + currentUser.getId();
                                    }
                                %>
                                <img src="<%= avatarUrl %>" alt="Ảnh đại diện" style="width: 120px; height: 120px; object-fit: cover; border-radius: 50%;">
                            </figure>
                            <h4><%= displayName %></h4>
                            <%
                                if (displayEmail != null && !displayEmail.isBlank()) {
                            %>
                            <a href="mailto:<%= displayEmail %>"><%= displayEmail %></a>
                            <%
                                } else {
                            %>
                            <span>Chưa cập nhật email</span>
                            <%
                                }
                            %>
                        </div>
                        <ul class="tab-btns tab-buttons clearfix">
                            <li class="tab-btn <%= (tab == null || tab.equals("info")) ? "active-btn" : "" %>" data-tab="#tab-1">Thông tin cá nhân</li>
                            <% if(currentUser.getRole().equalsIgnoreCase("CUSTOMER")) {%>
                            <!-- <li class="tab-btn <%= "payment".equals(tab) ? "active-btn" : "" %>" data-tab="#tab-2">Thanh toán & hoá đơn</li> -->
                            <li class="tab-btn <%= "orders".equals(tab) ? "active-btn" : "" %>" data-tab="#tab-3">Lịch sử đơn hàng</li>
<%--                            <li class="tab-btn <%= "wishlist".equals(tab) ? "active-btn" : "" %>" data-tab="#tab-4">Danh sách yêu thích</li>--%>
                            <% } %>
                        </ul>
                    </div>
                    <div class="tabs-content">
                        <div class="tab <%= (tab == null || tab.equals("info")) ? "active-tab" : "" %>" id="tab-1">
                            <div class="personal-info">
                                <h3>Thông tin cá nhân</h3>
                                <p>Quản lý thông tin cơ bản, số điện thoại và email liên hệ của bạn.</p>
                                
                                <div class="container mt-4">
                                    <div class="row">
                                        <div class="col-md-8 offset-md-2">
                                            <div class="card shadow-sm">
                                                <div class="card-body p-4">
                                                    <form>
                                                        <div class="row mb-3">
                                                            <label for="fullname" class="col-sm-3 col-form-label fw-bold">Họ và tên:</label>
                                                            <div class="col-sm-9">
                                                                <input type="text" class="form-control" id="fullname" value="<%= displayName %>" readonly>
                                                            </div>
                                                        </div>
                                                        <div class="row mb-3">
                                                            <label for="phone" class="col-sm-3 col-form-label fw-bold">Số điện thoại:</label>
                                                            <div class="col-sm-9">
                                                                <input type="text" class="form-control" id="phone" value="<%= displayPhone %>" readonly>
                                                            </div>
                                                        </div>
                                                        <div class="row mb-3">
                                                            <label for="email" class="col-sm-3 col-form-label fw-bold">Email:</label>
                                                            <div class="col-sm-9">
                                                                <input type="email" class="form-control" id="email" value="<%= displayEmail != null && !displayEmail.isBlank() ? displayEmail : "Chưa cập nhật" %>" readonly>
                                                            </div>
                                                        </div>
                                                        <div class="row mb-3">
                                                            <label for="address" class="col-sm-3 col-form-label fw-bold">Địa chỉ:</label>
                                                            <div class="col-sm-9">
                                                                <textarea class="form-control" id="address" rows="3" readonly><%= displayAddress %></textarea>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-sm-9 offset-sm-3">
                                                                <a href="${pageContext.request.contextPath}/user?action=edit-profile" class="btn btn-primary">
                                                                    <i class="fas fa-edit"></i> Chỉnh sửa thông tin
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row mt-4">
                                        <div class="col-md-8 offset-md-2">
                                            <div class="card shadow-sm">
                                                <div class="card-body p-4">
                                                    <h5 class="card-title mb-3">Đổi mật khẩu</h5>
                                                    <p class="text-muted mb-3">Thay đổi mật khẩu của bạn để bảo mật tài khoản. Sau khi đổi mật khẩu, bạn sẽ cần đăng nhập lại.</p>
                                                    <a href="${pageContext.request.contextPath}/user?action=change-password" class="btn btn-warning">
                                                        <i class="fas fa-key"></i> Đổi mật khẩu
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <%
                                        NewsletterDAO newsletterSubscription = (NewsletterDAO) request.getAttribute("newsletterSubscription");
                                        boolean isSubscribed = newsletterSubscription != null && 
                                                               "active".equals(newsletterSubscription.getStatus());
                                    %>
                                    <div class="row mt-4">
                                        <div class="col-md-8 offset-md-2">
                                            <div class="card shadow-sm">
                                                <div class="card-body p-4">
                                                    <h5 class="card-title mb-3">
                                                        <i class="fas fa-envelope"></i> Newsletter
                                                    </h5>
                                                    <p class="text-muted mb-3">
                                                        Quản lý đăng ký nhận tin từ chúng tôi. Bạn sẽ nhận được thông tin về sản phẩm mới, khuyến mãi và tin tức công nghệ.
                                                    </p>
                                                    
                                                    <% if (isSubscribed) { %>
                                                    <div class="alert alert-success mb-3">
                                                        <i class="fas fa-check-circle"></i> 
                                                        <strong>Bạn đang đăng ký nhận tin</strong>
                                                        <br>
                                                        <small>Email: <%= currentUser.getEmail() %></small>
                                                        <% if (newsletterSubscription.getSubscribed_at() != null) { %>
                                                        <br>
                                                        <small>Đăng ký từ: <%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(newsletterSubscription.getSubscribed_at()) %></small>
                                                        <% } %>
                                                    </div>
                                                    <form method="post" action="${pageContext.request.contextPath}/user" 
                                                          onsubmit="return confirm('Bạn có chắc chắn muốn hủy đăng ký newsletter? Bạn sẽ không nhận được thông tin về sản phẩm mới và khuyến mãi nữa.');">
                                                        <input type="hidden" name="action" value="unsubscribeNewsletter">
                                                        <button type="submit" class="btn btn-danger">
                                                            <i class="fas fa-times-circle"></i> Hủy đăng ký Newsletter
                                                        </button>
                                                    </form>
                                                    <% } else { %>
                                                    <div class="alert alert-secondary mb-3">
                                                        <i class="fas fa-info-circle"></i> 
                                                        <strong>Bạn chưa đăng ký nhận tin</strong>
                                                        <% if (newsletterSubscription != null && "unsubscribed".equals(newsletterSubscription.getStatus())) { %>
                                                        <br>
                                                        <small>Bạn đã hủy đăng ký trước đó. Bạn có thể đăng ký lại từ trang chủ.</small>
                                                        <% } else { %>
                                                        <br>
                                                        <small>Đăng ký ngay từ form ở footer trang chủ để nhận thông tin mới nhất!</small>
                                                        <% } %>
                                                    </div>
                                                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
                                                        <i class="fas fa-arrow-right"></i> Đăng ký Newsletter
                                                    </a>
                                                    <% } %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% if(currentUser.getRole().equalsIgnoreCase("CUSTOMER")) {%>

                        <!-- <div class="tab <%= "payment".equals(tab) ? "active-tab" : "" %>" id="tab-2">
                            <h3>Thanh toán & hoá đơn</h3>
                            <div class="payment-option">
                                <div class="bank-payment">
                                    <div class="check-box mb_12">
                                        <input class="check" type="radio" id="payment-bank" name="payment" checked>
                                        <label for="payment-bank">Chuyển khoản ngân hàng</label>
                                    </div>
                                    <p>Vui lòng ghi rõ mã đơn hàng ở phần nội dung chuyển khoản để chúng tôi xác nhận nhanh chóng.</p>
                                </div>
                                <ul class="other-payment">
                                    <li>
                                        <div class="check-box mb_12">
                                            <input class="check" type="radio" id="payment-cod" name="payment">
                                            <label for="payment-cod">Thanh toán khi nhận hàng</label>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="check-box mb_12">
                                            <input class="check" type="radio" id="payment-card" name="payment">
                                            <label for="payment-card">Thẻ tín dụng/Ghi nợ hoặc Paypal</label>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div> -->

                        <div class="tab <%= "orders".equals(tab) ? "active-tab" : "" %>" id="tab-3">
                            <h3>Lịch sử đơn hàng</h3>
                            <%
                                // Handle success/error messages for order cancellation
                                String successMsg = request.getParameter("success");
                                String errorMsg = request.getParameter("error");
                                if (successMsg != null && "order_cancelled".equals(successMsg)) {
                            %>
                            <div class="alert alert-success" style="padding: 15px; margin-bottom: 20px; border: 1px solid #c3e6cb; border-radius: 4px; background-color: #d4edda; color: #155724;">
                                <strong>Thành công!</strong> Đơn hàng đã được hủy thành công.
                            </div>
                            <%
                                }
                                if (errorMsg != null) {
                                    String errorText = "";
                                    if ("invalid_order".equals(errorMsg)) errorText = "Mã đơn hàng không hợp lệ.";
                                    else if ("order_not_found".equals(errorMsg)) errorText = "Không tìm thấy đơn hàng.";
                                    else if ("cannot_cancel".equals(errorMsg)) errorText = "Chỉ có thể hủy đơn hàng ở trạng thái 'Chờ xử lý'.";
                                    else if ("cancel_failed".equals(errorMsg)) errorText = "Có lỗi xảy ra khi hủy đơn hàng. Vui lòng thử lại.";
                                    else errorText = "Có lỗi xảy ra.";
                            %>
                            <div class="alert alert-danger" style="padding: 15px; margin-bottom: 20px; border: 1px solid #f5c6cb; border-radius: 4px; background-color: #f8d7da; color: #721c24;">
                                <strong>Lỗi!</strong> <%= errorText %>
                            </div>
                            <%
                                }
                            %>
                            <div class="history-box">
                                <%
                                    if (userOrders == null || userOrders.isEmpty()) {
                                %>
                                <p>Bạn chưa có đơn hàng nào.</p>
                                <%
                                    } else {
                                        try {
                                            javax.sql.DataSource ds = DataSourceUtil.getDataSource();
                                            OrderItemService orderItemService = new OrderItemServiceImpl(ds);
                                            ProductService productService = new ProductServiceImpl(ds);
                                            
                                            for (OrderDAO order : userOrders) {
                                                List<OrderItemDAO> orderItems = orderItemService.findByOrderId(order.getId());
                                                if (orderItems != null && !orderItems.isEmpty()) {
                                                    OrderItemDAO firstItem = orderItems.get(0);
                                                    ProductDAO product = productService.findById(firstItem.getProductId());
                                                    String productName = product != null ? product.getName() : "Sản phẩm #" + firstItem.getProductId();
                                                    String productImage = product != null && product.getImage() != null 
                                                            ? product.getImage() 
                                                            : "${pageContext.request.contextPath}/assets/client/images/resource/history-1.png";
                                                    String statusText = "";
                                                    boolean isCancelled = "CANCELLED".equals(order.getStatus()) || 
                                                                        (order.getIs_active() != null && !order.getIs_active());
                                                    if (isCancelled) {
                                                        statusText = "Đã hủy";
                                                    } else if ("PENDING".equals(order.getStatus())) {
                                                        statusText = "Chờ xử lý";
                                                    } else if ("PROCESSING".equals(order.getStatus())) {
                                                        statusText = "Đang xử lý";
                                                    } else if ("SHIPPED".equals(order.getStatus())) {
                                                        statusText = "Đang giao";
                                                    } else if ("DELIVERED".equals(order.getStatus())) {
                                                        statusText = "Đã giao";
                                                    } else {
                                                        statusText = order.getStatus() != null ? order.getStatus() : "Chưa xác định";
                                                    }
                                %>
                                <div class="single-history">
                                    <div class="product-box">
                                        <figure class="image-box">
                                            <img src="<%= productImage %>" alt="<%= productName %>">
                                        </figure>
                                        <div class="product-info">
                                            <h6><%= productName %><% if (orderItems.size() > 1) { %> và <%= orderItems.size() - 1 %> sản phẩm khác<% } %></h6>
                                            <span>#<%= order.getId() %></span>
                                            <% if (order.getOrderDate() != null) { %>
                                            <span style="display: block; color: #6c757d; font-size: 14px; margin-top: 5px;">
                                                <i class="fas fa-calendar-alt"></i> Ngày đặt: <%= dateFormat.format(order.getOrderDate()) %>
                                            </span>
                                            <% } %>
                                            <h4><%= currencyFormat.format(order.getTotalPrice()) %></h4>
                                        </div>
                                    </div>
                                    <span class="text"><%= statusText %></span>
                                    <div style="margin-left: 10px; display: inline-block;">
                                        <a href="${pageContext.request.contextPath}/order?id=<%= order.getId() %>" style="color: #007bff; text-decoration: none; margin-right: 10px;">Xem chi tiết</a>
                                        <% if ("PENDING".equals(order.getStatus()) && !isCancelled) { %>
                                        <form method="post" action="${pageContext.request.contextPath}/user" style="display: inline-block;" onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?');">
                                            <input type="hidden" name="action" value="cancelOrder">
                                            <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                            <button type="submit" style="background-color: #dc3545; color: white; border: none; padding: 5px 15px; border-radius: 4px; cursor: pointer; font-size: 14px;">Hủy đơn</button>
                                        </form>
                                        <% } %>
                                    </div>
                                </div>
                                <%
                                                }
                                            }
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                %>
                                <p>Có lỗi xảy ra khi tải đơn hàng.</p>
                                <%
                                        }
                                    }
                                %>
                            </div>
                            <%
                                // Pagination controls
                                if (ordersTotal > 0 && ordersTotalPages > 1) {
                            %>
                            <div class="pagination-container" style="margin-top: 30px; text-align: center;">
                                <nav aria-label="Phân trang đơn hàng">
                                    <ul class="pagination justify-content-center" style="display: inline-flex; list-style: none; padding: 0;">
                                        <%
                                            // Previous button
                                            if (ordersPage > 1) {
                                        %>
                                        <li class="page-item">
                                            <a class="page-link" href="${pageContext.request.contextPath}/user?tab=orders&page=<%= ordersPage - 1 %>" style="padding: 8px 15px; margin: 0 5px; border: 1px solid #ddd; border-radius: 4px; text-decoration: none; color: #007bff; background-color: #fff;">Trước</a>
                                        </li>
                                        <%
                                            } else {
                                        %>
                                        <li class="page-item disabled">
                                            <span class="page-link" style="padding: 8px 15px; margin: 0 5px; border: 1px solid #ddd; border-radius: 4px; color: #6c757d; background-color: #e9ecef; cursor: not-allowed;">Trước</span>
                                        </li>
                                        <%
                                            }
                                            
                                            // Page numbers
                                            int startPage = Math.max(1, ordersPage - 2);
                                            int endPage = Math.min(ordersTotalPages, ordersPage + 2);
                                            
                                            if (startPage > 1) {
                                        %>
                                        <li class="page-item">
                                            <a class="page-link" href="${pageContext.request.contextPath}/user?tab=orders&page=1" style="padding: 8px 15px; margin: 0 5px; border: 1px solid #ddd; border-radius: 4px; text-decoration: none; color: #007bff; background-color: #fff;">1</a>
                                        </li>
                                        <%
                                            if (startPage > 2) {
                                        %>
                                        <li class="page-item disabled">
                                            <span class="page-link" style="padding: 8px 15px; margin: 0 5px; border: none; color: #6c757d;">...</span>
                                        </li>
                                        <%
                                            }
                                            }
                                            
                                            for (int i = startPage; i <= endPage; i++) {
                                                if (i == ordersPage) {
                                        %>
                                        <li class="page-item active">
                                            <span class="page-link" style="padding: 8px 15px; margin: 0 5px; border: 1px solid #007bff; border-radius: 4px; background-color: #007bff; color: #fff; font-weight: bold;"><%= i %></span>
                                        </li>
                                        <%
                                                } else {
                                        %>
                                        <li class="page-item">
                                            <a class="page-link" href="${pageContext.request.contextPath}/user?tab=orders&page=<%= i %>" style="padding: 8px 15px; margin: 0 5px; border: 1px solid #ddd; border-radius: 4px; text-decoration: none; color: #007bff; background-color: #fff;"><%= i %></a>
                                        </li>
                                        <%
                                                }
                                            }
                                            
                                            if (endPage < ordersTotalPages) {
                                                if (endPage < ordersTotalPages - 1) {
                                        %>
                                        <li class="page-item disabled">
                                            <span class="page-link" style="padding: 8px 15px; margin: 0 5px; border: none; color: #6c757d;">...</span>
                                        </li>
                                        <%
                                                }
                                        %>
                                        <li class="page-item">
                                            <a class="page-link" href="${pageContext.request.contextPath}/user?tab=orders&page=<%= ordersTotalPages %>" style="padding: 8px 15px; margin: 0 5px; border: 1px solid #ddd; border-radius: 4px; text-decoration: none; color: #007bff; background-color: #fff;"><%= ordersTotalPages %></a>
                                        </li>
                                        <%
                                            }
                                            
                                            // Next button
                                            if (ordersPage < ordersTotalPages) {
                                        %>
                                        <li class="page-item">
                                            <a class="page-link" href="${pageContext.request.contextPath}/user?tab=orders&page=<%= ordersPage + 1 %>" style="padding: 8px 15px; margin: 0 5px; border: 1px solid #ddd; border-radius: 4px; text-decoration: none; color: #007bff; background-color: #fff;">Sau</a>
                                        </li>
                                        <%
                                            } else {
                                        %>
                                        <li class="page-item disabled">
                                            <span class="page-link" style="padding: 8px 15px; margin: 0 5px; border: 1px solid #ddd; border-radius: 4px; color: #6c757d; background-color: #e9ecef; cursor: not-allowed;">Sau</span>
                                        </li>
                                        <%
                                            }
                                        %>
                                    </ul>
                                </nav>
                                <p style="margin-top: 10px; color: #6c757d; font-size: 14px;">
                                    Hiển thị <%= (ordersPage - 1) * ordersPageSize + 1 %> - <%= Math.min(ordersPage * ordersPageSize, ordersTotal) %> trong tổng số <%= ordersTotal %> đơn hàng
                                </p>
                            </div>
                            <%
                                }
                            %>
                        </div>
                        <div class="tab <%= "wishlist".equals(tab) ? "active-tab" : "" %>" id="tab-4">
                            <h3>Danh sách yêu thích</h3>
                            <%
                                if (userWishlist == null || userWishlist.isEmpty()) {
                            %>
                            <p>Chưa có sản phẩm nào trong danh sách yêu thích.</p>
                            <%
                                } else {
                                    try {
                                        javax.sql.DataSource ds = DataSourceUtil.getDataSource();
                                        ProductService productService = new ProductServiceImpl(ds);
                            %>
                            <div class="row clearfix" style="margin-top: 20px;">
                                <%
                                    for (WishlistDAO wishlistItem : userWishlist) {
                                        ProductDAO product = productService.findById(wishlistItem.getProductId());
                                        if (product != null) {
                                            String productImage = product.getImage() != null && !product.getImage().isBlank()
                                                    ? product.getImage()
                                                    : "${pageContext.request.contextPath}/assets/client/images/resource/history-1.png";
                                %>
                                <div class="col-lg-3 col-md-4 col-sm-6 single-column" style="margin-bottom: 20px;">
                                    <div class="single-item" style="border: 1px solid #e5e5e5; padding: 15px; border-radius: 10px;">
                                        <figure class="image-box" style="margin-bottom: 10px;">
                                            <img src="<%= productImage %>" alt="<%= product.getName() %>" style="width: 100%; height: 200px; object-fit: cover; border-radius: 5px;">
                                        </figure>
                                        <div class="product-info">
                                            <h6 style="margin-bottom: 5px;"><a href="${pageContext.request.contextPath}/product?slug=<%= product.getSlug() != null ? product.getSlug() : "" %>" style="color: #333; text-decoration: none;"><%= product.getName() %></a></h6>
                                            <h4 style="color: #e52929; margin-bottom: 10px;"><%= currencyFormat.format(product.getPrice()) %></h4>
                                            <a href="${pageContext.request.contextPath}/wishlist?action=remove&productId=<%= product.getId() %>" class="theme-btn" style="text-decoration: none; display: inline-block; padding: 8px 15px; font-size: 14px; background: #dc2626;">Xóa</a>
                                        </div>
                                    </div>
                                </div>
                                <%
                                        }
                                    }
                                %>
                            </div>
                            <%
                                    } catch (Exception e) {
                                        e.printStackTrace();
                            %>
                            <p>Có lỗi xảy ra khi tải danh sách yêu thích.</p>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <% } %>
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
    // Handle tab switching from URL parameter
    $(document).ready(function() {
        var tabParam = '<%= tab != null ? tab : "" %>';
        if (tabParam) {
            $('.tab-btn').removeClass('active-btn');
            $('.tab').removeClass('active-tab');
            
            if (tabParam === 'orders') {
                $('.tab-btn[data-tab="#tab-3"]').addClass('active-btn');
                $('#tab-3').addClass('active-tab');
            } else if (tabParam === 'wishlist') {
                $('.tab-btn[data-tab="#tab-4"]').addClass('active-btn');
                $('#tab-4').addClass('active-tab');
            } else if (tabParam === 'payment') {
                $('.tab-btn[data-tab="#tab-2"]').addClass('active-btn');
                $('#tab-2').addClass('active-tab');
            }
        }
    });
</script>
</body>
</html>


