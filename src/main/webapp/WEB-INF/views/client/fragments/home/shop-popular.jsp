<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.ProductDAO" %>
<%
    List<ProductDAO> popularProducts = (List<ProductDAO>) request.getAttribute("popularProducts");
    String contextPath = request.getContextPath();
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
%>
<!-- shop-two -->
    <section class="shop-two pb_50">
        <div class="large-container">
            <div class="sec-title">
                <h2>Sản phẩm nổi bật hôm nay</h2>
            </div>
            <%
                if (popularProducts != null && !popularProducts.isEmpty()) {
            %>
            <style>
                .shop-block-two .inner-box {
                    display: flex;
                    flex-direction: column;
                    height: 100%;
                    min-height: 450px;
                }
                .shop-block-two .lower-content {
                    flex: 1;
                    display: flex;
                    flex-direction: column;
                }
                .shop-block-two .image-box {
                    position: relative;
                }
                .shop-block-two .image-box figure {
                    height: 250px;
                    overflow: hidden;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
                .shop-block-two .image-box img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
                .discount-product {
                    position: absolute;
                    top: 10px;
                    left: 10px;
                    background: #ff4444;
                    color: white;
                    padding: 0px 0px;
                    border-radius: 5px;
                    font-weight: bold;
                    z-index: 10;
                    font-size: 14px;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.2);
                }
                .new-product {
                    position: absolute;
                    top: 10px;
                    right: 10px;
                    background: #28a745;
                    color: white;
                    padding: 5px 12px;
                    border-radius: 5px;
                    font-weight: bold;
                    z-index: 10;
                    font-size: 14px;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.2);
                }
            </style>
            <div class="shop-carousel owl-carousel owl-theme owl-dots-none nav-style-one">
                <%
                    for (ProductDAO product : popularProducts) {
                        String productImage = product.getImage();
                        if (productImage == null || productImage.isBlank()) {
                            productImage = contextPath + "/assets/client/images/shop/shop-10.png";
                        }

                        String productLink = product.getSlug() != null && !product.getSlug().isBlank()
                                ? contextPath + "/product?slug=" + product.getSlug()
                                : contextPath + "/product?id=" + product.getId();

                        // Kiểm tra sản phẩm có đang giảm giá không
                        boolean isOnSale = product.getIs_on_sale() != null && product.getIs_on_sale() && product.isCurrentlyOnSale();
                        Double originalPrice = product.getOriginalPrice();
                        Double currentPrice = product.getCurrentPrice();
                        // Tính phần trăm giảm giá (tự động tính nếu discount_percentage null)
                        Double discountPercent = product.getCalculatedDiscountPercentage();

                        boolean inStock = product.getStock_quantity() > 0;
                %>
                <div class="shop-block-two">
                    <div class="inner-box">
                        <div class="image-box">
                            <% if (product.isNewProduct()) { %>
                            <span class="new-product" style="position: absolute; top: 10px; right: 10px; background: #28a745; color: white; padding: 5px 12px; border-radius: 5px; font-weight: bold; z-index: 10; font-size: 14px; box-shadow: 0 2px 4px rgba(0,0,0,0.2);">
                                New
                            </span>
                            <% if (isOnSale && discountPercent != null && discountPercent > 0) { %>
                            <span class="discount-product" style="top: 50px; right: 10px; left: auto;">
                                -<%= Math.round(discountPercent) %>%
                            </span>
                            <% } %>
                            <% } else if (isOnSale && discountPercent != null && discountPercent > 0) { %>
                            <span class="discount-product" style="top: 10px; right: 10px; left: auto;">
                                -<%= Math.round(discountPercent) %>%
                            </span>
                            <% } %>
                            <ul class="option-list">
                                <li>
                                    <a href="<%= productImage %>" class="lightbox-image" data-fancybox="gallery">
                                        <i class="far fa-eye"></i>
                                    </a>
                                </li>
                                <li>
                                    <a href="<%= productLink %>">
                                        <i class="icon-5"></i>
                                    </a>
                                </li>
                                <li>
                                    <button type="button">
                                        <i class="icon-6"></i>
                                    </button>
                                </li>
                            </ul>
                            <figure class="image">
                                <img src="<%= productImage %>" alt="<%= product.getName() %>">
                            </figure>
                        </div>
                        <div class="lower-content">
                            <!-- <span class="text">Danh mục #<%= product.getCategory_id() %></span> -->
                            <h4 style="min-height: 48px; margin-bottom: 10px;">
                                <a href="<%= productLink %>">
                                    <%= product.getName() %>
                                </a>
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
<%--                            <ul class="rating" style="margin-bottom: 10px;">--%>
<%--                                <li><i class="icon-11"></i></li>--%>
<%--                                <li><i class="icon-11"></i></li>--%>
<%--                                <li><i class="icon-11"></i></li>--%>
<%--                                <li><i class="icon-11"></i></li>--%>
<%--                                <li><i class="icon-11"></i></li>--%>
<%--                                <li><span>(0)</span></li>--%>
<%--                            </ul>--%>
                            <div style="margin-top: auto;">
                                <%
                                    if (inStock) {
                                %>
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
                                <%
                                    } else {
                                %>
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
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
            <%
                } else {
            %>
            <div class="text-center">
                <p>Chưa có sản phẩm nổi bật để hiển thị. Vui lòng quay lại sau.</p>
            </div>
            <%
                }
            %>
        </div>
    </section>
    <!-- shop-two end -->
