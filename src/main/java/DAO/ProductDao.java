package DAO;

import Model.Product;

import java.io.InputStream;
import java.sql.*;

public class ProductDao {
    private static final String JDBC_URL = "jdbc:h2:~/clothingdb"; // Adjust if needed
    private static final String JDBC_USER = "sa";
    private static final String JDBC_PASS = "";

    static {
        try {
            Class.forName("org.h2.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Method to fetch product by ID
    public static Product getProductById(int productId) {
        String sql = "SELECT * FROM Products WHERE product_Id = ?";
        Product product = null;

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId);  // Set the productId parameter
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                product = new Product();
                product.setProductId(rs.getInt("product_Id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setSize(rs.getString("size"));
                product.setcolor(rs.getString("color"));
                // Retrieve the image file path or filename (not the BLOB)
                product.setImage(rs.getString("image"));  // Assuming 'image' is a file path or filename
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return product;
    }
}
