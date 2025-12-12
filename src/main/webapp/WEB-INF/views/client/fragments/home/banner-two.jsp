<%
    String contextPath = request.getContextPath();
    // 2 hình hiển thị hai bên khung slide
    String leftImage = "/assets/client/images/background/banner15.webp";
    String rightImage = "/assets/client/images/background/banner16.webp";
%>
<!-- banner-two-images -->
<section class="banner-section p_relative">
    <div class="banner-carousel owl-theme owl-carousel owl-nav-none dots-style-one">
        <div class="slide-item p_relative">
            <div class="large-container">
                <div class="content-box p_relative dual-banner-wrapper">
                    <div class="dual-banner">
                        <div class="dual-banner__item">
                            <img src="<%= contextPath + leftImage %>" alt="Banner trái" class="dual-banner__img">
                        </div>
                        <div class="dual-banner__item">
                            <img src="<%= contextPath + rightImage %>" alt="Banner phải" class="dual-banner__img">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- banner-two-images end -->

