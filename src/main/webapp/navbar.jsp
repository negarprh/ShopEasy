<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String user = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
%>
<nav>
    <a href="index.jsp">Home</a>

    <div style="margin-left:auto;">
        <% if (user == null) { %>
        <a href="login.jsp">Login</a>
        <a href="signup.jsp">Sign Up</a>
        <% } else { %>
        <% if ("admin".equals(role)) { %>
        <a href="AdminPanel.jsp">Admin Panel</a>
        <% } %>
        <a href="CartServlet">View Cart</a>
        <span style="margin-right: 15px;">Hi, <%= user %></span>
        <a href="LogoutServlet">Logout</a>
        <% } %>
    </div>
</nav>
