<%@ page import="java.util.*, com.example.shopeasy.model.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Shopping Cart</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f8f8f8;
      margin: 0;
      padding: 0;
    }

    h2 {
      text-align: center;
      color: #333;
      margin-top: 30px;
    }

    table {
      width: 90%;
      max-width: 900px;
      margin: 30px auto;
      border-collapse: collapse;
      background-color: white;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
      border-radius: 10px;
      overflow: hidden;
    }

    th, td {
      padding: 15px;
      text-align: center;
      border-bottom: 1px solid #ddd;
    }

    th {
      background-color: #f2f2f2;
      color: #333;
      font-weight: 600;
    }

    td form {
      display: inline;
    }

    input[type="number"] {
      width: 60px;
      padding: 6px;
      border: 1px solid #ccc;
      border-radius: 5px;
      text-align: center;
    }

    button {
      padding: 6px 12px;
      background-color: #000;
      color: #fff;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background 0.3s ease;
    }

    button:hover {
      background-color: #333;
    }

    .total {
      text-align: center;
      font-size: 18px;
      margin-top: 20px;
      color: #111;
    }

    .checkout-link {
      text-align: center;
      margin: 20px 0;
    }

    .checkout-link a {
      background-color: #0077cc;
      color: white;
      padding: 10px 20px;
      text-decoration: none;
      border-radius: 6px;
      font-weight: bold;
    }

    .checkout-link a:hover {
      background-color: #005fa3;
    }

    .empty-message {
      text-align: center;
      margin-top: 40px;
      font-size: 18px;
      color: #888;
    }

  </style>
</head>
<body>

<h2>Your Shopping Cart</h2>

<%
  List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
  double total = 0;
  if (cartItems != null && !cartItems.isEmpty()) {
%>
<table>
  <tr>
    <th>Product</th>
    <th>Price</th>
    <th>Quantity</th>
    <th>Subtotal</th>
    <th>Actions</th>
  </tr>
  <%
    for (CartItem item : cartItems) {
      double subtotal = item.getPrice() * item.getQuantity();
      total += subtotal;
  %>
  <tr>
    <td><%= item.getProductName() %></td>
    <td>$<%= String.format("%.2f", item.getPrice()) %></td>
    <td>
      <form action="CartServlet" method="post">
        <input type="hidden" name="action" value="update"/>
        <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>"/>
        <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1"/>
        <button type="submit">Update</button>
      </form>
    </td>
    <td>$<%= String.format("%.2f", subtotal) %></td>
    <td>
      <form action="CartServlet" method="post">
        <input type="hidden" name="action" value="remove"/>
        <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>"/>
        <button type="submit">Remove</button>
      </form>
    </td>
  </tr>
  <% } %>
</table>

<p class="total">Total: $<%= String.format("%.2f", total) %></p>
<div class="checkout-link">
  <a href="checkout">🧾 Proceed to Checkout</a>
</div>

<% } else { %>
<p class="empty-message">Your cart is empty.</p>
<% } %>

</body>
</html>
