<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.ProductDAO" %>
<%
    List<ProductDAO> topSoldProducts = (List<ProductDAO>) request.getAttribute("topSoldProducts");
    String contextPath = request.getContextPath();
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
%>
<!-- shop-four -->
    <section class="shop-four pt_70">
        <div class="large-container">
            <div class="tabs-box">
                <div class="sec-title">
                    <h2>Sản phẩm đang bán</h2>
                    <a href="<%= contextPath %>/product?action=list">Xem tất cả</a>
                </div>
                <div class="tabs-content">
                    <div class="tab active-tab" id="tab-top-sold">
                        <div class="inner-container clearfix">
                            <%
                                if (topSoldProducts != null && !topSoldProducts.isEmpty()) {
                                    for (ProductDAO product : topSoldProducts) {
                                        String productImage = product.getImage_url();
                                        if (productImage == null || productImage.isBlank()) {
                                            productImage = contextPath + "/assets/client/images/shop/shop-32.png";
                                        } else if (!productImage.startsWith("http")) {
                                            if (!productImage.startsWith("/")) {
                                                productImage = "/" + productImage;
                                            }
                                            productImage = contextPath + productImage;
                                        }

                                        String productLink = product.getSlug() != null && !product.getSlug().isBlank()
                                                ? contextPath + "/product?slug=" + product.getSlug()
                                                : contextPath + "/product?id=" + product.getId();

                                        String priceDisplay = product.getPrice() != null
                                                ? currencyFormat.format(product.getPrice())
                                                : "Liên hệ";

                                        int stock = product.getStock_quantity();
                            %>
                            <div class="shop-block-five">
                                <div class="inner-box">
                                    <div class="image-box">
                                        <ul class="option-list">
                                            <li>
                                                <a href="<%= productImage %>" class="lightbox-image" data-fancybox="top-sold">
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
                                    <div class="content-box">
                                        <h6><a href="<%= productLink %>"><%= product.getName() %></a></h6>
                                        <ul class="rating">
                                            <li><i class="icon-11"></i></li>
                                            <li><i class="icon-11"></i></li>
                                            <li><i class="icon-11"></i></li>
                                            <li><i class="icon-11"></i></li>
                                            <li><i class="icon-11"></i></li>
                                            <li><span>(0)</span></li>
                                        </ul>
                                        <h5><%= priceDisplay %></h5>
                                        <div class="product-stock mt_5">
                                            <small>Còn lại: <%= stock > 0 ? stock : 0 %> sản phẩm</small>
                                        </div>
                                        <div class="cart-btn">
                                            <button type="button" 
                                                    class="add-to-cart-btn" 
                                                    data-product-id="<%= product.getId() %>"
                                                    data-product-name="<%= product.getName() %>"
                                                    data-product-price="<%= product.getPrice() != null ? product.getPrice() : 0 %>"
                                                    data-product-image="<%= productImage %>"
                                                    data-product-slug="<%= product.getSlug() != null ? product.getSlug() : "" %>"
                                                    <%= stock <= 0 ? "disabled" : "" %>>
                                                Thêm vào giỏ <i class="icon-12"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                    }
                                } else {
                            %>
                            <div class="text-center w-100">
                                <p>Chưa có sản phẩm bán chạy để hiển thị. Vui lòng quay lại sau.</p>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- shop-four end -->
    
    <script>
        // Handle add to cart button clicks
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.add-to-cart-btn').forEach(function(button) {
                button.addEventListener('click', function() {
                    if (this.disabled) {
                        return;
                    }
                    
                    const product = {
                        id: parseInt(this.getAttribute('data-product-id')),
                        name: this.getAttribute('data-product-name'),
                        price: parseFloat(this.getAttribute('data-product-price')),
                        image_url: this.getAttribute('data-product-image'),
                        slug: this.getAttribute('data-product-slug')
                    };
                    
                    if (CartManager.addToCart(product, 1)) {
                        // Show success message (optional)
                        const originalText = this.innerHTML;
                        this.innerHTML = 'Đã thêm! <i class="icon-12"></i>';
                        this.style.backgroundColor = '#28a745';
                        
                        setTimeout(() => {
                            this.innerHTML = originalText;
                            this.style.backgroundColor = '';
                        }, 1000);
                    }
                });
            });
        });
    </script>

