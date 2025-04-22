<%--To Add/Modify/Delete Product To the Database (For Admin Only)--%>
<%@ page import="java.sql.*, com.example.shopeasy.dao.DBConnection" %>
<html>
<head>
    <title>Admin Product Panel</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin-top: 30px; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background-color: #eee; }
        input, select, button { margin: 5px; }
    </style>
</head>
<body>

<h2>Add / Modify / Delete Product</h2>

<%
    // If Geting, fetch product data to prefill
    String GetId = request.getParameter("Get");
    String name = "", description = "", size = "", color = "";
    double price = 0;
    int stock = 0, productId = 0;

    if (GetId != null) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM products WHERE product_id = ?")) {

            stmt.setInt(1, Integer.parseInt(GetId));
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                productId = rs.getInt("product_id");
                name = rs.getString("name");
                description = rs.getString("description");
                price = rs.getDouble("price");
                stock = rs.getInt("stock");
                size = rs.getString("size");
                color = rs.getString("color");
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>

<form action="AdminProductServlet" method="post" enctype="multipart/form-data">
    <input type="hidden" name="product_id" value="<%= productId %>" />

    <input type="text" name="name" value="<%= name %>" placeholder="Clothing Name" required />
    <input type="text" name="description" value="<%= description %>" placeholder="Description" />
    <input type="number" step="0.01" name="price" value="<%= price %>" placeholder="Price" required />
    <input type="number" name="stock" value="<%= stock %>" placeholder="Stock" required />

    <select name="size">
        <option value="S" <%= size.equals("S") ? "selected" : "" %>>S</option>
        <option value="M" <%= size.equals("M") ? "selected" : "" %>>M</option>
        <option value="L" <%= size.equals("L") ? "selected" : "" %>>L</option>
    </select>

    <input type="text" name="color" value="<%= color %>" placeholder="Color (e.g. Red, Blue)" />
    <input type="file" name="product_image" />

    <br/>
    <button type="submit" name="action" value="add">Add Product</button>
    <button type="submit" name="action" value="modify">Modify Product</button>
    <button type="submit" name="action" value="delete" onclick="return confirm('Delete this product?');">Delete Product</button>
</form>



<hr/>

<h2>Product List</h2>
<table>
    <tr>
        <th>Image</th><th>ID</th><th>Name</th><th>Size</th><th>color</th><th>Price</th><th>Stock</th><th>Actions</th>
    </tr>

    <%
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM products")) {

            while (rs.next()) {
    %>
    <tr>
        <td>
            <img src="<%= rs.getString("image") %>" alt="Product Image" width="100" height="100"/>
        </td>
        <td><%= rs.getInt("product_id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("size") %></td>
        <td><%= rs.getString("color") %></td>
        <td>$<%= rs.getDouble("price") %></td>
        <td><%= rs.getInt("stock") %></td>
        <td>
            <form method="get">
                <input type="hidden" name="Get" value="<%= rs.getInt("product_id") %>" />
                <button type="submit">Get</button>
            </form>
        </td>
    </tr>
    <%
            }
        } catch (Exception e) {
            out.println("Error loading products: " + e.getMessage());
        }
    %>
</table>

</body>
</html>
