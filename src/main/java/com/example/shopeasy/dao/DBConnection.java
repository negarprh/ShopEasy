package com.example.shopeasy.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


/**
 * Utility class for managing database connections to the H2 database.
 * Provides methods to establish and close connections.
 * Used throughout the application to interact with the database.
 *
 * Database: H2
 * URL: jdbc:h2:~/clothingdb
 *
 * This class loads the H2 JDBC driver and manages connection lifecycle.
 *
 * @author Betty
 */


public class DBConnection {
    private static final String JDBC_URL = "jdbc:h2:~/clothingdb";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.h2.Driver"); // Force-load the driver
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
    }



    public static void closeQuietly(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                // Optionally log the error, but quietly ignore it
            }
        }
    }
}