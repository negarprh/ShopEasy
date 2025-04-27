package com.example.shopeasy.controller;

import com.example.shopeasy.dao.CartItemDAO;
import com.example.shopeasy.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    private CartItemDAO cartItemDAO;

    @Override
    public void init() {
        cartItemDAO = new CartItemDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp?message=loginRequired");
            return;
        }

        int userId = (int) session.getAttribute("user_id");
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                CartItem newItem = new CartItem(userId, productId, quantity);
                cartItemDAO.addOrUpdateCartItem(newItem);  // ✅ Always check existing first

            } else if ("remove".equals(action)) {
                int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
                cartItemDAO.removeCartItem(cartItemId);

            } else if ("update".equals(action)) {
                int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
                int newQuantity = Integer.parseInt(request.getParameter("quantity"));
                cartItemDAO.updateCartItemQuantity(cartItemId, newQuantity);
            }

            response.sendRedirect("CartServlet");

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp?message=loginRequired");
            return;
        }

        int userId = (int) session.getAttribute("user_id");

        try {
            List<CartItem> cartItems = cartItemDAO.getCartItemsByUserId(userId);
            request.setAttribute("cartItems", cartItems);
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
