<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.ProductDAO" %>
<%@ page import="model.CategoryDAO" %>
<%@ page import="model.BrandDAO" %>
<%
    String contextPath = request.getContextPath();

    String searchKeyword = (String) request.getAttribute("searchKeyword");
    Integer selectedCategoryId = (Integer) request.getAttribute("selectedCategoryId");
    Integer selectedBrandId = (Integer) request.getAttribute("selectedBrandId");

    if (selectedCategoryId == null) selectedCategoryId = 0;
    if (selectedBrandId == null) selectedBrandId = 0;

    List<CategoryDAO> categories = (List<CategoryDAO>) request.getAttribute("homeCategories");
    List<BrandDAO> brands = (List<BrandDAO>) request.getAttribute("homeBrands");
    List<ProductDAO> searchResults = (List<ProductDAO>) request.getAttribute("searchResults");

    boolean hasSearchParams =
            (searchKeyword != null && !searchKeyword.isBlank())
            || selectedCategoryId > 0
            || selectedBrandId > 0;

    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
%>

<section class="shop-three pt_40 pb_40">
    <div class="large-container">
        <div class="sec-title">
            <h2>Tìm kiếm &amp; lọc sản phẩm</h2>
            <p>Tìm nhanh sản phẩm theo tên, danh mục và linh kiện / thương hiệu.</p>
        </div>

        <form method="get" action="<%= contextPath %>/home" class="row g-3 mb-4">
            <div class="col-lg-4 col-md-6">
                <div class="form-group">
                    <label for="keyword">Từ khóa sản phẩm</label>
                    <input type="search"
                           id="keyword"
                           name="keyword"
                           class="form-control"
                           placeholder="Nhập tên hoặc giá sản phẩm..."
                           value="<%= searchKeyword != null ? searchKeyword : "" %>">
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="form-group">
                    <label for="categoryId">Danh mục</label>
                    <select id="categoryId" name="categoryId" class="form-control nice-select">
                        <option value="0">Tất cả danh mục</option>
                        <%
                            if (categories != null) {
                                for (CategoryDAO category : categories) {
                                    boolean selected = category.getId() == selectedCategoryId;
                        %>
                        <option value="<%= category.getId() %>" <%= selected ? "selected" : "" %>>
                            <%= category.getName() %>
                        </option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="form-group">
                    <label for="brandId">Linh kiện / Thương hiệu</label>
                    <select id="brandId" name="brandId" class="form-control nice-select">
                        <option value="0">Tất cả linh kiện / thương hiệu</option>
                        <%
                            if (brands != null) {
                                for (BrandDAO brand : brands) {
                                    boolean selected = brand.getId() == selectedBrandId;
                        %>
                        <option value="<%= brand.getId() %>" <%= selected ? "selected" : "" %>>
                            <%= brand.getName() %>
                        </option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
            </div>

            <div class="col-lg-2 col-md-6 d-flex align-items-end">
                <button type="submit" class="theme-btn btn-one w-100">
                    Tìm kiếm
                    <span></span><span></span><span></span><span></span>
                </button>
            </div>
        </form>

        <%
            if (hasSearchParams) {
        %>
        <div class="sec-title mb_20">
            <h3>Kết quả tìm kiếm</h3>
            <%
                if (searchResults != null && !searchResults.isEmpty()) {
            %>
            <p>Tìm thấy <%= searchResults.size() %> sản phẩm phù hợp.</p>
            <%
                } else {
            %>
            <p>Không tìm thấy sản phẩm phù hợp với tiêu chí hiện tại.</p>
            <%
                }
            %>
        </div>

        <%
            if (searchResults != null && !searchResults.isEmpty()) {
        %>
        <div class="row clearfix">
            <%
                for (ProductDAO product : searchResults) {
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
                    
                    // Giới hạn tên sản phẩm 6 từ
                    String productName = product.getName();
                    if (productName != null && !productName.isBlank()) {
                        String[] words = productName.trim().split("\\s+");
                        if (words.length > 6) {
                            productName = String.join(" ", java.util.Arrays.copyOf(words, 6)) + "...";
                        }
                    }
            %>
            <div class="col-lg-3 col-md-4 col-sm-6 shop-block-three">
                <div class="inner-box">
                    <div class="image-box" style="position: relative;">
                        <% if (product.isNewProduct()) { %>
                        <span class="new-badge" style="position: absolute; top: 10px; right: 10px; background: #28a745; color: white; padding: 5px 10px; border-radius: 5px; font-weight: bold; z-index: 10;">
                            New
                        </span>
                        <% if (isOnSale && discountPercent != null) { %>
                        <span class="sale-badge" style="position: absolute; top: 48px; right: 10px; background: #ff4444; color: white; padding: 5px 10px; border-radius: 5px; font-weight: bold; z-index: 10;">
                            -<%= Math.round(discountPercent) %>%
                        </span>
                        <% } %>
                        <% } else if (isOnSale && discountPercent != null) { %>
                        <span class="sale-badge" style="position: absolute; top: 10px; right: 10px; background: #ff4444; color: white; padding: 5px 10px; border-radius: 5px; font-weight: bold; z-index: 10;">
                            -<%= Math.round(discountPercent) %>%
                        </span>
                        <% } %>
                        <figure class="image">
                            <a href="<%= productLink %>">
                                <img src="<%= productImage %>" alt="<%= product.getName() %>">
                            </a>
                        </figure>
                    </div>
                    <div class="lower-content">
                        <!-- <span class="text">Danh mục #<%= product.getCategory_id() %></span> -->
                        <h4>
                            <a href="<%= productLink %>"><%= productName %></a>
                        </h4>
                        <div class="price-box">
                            <% if (isOnSale && originalPrice != null && currentPrice != null && originalPrice > currentPrice) { %>
                                <h5 style="color: #ff4444; font-weight: bold; margin-bottom: 5px;">
                                    <%= currencyFormat.format(currentPrice) %>
                                </h5>
                                <h6 style="color: #999; text-decoration: line-through; font-size: 0.9em; margin: 0;">
                                    <%= currencyFormat.format(originalPrice) %>
                                </h6>
                            <% } else { %>
                                <h5>
                                    <%= currentPrice != null ? currencyFormat.format(currentPrice) : "Đang cập nhật" %>
                                </h5>
                            <% } %>
                        </div>
                        <%
                            if (inStock) {
                        %>
                        <span class="product-stock">
                            <img src="<%= contextPath %>/assets/client/images/icons/icon-1.png" alt="">
                            Còn <%= product.getStock_quantity() %> sản phẩm
                        </span>
                        <%
                            } else {
                        %>
                        <span class="product-stock-out">
                            <img src="<%= contextPath %>/assets/client/images/icons/icon-2.png" alt="">
                            Tạm hết hàng
                        </span>
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
            }
        %>
        <%
            }
        %>
    </div>
</section>


