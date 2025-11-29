<%@ page import="java.util.List" %>
<%@ page import="model.NewsItem" %>
<%
    List<NewsItem> homeNews = (List<NewsItem>) request.getAttribute("homeNews");
    String contextPath = request.getContextPath();
%>
<!-- news-section -->
    <section class="news-section pb_45">
        <div class="large-container">
            <div class="sec-title">
                <h2>Tin tức mới</h2>
                <a href="${pageContext.request.contextPath}/blog">Xem tất cả</a>
            </div>
            <div class="row clearfix">
                <%
                    if (homeNews != null && !homeNews.isEmpty()) {
                        int delay = 0;
                        for (NewsItem news : homeNews) {
                            String imagePath = news.getImagePath();
                            if (imagePath == null || imagePath.isBlank()) {
                                imagePath = contextPath + "/assets/client/images/news/news-1.jpg";
                            } else if (!imagePath.startsWith("http")) {
                                if (!imagePath.startsWith("/")) {
                                    imagePath = "/" + imagePath;
                                }
                                imagePath = contextPath + imagePath;
                            }

                            String newsLink = news.getLink() != null && !news.getLink().isBlank()
                                    ? (news.getLink().startsWith("http") ? news.getLink() : contextPath + news.getLink())
                                    : "#";
                %>
                <div class="col-lg-3 col-md-6 col-sm-12 news-block">
                    <div class="news-block-one wow fadeInUp animated" data-wow-delay="<%= delay %>ms" data-wow-duration="1500ms">
                        <div class="inner-box">
                            <div class="image-box">
                                <figure class="image">
                                    <a href="<%= newsLink %>"><img src="<%= imagePath %>" alt="<%= news.getTitle() %>"></a>
                                </figure>
                            </div>
                            <div class="lower-content">
                                <ul class="post-info">
                                    <li class="category"><a href="<%= newsLink %>"><%= news.getCategory() %></a></li>
                                    <li>By <a href="<%= newsLink %>"><%= news.getAuthor() %></a></li>
                                </ul>
                                <h3><a href="<%= newsLink %>"><%= news.getTitle() %></a></h3>
                                <p><%= news.getSummary() %></p>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                            delay += 200;
                        }
                    } else {
                %>
                <div class="col-12">
                    <p class="text-center">Chưa có tin tức mới để hiển thị.</p>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </section>
    <!-- news-section end -->

    <!-- news-section end -->
