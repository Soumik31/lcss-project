-- ============================================================
-- LCSS Web Project - Database Setup
-- Run this file in phpMyAdmin or MySQL CLI to set up the DB
-- ============================================================

-- Create and select the main database
CREATE DATABASE IF NOT EXISTS `lcss_web_project` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lcss_web_project`;

-- ============================================================
-- Table: users
-- ============================================================
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `gender` VARCHAR(10),
  `dob` DATE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Sample users (password stored as plaintext — as per original project)
INSERT INTO `users` (`name`, `email`, `username`, `password`, `gender`, `dob`) VALUES
('Alice Johnson', 'alice@example.com', 'alice', 'alice123', 'female', '1995-04-12'),
('Bob Smith', 'bob@example.com', 'bob', 'bob123', 'male', '1992-08-25'),
('Carol White', 'carol@example.com', 'carol', 'carol123', 'female', '1998-01-30');

-- ============================================================
-- Table: admin
-- ============================================================
CREATE TABLE IF NOT EXISTS `admin` (
  `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `aduser` VARCHAR(50) NOT NULL,
  `password` VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Default admin account: admin / admin123
INSERT INTO `admin` (`aduser`, `password`) VALUES
('admin', 'admin123');

-- ============================================================
-- Create and select the product database
-- Note: The PHP code uses "Productdb" as the DB name (case-sensitive on Linux).
-- On Windows/MAMP this is case-insensitive. Both are created here for compatibility.
-- ============================================================
CREATE DATABASE IF NOT EXISTS `Productdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `Productdb`;

-- ============================================================
-- Table: producttb
-- ============================================================
CREATE TABLE IF NOT EXISTS `producttb` (
  `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `product_name` VARCHAR(100) NOT NULL,
  `product_des` TEXT,
  `product_price` FLOAT,
  `product_cat` VARCHAR(50),
  `product_quan` INT(11),
  `product_image` VARCHAR(200),
  `product_date` DATE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Sample products — Laptops
INSERT INTO `producttb` (`product_name`, `product_des`, `product_price`, `product_cat`, `product_quan`, `product_image`, `product_date`) VALUES
('Dell XPS 15', 'High-performance laptop with 15.6" OLED display, Intel Core i7, 16GB RAM, 512GB SSD.', 1299.99, 'Laptop', 10, 'img/product01.png', '2024-01-10'),
('MacBook Pro 14', 'Apple M3 chip, 14-inch Liquid Retina display, 16GB unified memory, 512GB SSD.', 1999.00, 'Laptop', 7, 'img/product02.png', '2024-01-15'),
('Lenovo ThinkPad X1', 'Business ultrabook with Intel Core i5, 8GB RAM, 256GB SSD, 14" FHD display.', 899.99, 'Laptop', 15, 'img/product03.png', '2024-02-01'),

-- Sample products — Phones
('Samsung Galaxy S24', 'Flagship Android phone with 6.2" Dynamic AMOLED, Snapdragon 8 Gen 3, 256GB.', 799.99, 'Phones', 20, 'img/product04.png', '2024-01-20'),
('iPhone 15 Pro', 'Apple A17 Pro chip, 6.1" Super Retina XDR, 128GB, Titanium design.', 999.00, 'Phones', 12, 'img/product05.png', '2024-01-22'),
('Google Pixel 8', 'Google Tensor G3 chip, 6.2" OLED, 128GB, advanced AI camera features.', 699.00, 'Phones', 18, 'img/product06.png', '2024-02-05'),

-- Sample products — Music
('Sony WH-1000XM5', 'Industry-leading noise cancelling wireless headphones, 30hr battery life.', 349.99, 'Music', 25, 'img/product07.png', '2024-01-18'),
('JBL Charge 5', 'Portable Bluetooth speaker, IP67 waterproof, 20hr playtime, powerbank feature.', 179.99, 'Music', 30, 'img/product08.png', '2024-01-25'),
('Apple AirPods Pro', '2nd gen AirPods with Active Noise Cancellation, Adaptive Transparency, USB-C.', 249.00, 'Music', 22, 'img/product09.png', '2024-02-10');
