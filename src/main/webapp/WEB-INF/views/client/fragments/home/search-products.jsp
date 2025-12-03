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
                    String productImage = product.getImage_url();
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
            <div class="col-lg-3 col-md-4 col-sm-6 shop-block-three">
                <div class="inner-box">
                    <div class="image-box">
                        <figure class="image">
                            <a href="<%= productLink %>">
                                <img src="<%= productImage %>" alt="<%= product.getName() %>">
                            </a>
                        </figure>
                    </div>
                    <div class="lower-content">
                        <span class="text">Danh mục #<%= product.getCategory_id() %></span>
                        <h4>
                            <a href="<%= productLink %>"><%= product.getName() %></a>
                        </h4>
                        <h5><%= priceDisplay %></h5>
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


