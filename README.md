# LCSS E-Commerce Web Project

A PHP-based e-commerce web application built as part of a Master's degree project. It supports product browsing by category (Laptops, Phones, Music), a shopping cart, user registration/login, and an admin panel for managing products and users.

---

## Tech Stack

- PHP (procedural + OOP)
- MySQL / MySQLi
- Bootstrap 4.6
- jQuery 3.6
- PayPal REST API SDK (sandbox)

---

## Run Locally with XAMPP or WAMP

### Step 1 — Download the project

Click the green **Code** button on this page → **Download ZIP**, then extract it.

Or clone it:
```bash
git clone https://github.com/Soumik31/lcss-project.git
```

### Step 2 — Move to your web server folder

- XAMPP (Windows): `C:/xampp/htdocs/lcss-project/`
- WAMP (Windows): `C:/wamp64/www/lcss-project/`
- MAMP (Mac): `/Applications/MAMP/htdocs/lcss-project/`

### Step 3 — Import the database

1. Start Apache and MySQL from your XAMPP/WAMP control panel
2. Open your browser and go to `http://localhost/phpmyadmin`
3. Click **Import** → choose the file `database.sql` from this project → click **Go**

### Step 4 — Open the site

```
http://localhost/lcss-project/
```

Admin panel:
```
http://localhost/lcss-project/admin/adminlogin.php
```

---

## Login Credentials

### Admin

| Username | Password  |
|----------|-----------|
| admin    | admin123  |

### Sample Users

| Username | Password  |
|----------|-----------|
| alice    | alice123  |
| bob      | bob123    |
| carol    | carol123  |

---

## Sample Products

| Category | Products |
|----------|----------|
| Laptop   | Dell XPS 15, MacBook Pro 14, Lenovo ThinkPad X1 |
| Phones   | Samsung Galaxy S24, iPhone 15 Pro, Google Pixel 8 |
| Music    | Sony WH-1000XM5, JBL Charge 5, Apple AirPods Pro |

---

## Project Structure

```
/
├── index.php               # Homepage
├── login.php               # User login
├── registration.php        # User registration
├── connection.php          # DB connection
├── database.sql            # Database setup + sample data
├── style.css               # Global styles
│
├── admin/                  # Admin panel
│   ├── adminlogin.php      # Admin login
│   ├── index.php           # Dashboard
│   ├── products.php        # View products
│   ├── add_product.php     # Add product
│   ├── orders.php          # View orders
│   └── users.php           # View users
│
├── user/                   # Logged-in user area
│   ├── index.php           # User homepage
│   ├── cart.php            # Shopping cart
│   ├── checkout.php        # Checkout
│   └── payment.php         # Payment
│
├── php/                    # DB helper classes
└── img/                    # Images
```

---

## Notes

- Passwords are stored in plaintext — this is an academic project, not for production
- PayPal is configured in sandbox mode (`user/config.php`)
- Built as a learning exercise for a Master's degree course (LCSS)
