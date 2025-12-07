-- Migration script: Thay đổi kiểu dữ liệu avatar_blob từ BLOB sang MEDIUMBLOB
-- Chạy script này nếu bạn đã tạo bảng users trước đó và gặp lỗi "Data too long for column 'avatar_blob'"

USE computer_store;

-- Thay đổi kiểu dữ liệu cột avatar_blob từ BLOB sang MEDIUMBLOB
-- MEDIUMBLOB có thể lưu tối đa 16MB, đủ cho ảnh avatar (giới hạn upload 5MB)
ALTER TABLE users MODIFY COLUMN avatar_blob MEDIUMBLOB;
ALTER TABLE brands ADD COLUMN image BLOB NULL;
ALTER TABLE categories ADD COLUMN image BLOB NULL;
ALTER TABLE products ADD COLUMN image BLOB NULL;
-- Kiểm tra kết quả
-- DESCRIBE users;

