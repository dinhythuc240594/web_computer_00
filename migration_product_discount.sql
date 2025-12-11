-- Migration script để thêm tính năng giảm giá cho sản phẩm
-- Chạy script này để thêm các trường giảm giá vào bảng products
-- 
-- Logic: 
-- - price: giá hiện tại (giá bán sau khi giảm, nếu có giảm giá)
-- - original_price: giá gốc (trước khi giảm giá)
-- - discount_percentage: phần trăm giảm giá (ví dụ: 20 = giảm 20%)
-- - is_on_sale: có đang giảm giá không

USE `computer_store`;

-- Thêm các trường giảm giá vào bảng products
ALTER TABLE `products`
ADD COLUMN `original_price` double DEFAULT NULL COMMENT 'Giá gốc của sản phẩm (trước khi giảm giá)',
ADD COLUMN `discount_percentage` double DEFAULT NULL COMMENT 'Phần trăm giảm giá (ví dụ: 20 = 20%)',
ADD COLUMN `is_on_sale` tinyint(1) DEFAULT '0' COMMENT 'Có đang giảm giá không (1 = có, 0 = không)',
ADD COLUMN `sale_start_date` timestamp NULL COMMENT 'Ngày bắt đầu giảm giá',
ADD COLUMN `sale_end_date` timestamp NULL COMMENT 'Ngày kết thúc giảm giá';

-- Cập nhật dữ liệu hiện có: nếu chưa có original_price thì set bằng price
-- Tắt safe update mode tạm thời để cập nhật tất cả records
SET SQL_SAFE_UPDATES = 0;
UPDATE `products` 
SET `original_price` = `price` 
WHERE `original_price` IS NULL;
SET SQL_SAFE_UPDATES = 1;

-- Tạo index để tối ưu truy vấn sản phẩm đang giảm giá
ALTER TABLE `products` ADD KEY `idx_is_on_sale` (`is_on_sale`);
ALTER TABLE `products` ADD KEY `idx_sale_dates` (`sale_start_date`, `sale_end_date`);

