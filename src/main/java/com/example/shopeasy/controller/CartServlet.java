package com.example.shopeasy.controller;

import com.example.shopeasy.dao.CartItemDAO;
import com.example.shopeasy.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private CartItemDAO cartItemDAO;

    @Override
    public void init() {
        cartItemDAO = new CartItemDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        int userId = 1; // TODO: Replace with session-based user ID when login is added

        if ("add".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            CartItem item = new CartItem(userId, productId, quantity);
            try {
                cartItemDAO.addCartItem(item);
            } catch (SQLException e) {
                throw new ServletException(e);
            }
        } else if ("remove".equals(action)) {
            int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
            try {
                cartItemDAO.removeCartItem(cartItemId);
            } catch (SQLException e) {
                throw new ServletException(e);
            }
        }

        response.sendRedirect("cart.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = 1; // TODO: Replace with session-based user ID when login is added

        try {
            List<CartItem> cartItems = cartItemDAO.getCartItemsByUserId(userId);
            request.setAttribute("cartItems", cartItems);
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
