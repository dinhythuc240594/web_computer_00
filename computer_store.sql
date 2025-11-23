DROP DATABASE IF EXISTS computer_store;
CREATE DATABASE computer_store;
USE computer_store;

-- 1. Bảng Categories (Danh mục)
CREATE TABLE categories (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            name VARCHAR(255) NOT NULL,
                            description TEXT,
                            is_active BOOLEAN DEFAULT TRUE,
                            parent_id INT,
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL
);

-- 2. Bảng Brands (Thương hiệu)
CREATE TABLE brands (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        name VARCHAR(255) NOT NULL,
                        code VARCHAR(255) NOT NULL,
                        is_active BOOLEAN DEFAULT TRUE,
                        logo_url VARCHAR(255),
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Bảng Users (Người dùng)
CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(50) NOT NULL UNIQUE,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       password_hash VARCHAR(255) NOT NULL,
                       full_name VARCHAR(100),
                       phone_number VARCHAR(20),
                       address TEXT,
                       is_active BOOLEAN DEFAULT TRUE,
                       role ENUM('ADMIN', 'CUSTOMER', 'STAFF') DEFAULT 'CUSTOMER',
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Bảng Products (Sản phẩm)
CREATE TABLE products (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          name VARCHAR(255) NOT NULL,
                          slug VARCHAR(255) UNIQUE,
                          description TEXT,
                          price DOUBLE NOT NULL,
                          stock_quantity INT DEFAULT 0,
                          image_url VARCHAR(255),
                          category_id INT,
                          brand_id INT,
                          is_active BOOLEAN DEFAULT TRUE,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL,
                          FOREIGN KEY (brand_id) REFERENCES brands(id) ON DELETE SET NULL
);

-- 5. Bảng Product Specs (Thông số kỹ thuật - Quan trọng cho cửa hàng máy tính)
CREATE TABLE product_specs (
                               id INT AUTO_INCREMENT PRIMARY KEY,
                               product_id INT NOT NULL,
                               spec_name VARCHAR(100) NOT NULL, -- Ví dụ: RAM, CPU, HDD
                               spec_value VARCHAR(255) NOT NULL, -- Ví dụ: 16GB, i7-12700H
                               created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- 6. Bảng Orders (Đơn hàng)
CREATE TABLE orders (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        user_id INT,
                        order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        status ENUM('PENDING', 'PROCESSING', 'SHIPPED', 'DELIVERED', 'CANCELLED') DEFAULT 'PENDING',
                        total_amount DOUBLE NOT NULL,
                        shipping_address TEXT NOT NULL,
                        payment_method VARCHAR(50),
                        note TEXT,
                        is_active BOOLEAN DEFAULT TRUE,
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- 7. Bảng Order Items (Chi tiết đơn hàng)
CREATE TABLE order_items (
                             id INT AUTO_INCREMENT PRIMARY KEY,
                             order_id INT NOT NULL,
                             product_id INT,
                             quantity INT NOT NULL,
                             price_at_purchase DOUBLE NOT NULL, -- Lưu giá tại thời điểm mua
                             created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                             updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                             FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
                             FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL
);

-- 8. Bảng Reviews (Đánh giá)
CREATE TABLE reviews (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         user_id INT NOT NULL,
                         product_id INT NOT NULL,
                         rating INT CHECK (rating >= 1 AND rating <= 5),
                         comment TEXT,
                         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
                         FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Sử dụng database (Thay tên database của bạn nếu khác)
-- USE computer_store;

-- 1. Insert Bảng Brands (Thương hiệu)
INSERT INTO brands (name, code, logo_url) VALUES
                                              ('Dell', 'DELL', NULL),
                                              ('Asus', 'ASUS', NULL),
                                              ('Apple', 'APPLE', NULL),
                                              ('HP', 'HP', NULL),
                                              ('Logitech', 'LOGITECH', NULL);

-- 2. Insert Bảng Categories (Danh mục)
-- Trước hết insert các danh mục cha (Parent)
INSERT INTO categories (name, description, parent_id, is_active) VALUES
                                                                     ('Laptop', 'Các loại máy tính xách tay', NULL, TRUE),       -- ID: 1
                                                                     ('PC Gaming', 'Máy tính để bàn chơi game', NULL, TRUE),      -- ID: 2
                                                                     ('Linh Kiện', 'RAM, ổ cứng, chip', NULL, TRUE),              -- ID: 3
                                                                     ('Phụ Kiện', 'Chuột, bàn phím, tai nghe', NULL, TRUE);       -- ID: 4

-- Sau đó insert các danh mục con (Child)
INSERT INTO categories (name, description, parent_id, is_active) VALUES
                                                                     ('Laptop Gaming', 'Laptop cấu hình cao chơi game', 1, TRUE), -- ID: 5 (Con của Laptop)
                                                                     ('Macbook', 'Laptop của Apple', 1, TRUE),                    -- ID: 6 (Con của Laptop)
                                                                     ('Laptop Văn Phòng', 'Laptop mỏng nhẹ', 1, TRUE),            -- ID: 7 (Con của Laptop)
                                                                     ('Chuột Máy Tính', 'Chuột có dây và không dây', 4, TRUE);    -- ID: 8 (Con của Phụ kiện)

-- 3. Insert Bảng Users (Người dùng)
-- Password hash ở đây là ví dụ (thường là chuỗi BCrypt/MD5 dài)
INSERT INTO users (username, email, password_hash, full_name, phone_number, address, role) VALUES
                                                                                               ('admin_system', 'admin@store.com', '$2a$12$EIxZaYGH...', 'Quản Trị Viên Chính', '0909000111', 'Hà Nội', 'ADMIN'),
                                                                                               ('staff_sales', 'staff@store.com', '$2a$12$9kKd8fJG...', 'Nhân Viên Bán Hàng', '0909000222', 'Đà Nẵng', 'STAFF'),
                                                                                               ('customer_nam', 'nam.nguyen@gmail.com', '$2a$12$LpKj7hTR...', 'Nguyễn Văn Nam', '0912345678', '123 Lê Lợi, TP.HCM', 'CUSTOMER'),
                                                                                               ('customer_huong', 'huong.tran@gmail.com', '$2a$12$MpOj9iUy...', 'Trần Thị Hương', '0987654321', '456 Nguyễn Huệ, TP.HCM', 'CUSTOMER');

-- 4. Insert Bảng Products (Sản phẩm)
INSERT INTO products (name, slug, description, price, stock_quantity, category_id, brand_id, image_url) VALUES
-- Sản phẩm 1: Asus Gaming
('Asus ROG Strix G15', 'asus-rog-strix-g15', 'Laptop gaming cấu hình khủng, tản nhiệt tốt', 32000000, 10, 5, 2, NULL),
-- Sản phẩm 2: Macbook Air
('MacBook Air M2 2022', 'macbook-air-m2-2022', 'Thiết kế mỏng nhẹ, chip M2 mạnh mẽ', 26500000, 20, 6, 3, NULL),
-- Sản phẩm 3: Dell XPS
('Dell XPS 13 Plus', 'dell-xps-13-plus', 'Laptop doanh nhân cao cấp, màn hình vô cực', 45000000, 5, 7, 1, NULL),
-- Sản phẩm 4: Chuột Logitech
('Chuột Logitech G502', 'chuot-logitech-g502', 'Chuột gaming cảm biến HERO', 990000, 50, 8, 5, NULL);

-- 5. Insert Bảng Product Specs (Thông số kỹ thuật)
INSERT INTO product_specs (product_id, spec_name, spec_value) VALUES
-- Specs cho Asus ROG (ID: 1)
(1, 'CPU', 'Intel Core i7-12700H'),
(1, 'RAM', '16GB DDR5'),
(1, 'VGA', 'NVIDIA RTX 3060 6GB'),
(1, 'Màn hình', '15.6 inch FHD 144Hz'),
-- Specs cho MacBook Air (ID: 2)
(2, 'CPU', 'Apple M2 8-core'),
(2, 'RAM', '8GB Unified Memory'),
(2, 'SSD', '256GB NVMe'),
(2, 'Màn hình', '13.6 inch Liquid Retina'),
-- Specs cho Dell XPS (ID: 3)
(3, 'CPU', 'Intel Core i7-1260P'),
(3, 'RAM', '16GB LPDDR5'),
(3, 'Trọng lượng', '1.23 kg');

-- 6. Insert Bảng Orders (Đơn hàng)
INSERT INTO orders (user_id, status, total_amount, shipping_address, payment_method, note) VALUES
-- Đơn hàng 1: Khách hàng Nam mua Macbook (Đã giao)
(3, 'DELIVERED', 26500000, '123 Lê Lợi, TP.HCM', 'COD', 'Giao giờ hành chính'),
-- Đơn hàng 2: Khách hàng Hương mua Asus và Chuột (Đang xử lý)
(4, 'PROCESSING', 32990000, '456 Nguyễn Huệ, TP.HCM', 'BANK_TRANSFER', 'Gọi trước khi giao');

-- 7. Insert Bảng Order Items (Chi tiết đơn hàng)
INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase) VALUES
-- Chi tiết cho Đơn hàng 1 (Nam mua Macbook)
(1, 2, 1, 26500000),
-- Chi tiết cho Đơn hàng 2 (Hương mua Asus + Chuột)
(2, 1, 1, 32000000), -- Asus
(2, 4, 1, 990000);    -- Chuột

-- 8. Insert Bảng Reviews (Đánh giá)
INSERT INTO reviews (user_id, product_id, rating, comment) VALUES
-- Nam đánh giá Macbook
(3, 2, 5, 'Máy rất đẹp, pin trâu dùng cả ngày không hết. Rất đáng tiền!'),
-- Hương đánh giá Chuột (Giả sử đã nhận được hàng trước đó)
(4, 4, 4, 'Chuột cầm đầm tay, nhưng click hơi ồn.');