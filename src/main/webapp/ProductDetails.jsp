<%@ page import="java.sql.*, DAO.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<%
    String productId = request.getParameter("id");  // Get productId from the URL

    if (productId != null) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM products WHERE product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(productId)); // Set the product ID in the query
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                String image = rs.getString("image");
                String size = rs.getString("size");
                String color = rs.getString("color");
%>

<!-- Product Details Section -->
<div class="product-detail">
    <img src="<%= image != null ? image : "uploads/default.png" %>" alt="Product Image" width="400">
    <h1><%= name %></h1>
    <p><strong>Description:</strong> <%= description %></p>
    <p><strong>Price:</strong> $<%= price %></p>
    <p><strong>Size:</strong> <%= size %></p>
    <p><strong>Color:</strong> <%= color %></p>
</div>

<%
            } else {
                out.println("Product not found");
            }
        } catch (Exception e) {
            out.println("Error loading product details: " + e.getMessage());
        }
    } else {
        out.println("No product ID provided.");
    }
%>

</body>
</html>
