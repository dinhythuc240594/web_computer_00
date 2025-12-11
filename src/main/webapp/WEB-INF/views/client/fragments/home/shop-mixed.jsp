<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.ProductDAO" %>
<%
    List<ProductDAO> phoneProducts = (List<ProductDAO>) request.getAttribute("homePhoneProducts");
    String contextPath = request.getContextPath();
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    String fallbackImage = contextPath + "/assets/client/images/shop/shop-10.png";
%>
<!-- shop-three -->
    <section class="shop-three pb_50">
        <div class="large-container">
            <div class="row clearfix">
                <div class="col-lg-3 col-md-6 col-sm-12 shop-block">
                    <div class="shop-block-three">
                        <div class="inner-box">
                            <span class="text">Điện thoại</span>
                            <figure class="image r_0 b_10 float-bob-y"><img src="${pageContext.request.contextPath}/assets/client/images/background/banner13.webp" alt=""></figure>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12 shop-block">
                    <%
                        if (phoneProducts != null && !phoneProducts.isEmpty()) {
                            int count = 0;
                            for (ProductDAO product : phoneProducts) {
                                if (count >= 4) break;
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

                                Double currentPrice = product.getCurrentPrice();
                                Double originalPrice = product.getOriginalPrice();
                                boolean onSale = product.isCurrentlyOnSale()
                                        && originalPrice != null
                                        && currentPrice != null
                                        && currentPrice < originalPrice;
                    %>
                    <div class="shop-block-four">
                        <div class="inner-box">
                            <figure class="image-box">
                                <a href="<%= productLink %>">
                                    <img src="<%= productImage %>" alt="<%= product.getName() %>">
                                </a>
                            </figure>
                            <h4><a href="<%= productLink %>"><%= product.getName() %></a></h4>
                            <h5>
                                <% if (onSale) { %>
                                    <span class="price-current"><%= currencyFormat.format(currentPrice) %></span>
                                    <del class="price-old"><%= currencyFormat.format(originalPrice) %></del>
                                <% } else if (currentPrice != null || originalPrice != null) { %>
                                    <span class="price-current"><%= currencyFormat.format(currentPrice != null ? currentPrice : originalPrice) %></span>
                                <% } else { %>
                                    <span class="price-current">Đang cập nhật</span>
                                <% } %>
                            </h5>
                        </div>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <div class="shop-block-four">
                        <div class="inner-box">
                            <p class="mb-0">Chưa có sản phẩm điện thoại để hiển thị.</p>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12 shop-block">
                    <div class="shop-block-three alternat-2">
                        <div class="inner-box">
                            <span class="text">Laptop</span>
                            <figure class="image r_0 b_10 float-bob-y"><img src="${pageContext.request.contextPath}/assets/client/images/background/banner14.webp" alt=""></figure>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12 shop-block">
                    <div class="shop-block-four">
                        <div class="inner-box">
                            <figure class="image-box"><a href="shop-details.html"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-21.png" alt=""></a></figure>
                            <h4><a href="shop-details.html">Xiaomi Mi 4S 55 Inches 4K UHD Smart Television</a></h4>
                            <h5>$249.99</h5>
                        </div>
                    </div>
                    <div class="shop-block-four">
                        <div class="inner-box">
                            <figure class="image-box"><a href="shop-details.html"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-22.png" alt=""></a></figure>
                            <h4><a href="shop-details.html">1.2V Rechargeable Battery, 4300mAh- Sony</a></h4>
                            <h5>$16.99 <del>$19.99</del></h5>
                        </div>
                    </div>
                    <div class="shop-block-four">
                        <div class="inner-box">
                            <figure class="image-box"><a href="shop-details.html"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-23.png" alt=""></a></figure>
                            <h4><a href="shop-details.html">AV Log Beginner 14" 2-in-1 Convertible Laptop</a></h4>
                            <h5>$789.99</h5>
                        </div>
                    </div>
                    <div class="shop-block-four">
                        <div class="inner-box">
                            <figure class="image-box"><a href="shop-details.html"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-24.png" alt=""></a></figure>
                            <h4><a href="shop-details.html">Vintage 1970s Sony AVC-1420 Video</a></h4>
                            <h5>$199.99 <del>$219.99</del></h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- shop-three end -->
