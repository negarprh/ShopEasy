package com.example.shopeasy.controller;

import com.example.shopeasy.dao.DatabaseSchema;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;


/**
 * This servlet context listener is triggered when the web application starts or stops.
 * It initializes the database schema during application startup by calling
 * {@link com.example.shopeasy.dao.DatabaseSchema#initializeSchema()}.
 *
 * Registered as a {@code @WebListener}, it ensures required tables are created
 * and ready for use before handling any requests.
 *
 * Typical use case: Prepares the environment for the ShopEasy e-commerce app.
 *
 * This listener also logs a message when the application shuts down.
 *
 * @author Betty
 */

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
