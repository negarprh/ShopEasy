<%@ page import="java.util.*, com.example.shopeasy.model.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Shopping Cart</title>
  <style>
    table {
      width: 60%;
      border-collapse: collapse;
      margin: 20px auto;
    }
    th, td {
      border: 1px solid #aaa;
      padding: 10px;
      text-align: center;
    }
    h2 {
      text-align: center;
    }
    .total {
      font-weight: bold;
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
    <th>Product ID</th>
    <th>Quantity</th>
    <th>Action</th>
  </tr>
  <%
    for (CartItem item : cartItems) {
      total += item.getQuantity(); // Or use price if available
  %>
  <tr>
    <td><%= item.getProductId() %></td>
    <td><%= item.getQuantity() %></td>
    <td>
      <form action="cart" method="post">
        <input type="hidden" name="action" value="remove"/>
        <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>"/>
        <input type="submit" value="Remove"/>
      </form>
    </td>
  </tr>
  <% } %>
</table>
<p class="total" style="text-align:center;">Total Items: <%= total %></p>
<div style="text-align:center;"><a href="checkout.jsp">Proceed to Checkout</a></div>
<%
} else {
%>
<p style="text-align:center;">Your cart is empty.</p>
<% } %>

</body>
</html>
