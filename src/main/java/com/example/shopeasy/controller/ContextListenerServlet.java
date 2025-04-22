package com.example.shopeasy.controller;

import com.example.shopeasy.dao.DatabaseSchema;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class ContextListenerServlet implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // When the web application starts, initialize the database schema
        System.out.println("Initializing database for E-Commerce App...");

        // Initialize the schema (tables like users, products, orders, etc.)
        DatabaseSchema.initializeSchema();

        System.out.println("Database initialization complete!");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Clean up database resources if needed
        System.out.println("E-Commerce App shutting down...");
    }
}
