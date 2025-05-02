<%@ page import="java.sql.*, com.example.shopeasy.dao.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ShopEasy - Home</title>

    <link rel="stylesheet" href="css/style.css">

</head>
<body>


    <%@ include file="navbar.jsp" %>

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
    %>
<%--    <div class="product-card">--%>
<%--        <img src="<%= image != null ? image : "uploads/default.png" %>" alt="Product Image">--%>
<%--        <h3><%= name %></h3>--%>
<%--        <p>$<%= price %></p>--%>
<%--        <p><%= description %></p>--%>
<%--    </div>--%>
    <div class="product-card">
        <img src="<%= image != null ? image : "uploads/default.png" %>" alt="Product Image">
        <h3><%= name %></h3>
        <p>$<%= price %></p>
        <p><%= description %></p>

        <form action="CartServlet" method="post">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="productId" value="<%= rs.getInt("product_id") %>">
            <input type="hidden" name="quantity" value="1">
            <button type="submit">Add to Cart</button>
        </form>
        <form action="ProductDetails" method="get">
            <input type="hidden" name="id" value="<%= rs.getInt("product_id") %>">
            <button type="submit">View Details</button>
        </form>


    </div>

    <%
            }
        } catch (Exception e) {
            out.println("Error loading products: " + e.getMessage());
        }
    %>
</div>

    <%@ include file="footer.jsp" %>

</body>
</html>
