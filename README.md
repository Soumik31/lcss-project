# LCSS E-Commerce Web Project

A PHP-based e-commerce web application built as part of a Master's degree project. It supports product browsing by category (Laptops, Phones, Music), a shopping cart, user registration/login, and an admin panel for managing products and users.

---

## Run in GitHub Codespaces (no install needed)

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/Soumik31/lcsslab.github.io)

1. Click the button above (or go to the repo on GitHub → green "Code" button → "Codespaces" tab → "Create codespace")
2. Wait ~2 minutes for the environment to build
3. The browser will automatically open the site at `http://localhost:8080`

> Free tier: 120 core-hours/month on personal GitHub accounts.

---

## Tech Stack

- PHP (procedural + OOP)
- MySQL / MySQLi
- Bootstrap 4.6
- jQuery 3.6
- PayPal REST API SDK (sandbox)

---

## Project Structure

```
/
├── index.php               # Homepage — product listing
├── login.php               # User login
├── registration.php        # User registration
├── process.php             # User login handler
├── checkout.php            # Checkout page
├── payment.php             # Payment page
├── contact.php             # Contact page
├── aboutus.php             # About page
├── laptop.php              # Laptops category
├── phone.php               # Phones category
├── music.php               # Music category
├── connection.php          # Root DB connection (lcss_web_project)
├── style.css               # Global styles
├── database.sql            # Database setup + sample data
│
├── admin/                  # Admin panel
│   ├── adminlogin.php      # Admin login page
│   ├── process.php         # Admin login handler
│   ├── index.php           # Admin dashboard
│   ├── products.php        # View all products
│   ├── add_product.php     # Add a product
│   ├── edit_product.php    # Edit a product
│   ├── orders.php          # View orders
│   ├── users.php           # View registered users
│   ├── reports.php         # Reports page
│   ├── connection.php      # Admin DB connection (lcss_web_project)
│   └── conn.php            # Product DB connection (productdb)
│
├── user/                   # Logged-in user area
│   ├── index.php           # User homepage
│   ├── cart.php            # Shopping cart
│   ├── checkout.php        # User checkout
│   ├── payment.php         # Payment processing
│   ├── PaypalSuccess.php   # PayPal return handler
│   ├── connection.php      # User DB connection (lcss_web_project)
│   └── config.php          # PayPal API config
│
├── php/                    # DB helper classes
│   ├── CreateDb.php        # Main product DB class
│   ├── CreateDb_laptop.php # Laptop category query
│   ├── CreateDb_music.php  # Music category query
│   ├── CreateDb_phone.php  # Phone category query
│   └── component.php       # Reusable product card HTML
│
├── img/                    # Product and site images
└── upload/                 # Uploaded product images
```

---

## Database Setup

The project uses two MySQL databases:

| Database          | Used by                        |
|-------------------|--------------------------------|
| `lcss_web_project`| Users, admin accounts          |
| `productdb`       | Products (producttb table)     |

### Quick Setup

1. Open **phpMyAdmin** (or your MySQL client)
2. Import the file: `database.sql`
3. This will create both databases, all tables, and insert sample data

---

## Sample Data

### Admin Login

| Username | Password  |
|----------|-----------|
| admin    | admin123  |

### Sample User Logins

| Username | Password  |
|----------|-----------|
| alice    | alice123  |
| bob      | bob123    |
| carol    | carol123  |

### Sample Products (9 total)

| Category | Products |
|----------|----------|
| Laptop   | Dell XPS 15, MacBook Pro 14, Lenovo ThinkPad X1 |
| Phones   | Samsung Galaxy S24, iPhone 15 Pro, Google Pixel 8 |
| Music    | Sony WH-1000XM5, JBL Charge 5, Apple AirPods Pro |

---

## Local Setup (XAMPP / WAMP / MAMP)

1. Clone or copy the project into your web server's root folder:
   - XAMPP: `C:/xampp/htdocs/lcss/`
   - MAMP: `/Applications/MAMP/htdocs/lcss/`

2. Start Apache and MySQL from your control panel

3. Import `database.sql` via phpMyAdmin

4. Open your browser and go to:
   ```
   http://localhost/lcss/
   ```

5. Admin panel:
   ```
   http://localhost/lcss/admin/adminlogin.php
   ```

---

## Notes

- Passwords are stored in **plaintext** — this is an academic project and not intended for production use
- PayPal integration is configured in **sandbox mode** (`user/config.php`)
- The project was built as a learning exercise for a Master's degree course (LCSS)
