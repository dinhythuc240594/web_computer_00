<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../admin/layout/init.jspf" %>
<%@ page import="java.util.List" %>
<%@ page import="model.BrandDAO" %>
<%@ page import="model.Page" %>
<%
    List<BrandDAO> brands = (List<BrandDAO>) request.getAttribute("brands");
    Page<BrandDAO> brandPage = (Page<BrandDAO>) request.getAttribute("brandPage");
    String keyword = (String) request.getAttribute("keyword");
%>
<!doctype html>
<html lang="en" class="layout-navbar-fixed layout-menu-fixed layout-compact" dir="ltr"
      data-skin="default" data-bs-theme="light" data-assets-path="${adminAssetsPath}/"
      data-template="vertical-menu-template">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>
    <meta name="robots" content="noindex, nofollow"/>
    <title>Quản lý Thương hiệu - Staff</title>
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
    <script src="${adminAssetsPath}/vendor/js/template-customizer.js"></script>
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
                        <h4 class="fw-bold py-3 mb-4">Quản lý Thương hiệu</h4>
                        <a href="${contextPath}/staff?action=brand-add" class="btn btn-primary">
                            <i class="icon-base ri ri-add-line me-2"></i>Thêm thương hiệu
                        </a>
                    </div>

                    <!-- Search Form -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <form method="get" action="${contextPath}/staff">
                                <input type="hidden" name="action" value="brands"/>
                                <div class="row g-3">
                                    <div class="col-md-8">
                                        <input type="text" class="form-control" name="keyword" 
                                               placeholder="Tìm kiếm theo tên hoặc mã..." 
                                               value="<%= keyword != null ? keyword : "" %>"/>
                                    </div>
                                    <div class="col-md-4">
                                        <button type="submit" class="btn btn-primary w-100">
                                            <i class="icon-base ri ri-search-line me-2"></i>Tìm kiếm
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Brands Table -->
                    <div class="card">
                        <div class="card-datatable table-responsive">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Logo</th>
                                    <th>Tên thương hiệu</th>
                                    <th>Mã</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    if (brands != null && !brands.isEmpty()) {
                                        for (BrandDAO brand : brands) {
                                %>
                                    <tr>
                                        <td><%= brand.getId() %></td>
                                        <td>
                                            <%
                                                if (brand.getLogo_url() != null && !brand.getLogo_url().isEmpty()) {
                                            %>
                                                <img src="<%= brand.getLogo_url() %>" alt="<%= brand.getName() %>" 
                                                     style="width: 50px; height: 50px; object-fit: cover;"/>
                                            <%
                                                }
                                            %>
                                        </td>
                                        <td><%= brand.getName() %></td>
                                        <td><%= brand.getCode() %></td>
                                        <td>
                                            <%
                                                if (brand.getIs_active() != null && brand.getIs_active()) {
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
                                                <a href="${contextPath}/staff?action=brand-edit&id=<%= brand.getId() %>" 
                                                   class="btn btn-sm btn-outline-primary">
                                                    <i class="icon-base ri ri-edit-line"></i>
                                                </a>
                                                <form method="post" action="${contextPath}/staff" style="display: inline;">
                                                    <input type="hidden" name="action" value="brand-delete"/>
                                                    <input type="hidden" name="id" value="<%= brand.getId() %>"/>
                                                    <button type="submit" class="btn btn-sm btn-outline-danger" 
                                                            onclick="return confirm('Bạn có chắc muốn ẩn thương hiệu này?');">
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
                                        <td colspan="6" class="text-center">Không có thương hiệu nào</td>
                                    </tr>
                                <%
                                    }
                                %>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <%
                            if (brandPage != null && brandPage.getTotalPage() > 1) {
                                int currentPage = brandPage.getCurrentPage();
                                int totalPages = brandPage.getTotalPage();
                                String baseUrl = contextPath + "/staff?action=brands";
                                if (keyword != null && !keyword.isEmpty()) {
                                    baseUrl += "&keyword=" + java.net.URLEncoder.encode(keyword, "UTF-8");
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
                                        (Tổng <%= brandPage.getTotalItem() %> thương hiệu)</small>
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
