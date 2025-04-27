<%@ page import="java.sql.*, DAO.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ShopEasy - Home</title>

    <link rel="stylesheet" href="css/style.css">

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


<h1>Welcome to ShopEasy!</h1>

<div class="product-grid">
    <%
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM products")) {

            while (rs.next()) {
                String name = rs.getString("name");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                String image = rs.getString("image");
                int productId = rs.getInt("product_Id");
    %>
    <div class="product-card">
        <a href="ProductDetails.jsp?id=<%= productId %>">
        <img src="<%= image != null ? image : "uploads/default.png" %>" alt="Product Image">
        <h3><%= name %></h3>
        <p>$<%= price %></p>
        <p><%= description %></p>
    </div>
    <%
            }
        } catch (Exception e) {
            out.println("Error loading products: " + e.getMessage());
        }
    %>
</div>
<footer>
    <p>© 2025 ShopEasy. All rights reserved.</p>
    <p>
        <a href="#">Privacy Policy</a> |
        <a href="#">Terms of Use</a> |
        <a href="AdminPanel.jsp">Admin Panel</a>
    </p>
</footer>

</body>
</html>
