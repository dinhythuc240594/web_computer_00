<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.ProductDAO" %>
<%
    List<ProductDAO> sliderProducts = (List<ProductDAO>) request.getAttribute("sliderProducts");
    String contextPath = request.getContextPath();
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
    String[] patternImages = {
            "/assets/client/images/shape/shape-1.png",
            "/assets/client/images/shape/shape-2.png"
    };
%>
<!-- banner-section -->
    <section class="banner-section p_relative">
        <div class="banner-carousel owl-theme owl-carousel owl-nav-none dots-style-one">
            <%
                if (sliderProducts != null && !sliderProducts.isEmpty()) {
                    int index = 0;
                    for (ProductDAO product : sliderProducts) {
                        String productImage = product.getImage();
                        if (productImage == null || productImage.isBlank()) {
                            productImage = contextPath + "/assets/client/images/banner/banner-img-1.png";
                        }

                        String productLink = product.getSlug() != null && !product.getSlug().isBlank()
                                ? contextPath + "/product?slug=" + product.getSlug()
                                : contextPath + "/product?id=" + product.getId();

                        String priceDisplay = product.getPrice() != null
                                ? currencyFormat.format(product.getPrice())
                                : "Liên hệ";

                        String headline = product.getName() != null ? product.getName() : "Sản phẩm mới";
                        String subHeadline = product.getDescription() != null && !product.getDescription().isBlank()
                                ? product.getDescription()
                                : "Ưu đãi hấp dẫn cho khách hàng HCMUTE.";

                        String patternImage = contextPath + patternImages[index % patternImages.length];
                        boolean shiftImage = index % 2 == 1;
                        String figureClass = shiftImage ? "image-layer r_95 b_0" : "image-layer r_50 b_50";
            %>
            <div class="slide-item p_relative">
                <div class="pattern-layer" style="background-image: url('<%= patternImage %>');"></div>
                <figure class="<%= figureClass %>">
                    <img src="<%= productImage %>" alt="<%= headline %>">
                </figure>
                <div class="large-container">
                    <div class="content-box">
                        <span class="upper-text">Ưu đãi mới</span>
                        <h2><span><%= headline %></span></h2>
                        <h3>Bắt đầu từ <span><%= priceDisplay %></span></h3>
                        <p><%= subHeadline %></p>
                        <div class="btn-box">
                            <a href="<%= productLink %>" class="theme-btn btn-one">
                                Xem chi tiết<span></span><span></span><span></span><span></span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <%
                        index++;
                    }
                } else {
            %>
            <div class="slide-item p_relative">
                <div class="large-container">
                    <div class="content-box text-center">
                        <span class="upper-text">Đang cập nhật</span>
                        <h2>Chưa có sản phẩm nổi bật cho banner</h2>
                        <p>Vui lòng quay lại sau để xem các chương trình khuyến mãi mới.</p>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </section>
    <!-- banner-section end -->



