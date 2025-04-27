package com.example.shopeasy.controller;

import com.example.shopeasy.dao.CartItemDAO;
import com.example.shopeasy.model.CartItem;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private CartItemDAO cartItemDAO;

    @Override
    public void init() {
        cartItemDAO = new CartItemDAO();
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
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

}
