package com.example.shopeasy;

import DAO.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.nio.file.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/AdminProductServlet")
@MultipartConfig  // Enable file upload functionality
public class AdminProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action"); // add, modify, or delete
        String idStr = request.getParameter("product_id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String size = request.getParameter("size");
        String color = request.getParameter("color");

        // Basic validation
        if (name == null || name.isEmpty() || priceStr == null || priceStr.isEmpty() || stockStr == null || stockStr.isEmpty()) {
            response.getWriter().println("Error: Name, Price, and Stock are required fields.");
            return;
        }

        // Handle file upload
        String imagePath = null;
        if ("add".equals(action) || "modify".equals(action)) {
            Part filePart = request.getPart("product_image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString();
                String uploadDir = getServletContext().getRealPath("/uploads");
                Path filePath = Paths.get(uploadDir, fileName);

                Files.createDirectories(filePath.getParent());
                filePart.write(filePath.toString());

                imagePath = "uploads/" + fileName; // path to save in DB
            }
        }

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement stmt;

            switch (action) {
                case "add":
                    stmt = conn.prepareStatement("INSERT INTO products (name, description, price, stock, size, color, image) VALUES (?, ?, ?, ?, ?, ?, ?)");
                    stmt.setString(1, name);
                    stmt.setString(2, description);
                    stmt.setDouble(3, Double.parseDouble(priceStr));
                    stmt.setInt(4, Integer.parseInt(stockStr));
                    stmt.setString(5, size);
                    stmt.setString(6, color);
                    stmt.setString(7, imagePath);
                    stmt.executeUpdate();
                    break;

                case "modify":
                    if (idStr == null || idStr.isEmpty()) {
                        response.getWriter().println("Error: Product ID is required for modification.");
                        return;
                    }
                    stmt = conn.prepareStatement("UPDATE products SET name=?, description=?, price=?, stock=?, size=?, color=?, image=? WHERE product_id=?");
                    stmt.setString(1, name);
                    stmt.setString(2, description);
                    stmt.setDouble(3, Double.parseDouble(priceStr));
                    stmt.setInt(4, Integer.parseInt(stockStr));
                    stmt.setString(5, size);
                    stmt.setString(6, color);
                    stmt.setString(7, imagePath);
                    stmt.setInt(8, Integer.parseInt(idStr));
                    stmt.executeUpdate();
                    break;

                case "delete":
                    if (idStr == null || idStr.isEmpty()) {
                        response.getWriter().println("Error: Product ID is required for deletion.");
                        return;
                    }
                    stmt = conn.prepareStatement("DELETE FROM products WHERE product_id=?");
                    stmt.setInt(1, Integer.parseInt(idStr));
                    stmt.executeUpdate();
                    break;

                default:
                    response.getWriter().println("Error: Unknown action.");
                    return;
            }

            // ✅ Redirect to admin panel after successful operation
            response.sendRedirect("AdminPanel.jsp");

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
