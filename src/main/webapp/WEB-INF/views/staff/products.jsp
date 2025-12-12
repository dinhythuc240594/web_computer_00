<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin/layout/init.jspf" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.ProductDAO" %>
<%@ page import="model.CategoryDAO" %>
<%@ page import="model.BrandDAO" %>
<%@ page import="model.Page" %>
<%
    List<ProductDAO> products = (List<ProductDAO>) request.getAttribute("products");
    List<CategoryDAO> categories = (List<CategoryDAO>) request.getAttribute("categories");
    List<BrandDAO> brands = (List<BrandDAO>) request.getAttribute("brands");
    Page<ProductDAO> productPage = (Page<ProductDAO>) request.getAttribute("productPage");
    String keyword = (String) request.getAttribute("keyword");
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

    Integer filterCategoryId = (Integer) request.getAttribute("selectedCategoryId");
    if (filterCategoryId == null) filterCategoryId = 0;
    Integer filterBrandId = (Integer) request.getAttribute("selectedBrandId");
    if (filterBrandId == null) filterBrandId = 0;
    String filterSort = (String) request.getAttribute("selectedSort");
    if (filterSort == null || filterSort.isBlank()) filterSort = "id_desc";
    String filterStatus = (String) request.getAttribute("selectedStatus");
    if (filterStatus == null || filterStatus.isBlank()) filterStatus = "all";
%>
<!doctype html>
<html lang="en" class="layout-navbar-fixed layout-menu-fixed layout-compact" dir="ltr"
      data-skin="default" data-bs-theme="light" data-assets-path="${adminAssetsPath}/"
      data-template="vertical-menu-template">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <meta name="robots" content="noindex, nofollow"/>
    <title>Quản lý Sản phẩm - Staff</title>
    <link rel="icon" type="image/x-icon" href="${adminAssetsPath}/img/favicon/Logo%20HCMUTE_White%20background.png"/>
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&ampdisplay=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/fonts/iconify-icons.css"/>
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/node-waves/node-waves.css"/>
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/pickr/pickr-themes.css"/>
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/css/core.css"/>
    <link rel="stylesheet" href="${adminAssetsPath}/css/demo.css"/>
    <link rel="stylesheet" href="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.css"/>
    <script src="${adminAssetsPath}/vendor/js/helpers.js"></script>
    <!-- <script src="${adminAssetsPath}/vendor/js/template-customizer.js"></script> -->
    <script src="${adminAssetsPath}/js/config.js"></script>
</head>
<body>
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <jsp:include page="../admin/layout/sidebar.jsp"/>
        <div class="layout-page">
            <jsp:include page="../admin/layout/navbar.jsp"/>
            <div class="content-wrapper">
                <div class="container-xxl flex-grow-1 container-p-y">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        
                        <a href="${contextPath}/staff?action=product-add" class="btn btn-primary">
                            <i class="icon-base ri ri-add-line me-2"></i>Thêm sản phẩm
                        </a>
                    </div>

                    <!-- Search Form -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <form method="get" action="${contextPath}/staff">
                                <input type="hidden" name="action" value="products"/>
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <input type="text" class="form-control" name="keyword" 
                                               placeholder="Tìm kiếm theo tên hoặc giá..." 
                                               value="<%= keyword != null ? keyword : "" %>"/>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-select" name="categoryId">
                                            <option value="0">Tất cả danh mục</option>
                                            <%
                                                if (categories != null) {
                                                    for (CategoryDAO cat : categories) {
                                            %>
                                            <option value="<%= cat.getId() %>" <%= filterCategoryId == cat.getId() ? "selected" : "" %>>
                                                <%= cat.getName() %>
                                            </option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-select" name="brandId">
                                            <option value="0">Tất cả thương hiệu</option>
                                            <%
                                                if (brands != null) {
                                                    for (BrandDAO b : brands) {
                                            %>
                                            <option value="<%= b.getId() %>" <%= filterBrandId == b.getId() ? "selected" : "" %>>
                                                <%= b.getName() %>
                                            </option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-select" name="sort">
                                            <%
                                            %>
                                            <option value="id_desc" <%= "id_desc".equals(filterSort) ? "selected" : "" %>>Mới nhất</option>
                                            <option value="price_asc" <%= "price_asc".equals(filterSort) ? "selected" : "" %>>Giá tăng dần</option>
                                            <option value="price_desc" <%= "price_desc".equals(filterSort) ? "selected" : "" %>>Giá giảm dần</option>
                                            <option value="name_asc" <%= "name_asc".equals(filterSort) ? "selected" : "" %>>Tên A-Z</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <select class="form-select" name="status">
                                            <option value="all" <%= "all".equals(filterStatus) ? "selected" : "" %>>Tất cả trạng thái</option>
                                            <option value="active" <%= "active".equals(filterStatus) ? "selected" : "" %>>Đang hiển thị</option>
                                            <option value="hidden" <%= "hidden".equals(filterStatus) ? "selected" : "" %>>Đang ẩn</option>
                                        </select>
                                    </div>
                                    <div class="col-md-12">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="icon-base ri ri-search-line me-2"></i>Lọc
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Products Table -->
                    <div class="card">
                        <div class="card-datatable table-responsive">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Hình ảnh</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Giá</th>
                                    <th>Tồn kho</th>
                                    <th>Danh mục</th>
                                    <th>Thương hiệu</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    if (products != null && !products.isEmpty()) {
                                        for (ProductDAO product : products) {
                                %>
                                    <tr>
                                        <td><%= product.getId() %></td>
                                        <td>
                                            <%
                                                if (product.getImage() != null && !product.getImage().isEmpty()) {
                                            %>
                                                <img src="<%= product.getImage() %>" alt="<%= product.getName() %>" 
                                                     style="width: 50px; height: 50px; object-fit: cover;"/>
                                            <%
                                                }
                                            %>
                                        </td>
                                        <td><%= product.getName() %></td>
                                        <td><%= currencyFormat.format(product.getPrice() != null ? product.getPrice() : 0) %></td>
                                        <td><%= product.getStock_quantity() %></td>
                                        <td>
                                            <%
                                                String categoryName = "-";
                                                if (categories != null) {
                                                    for (CategoryDAO cat : categories) {
                                                        if (cat.getId() == product.getCategory_id()) {
                                                            categoryName = cat.getName();
                                                            break;
                                                        }
                                                    }
                                                }
                                            %>
                                            <%= categoryName %>
                                        </td>
                                        <td>
                                            <%
                                                String brandName = "-";
                                                if (brands != null) {
                                                    for (BrandDAO brand : brands) {
                                                        if (brand.getId() == product.getBrand_id()) {
                                                            brandName = brand.getName();
                                                            break;
                                                        }
                                                    }
                                                }
                                            %>
                                            <%= brandName %>
                                        </td>
                                        <td>
                                            <%
                                                if (product.getIs_active() != null && product.getIs_active()) {
                                            %>
                                                <span class="badge bg-label-success">Hoạt động</span>
                                            <%
                                                } else {
                                            %>
                                                <span class="badge bg-label-danger">Đã ẩn</span>
                                            <%
                                                }
                                            %>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-2">
                                                <a href="${contextPath}/staff?action=product-edit&id=<%= product.getId() %>" 
                                                   class="btn btn-sm btn-outline-primary">
                                                    <i class="icon-base ri ri-edit-line"></i>
                                                </a>
                                                <form method="post" action="${contextPath}/staff" style="display: inline;">
                                                    <input type="hidden" name="action" value="product-delete"/>
                                                    <input type="hidden" name="id" value="<%= product.getId() %>"/>
                                                    <button type="submit" class="btn btn-sm btn-outline-danger" 
                                                            onclick="return confirm('Bạn có chắc muốn ẩn sản phẩm này?');">
                                                        <i class="icon-base ri ri-delete-bin-line"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                <%
                                        }
                                    } else {
                                %>
                                    <tr>
                                        <td colspan="9" class="text-center">Không có sản phẩm nào</td>
                                    </tr>
                                <%
                                    }
                                %>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <%
                            if (productPage != null && productPage.getTotalPage() > 1) {
                                int currentPage = productPage.getCurrentPage();
                                int totalPages = productPage.getTotalPage();
                                String baseUrl = request.getContextPath() + "/staff?action=products";
                                if (keyword != null && !keyword.isEmpty()) {
                                    baseUrl += "&keyword=" + java.net.URLEncoder.encode(keyword, "UTF-8");
                                }
                                if (filterCategoryId != null && filterCategoryId > 0) {
                                    baseUrl += "&categoryId=" + filterCategoryId;
                                }
                                if (filterBrandId != null && filterBrandId > 0) {
                                    baseUrl += "&brandId=" + filterBrandId;
                                }
                                if (filterSort != null && !filterSort.isBlank() && !"id_desc".equals(filterSort)) {
                                    baseUrl += "&sort=" + filterSort;
                                }
                                if (filterStatus != null && !"all".equals(filterStatus)) {
                                    baseUrl += "&status=" + filterStatus;
                                }
                        %>
                            <div class="card-footer">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center mb-0">
                                        <li class="page-item <%= currentPage == 1 ? "disabled" : "" %>">
                                            <a class="page-link" href="<%= baseUrl %>&page=<%= currentPage - 1 %>">Trước</a>
                                        </li>
                                        <%
                                            for (int i = 1; i <= totalPages; i++) {
                                                if (i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)) {
                                        %>
                                            <li class="page-item <%= i == currentPage ? "active" : "" %>">
                                                <a class="page-link" href="<%= baseUrl %>&page=<%= i %>"><%= i %></a>
                                            </li>
                                        <%
                                                }
                                                if (i == currentPage - 3 || i == currentPage + 3) {
                                        %>
                                            <li class="page-item disabled"><span class="page-link">...</span></li>
                                        <%
                                                }
                                            }
                                        %>
                                        <li class="page-item <%= currentPage == totalPages ? "disabled" : "" %>">
                                            <a class="page-link" href="<%= baseUrl %>&page=<%= currentPage + 1 %>">Sau</a>
                                        </li>
                                    </ul>
                                </nav>
                                <div class="text-center mt-2">
                                    <small class="text-muted">Trang <%= currentPage %> / <%= totalPages %> 
                                        (Tổng <%= productPage.getTotalItem() %> sản phẩm)</small>
                                </div>
                            </div>
                        <%
                            }
                        %>
                    </div>
                </div>
                <jsp:include page="../admin/layout/footer.jsp"/>
            </div>
        </div>
    </div>
</div>

<script src="${adminAssetsPath}/vendor/libs/jquery/jquery.js"></script>
<script src="${adminAssetsPath}/vendor/libs/popper/popper.js"></script>
<script src="${adminAssetsPath}/vendor/js/bootstrap.js"></script>
<script src="${adminAssetsPath}/vendor/libs/node-waves/node-waves.js"></script>
<script src="${adminAssetsPath}/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
<script src="${adminAssetsPath}/vendor/js/menu.js"></script>
<script src="${adminAssetsPath}/js/main.js"></script>
</body>
</html>
