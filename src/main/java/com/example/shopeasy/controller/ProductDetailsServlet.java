package com.example.shopeasy.controller;

import com.example.shopeasy.dao.ProductDAO;
import com.example.shopeasy.model.Product;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/product-details")
public class ProductDetailsServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        if (idStr == null || idStr.isEmpty()) {
            response.getWriter().println("Product ID is missing.");
            return;
        }

        int productId = Integer.parseInt(idStr);

        try {
            Product product = productDAO.getProductById(productId);
            if (product != null) {
                request.setAttribute("product", product);
                request.getRequestDispatcher("ProductDetails.jsp").forward(request, response);
            } else {
                response.getWriter().println("Product not found.");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
