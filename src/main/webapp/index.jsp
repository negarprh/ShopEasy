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
            max-width: 1000px;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.05);
            display: flex;
            gap: 40px;
            align-items: flex-start;
        }

        .product-image {
            max-width: 350px;
            width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .product-info {
            flex: 1;
        }

        .product-info h1 {
            font-size: 2rem;
            color: #222;
            margin-bottom: 20px;
        }

        .product-info p {
            font-size: 1.1rem;
            margin: 10px 0;
            color: #555;
        }

        .label {
            font-weight: bold;
            color: #111;
        }

        form {
            margin-top: 25px;
        }

        input[type="number"] {
            width: 70px;
            padding: 6px;
            font-size: 1rem;
            margin-right: 12px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        button {
            padding: 10px 20px;
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

        @media (max-width: 768px) {
            .product-detail-container {
                flex-direction: column;
                align-items: center;
            }

            .product-image {
                max-width: 100%;
            }

            .product-info {
                width: 100%;
            }
        }


    </style>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="product-detail-container">
    <img class="product-image" src="<%= product.getImage() != null ? product.getImage() : "uploads/default.png" %>" alt="Product Image">

    <div class="product-info">
        <h1><%= product.getName() %></h1>

        <p><span class="label">Description:</span> <%= product.getDescription() %></p>
        <p><span class="label">Price:</span> $<%= product.getPrice() %></p>
        <p><span class="label">Size:</span> <%= product.getSize() %></p>
        <p><span class="label">Color:</span> <%= product.getColor() %></p>

        <form action="CartServlet" method="post">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="productId" value="<%= product.getProductId() %>">

            <label for="quantity" class="label">Quantity:</label>
            <input type="number" name="quantity" id="quantity" value="1" min="1" required>

            <button type="submit">Add to Cart</button>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
