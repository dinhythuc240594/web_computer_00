-- Migration script để tạo bảng newsletter_subscriptions
-- Chạy script này để tạo bảng lưu trữ email đăng ký newsletter

USE `computer_store`;

-- Tạo bảng newsletter_subscriptions
CREATE TABLE IF NOT EXISTS `newsletter_subscriptions` (
    `id` int NOT NULL AUTO_INCREMENT,
    `email` varchar(255) NOT NULL,
    `status` varchar(20) DEFAULT 'active' COMMENT 'active, unsubscribed',
    `subscribed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `unsubscribed_at` timestamp NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_email` (`email`),
    KEY `idx_status` (`status`),
    KEY `idx_subscribed_at` (`subscribed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

