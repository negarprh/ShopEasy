package com.example.shopeasy;

import DAO.ProductDao;
import Model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/product-details")
public class ProductDetailsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productIdStr = request.getParameter("id"); // Get product ID from the URL

        if (productIdStr == null || productIdStr.isEmpty()) {
            response.sendRedirect("error.jsp");
            return;
        }

        try {
            // Convert the productId to an integer
            int productId = Integer.parseInt(productIdStr);

            // Fetch the product from the database
            Product product = ProductDao.getProductById(productId);

            // Check if the product exists
            if (product != null) {
                // Set the product as a request attribute to display on the JSP page
                request.setAttribute("product", product);
                request.getRequestDispatcher("/ProductDetails.jsp").forward(request, response); // Forward to product details page
            } else {
                response.sendRedirect("not-found.jsp");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp"); // Handle invalid productId format
        }
    }
}
