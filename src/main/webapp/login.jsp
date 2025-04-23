<!DOCTYPE html>
<html>
<head>
  <title>Login | ShopEasy</title>
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
      width: 100%;
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
    .error {
      color: red;
      font-size: 0.9rem;
    }
    a {
      display: block;
      margin-top: 15px;
      color: #333;
    }
  </style>
</head>
<body>

<div class="form-container">
  <h2>Login to ShopEasy</h2>
  <form action="LoginServlet" method="post">
    <input type="text" name="username" placeholder="Username" required/>
    <input type="password" name="password" placeholder="Password" required/>
    <button type="submit">Login</button>
  </form>
  <div class="error"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %></div>
  <a href="signup.jsp">Dont have an account? Sign up</a>
</div>

</body>
</html>
