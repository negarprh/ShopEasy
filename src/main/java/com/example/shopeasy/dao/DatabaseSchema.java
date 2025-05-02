package com.example.shopeasy.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * This utility class is responsible for initializing and setting up the
 * database schema for the ShopEasy application. It creates necessary tables
 * such as `users`, `products`, `orders`, and `cart_items`, and inserts default data.
 *
 * It is typically executed once during application setup or testing to ensure
 * the database is correctly structured.
 *
 * Usage: Run the `main` method to initialize the schema.
 *
 * Note: This class connects to an H2 database via the {@link DBConnection} utility.
 *
 * Tables created:
 * - users
 * - products
 * - orders
 * - cart_items
 *
 * Default admin and test users are also inserted if they do not already exist.
 *
 * @author Betty
 */

public class DatabaseSchema {
    public static void initializeSchema() {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();  // Your DB connection utility

            Statement stmt = conn.createStatement();

            // Drop old orders table first
            stmt.execute("DROP TABLE IF EXISTS orders");
            System.out.println("Old orders table dropped.");

            // --- USERS table ---
            stmt.execute(
                    "CREATE TABLE IF NOT EXISTS users (" +
                            "  user_id INT AUTO_INCREMENT PRIMARY KEY, " +
                            "  username VARCHAR(50) NOT NULL, " +
                            "  password VARCHAR(100) NOT NULL, " +
                            "  email VARCHAR(100) NOT NULL UNIQUE, " +
                            "  role VARCHAR(10) DEFAULT 'user'" +
                            ")"
            );
            System.out.println("Users table created.");

            // Insert default users
            stmt.executeUpdate(
                    "INSERT INTO users (username, password, email, role) " +
                            "SELECT 'admin', 'admin123', 'admin@shopeasy.com', 'admin' " +
                            "WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'admin')"
            );
            stmt.executeUpdate(
                    "INSERT INTO users (username, password, email, role) " +
                            "SELECT 'usertest', 'user123', 'usertest@shopeasy.com', 'user' " +
                            "WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'usertest')"
            );
            System.out.println("Default users created.");

            // --- PRODUCTS table ---
            stmt.execute(
                    "CREATE TABLE IF NOT EXISTS products (" +
                            "  product_id INT AUTO_INCREMENT PRIMARY KEY, " +
                            "  name VARCHAR(100), " +
                            "  description VARCHAR(500), " +
                            "  price DECIMAL(10, 2), " +
                            "  stock INT, " +
                            "  size VARCHAR(5), " +
                            "  color VARCHAR(50), " +
                            "  image BLOB NULL" +
                            ")"
            );
            System.out.println("Products table created.");

            // --- ORDERS table (NEW) ---
            stmt.execute(
                    "CREATE TABLE IF NOT EXISTS orders (" +
                            "  order_id INT AUTO_INCREMENT PRIMARY KEY, " +
                            "  user_id INT, " +
                            "  full_name VARCHAR(100) NOT NULL, " +
                            "  address VARCHAR(255) NOT NULL, " +
                            "  phone VARCHAR(20) NOT NULL, " +
                            "  payment_method VARCHAR(50) NOT NULL, " +
                            "  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                            "  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE" +
                            ")"
            );
            System.out.println("Orders table created.");

            // --- CART ITEMS table ---
            stmt.execute(
                    "CREATE TABLE IF NOT EXISTS cart_items (" +
                            "  cart_item_id INT AUTO_INCREMENT PRIMARY KEY, " +
                            "  user_id INT, " +
                            "  product_id INT, " +
                            "  quantity INT, " +
                            "  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE, " +
                            "  FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE" +
                            ")"
            );
            System.out.println("Cart items table created.");

            System.out.println("✅ Database schema setup complete!");

        } catch (SQLException e) {
            System.err.println("Error setting up database: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.closeQuietly(conn);  // Optional clean-up method
        }
    }

    public static void main(String[] args) {
        initializeSchema();
    }
}
