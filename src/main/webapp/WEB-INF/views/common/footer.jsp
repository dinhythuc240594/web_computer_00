    <!-- main-footer -->
    <footer class="main-footer">
        <div class="large-container">
            <div class="widget-section">
                  <div class="row clearfix">
                    <div class="col-lg-3 col-md-6 col-sm-12 footer-column">
                        <div class="footer-widget contact-widget mt_10">
                            <div class="widget-content">
                                <div class="support-box">
                                    <div class="icon-box"><i class="icon-3"></i></div>
                                    <a href="tel:912345678">091 2345 678</a>
                                </div>
                                <ul class="info mb_30 clearfix">
                                    <li>Số 1 Võ Văn Ngân, Phường Thủ Đức, TP.HCM</li>
                                    <li><a href="mailto:info@example.com">ptchc@hcmute.edu.vn</a></li>
                                </ul>
                                <ul class="social-links">
                                    <li><a href="index.html"><i class="icon-13"></i></a></li>
                                    <li><a href="index.html"><i class="icon-14"></i></a></li>
                                    <li><a href="index.html"><i class="icon-15"></i></a></li>
                                    <li><a href="index.html"><i class="icon-16"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-12 footer-column">
                        <div class="footer-widget links-widget">
                            <div class="widget-title">
                                <h4>Thông tin</h4>
                            </div>
                            <div class="widget-content">
                                <ul class="links-list clearfix">
                                    <li><a href="about.html">Về chúng tôi</a></li>
                                    <li><a href="shop.html">Cửa hàng</a></li>
                                    <li><a href="cart.html">Giỏ hàng</a></li>
                                    <li><a href="index.html">Thương hiệu</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-12 footer-column">
                        <div class="footer-widget links-widget">
                            <div class="widget-title">
                                <h4>Hỗ trợ</h4>
                            </div>
                            <div class="widget-content">
                                <ul class="links-list clearfix">
                                    <li><a href="index.html">Đánh giá</a></li>
                                    <li><a href="contact.html">Liên hệ</a></li>
                                    <li><a href="index.html">Chính sách đổi trả</a></li>
                                    <li><a href="index.html">Hỗ trợ trực tuyến</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-12 footer-column">
                        <div class="footer-widget links-widget">
                            <div class="widget-title">
                                <h4>Thông tin cửa hàng</h4>
                            </div>
                            <div class="widget-content">
                                <ul class="links-list clearfix">
                                    <li><a href="shop.html">Bán chạy nhất</a></li>
                                    <li><a href="shop.html">Sản phẩm bán chạy</a></li>
                                    <li><a href="shop.html">Hàng mới về</a></li>
                                    <li><a href="shop.html">Flash sale</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-12 footer-column">
                        <div class="footer-widget subscribe-widget">
                            <div class="widget-title">
                                <h4>Đăng ký nhận tin</h4>
                            </div>
                            <div class="widget-content">
                                <p>Nhận thông báo về sự kiện, sản phẩm và chương trình hấp dẫn sắp tới.</p>
                                <div class="form-inner">
                                    <form method="post" id="newsletter-form" action="${pageContext.request.contextPath}/newsletter">
                                        <div class="form-group">
                                            <input type="email" name="email" id="newsletter-email" placeholder="Địa chỉ email" required="">
                                            <button type="submit"><i class="icon-12"></i></button>
                                        </div>
                                        <div id="newsletter-message" style="margin-top: 10px; font-size: 14px;"></div>
                                    </form>
                                </div>
                            </div>
                            <script>
                                document.getElementById('newsletter-form').addEventListener('submit', function(e) {
                                    e.preventDefault();
                                    const email = document.getElementById('newsletter-email').value;
                                    const messageDiv = document.getElementById('newsletter-message');
                                    
                                    // Disable form
                                    const submitBtn = this.querySelector('button[type="submit"]');
                                    submitBtn.disabled = true;
                                    messageDiv.innerHTML = '<span style="color: #666;">Đang xử lý...</span>';
                                    
                                    // Send AJAX request
                                    fetch('${pageContext.request.contextPath}/newsletter', {
                                        method: 'POST',
                                        headers: {
                                            'Content-Type': 'application/x-www-form-urlencoded',
                                        },
                                        body: 'email=' + encodeURIComponent(email) + '&action=subscribe'
                                    })
                                    .then(response => response.json())
                                    .then(data => {
                                        if (data.success) {
                                            messageDiv.innerHTML = '<span style="color: #28a745;">' + data.message + '</span>';
                                            document.getElementById('newsletter-email').value = '';
                                        } else {
                                            messageDiv.innerHTML = '<span style="color: #dc3545;">' + data.message + '</span>';
                                        }
                                        submitBtn.disabled = false;
                                    })
                                    .catch(error => {
                                        messageDiv.innerHTML = '<span style="color: #dc3545;">Đã xảy ra lỗi. Vui lòng thử lại sau.</span>';
                                        submitBtn.disabled = false;
                                    });
                                });
                            </script>
                        </div>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="bottom-inner">
                    <div class="copyright"><p>Bản quyền &copy; 2025 <a href="index.html">HCMUTE</a>, Inc. Đã đăng ký bản quyền</p></div>
                    <ul class="footer-card">
<%--                        <li><a href="index.html"><img src="${pageContext.request.contextPath}/assets/client/images/resource/footer-card-1.png" alt=""></a></li>--%>
<%--                        <li><a href="index.html"><img src="${pageContext.request.contextPath}/assets/client/images/resource/footer-card-2.png" alt=""></a></li>--%>
<%--                        <li><a href="index.html"><img src="${pageContext.request.contextPath}/assets/client/images/resource/footer-card-3.png" alt=""></a></li>--%>
<%--                        <li><a href="index.html"><img src="${pageContext.request.contextPath}/assets/client/images/resource/footer-card-4.png" alt=""></a></li>--%>
<%--                        <li><a href="index.html"><img src="${pageContext.request.contextPath}/assets/client/images/resource/footer-card-5.png" alt=""></a></li>--%>
<%--                        <li><a href="index.html"><img src="${pageContext.request.contextPath}/assets/client/images/resource/footer-card-6.png" alt=""></a></li>--%>
                    </ul>
                </div>
            </div>
        </div>
    </footer>
    <!-- main-footer end -->

