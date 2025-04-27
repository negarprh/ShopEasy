package com.example.shopeasy.dao;

import com.example.shopeasy.model.CartItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartItemDAO {

    // ✅ Add or Update Item
    public void addOrUpdateCartItem(CartItem item) throws SQLException {
        CartItem existingItem = getCartItemByUserIdAndProductId(item.getUserId(), item.getProductId());

        if (existingItem != null) {
            int newQuantity = existingItem.getQuantity() + item.getQuantity();
            updateCartItemQuantity(existingItem.getCartItemId(), newQuantity);
        } else {
            String sql = "INSERT INTO cart_items (user_id, product_id, quantity) VALUES (?, ?, ?)";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, item.getUserId());
                stmt.setInt(2, item.getProductId());
                stmt.setInt(3, item.getQuantity());
                stmt.executeUpdate();
            }
        }
    }

    public CartItem getCartItemByUserIdAndProductId(int userId, int productId) throws SQLException {
        String sql = "SELECT * FROM cart_items WHERE user_id = ? AND product_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                CartItem item = new CartItem();
                item.setCartItemId(rs.getInt("cart_item_id"));
                item.setUserId(rs.getInt("user_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                return item;
            }
        }
        return null;
    }

    public void removeCartItem(int cartItemId) throws SQLException {
        String sql = "DELETE FROM cart_items WHERE cart_item_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartItemId);
            stmt.executeUpdate();
        }
    }

    public void updateCartItemQuantity(int cartItemId, int newQuantity) throws SQLException {
        String sql = "UPDATE cart_items SET quantity = ? WHERE cart_item_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, newQuantity);
            stmt.setInt(2, cartItemId);
            stmt.executeUpdate();
        }
    }

    public List<CartItem> getCartItemsByUserId(int userId) throws SQLException {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT c.cart_item_id, c.user_id, c.product_id, c.quantity, p.name AS product_name, p.price AS product_price " +
                "FROM cart_items c JOIN products p ON c.product_id = p.product_id WHERE c.user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setCartItemId(rs.getInt("cart_item_id"));
                item.setUserId(rs.getInt("user_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setProductName(rs.getString("product_name"));
                item.setPrice(rs.getDouble("product_price"));
                cartItems.add(item);
            }
        }
        return cartItems;
    }

    public void clearCartByUserId(int userId) throws SQLException {
        String sql = "DELETE FROM cart_items WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        }
    }
}
