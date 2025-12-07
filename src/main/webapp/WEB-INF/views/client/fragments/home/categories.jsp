<%@ page import="java.util.List" %>
<%@ page import="model.CategoryDAO" %>
<%
    List<CategoryDAO> categories = (List<CategoryDAO>) request.getAttribute("homeCategories");
    String contextPath = request.getContextPath();
    String[] fallbackImages = {
            "/assets/client/images/resource/category-1.png",
            "/assets/client/images/resource/category-2.png",
            "/assets/client/images/resource/category-3.png",
            "/assets/client/images/resource/category-4.png",
            "/assets/client/images/resource/category-5.png",
            "/assets/client/images/resource/category-6.png",
            "/assets/client/images/resource/category-7.png",
            "/assets/client/images/resource/category-8.png"
    };
%>
<!-- category-section -->
    <section class="category-section pt_70 pb_75">
        <div class="large-container">
            <div class="sec-title">
                <h2>Danh Mục</h2>
                <a href="<%= contextPath %>/category">Xem tất cả danh mục</a>
            </div>
            <div class="category-carousel owl-carousel owl-theme owl-dots-none owl-nav-none">
                <%
                    if (categories != null && !categories.isEmpty()) {
                        int index = 0;
                        for (CategoryDAO category : categories) {
                            if(category.getIs_active() == true) {
                                String imageSrc =  category.getImage();
                                if (imageSrc == null || imageSrc.isBlank()) {
                                    imageSrc = contextPath + fallbackImages[index % fallbackImages.length];
                                }
                                String categoryLink = contextPath + "/products?categoryId=" + category.getId();
                                String description = category.getDescription();
                                if (description == null || description.isBlank()) {
                                    description = "Đang cập nhật";
                                }
                %>
                <div class="category-block-one">
                    <div class="inner-box">
                        <figure class="image-box">
                            <img style="width: 160px; height: 160px; object-fit: contain;"
                                 width="160" height="160" src="<%= imageSrc %>" alt="<%= category.getName() %>">
                        </figure>
                        <div class="lower-content">
                            <h4><a href="<%= categoryLink %>"><%= category.getName() %></a></h4>
                            <span><%= description %></span>
                        </div>
                    </div>
                </div>
                <%
                                index++;
                            }
                        }
                    } else {
                %>
                <div class="category-block-one">
                    <div class="inner-box">
                        <div class="lower-content text-center">
                            <span>Chưa có danh mục để hiển thị.</span>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </section>
    <!-- category-section end -->

