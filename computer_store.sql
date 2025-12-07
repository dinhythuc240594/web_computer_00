CREATE DATABASE  IF NOT EXISTS `computer_store` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `computer_store`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: computer_store
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
                          `id` int NOT NULL AUTO_INCREMENT,
                          `name` varchar(255) NOT NULL,
                          `code` varchar(255) NOT NULL,
                          `is_active` tinyint(1) DEFAULT '1',
                          `logo_url` varchar(255) DEFAULT NULL,
                          `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                          `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                          `logo_blob` mediumblob,
                          `image` blob,
                          PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES (1,'Dell','DELL',1,NULL,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,_binary '/web_computer_00_war_exploded/uploads/brands/b37223ed7f8545cba1ac3e4fe980df6a.png'),(2,'Asus','ASUS',1,NULL,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,_binary '/web_computer_00_war_exploded/uploads/brands/ee37d72eb19c4d00bfa95f5255c82bd9.jpg'),(3,'Apple','APPLE',1,NULL,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,_binary '/web_computer_00_war_exploded/uploads/brands/27dd93be914340e39b9f51dec6299e9b.png'),(4,'HP','HP',1,NULL,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,_binary '/web_computer_00_war_exploded/uploads/brands/64ea6f74e56e4f938c8495344c43b1a6.jpg'),(5,'Logitech','LOGITECH',1,NULL,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,_binary '/web_computer_00_war_exploded/uploads/brands/1b8e4fe657a541eb8a32dcc85960d7bd.jpg'),(6,'Xiaomi','Xiaomi',1,NULL,'2025-12-07 11:42:58','2025-12-07 11:42:58',NULL,_binary '/web_computer_00_war_exploded/uploads/brands/952cb2399b624b26939f4151ef7974d3.png');
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
                              `id` int NOT NULL AUTO_INCREMENT,
                              `name` varchar(255) NOT NULL,
                              `description` text,
                              `is_active` tinyint(1) DEFAULT '1',
                              `parent_id` int DEFAULT NULL,
                              `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                              `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                              `logo_blob` mediumblob,
                              `image` blob,
                              PRIMARY KEY (`id`),
                              KEY `parent_id` (`parent_id`),
                              CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Laptop','<p>C&aacute;c loại m&aacute;y t&iacute;nh x&aacute;ch tay</p>\r\n\r\n<p>Laptop văn ph&ograve;ng cấp cao</p>',0,NULL,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,_binary '/web_computer_00_war_exploded/uploads/categories/d43ef09831ac4a7582a9ad7d0345e23e.jpg'),(2,'PC Gaming','Máy tính để bàn chơi game',0,NULL,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,NULL),(3,'Linh Kiện','RAM, ổ cứng, chip',0,NULL,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,NULL),(4,'Phụ Kiện','Chuột, bàn phím, tai nghe',0,NULL,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,NULL),(5,'Laptop Gaming','<p>Laptop cấu h&igrave;nh cao chơi game</p>',1,1,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,_binary '/web_computer_00_war_exploded/uploads/categories/2bbe5821b7bb4cbba4dcde1cbe7c0a9b.webp'),(6,'Macbook','<p>Laptop của Apple</p>',1,1,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,_binary '/web_computer_00_war_exploded/uploads/categories/128d4ce4aea844d193db452879ec9ec6.webp'),(7,'Laptop Văn Phòng','<p>Laptop mỏng nhẹ</p>',1,1,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,_binary '/web_computer_00_war_exploded/uploads/categories/06de7feb8faf4f229ea5118844fbe69b.jpg'),(8,'Chuột Máy Tính','<p>Chuột c&oacute; d&acirc;y v&agrave; kh&ocirc;ng d&acirc;y</p>',1,4,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,_binary '/web_computer_00_war_exploded/uploads/categories/3b3ee027c68e41b79b284040917313c4.jpg'),(10,'Điện thoại','<p>Điện thoại th&ocirc;ng minh</p>',1,4,'2025-12-07 11:51:42','2025-12-07 11:51:42',NULL,_binary '/web_computer_00_war_exploded/uploads/categories/46b6a0abc4274f369d9a56c468f22b0c.jpg'),(11,'Đồng hồ thông minh','<p>Đồng hồ th&ocirc;ng minh</p>',1,4,'2025-12-07 12:19:41','2025-12-07 12:19:41',NULL,_binary '/web_computer_00_war_exploded/uploads/categories/0e65c612fb4744bfb28879c69ac56ec8.webp');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
                               `id` int NOT NULL AUTO_INCREMENT,
                               `order_id` int NOT NULL,
                               `product_id` int DEFAULT NULL,
                               `quantity` int NOT NULL,
                               `price_at_purchase` double NOT NULL,
                               `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                               `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                               PRIMARY KEY (`id`),
                               KEY `order_id` (`order_id`),
                               KEY `product_id` (`product_id`),
                               CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
                               CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,2,1,26500000,'2025-11-23 15:33:39','2025-11-23 15:33:39'),(2,2,1,1,32000000,'2025-11-23 15:33:39','2025-11-23 15:33:39'),(3,2,4,1,990000,'2025-11-23 15:33:39','2025-11-23 15:33:39'),(4,3,3,2,45000000,'2025-12-06 03:28:05','2025-12-06 03:28:05'),(5,4,3,2,45000000,'2025-12-06 03:56:04','2025-12-06 03:56:04'),(6,6,3,1,45000000,'2025-12-06 04:19:30','2025-12-06 04:19:30'),(7,7,1,1,32000000,'2025-12-06 04:58:35','2025-12-06 04:58:35'),(8,8,1,1,32000000,'2025-12-06 07:45:13','2025-12-06 07:45:13'),(9,9,4,2,990000,'2025-12-07 15:18:18','2025-12-07 15:18:18');
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
                          `id` int NOT NULL AUTO_INCREMENT,
                          `user_id` int DEFAULT NULL,
                          `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                          `status` enum('PENDING','PROCESSING','SHIPPED','DELIVERED','CANCELLED') DEFAULT 'PENDING',
                          `total_amount` double NOT NULL,
                          `shipping_address` text NOT NULL,
                          `payment_method` varchar(50) DEFAULT NULL,
                          `note` text,
                          `is_active` tinyint(1) DEFAULT '1',
                          `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                          `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                          PRIMARY KEY (`id`),
                          KEY `user_id` (`user_id`),
                          CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,3,'2025-11-23 15:33:39','DELIVERED',26500000,'123 Lê Lợi, TP.HCM','COD','Giao giờ hành chính',1,'2025-11-23 15:33:39','2025-11-23 15:33:39'),(2,4,'2025-11-23 15:33:39','DELIVERED',32990000,'456 Nguyễn Huệ, TP.HCM','BANK_TRANSFER','Gọi trước khi giao',1,'2025-11-23 15:33:39','2025-11-23 15:33:39'),(3,5,'2025-12-05 17:00:00','CANCELLED',90000000,'706A XaLo HaNoi','bank_transfer','',0,'2025-12-06 03:28:05','2025-12-06 03:28:05'),(4,5,'2025-12-05 17:00:00','CANCELLED',90000000,'706A XaLo HaNoi','bank_transfer','',0,'2025-12-06 03:56:04','2025-12-06 03:56:04'),(5,5,'2025-12-05 17:00:00','SHIPPED',90000000,'706A XaLo HaNoi','bank_transfer','',1,'2025-12-06 04:19:02','2025-12-06 04:19:02'),(6,5,'2025-12-05 17:00:00','SHIPPED',45000000,'22 Đường số 6','bank_transfer','',1,'2025-12-06 04:19:30','2025-12-06 04:19:30'),(7,5,'2025-12-05 17:00:00','CANCELLED',32000000,'706A XaLo HaNoi','cod','',0,'2025-12-06 04:58:35','2025-12-06 04:58:35'),(8,5,'2025-12-05 17:00:00','DELIVERED',32000000,'22 Đường số 6','bank_transfer','',1,'2025-12-06 07:45:13','2025-12-06 07:45:13'),(9,5,'2025-12-07 15:18:18','PROCESSING',1980000,'Chung cư Mini Văn Minh','bank_transfer','',1,'2025-12-07 15:18:18','2025-12-07 15:18:18');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
                                         `id` int NOT NULL AUTO_INCREMENT,
                                         `user_id` int NOT NULL,
                                         `token` varchar(255) NOT NULL,
                                         `expires_at` timestamp NOT NULL,
                                         `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                         `used` tinyint(1) DEFAULT '0',
                                         PRIMARY KEY (`id`),
                                         UNIQUE KEY `token` (`token`),
                                         KEY `idx_token` (`token`),
                                         KEY `idx_user_id` (`user_id`),
                                         CONSTRAINT `password_reset_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
INSERT INTO `password_reset_tokens` VALUES (1,5,'UCP6w-dsK-wY4rVievXSZws48u3rAzyV6jFExQeGtXk','2025-12-07 09:14:56','2025-12-07 15:14:56',1);
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_specs`
--

DROP TABLE IF EXISTS `product_specs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_specs` (
                                 `id` int NOT NULL AUTO_INCREMENT,
                                 `product_id` int NOT NULL,
                                 `spec_name` varchar(100) NOT NULL,
                                 `spec_value` varchar(255) NOT NULL,
                                 `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                 `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                 PRIMARY KEY (`id`),
                                 KEY `product_id` (`product_id`),
                                 CONSTRAINT `product_specs_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_specs`
--

LOCK TABLES `product_specs` WRITE;
/*!40000 ALTER TABLE `product_specs` DISABLE KEYS */;
INSERT INTO `product_specs` VALUES (1,1,'CPU','Intel Core i7-12700H','2025-11-23 15:33:39','2025-11-23 15:33:39'),(2,1,'RAM','16GB DDR5','2025-11-23 15:33:39','2025-11-23 15:33:39'),(3,1,'VGA','NVIDIA RTX 3060 6GB','2025-11-23 15:33:39','2025-11-23 15:33:39'),(4,1,'Màn hình','15.6 inch FHD 144Hz','2025-11-23 15:33:39','2025-11-23 15:33:39'),(5,2,'CPU','Apple M2 8-core','2025-11-23 15:33:39','2025-11-23 15:33:39'),(6,2,'RAM','8GB Unified Memory','2025-11-23 15:33:39','2025-11-23 15:33:39'),(7,2,'SSD','256GB NVMe','2025-11-23 15:33:39','2025-11-23 15:33:39'),(8,2,'Màn hình','13.6 inch Liquid Retina','2025-11-23 15:33:39','2025-11-23 15:33:39'),(9,3,'CPU','Intel Core i7-1260P','2025-11-23 15:33:39','2025-11-23 15:33:39'),(10,3,'RAM','16GB LPDDR5','2025-11-23 15:33:39','2025-11-23 15:33:39'),(11,3,'Trọng lượng','1.23 kg','2025-11-23 15:33:39','2025-11-23 15:33:39');
/*!40000 ALTER TABLE `product_specs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
                            `id` int NOT NULL AUTO_INCREMENT,
                            `name` varchar(255) NOT NULL,
                            `slug` varchar(255) DEFAULT NULL,
                            `description` text,
                            `price` double NOT NULL,
                            `stock_quantity` int DEFAULT '0',
                            `image_url` varchar(255) DEFAULT NULL,
                            `category_id` int DEFAULT NULL,
                            `brand_id` int DEFAULT NULL,
                            `is_active` tinyint(1) DEFAULT '1',
                            `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                            `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                            `logo_blob` mediumblob,
                            `image` blob,
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `slug` (`slug`),
                            KEY `category_id` (`category_id`),
                            KEY `brand_id` (`brand_id`),
                            CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
                            CONSTRAINT `products_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Asus ROG Strix G15','asus-rog-strix-g15','<p>Laptop gaming cấu h&igrave;nh khủng, tản nhiệt tốt</p>\r\n\r\n<p><img alt=\"Asus ROG Strix G15 G513IH HN015W | Chính Hãng Giá Rẻ Nhất\" src=\"https://laptop15.vn/wp-content/uploads/2023/04/ASUS-ROG-Strix-G15-G513IE-HN246W-2.png\" /></p>',28000000,20,NULL,5,2,1,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,_binary '/web_computer_00_war_exploded/uploads/products/828d672cbb8846e49b6da94e46de00d4.webp'),(2,'MacBook Air M2 2022','macbook-air-m2-2022','<p>Thiết kế mỏng nhẹ, chip M2 mạnh mẽ</p>\r\n\r\n<p><img alt=\"MacBook Air (M2, 2022) - Thông số kỹ thuật - Bộ phận hỗ trợ của Apple (VN)\" src=\"https://cdsassets.apple.com/live/SZLF0YNV/images/sp/111867_SP869-2022-macbook-air-m2-colors.png\" /></p>',26500000,20,NULL,6,3,1,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,_binary '/web_computer_00_war_exploded/uploads/products/0c7b0eb2d77d48a185cb964d2e476c43.webp'),(3,'Dell XPS 13 Plus','dell-xps-13-plus','<p>Laptop doanh nh&acirc;n cao cấp, m&agrave;n h&igrave;nh v&ocirc; cực</p>\r\n\r\n<p><img alt=\"Laptop Dell XPS 13 Plus 9320 i5 (71013325) - Chính hãng, mua trả chậm\" src=\"https://cdn.tgdd.vn/Products/Images/44/314838/dell-xps-13-plus-9320-i5-71013325-1-750x500.jpg\" /></p>',42000000,100,'',7,1,1,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,_binary '/web_computer_00_war_exploded/uploads/products/73db38bbcdb547f2a42fd6ee8c1d3bd4.jpg'),(4,'Chuột Logitech G502','chuot-logitech-g502','<p>Chuột gaming cảm biến HERO</p>\r\n\r\n<p>chuột c&oacute; d&acirc;y</p>\r\n\r\n<p><img alt=\"Chuột Logitech G502 Hero Gaming chính hãng, gá rẻ\" src=\"https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/86/326725/chuot-co-day-gaming-logitech-g502-hero-den-1-638622770814523787-750x500.jpg\" /></p>',990000,8,NULL,8,5,1,'2025-11-23 15:33:39','2025-11-23 15:33:39',NULL,_binary '/web_computer_00_war_exploded/uploads/products/4f237cdcf27041b18534fc851036450c.jpg'),(5,'Điện thoại Xiaomi Redmi Note 14 6GB/128GB','xiaomi-redmi-not-14-64gb','<p><img alt=\"Xiaomi Redmi Note 14 6GB/128GB\" src=\"https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/42/320729/Kit/redmi-note-14-note-638724626243747656.jpg\" /></p>',4600000,10,NULL,10,6,1,'2025-12-07 11:52:45','2025-12-07 11:52:45',NULL,_binary '/web_computer_00_war_exploded/uploads/products/d3fe32648aba4eff9ced1937bd9b70a6.jpg');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
                           `id` int NOT NULL AUTO_INCREMENT,
                           `user_id` int NOT NULL,
                           `product_id` int NOT NULL,
                           `rating` int DEFAULT NULL,
                           `comment` text,
                           `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                           `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                           PRIMARY KEY (`id`),
                           KEY `user_id` (`user_id`),
                           KEY `product_id` (`product_id`),
                           CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
                           CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
                           CONSTRAINT `reviews_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,3,2,5,'Máy rất đẹp, pin trâu dùng cả ngày không hết. Rất đáng tiền!','2025-11-23 15:33:39','2025-11-23 15:33:39'),(2,4,4,4,'Chuột cầm đầm tay, nhưng click hơi ồn.','2025-11-23 15:33:39','2025-11-23 15:33:39'),(3,5,4,3,'Ok tốt','2025-12-07 11:07:45','2025-12-07 11:07:45'),(4,5,4,5,'Tốt','2025-12-07 11:18:33','2025-12-07 11:18:33');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
                         `id` int NOT NULL AUTO_INCREMENT,
                         `username` varchar(50) NOT NULL,
                         `email` varchar(100) NOT NULL,
                         `password_hash` varchar(255) NOT NULL,
                         `full_name` varchar(100) DEFAULT NULL,
                         `phone_number` varchar(20) DEFAULT NULL,
                         `address` text,
                         `is_active` tinyint(1) DEFAULT '1',
                         `role` enum('ADMIN','CUSTOMER','STAFF') DEFAULT 'CUSTOMER',
                         `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                         `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                         `avatar_blob` mediumblob,
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `username` (`username`),
                         UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'admin_system','admin@store.com','12345678','Quản Trị Viên Chính','0909000111','Hà Nội',1,'ADMIN','2025-11-23 15:33:39','2025-11-23 15:33:39',NULL),
(2,'staff_sales','staff@store.com','12345678','Nhân Viên Bán Hàng','0909000222','Đà Nẵng',1,'STAFF','2025-11-23 15:33:39','2025-11-23 15:33:39',NULL),
(3,'customer_nam','nam.nguyen@gmail.com','12345678','Nguyễn Văn Nam','0912345678','123 Lê Lợi, TP.HCM',0,'CUSTOMER','2025-11-23 15:33:39','2025-11-23 15:33:39',NULL),
(4,'customer_huong','huong.tran@gmail.com','12345678','Trần Thị Hương','0987654321','456 Nguyễn Huệ, TP.HCM',0,'CUSTOMER','2025-11-23 15:33:39','2025-11-23 15:33:39',NULL),
(5,'dinhythuc240594@gmail.com','dinhythuc240594@gmail.com','12345678','Thức Đinh','0982109103','22 Đường số 6',1,'CUSTOMER','2025-12-06 03:26:41','2025-12-06 03:26:41',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
                            `id` int NOT NULL AUTO_INCREMENT,
                            `user_id` int NOT NULL,
                            `product_id` int NOT NULL,
                            `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `unique_user_product` (`user_id`,`product_id`),
                            KEY `product_id` (`product_id`),
                            CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
                            CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-07 22:55:48
