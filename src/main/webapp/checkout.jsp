<%@ page import="java.util.*, com.example.shopeasy.model.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Checkout</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            margin: 30px 0 20px;
            font-size: 2rem;
            color: #222;
        }

        table {
            width: 90%;
            max-width: 900px;
            margin: 0 auto 30px;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.06);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 16px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #f1f1f1;
            font-weight: bold;
            color: #333;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .checkout-form {
            width: 90%;
            max-width: 600px;
            margin: 0 auto 50px;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
        }

        .checkout-form h3 {
            margin-top: 0;
            color: #444;
            text-align: left;
            margin-bottom: 15px;
            font-size: 1.2rem;
        }

        .checkout-form input[type="text"],
        .checkout-form input[type="tel"],
        .checkout-form select {
            width: 100%;
            padding: 12px;
            margin: 10px 0 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 1rem;
            box-sizing: border-box;
        }

        .checkout-form button {
            width: 100%;
            padding: 14px;
            background-color: #28a745;
            color: white;
            font-weight: bold;
            font-size: 1rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .checkout-form button:hover {
            background-color: #218838;
        }

        p.total {
            text-align: center;
            font-size: 1.2rem;
            color: #000;
            font-weight: 600;
            margin: 20px 0;
        }

    </style>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="navbar.jsp" %>
<h2>Checkout Page</h2>

<%
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    double total = 0;
    if (cartItems != null && !cartItems.isEmpty()) {
%>

<table>
    <tr>
        <th>Product Name</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Subtotal</th>
    </tr>
    <%
        for (CartItem item : cartItems) {
            double subtotal = item.getPrice() * item.getQuantity();
            total += subtotal;
    %>
    <tr>
        <td><%= item.getProductName() %></td>
        <td>$<%= String.format("%.2f", item.getPrice()) %></td>
        <td><%= item.getQuantity() %></td>
        <td>$<%= String.format("%.2f", subtotal) %></td>
    </tr>
    <% } %>
</table>

<p class="total">Total: $<%= String.format("%.2f", total) %></p>


<form class="checkout-form" action="ConfirmOrderServlet" method="post">
    <h3>Shipping Information</h3>
    <input type="text" name="fullname" placeholder="Full Name" required><br>
    <input type="text" name="address" placeholder="Shipping Address" required><br>
    <input type="tel" name="phone" placeholder="Phone Number" required><br>

    <h3>Payment Method</h3>
    <select name="paymentMethod" required>
        <option value="">Select a payment method</option>
        <option value="Credit Card">Credit Card</option>
        <option value="Cash on Delivery">Cash on Delivery</option>
        <option value="Paypal">Paypal</option>
    </select><br>

    <button type="submit">Confirm Order</button>
</form>

<%
} else {
%>
<p style="text-align:center;">Your cart is empty.</p>
<% } %>

</body>
</html>
