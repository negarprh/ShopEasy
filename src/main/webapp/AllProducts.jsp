<%@ page import="java.util.*, com.example.shopeasy.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Shop - All Products</title>
  <style>
    .product-card {
      border: 1px solid #ccc;
      padding: 12px;
      margin: 12px;
      width: 220px;
      float: left;
      text-align: center;
    }
    .product-image {
      height: 150px;
      width: 150px;
      object-fit: cover;
    }
  </style>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<h2>All Products</h2>
<%
  List<Product> products = (List<Product>) request.getAttribute("products");
  for (Product p : products) {
%>
<div class="product-card">
  <img src="<%= p.getImage() %>" alt="Product Image" class="product-image"><br>
  <strong><%= p.getName() %></strong><br>
  $<%= p.getPrice() %><br>
  <a href="product-details?id=<%= p.getProductId() %>">View Details</a>
</div>
<% } %>

<%@ include file="footer.jsp" %>
</body>
</html>
