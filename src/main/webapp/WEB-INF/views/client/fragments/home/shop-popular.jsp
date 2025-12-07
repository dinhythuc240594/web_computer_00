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
            <div class="shop-carousel owl-carousel owl-theme owl-dots-none nav-style-one">
                <%
                    for (ProductDAO product : popularProducts) {
                        String productImage = product.getImage();
                        if (productImage == null || productImage.isBlank()) {
                            productImage = contextPath + "/assets/client/images/shop/shop-10.png";
                        } else if (!productImage.startsWith("http")) {
                            productImage = contextPath + productImage;
                        }

                        String productLink = product.getSlug() != null && !product.getSlug().isBlank()
                                ? contextPath + "/product?slug=" + product.getSlug()
                                : contextPath + "/product?id=" + product.getId();

                        String priceDisplay = product.getPrice() != null
                                ? currencyFormat.format(product.getPrice())
                                : "Đang cập nhật";

                        boolean inStock = product.getStock_quantity() > 0;
                %>
                <div class="shop-block-two">
                    <div class="inner-box">
                        <div class="image-box">
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
                            <span class="text">Danh mục #<%= product.getCategory_id() %></span>
                            <h4>
                                <a href="<%= productLink %>">
                                    <%= product.getName() %>
                                </a>
                            </h4>
                            <h5><%= priceDisplay %></h5>
                            <ul class="rating">
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><i class="icon-11"></i></li>
                                <li><span>(0)</span></li>
                            </ul>
                            <%
                                if (inStock) {
                            %>
                            <span class="product-stock">
                                <img src="<%= contextPath %>/assets/client/images/icons/icon-1.png" alt="">
                                Còn <%= product.getStock_quantity() %> sản phẩm
                            </span>
                            <div class="cart-btn">
                                <button type="button" class="theme-btn">
                                    Thêm vào giỏ
                                    <span></span><span></span><span></span><span></span>
                                </button>
                            </div>
                            <%
                                } else {
                            %>
                            <span class="product-stock-out">
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
