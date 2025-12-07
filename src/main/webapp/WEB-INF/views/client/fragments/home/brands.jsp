<%@ page import="java.util.List" %>
<%@ page import="model.BrandDAO" %>
<%
    List<BrandDAO> brands = (List<BrandDAO>) request.getAttribute("homeBrands");
    String contextPath = request.getContextPath();
    String fallbackLogo = contextPath + "/assets/client/images/clients/clients-1.png";
%>
<!-- clients-section -->
    <section class="clients-section pb_70">
        <div class="large-container">
            <div class="sec-title">
                <h2>Thương Hiệu</h2>
                <a href="<%= contextPath %>/brand">Xem tất cả thương hiệu</a>
            </div>
            <ul class="clients-list clearfix">
                <%
                    if (brands != null && !brands.isEmpty()) {
                        for (BrandDAO brand : brands) {
                            String logoUrl = brand.getImage() getImage() || contextPath + fallbackImages[index % fallbackImages.length];
                            String brandLink = contextPath + "/brand?brandId=" + brand.getId();
                %>
                <li>
                    <a href="<%= brandLink %>" title="<%= brand.getName() %>">
                        <img src="<%= logoUrl %>" alt="<%= brand.getName() %>">
                    </a>
                </li>
                <%
                        }
                    } else {
                %>
                <li>
                    <span>Chưa có thương hiệu để hiển thị.</span>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
    </section>
    <!-- clients-section end -->
