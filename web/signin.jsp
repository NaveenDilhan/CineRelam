<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign In</title>
    <link rel="stylesheet" href="css/signin.css">
    <script>
        // Optional: JavaScript to handle any form validation or behavior
    </script>
</head>
<body>
    <div class="form-container">
        <h2>Sign In</h2>
        
        <% String error = request.getParameter("error"); 
           if ("empty_fields".equals(error)) { %>
            <p class="error-message">Please fill in both username and password.</p>
        <% } else if ("invalid_credentials".equals(error)) { %>
            <p class="error-message">Invalid username or password. Please try again.</p>
        <% } else if ("database_error".equals(error)) { %>
            <p class="error-message">There was an error with the database. Please try again later.</p>
        <% } %>

        <form action="SigninServlet" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required placeholder="Enter your username"><br>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required placeholder="Enter your password"><br>

            <button type="submit">Sign In</button>
        </form>

        <div class="form-links">
            <p class="redirect-link">Don't have an account? <a href="signup.jsp">Sign Up</a></p>
            <p class="redirect-link"><a href="homepage">Back to Homepage</a></p>
        </div>
    </div>
        
</body>
<%--<%@ include file="footer.jsp" %>--%>
</html>
