<%@ page import="com.example.shopeasy.model.Product" %>
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
<p><strong>color:</strong> <%= product.getColor() %></p>
<form action="cart" method="post">
    <input type="hidden" name="action" value="add">
    <input type="hidden" name="productId" value="<%= product.getProductId() %>">

    <label for="quantity">Quantity:</label>
    <input type="number" name="quantity" id="quantity" value="1" min="1" required>

    <button type="submit">🛒 Add to Cart</button>
</form>

</body>
</html>