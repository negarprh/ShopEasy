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
    .cart-container {
      display: flex;
      flex-direction: column;
      align-items: center;
    }


    table {
      width: 90%;
      max-width: 900px;
      margin: 30px auto;

      background-color: white;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
      overflow: hidden;
      border-collapse: separate;
      border-spacing: 0;
      border-radius: 12px;

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

    .btn {
      padding: 6px 12px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      font-weight: 600;
    }

    .btn-update {
      background-color: #333;
      color: white;
    }

    .btn-update:hover {
      background-color: #555;
    }

    .btn-remove {
      background-color: #e60023;
      color: white;
    }

    .btn-remove:hover {
      background-color: #b3001b;
    }


    .total {
      text-align: center;
      font-size: 22px;
      margin-top: 30px;
      font-weight: 600;
      color: #222;
      letter-spacing: 0.5px;
    }

    .checkout-link {
      text-align: center;
      margin: 25px 0;
    }

    .checkout-link a {
      background-color: #007bff;
      color: white;
      padding: 12px 24px;
      text-decoration: none;
      border-radius: 8px;
      font-weight: 600;
      box-shadow: 0 4px 10px rgba(0, 123, 255, 0.2);
      transition: background 0.3s, transform 0.2s;
      display: inline-block;
    }

    .checkout-link a:hover {
      background-color: #0056b3;
      transform: translateY(-2px);
    }

    /* Updated empty message */
    .empty-message {
      text-align: center;
      margin-top: 80px;
      font-size: 20px;
      font-weight: 500;
      color: #777;
      opacity: 0.9;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    .empty-message::before {
      content: "🛒";
      font-size: 50px;
      margin-bottom: 15px;
      opacity: 0.6;
    }


  </style>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<h2>Your Shopping Cart</h2>

<%
  List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
  double total = 0;
  if (cartItems != null && !cartItems.isEmpty()) {
%>

<div class="cart-container">
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
        <button class="btn btn-update" type="submit">Update</button>
      </form>
    </td>
    <td>$<%= String.format("%.2f", subtotal) %></td>
    <td>
      <form action="CartServlet" method="post">
        <input type="hidden" name="action" value="remove"/>
        <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>"/>
        <button class="btn btn-remove" type="submit">Remove</button>
      </form>
    </td>
  </tr>
  <% } %>
</table>

<p class="total">Total: $<%= String.format("%.2f", total) %></p>
<div class="checkout-link">
  <a href="checkout">🧾 Proceed to Checkout</a>
</div>
</div>

<% } else { %>
<p class="empty-message">Your cart is empty.</p>
<% } %>



<%--<%@ include file="footer.jsp" %>--%>
</body>
</html>
