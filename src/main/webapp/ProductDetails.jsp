<%@ page import="Model.Product" %>
<%
    Product product = (Product) request.getAttribute("product");
%>
<html>
<head><title><%= product.getName() %></title></head>
<body>
<h1><%= product.getName() %></h1>
<p><strong>Description:</strong> <%= product.getDescription() %></p>
<p><strong>Price:</strong> $<%= product.getPrice() %></p>
<p><strong>Size:</strong> <%= product.getSize() %></p>
<p><strong>color:</strong> <%= product.getcolor() %></p>
</body>
</html>