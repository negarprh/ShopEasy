<%@ page import="com.example.shopeasy.model.Product" %>
<%
    Product product = (Product) request.getAttribute("product");
%>
<html>
<head>
    <title><%= product.getName() %></title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
        }

        .product-detail-container {
            max-width: 700px;
            margin: 50px auto;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 12px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
        }

        .product-detail-container h1 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 20px;
        }

        .product-detail-container p {
            font-size: 1.1rem;
            margin: 10px 0;
            color: #555;
        }

        .label {
            font-weight: bold;
            color: #222;
        }
        .product-image {
            max-width: 300px;
            height: auto;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        form {
            margin-top: 25px;
        }

        input[type="number"] {
            width: 60px;
            padding: 6px;
            font-size: 1rem;
            margin-right: 10px;
        }

        button {
            padding: 8px 18px;
            font-size: 1rem;
            background-color: #000;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #444;
        }
    </style>
</head>
<body>

<div class="product-detail-container">
    <h1><%= product.getName() %></h1>
    <!-- Product Image -->
    <img class="product-image" src="<%= product.getImage() != null ? product.getImage() : "uploads/default.png" %>" alt="Product Image">

    <p><span class="label">Description:</span> <%= product.getDescription() %></p>
    <p><span class="label">Price:</span> $<%= product.getPrice() %></p>
    <p><span class="label">Size:</span> <%= product.getSize() %></p>
    <p><span class="label">Color:</span> <%= product.getColor() %></p>

    <form action="cart" method="post">
        <input type="hidden" name="action" value="add">
        <input type="hidden" name="productId" value="<%= product.getProductId() %>">

        <label for="quantity" class="label">Quantity:</label>
        <input type="number" name="quantity" id="quantity" value="1" min="1" required>

        <button type="submit"> Add to Cart</button>
    </form>
</div>

</body>
</html>
