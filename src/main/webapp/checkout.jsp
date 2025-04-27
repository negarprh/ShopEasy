<%@ page import="java.util.*, com.example.shopeasy.model.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Checkout</title>
    <style>
        table {
            width: 60%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #aaa;
            padding: 10px;
            text-align: center;
        }
        h2 {
            text-align: center;
        }
    </style>
</head>
<body>
<h2>Checkout Page</h2>

<%
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    double total = 0;
    if (cartItems != null && !cartItems.isEmpty()) {
%>

<table>
    <tr>
        <th>Product ID</th>
        <th>Quantity</th>
    </tr>
    <%
        for (CartItem item : cartItems) {
            total += item.getQuantity(); // (Later we can calculate price if you want!)
    %>
    <tr>
        <td><%= item.getProductId() %></td>
        <td><%= item.getQuantity() %></td>
    </tr>
    <% } %>
</table>

<p style="text-align:center;"><strong>Total Items:</strong> <%= total %></p>

<form action="checkout" method="post" style="text-align:center;">
    <input type="submit" value="Confirm Order">
</form>

<%
} else {
%>
<p style="text-align:center;">Your cart is empty.</p>
<% } %>

</body>
</html>
