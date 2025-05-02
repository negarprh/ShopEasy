package com.example.shopeasy.controller;

import com.example.shopeasy.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

/**
 * Handles user registration by validating input and inserting new user data into the database.
 * Checks for duplicate usernames or emails.
 * Automatically logs in the user after successful registration.
 *
 * @author Negar
 */


@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Simple regex check for email format
        if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            request.setAttribute("error", "Invalid email format.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        if (username == null || username.isBlank() || password.length() < 6) {
            request.setAttribute("error", "Please fill out all fields correctly.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }


        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement checkStmt = conn.prepareStatement(
                    "SELECT * FROM users WHERE username = ? OR email = ?"
            );
            checkStmt.setString(1, username);
            checkStmt.setString(2, email);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                request.setAttribute("error", "Username or email already exists.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }

            PreparedStatement insert = conn.prepareStatement(
                    "INSERT INTO users (username, password, email, role) VALUES (?, ?, ?, 'user')"
            );
            insert.setString(1, username);
            insert.setString(2, password);
            insert.setString(3, email);
            insert.executeUpdate();

            // Auto-login after signup
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", "user");

            response.sendRedirect("index.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}
