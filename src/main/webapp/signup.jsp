<!DOCTYPE html>
<html>
<head>
  <title>Sign Up | ShopEasy</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    .form-container {
      max-width: 400px;
      margin: 100px auto;
      background: #fff;
      padding: 40px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.1);
      border-radius: 12px;
      text-align: center;
    }
    input {
      width: 93%;
      padding: 12px;
      margin: 15px 0;
      border: 1px solid #ccc;
      border-radius: 8px;
      font-size: 1rem;
    }
    button {
      padding: 12px 20px;
      width: 100%;
      border: none;
      background: #111;
      color: #fff;
      border-radius: 8px;
      font-size: 1rem;
      cursor: pointer;
    }
    /*a {*/
    /*  display: block;*/
    /*  margin-top: 15px;*/
    /*  color: #333;*/
    /*}*/
    .error {
      color: red;
      font-size: 0.9rem;
    }
  </style>
</head>
<body>

<%@ include file="navbar.jsp" %>
<div class="form-container">
  <h2>Create Your Account</h2>

  <% if (request.getAttribute("error") != null) { %>
  <div class="error"><%= request.getAttribute("error") %></div>
  <% } %>

  <form action="RegisterServlet" method="post">
    <input type="text" name="username" placeholder="Username" required/>
    <input type="email" name="email" placeholder="Email" required/>
    <input type="password" name="password" placeholder="Password" required/>
    <button type="submit">Sign Up</button>
  </form>


  <a href="login.jsp">Already have an account? Login</a>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
