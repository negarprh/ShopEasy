<%@ page import="java.sql.*, DAO.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <link rel="stylesheet" href="css/productdetails.css">

</head>
<body>

<nav>
    <a href="index.jsp">Home</a>

    <%
        String user = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
    %>

    <div style="margin-left:auto;">
        <% if (user == null) { %>
        <a href="login.jsp">Login</a>
        <a href="signup.jsp">Sign Up</a>
        <% } else { %>
        <% if ("admin".equals(role)) { %>
        <a href="AdminPanel.jsp">Admin Panel</a>
        <% } %>
        <span style="margin-right: 15px;">Hi, <%= user %></span>
        <a href="LogoutServlet">Logout</a>
        <% } %>
    </div>
</nav>



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
<!-- Product Details Section -->
<div class="product-detail">
    <img src="<%= image != null ? image : "uploads/default.png" %>" alt="Product Image">

    <div class="product-info">
        <h1><%= name %></h1>
        <p><strong>Description:</strong> <%= description %></p>
        <p><strong>Price:</strong> $<%= price %></p>
        <p><strong>Size:</strong> <%= size %></p>
        <p><strong>Color:</strong> <%= color %></p>

        <div class="add-to-cart">
            <form action="CartServlet" method="post">
                <input type="hidden" name="productId" value="<%= productId %>">
                <button type="submit">Add to Cart</button>
            </form>
        </div>
    </div>
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

<footer>
    <p>2025 ShopEasy. All rights reserved.</p>
    <p>
        <a href="#">Privacy Policy</a> |
        <a href="#">Terms of Use</a> |
        <a href="AdminPanel.jsp">Admin Panel</a>
    </p>
</footer>
</body>
</html>
