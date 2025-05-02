package com.example.shopeasy.dao;

import com.example.shopeasy.model.User;

import java.sql.*;

/**
 * This DAO (Data Access Object) class handles database operations
 * related to user management such as registration and login authentication.
 * It interacts with the 'users' table in the database.
 *
 * Used by servlets and other components that require user data access.
 *
 * @author Betty
 */

public class UserDao {

    /**
     * Registers a new user by inserting their information into the database.
     *
     * @param user the User object containing user details to be stored
     */

    public void registerUser(User user) {
        String sql = "INSERT INTO users (username, password, email, role) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getRole());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public User login(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                return user;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
