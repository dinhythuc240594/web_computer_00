    <style>
        .cart-menu-two .cart-action {
            display: flex;
            gap: 12px;
            flex-wrap: nowrap;
        }

        .cart-menu-two .cart-action .theme-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            white-space: nowrap;
            padding: 12px 28px;
            flex: 1 1 0;
            text-align: center;
        }

        .cart-menu-two .cart-action .theme-btn span {
            display: none;
        }
    </style>
    <!-- main header -->
    <header class="main-header">
        <!-- header-upper -->
        <div class="header-upper">
            <div class="large-container">
                <div class="upper-inner">
                    <figure class="logo-box"><a href="index.html"><img src="${pageContext.request.contextPath}/assets/client/images/Logo%20HCMUTE_Color%20background.png" alt="" style="height: 70px; width: 70px;"></a></figure>
                    <div class="search-area">
                        <div class="category-inner">
                            <div class="select-box">
                                <select class="wide">
                                    <option data-display="Danh Mục">Danh Mục</option>
                                    <option value="1">Điện thoại & Máy tính bảng</option>
                                    <option value="2">Laptop & Máy tính để bàn</option>
                                    <option value="3">Thiết bị âm thanh</option>
                                    <option value="4">Nguồn & Phụ kiện</option>
                                    <option value="5">Thiết bị đeo & Thể thao</option>
                                    <option value="6">Thiết bị ngoại vi</option>
                                    <option value="7">Ốp & Kính cường lực</option>
                                    <option value="8">Thiết bị điện tử thông minh</option>
                                    <option value="9">Đồ gia dụng</option>
                                    <option value="10">Drone & Máy ảnh</option>
                                </select>
                            </div>
                        </div>
                        <div class="search-box">
                            <form method="post" action="shop.html">
                                <div class="form-group">
                                    <input type="search" name="search-field" placeholder="Tìm kiếm sản phẩm..." required>
                                    <button type="submit"><i class="icon-2"></i></button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="right-column">
                        <div class="support-box">
<%--                            <div class="icon-box"><i class="icon-3"></i></div>--%>
<%--                            <a href="tel:912345678">091 2345 678</a>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- header-lower -->
        <div class="header-lower">
            <div class="large-container">
                <div class="outer-box">
                    <div style="position: relative;
    display: inline-block;
    left: 0px;
    top: 4px;
    /*width: 300px;*/
padding: 15px 20px;"></div>
<%--                    <div class="category-box">--%>
<%--                        <div class="text"><i class="fas fa-bars"></i><span>Danh mục</span></div>--%>
<%--                        <ul class="category-list clearfix">--%>
<%--                            <li class="category-dropdown">--%>
<%--                                <a href="#">Điện thoại & Máy tính bảng</a>--%>
<%--                                <div class="list-inner">--%>
<%--                                    <div class="inner-box clearfix">--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Thương hiệu</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">Apple</a></li>--%>
<%--                                                <li><a href="shop-details.html">Lenovo</a></li>--%>
<%--                                                <li><a href="shop-details.html">Microsoft</a></li>--%>
<%--                                                <li><a href="shop-details.html">Dell</a></li>--%>
<%--                                                <li><a href="shop-details.html">Gigabyte</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Kích thước</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">5.5 inch</a></li>--%>
<%--                                                <li><a href="shop-details.html">6.0 inch</a></li>--%>
<%--                                                <li><a href="shop-details.html">6.5 inch</a></li>--%>
<%--                                                <li><a href="shop-details.html">7.0 inch</a></li>--%>
<%--                                                <li><a href="shop-details.html">7.5 inch</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Danh mục</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">Android</a></li>--%>
<%--                                                <li><a href="shop-details.html">IOS</a></li>--%>
<%--                                                <li><a href="shop-details.html">Microsoft</a></li>--%>
<%--                                                <li><a href="shop-details.html">Java</a></li>--%>
<%--                                                <li><a href="shop-details.html">Màn hình cảm ứng</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <div class="shop-block">--%>
<%--                                        <span class="title">Chỉ trong tháng này</span>--%>
<%--                                        <h2><a href="shop-details.html">Mua thiết bị công nghệ</a></h2>--%>
<%--                                        <h4>Chỉ từ $99.99</h4>--%>
<%--                                        <a href="shop-details.html" class="link">Mua ngay</a>--%>
<%--                                        <figure class="image r_0 b_10"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-1.png" alt=""></figure>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </li>--%>
<%--                            <li class="category-dropdown">--%>
<%--                                <a href="#">Laptop & Máy tính để bàn</a>--%>
<%--                                <div class="list-inner">--%>
<%--                                    <div class="inner-box clearfix">--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Thương hiệu</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">Apple</a></li>--%>
<%--                                                <li><a href="shop-details.html">Lenovo</a></li>--%>
<%--                                                <li><a href="shop-details.html">Microsoft</a></li>--%>
<%--                                                <li><a href="shop-details.html">Dell</a></li>--%>
<%--                                                <li><a href="shop-details.html">Gigabyte</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Kích thước</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">12 inch</a></li>--%>
<%--                                                <li><a href="shop-details.html">13 inch</a></li>--%>
<%--                                                <li><a href="shop-details.html">14 inch</a></li>--%>
<%--                                                <li><a href="shop-details.html">15 inch</a></li>--%>
<%--                                                <li><a href="shop-details.html">15 inch</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Danh mục</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">Laptop gaming</a></li>--%>
<%--                                                <li><a href="shop-details.html">MacBook</a></li>--%>
<%--                                                <li><a href="shop-details.html">Ultrabook</a></li>--%>
<%--                                                <li><a href="shop-details.html">iMac</a></li>--%>
<%--                                                <li><a href="shop-details.html">Màn hình cảm ứng</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <div class="shop-block">--%>
<%--                                        <span class="title">Chỉ trong tháng này</span>--%>
<%--                                        <h2><a href="shop-details.html">Mua laptop</a></h2>--%>
<%--                                        <h4>Chỉ từ $399.99</h4>--%>
<%--                                        <a href="shop-details.html" class="link">Mua ngay</a>--%>
<%--                                        <figure class="image r_0 b_0"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-2.png" alt=""></figure>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </li>--%>
<%--                            <li class="category-dropdown">--%>
<%--                                <a href="#">Thiết bị âm thanh</a>--%>
<%--                                <div class="list-inner">--%>
<%--                                    <div class="inner-box clearfix">--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Thương hiệu</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">Jbl</a></li>--%>
<%--                                                <li><a href="shop-details.html">Microlab</a></li>--%>
<%--                                                <li><a href="shop-details.html">Sony</a></li>--%>
<%--                                                <li><a href="shop-details.html">Bose</a></li>--%>
<%--                                                <li><a href="shop-details.html">Yamaha</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Kích thước</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">10 dB - hít thở bình thường</a></li>--%>
<%--                                                <li><a href="shop-details.html">20 dB - thì thầm ở 1,5m</a></li>--%>
<%--                                                <li><a href="shop-details.html">30 dB - nói khẽ</a></li>--%>
<%--                                                <li><a href="shop-details.html">50 dB - tiếng mưa rơi</a></li>--%>
<%--                                                <li><a href="shop-details.html">120 dB - tiếng sấm</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Danh mục</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">Âm thanh sân bay</a></li>--%>
<%--                                                <li><a href="shop-details.html">Âm thanh lưỡng cư & bò sát</a></li>--%>
<%--                                                <li><a href="shop-details.html">Âm thanh động vật</a></li>--%>
<%--                                                <li><a href="shop-details.html">Âm chuông</a></li>--%>
<%--                                                <li><a href="shop-details.html">Tiếng chim</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <div class="shop-block">--%>
<%--                                        <span class="title">Chỉ trong tháng này</span>--%>
<%--                                        <h2><a href="shop-details.html">Mua loa</a></h2>--%>
<%--                                        <h4>Chỉ từ $79.99</h4>--%>
<%--                                        <a href="shop-details.html" class="link">Mua ngay</a>--%>
<%--                                        <figure class="image r_15 b_10"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-3.png" alt=""></figure>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </li>--%>
<%--                            <li><a href="shop-details.html">Nguồn & Phụ kiện</a></li>--%>
<%--                            <li><a href="shop-details.html">Thiết bị đeo & Thể thao</a></li>--%>
<%--                            <li class="category-dropdown">--%>
<%--                                <a href="#">Thiết bị ngoại vi</a>--%>
<%--                                <div class="list-inner">--%>
<%--                                    <div class="inner-box clearfix">--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Thương hiệu</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">Razer</a></li>--%>
<%--                                                <li><a href="shop-details.html">Logitech</a></li>--%>
<%--                                                <li><a href="shop-details.html">Asus</a></li>--%>
<%--                                                <li><a href="shop-details.html">Apple</a></li>--%>
<%--                                                <li><a href="shop-details.html">Intel</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Thiết bị ngoại vi</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">Chuột</a></li>--%>
<%--                                                <li><a href="shop-details.html">Bàn phím</a></li>--%>
<%--                                                <li><a href="shop-details.html">Màn hình</a></li>--%>
<%--                                                <li><a href="shop-details.html">RAM</a></li>--%>
<%--                                                <li><a href="shop-details.html">Đầu DVD</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Danh mục</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">Chuột</a></li>--%>
<%--                                                <li><a href="shop-details.html">Bàn phím</a></li>--%>
<%--                                                <li><a href="shop-details.html">Màn hình</a></li>--%>
<%--                                                <li><a href="shop-details.html">RAM</a></li>--%>
<%--                                                <li><a href="shop-details.html">Đầu DVD</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <div class="shop-block">--%>
<%--                                        <span class="title">Chỉ trong tháng này</span>--%>
<%--                                        <h2><a href="shop-details.html">Mua thiết bị ngoại vi</a></h2>--%>
<%--                                        <h4>Chỉ từ $49.99</h4>--%>
<%--                                        <a href="shop-details.html" class="link">Mua ngay</a>--%>
<%--                                        <figure class="image r_20 b_30"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-4.png" alt=""></figure>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </li>--%>
<%--                            <li class="category-dropdown">--%>
<%--                                <a href="#">Ốp & Kính cường lực</a>--%>
<%--                                <div class="list-inner">--%>
<%--                                    <div class="inner-box clearfix">--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Thương hiệu</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">Adensco</a></li>--%>
<%--                                                <li><a href="shop-details.html">Bally</a></li>--%>
<%--                                                <li><a href="shop-details.html">Brioni</a></li>--%>
<%--                                                <li><a href="shop-details.html">Coach</a></li>--%>
<%--                                                <li><a href="shop-details.html">Elasta</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Kích thước</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">12 inch</a></li>--%>
<%--                                                <li><a href="shop-details.html">13 inch</a></li>--%>
<%--                                                <li><a href="shop-details.html">14 inch</a></li>--%>
<%--                                                <li><a href="shop-details.html">15 inch</a></li>--%>
<%--                                                <li><a href="shop-details.html">15 inch</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Danh mục</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">Kính cường lực trong suốt</a></li>--%>
<%--                                                <li><a href="shop-details.html">Kính cường lực chống chói</a></li>--%>
<%--                                                <li><a href="shop-details.html">Kính cường lực chống nhìn trộm</a></li>--%>
<%--                                                <li><a href="shop-details.html">Kính cường lực phủ toàn màn</a></li>--%>
<%--                                                <li><a href="shop-details.html">Kính cường lực màu</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <div class="shop-block">--%>
<%--                                        <span class="title">Chỉ trong tháng này</span>--%>
<%--                                        <h2><a href="shop-details.html">Mua ốp lưng</a></h2>--%>
<%--                                        <h4>Chỉ từ $29.99</h4>--%>
<%--                                        <a href="shop-details.html" class="link">Mua ngay</a>--%>
<%--                                        <figure class="image r_0 b_0"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-5.png" alt=""></figure>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </li>--%>
<%--                            <li class="category-dropdown">--%>
<%--                                <a href="#">Thiết bị điện tử thông minh</a>--%>
<%--                                <div class="list-inner">--%>
<%--                                    <div class="inner-box clearfix">--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Thương hiệu</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">Samgung</a></li>--%>
<%--                                                <li><a href="shop-details.html">Sony</a></li>--%>
<%--                                                <li><a href="shop-details.html">Canon</a></li>--%>
<%--                                                <li><a href="shop-details.html">Hikvision</a></li>--%>
<%--                                                <li><a href="shop-details.html">Xiaomi</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Kích thước</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">12 inch</a></li>--%>
<%--                                                <li><a href="shop-details.html">13 inch</a></li>--%>
<%--                                                <li><a href="shop-details.html">14 inch</a></li>--%>
<%--                                                <li><a href="shop-details.html">15 inch</a></li>--%>
<%--                                                <li><a href="shop-details.html">15 inch</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                        <div class="single-column">--%>
<%--                                            <p>Danh mục</p>--%>
<%--                                            <ul>--%>
<%--                                                <li><a href="shop-details.html">Đèn thông minh</a></li>--%>
<%--                                                <li><a href="shop-details.html">Camera an ninh</a></li>--%>
<%--                                                <li><a href="shop-details.html">Ổ cắm thông minh</a></li>--%>
<%--                                                <li><a href="shop-details.html">Chuông cửa có hình</a></li>--%>
<%--                                                <li><a href="shop-details.html">Màn hình thông minh</a></li>--%>
<%--                                            </ul>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
<%--                                    <div class="shop-block">--%>
<%--                                        <span class="title">Chỉ trong tháng này</span>--%>
<%--                                        <h2><a href="shop-details.html">Mua camera</a></h2>--%>
<%--                                        <h4>Chỉ từ $199.99</h4>--%>
<%--                                        <a href="shop-details.html" class="link">Mua ngay</a>--%>
<%--                                        <figure class="image r_20 b_0"><img src="${pageContext.request.contextPath}/assets/client/images/shop/shop-6.png" alt=""></figure>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </li>--%>
<%--                            <li><a href="shop-details.html">Đồ gia dụng</a></li>--%>
<%--                            <li><a href="shop-details.html">Drone & Máy ảnh</a></li>--%>
<%--                        </ul>--%>
<%--                    </div>--%>
                    <div class="menu-area">
                        <!--Mobile Navigation Toggler-->
                        <div class="mobile-nav-toggler">
                            <i class="icon-bar"></i>
                            <i class="icon-bar"></i>
                            <i class="icon-bar"></i>
                        </div>
                        <nav class="main-menu navbar-expand-md navbar-light clearfix">
                            <div class="collapse navbar-collapse show clearfix" id="navbarSupportedContent">
                                <ul class="navigation clearfix">
                                    <li class="current"><a href="home">Home</a>
<%--                                        <ul>--%>
<%--                                            <li><a href="index.html">Electronics</a></li>--%>
<%--                                            <li><a href="index-2.html">Grocery</a></li>--%>
<%--                                            <li><a href="index-3.html">Fish & Meat</a></li>--%>
<%--                                            <li><a href="index-4.html">Vegetable</a></li>--%>
<%--                                            <li><a href="index-5.html">Furniture</a></li>--%>
<%--                                            <li><a href="index-6.html">Medical</a></li>--%>
<%--                                            <li><a href="index-7.html">Kids</a></li>--%>
<%--                                            <li><a href="index-8.html">Gardeing</a></li>--%>
<%--                                            <li><a href="index-9.html">Watch</a></li>--%>
<%--                                            <li><a href="index-10.html">Pet</a></li>--%>
<%--                                        </ul>--%>
                                    </li>
                                    <li><a href="category">Danh Mục</a>
<%--                                        <ul>--%>
<%--                                            <li><a href="shop.html">Shop Page 1</a></li>--%>
<%--                                            <li><a href="shop-2.html">Shop Page 2</a></li>--%>
<%--                                            <li><a href="shop-3.html">Shop Page 3</a></li>--%>
<%--                                            <li><a href="shop-4.html">Shop Page 4</a></li>--%>
<%--                                            <li><a href="shop-5.html">Shop Page 5</a></li>--%>
<%--                                            <li><a href="shop-details.html">Shop Details 1</a></li>--%>
<%--                                            <li><a href="shop-details-2.html">Shop Details 2</a></li>--%>
<%--                                            <li><a href="cart.html">Cart</a></li>--%>
<%--                                            <li><a href="checkout.html">Checkout</a></li>--%>
<%--                                            <li><a href="search.html">Search Result</a></li>--%>
<%--                                            <li><a href="account.html">Account</a></li>--%>
<%--                                            <li><a href="compare.html">Compare</a></li>--%>
<%--                                        </ul>--%>
                                    </li>
<%--                                    <li class="dropdown"><a href="index.html">Pages</a>--%>
<%--                                        <ul>--%>
<%--                                            <li><a href="about.html">About Us</a></li>--%>
<%--                                            <li><a href="login.html">Log In</a></li>--%>
<%--                                            <li><a href="signup.html">Sign Up</a></li>--%>
<%--                                            <li><a href="error.html">404</a></li>--%>
<%--                                        </ul>--%>
<%--                                    </li>--%>
<%--                                    <li class="dropdown"><a href="index.html">Blog</a>--%>
<%--                                        <ul>--%>
<%--                                            <li><a href="blog.html">Blog Grid</a></li>--%>
<%--                                            <li><a href="blog-2.html">Blog Standard</a></li>--%>
<%--                                            <li><a href="blog-details.html">Blog Details</a></li>--%>
<%--                                        </ul>--%>
<%--                                    </li>--%>
                                    <li><a href="contact">Contact</a></li>
                                    <li></li>
                                    <li></li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <div class="menu-right-content" style="padding: 15px 20px;">
                        <ul class="info-list">
                            <li class="cart-box">
                                <a class="shopping-cart shopping-cart-two" href="#" data-bs-toggle="offcanvas" data-bs-target="offcanvasRight"><i class="icon-7"></i><span>2</span></a>
                                <div class="cart-menu cart-menu-two">
                                    <div class="close-icon close-icon-two"><a href="javascript:void(0);"><i class="icon-9"></i></a></div>
                                    <div class="cart-products">
                                        <div class="product">
                                            <figure class="image-box"><a href="blog-details.html"><img src="${pageContext.request.contextPath}/assets/client/images/resource/cart-1.png" alt=""></a></figure>
                                            <h5><a href="shop-details.html">Sony Bluetooth Speaker Extra</a></h5>
                                            <span>$66.99 <span class="quentity">x 1</span></span>
                                            <button type="button" class="remove-btn"><i class="icon-9"></i></button>
                                        </div>
                                        <div class="product">
                                            <figure class="image-box"><a href="blog-details.html"><img src="${pageContext.request.contextPath}/assets/client/images/resource/cart-2.png" alt=""></a></figure>
                                            <h5><a href="shop-details.html">Iphone 12 Red Color Veriant</a></h5>
                                            <span>$999.99 <span class="quentity">x 1</span></span>
                                            <button type="button" class="remove-btn"><i class="icon-9"></i></button>
                                        </div>
                                        <div class="product">
                                            <figure class="image-box"><a href="blog-details.html"><img src="${pageContext.request.contextPath}/assets/client/images/resource/cart-3.png" alt=""></a></figure>
                                            <h5><a href="shop-details.html">Video Game Stick Lite 4K Console</a></h5>
                                            <span>$36.99 <span class="quentity">x 1</span></span>
                                            <button type="button" class="remove-btn"><i class="icon-9"></i></button>
                                        </div>
                                    </div>
                                    <div class="cart-total">
                                        <span>Tạm tính</span>
                                        <span class="cart-total-price">$1103.97</span>
                                    </div>
                                    <div class="cart-action">
                                        <a href="cart.html" class="theme-btn btn-two">Xem giỏ hàng <span></span><span></span><span></span><span></span></a>
                                        <a href="checkout.html" class="theme-btn btn-one">Thanh toán <span></span><span></span><span></span><span></span></a>
                                    </div>
                                </div>
                            </li>
                            <li><a href="login">Đăng nhập</a></li>
                            <li><a href="register">Đăng ký</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- main-header end -->

