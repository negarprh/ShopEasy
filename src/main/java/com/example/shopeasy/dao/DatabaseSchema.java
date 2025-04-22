package com.example.shopeasy.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseSchema {
    public static void initializeSchema() {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();  // Your DB connection utility

            Statement stmt = conn.createStatement();

            // Create Users table
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
            // testing data
            stmt.execute("INSERT INTO users (user_id, username, password, email, role) " +
                    "SELECT 1, 'testuser', '123', 'test@example.com', 'user' " +
                    "WHERE NOT EXISTS (SELECT 1 FROM users WHERE user_id = 1)");
            System.out.println("Default test user inserted (if not exists).");

            // Modify Products table to include image column
            stmt.execute(
                    "CREATE TABLE IF NOT EXISTS products (" +
                            "  product_id INT AUTO_INCREMENT PRIMARY KEY, " +
                            "  name VARCHAR(100), " +
                            "  description VARCHAR(500), " +
                            "  price DECIMAL(10, 2), " +
                            "  stock INT, " +
                            "  size VARCHAR(5), " +
                            "  color VARCHAR(50), " +
                            "  image BLOB NULL" +   // Add image column here
                            ")"
            );
            System.out.println("Products table created or modified.");

            // Create Orders table
            stmt.execute(
                    "CREATE TABLE IF NOT EXISTS orders (" +
                            "  order_id INT AUTO_INCREMENT PRIMARY KEY, " +
                            "  user_id INT, " +
                            "  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                            "  total DECIMAL(10, 2), " +
                            "  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE" +
                            ")"
            );
            System.out.println("Orders table created.");

            // Create cart_items table
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

            System.out.println("Database schema setup complete!");

        } catch (SQLException e) {
            System.err.println("Error setting up database: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.closeQuietly(conn);  // Optional clean-up method
        }
    }

    public static void main(String[] args) {
        // Run this method to create or modify the database schema
        initializeSchema();
    }
}
