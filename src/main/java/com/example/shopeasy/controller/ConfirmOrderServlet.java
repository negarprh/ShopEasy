package com.example.shopeasy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.example.shopeasy.dao.DBConnection;

@WebServlet("/ConfirmOrderServlet")
public class ConfirmOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp?message=loginRequired");
            return;
        }

        // Get customer input from form
        String fullName = request.getParameter("fullname");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String paymentMethod = request.getParameter("paymentMethod");

        int userId = (int) session.getAttribute("user_id");

        try (Connection conn = DBConnection.getConnection()) {
            // Insert order into the database
            String sql = "INSERT INTO orders (user_id, full_name, address, phone, payment_method) VALUES (?, ?, ?, ?, ?)";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                stmt.setString(2, fullName);
                stmt.setString(3, address);
                stmt.setString(4, phone);
                stmt.setString(5, paymentMethod);

                stmt.executeUpdate();
            }

            // Clear the cart after successful order
            String clearCartSql = "DELETE FROM cart_items WHERE user_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(clearCartSql)) {
                stmt.setInt(1, userId);
                stmt.executeUpdate();
            }

            // Redirect to order success page
            response.sendRedirect("orderSuccess.jsp");

        } catch (SQLException e) {
            throw new ServletException("Error confirming order", e);
        }
    }
}
