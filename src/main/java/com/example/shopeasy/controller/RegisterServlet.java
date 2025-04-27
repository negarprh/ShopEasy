package com.example.shopeasy.controller;

import com.example.shopeasy.dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

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
