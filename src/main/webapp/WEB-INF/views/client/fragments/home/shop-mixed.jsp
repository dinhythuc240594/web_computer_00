<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.ProductDAO" %>
<%
    List<ProductDAO> phoneProducts = (List<ProductDAO>) request.getAttribute("homePhoneProducts");
    List<ProductDAO> laptopProducts = (List<ProductDAO>) request.getAttribute("homeLaptopProducts");
    String contextPath = request.getContextPath();
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    String fallbackImage = contextPath + "/assets/client/images/shop/shop-10.png";
%>
<!-- shop-three -->
    <section class="shop-three pb_50">
        <div class="large-container">
            <div class="row clearfix">
                <div class="col-lg-3 col-md-6 col-sm-12 shop-block">
                    <div class="shop-block-three" style="height: 100%;">
                        <div class="inner-box" style="height: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center;">
                            <span class="text" style="font-size: 22px; font-weight: 700; letter-spacing: 0.5px;">Điện thoại</span>
                            <figure class="image r_0 b_10 float-bob-y" style="margin: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center;">
                                <img src="${pageContext.request.contextPath}/assets/client/images/background/banner13.webp" alt="" style="width: 100%; height: 100%; object-fit: cover; border-radius: 8px;">
                            </figure>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9 col-md-6 col-sm-12 shop-block">
                    <style>
                        .phone-grid .shop-block-two .inner-box {
                            display: flex;
                            flex-direction: column;
                            height: 100%;
                            min-height: 420px;
                        }
                        .phone-grid .shop-block-two .lower-content {
                            flex: 1;
                            display: flex;
                            flex-direction: column;
                        }
                        .phone-grid .shop-block-two .image-box figure {
                            height: 220px;
                            overflow: hidden;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                        }
                        .phone-grid .shop-block-two .image-box img {
                            width: 100%;
                            height: 100%;
                            object-fit: cover;
                        }
                        .phone-grid .shop-block-two .image-box {
                            position: relative;
                        }
                        .phone-grid .discount-product,
                        .phone-grid .new-product {
                            position: absolute;
                            top: 10px;
                            background: #ff4444;
                            color: white;
                            padding: 5px 10px;
                            border-radius: 5px;
                            font-weight: bold;
                            z-index: 10;
                            font-size: 13px;
                            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
                        }
                        .phone-grid .discount-product {
                            left: 10px;
                        }
                        .phone-grid .new-product {
                            right: 10px;
                            background: #28a745;
                        }
                    </style>
                    <div class="row clearfix phone-grid">
                        <%
                            if (phoneProducts != null && !phoneProducts.isEmpty()) {
                                int count = 0;
                                for (ProductDAO product : phoneProducts) {
                                    if (count >= 8) break;
                                    count++;

                                    String productImage = product.getImage();
                                    if (productImage == null || productImage.isBlank()) {
                                        productImage = fallbackImage;
                                    }
                                    if (!productImage.startsWith("http")) {
                                        productImage = productImage.startsWith("/") ? contextPath + productImage : productImage;
                                    }

                                    String productLink = product.getSlug() != null && !product.getSlug().isBlank()
                                            ? contextPath + "/product?slug=" + product.getSlug()
                                            : contextPath + "/product?id=" + product.getId();

                                    boolean isOnSale = product.getIs_on_sale() != null && product.getIs_on_sale() && product.isCurrentlyOnSale();
                                    Double originalPrice = product.getOriginalPrice();
                                    Double currentPrice = product.getCurrentPrice();
                                    Double discountPercent = product.getCalculatedDiscountPercentage();
                                    boolean inStock = product.getStock_quantity() > 0;
                        %>
                        <div class="col-lg-3 col-md-4 col-sm-6 shop-block-two">
                            <div class="inner-box">
                                <div class="image-box">
                                    <% if (product.isNewProduct()) { %>
                                    <span class="new-product">New</span>
                                    <% if (isOnSale && discountPercent != null && discountPercent > 0) { %>
                                    <span class="discount-product" style="right: 10px; left: auto;">-<%= Math.round(discountPercent) %>%</span>
                                    <% } %>
                                    <% } else if (isOnSale && discountPercent != null && discountPercent > 0) { %>
                                    <span class="discount-product" style="right: 10px; left: auto;">-<%= Math.round(discountPercent) %>%</span>
                                    <% } %>
                                    <figure class="image">
                                        <a href="<%= productLink %>">
                                            <img src="<%= productImage %>" alt="<%= product.getName() %>">
                                        </a>
                                    </figure>
                                </div>
                                <div class="lower-content">
                                    <h4 style="min-height: 48px; margin-bottom: 10px;">
                                        <a href="<%= productLink %>"><%= product.getName() %></a>
                                    </h4>
                                    <div class="price-box" style="margin-bottom: 10px;">
                                        <% if (isOnSale && originalPrice != null && currentPrice != null && originalPrice > currentPrice) { %>
                                            <h5 style="color: #ff4444; font-weight: bold; margin-bottom: 5px; font-size: 18px;">
                                                <%= currencyFormat.format(currentPrice) %>
                                            </h5>
                                            <h6 style="color: #999; text-decoration: line-through; font-size: 14px; margin: 0;">
                                                <%= currencyFormat.format(originalPrice) %>
                                            </h6>
                                        <% } else { %>
                                            <h5 style="font-size: 18px;">
                                                <%= currentPrice != null ? currencyFormat.format(currentPrice) : "Đang cập nhật" %>
                                            </h5>
                                        <% } %>
                                    </div>
                                    <div style="margin-top: auto;">
                                        <% if (inStock) { %>
                                            <span class="product-stock" style="display: block; margin-bottom: 10px;">
                                                <img src="<%= contextPath %>/assets/client/images/icons/icon-1.png" alt="">
                                                Còn <%= product.getStock_quantity() %> sản phẩm
                                            </span>
                                            <div class="cart-btn">
                                                <button type="button"
                                                        class="theme-btn add-to-cart-btn"
                                                        data-product-id="<%= product.getId() %>"
                                                        data-product-name="<%= product.getName() %>"
                                                        data-product-price="<%= currentPrice != null ? currentPrice : (product.getPrice() != null ? product.getPrice() : 0) %>"
                                                        data-product-image="<%= productImage %>"
                                                        data-product-slug="<%= product.getSlug() != null ? product.getSlug() : "" %>">
                                                    Thêm vào giỏ
                                                    <span></span><span></span><span></span><span></span>
                                                </button>
                                            </div>
                                        <% } else { %>
                                            <span class="product-stock-out" style="display: block; margin-bottom: 10px;">
                                                <img src="<%= contextPath %>/assets/client/images/icons/icon-2.png" alt="">
                                                Tạm hết hàng
                                            </span>
                                            <div class="cart-btn">
                                                <button type="button" class="theme-btn not" disabled>
                                                    Hết hàng
                                                    <span></span><span></span><span></span><span></span>
                                                </button>
                                            </div>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                                }
                            } else {
                        %>
                        <div class="col-12">
                            <div class="shop-block-four">
                                <div class="inner-box">
                                    <p class="mb-0">Chưa có sản phẩm điện thoại để hiển thị.</p>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
<%--                <div class="col-lg-3 col-md-6 col-sm-12 shop-block">--%>
<%--                    <div class="shop-block-three alternat-2">--%>
<%--                        <div class="inner-box">--%>
<%--                            <span class="text">Laptop</span>--%>
<%--                            <figure class="image r_0 b_10 float-bob-y"><img src="${pageContext.request.contextPath}/assets/client/images/background/banner14.webp" alt="" style="width: 70%;"></figure>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="col-lg-3 col-md-6 col-sm-12 shop-block">--%>
<%--                    <%--%>
<%--                        if (laptopProducts != null && !laptopProducts.isEmpty()) {--%>
<%--                            int count = 0;--%>
<%--                            for (ProductDAO product : laptopProducts) {--%>
<%--                                if (count >= 4) break;--%>
<%--                                count++;--%>

<%--                                String productImage = product.getImage();--%>
<%--                                if (productImage == null || productImage.isBlank()) {--%>
<%--                                    productImage = fallbackImage;--%>
<%--                                }--%>
<%--                                if (!productImage.startsWith("http")) {--%>
<%--                                    productImage = productImage.startsWith("/") ? contextPath + productImage : productImage;--%>
<%--                                }--%>

<%--                                String productLink = product.getSlug() != null && !product.getSlug().isBlank()--%>
<%--                                        ? contextPath + "/product?slug=" + product.getSlug()--%>
<%--                                        : contextPath + "/product?id=" + product.getId();--%>

<%--                                Double currentPrice = product.getCurrentPrice();--%>
<%--                                Double originalPrice = product.getOriginalPrice();--%>
<%--                                boolean onSale = product.isCurrentlyOnSale()--%>
<%--                                        && originalPrice != null--%>
<%--                                        && currentPrice != null--%>
<%--                                        && currentPrice < originalPrice;--%>
<%--                    %>--%>
<%--                    <div class="shop-block-four">--%>
<%--                        <div class="inner-box">--%>
<%--                            <figure class="image-box">--%>
<%--                                <a href="<%= productLink %>">--%>
<%--                                    <img src="<%= productImage %>" alt="<%= product.getName() %>">--%>
<%--                                </a>--%>
<%--                            </figure>--%>
<%--                            <h4><a href="<%= productLink %>"><%= product.getName() %></a></h4>--%>
<%--                            <h5>--%>
<%--                                <% if (onSale) { %>--%>
<%--                                    <span class="price-current"><%= currencyFormat.format(currentPrice) %></span>--%>
<%--                                    <del class="price-old"><%= currencyFormat.format(originalPrice) %></del>--%>
<%--                                <% } else if (currentPrice != null || originalPrice != null) { %>--%>
<%--                                    <span class="price-current"><%= currencyFormat.format(currentPrice != null ? currentPrice : originalPrice) %></span>--%>
<%--                                <% } else { %>--%>
<%--                                    <span class="price-current">Đang cập nhật</span>--%>
<%--                                <% } %>--%>
<%--                            </h5>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <%--%>
<%--                            }--%>
<%--                        } else {--%>
<%--                    %>--%>
<%--                    <div class="shop-block-four">--%>
<%--                        <div class="inner-box">--%>
<%--                            <p class="mb-0">Chưa có sản phẩm laptop để hiển thị.</p>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <%--%>
<%--                        }--%>
<%--                    %>--%>
<%--                </div>--%>
            </div>
        </div>
    </section>
    <!-- shop-three end -->
