<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <link rel="stylesheet" href="css/signup.css">
    <script>
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirm_password").value;
            if (password !== confirmPassword) {
                alert("Passwords do not match.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="form-container">
        <h2>Sign Up</h2>
        <form action="SignupServlet" method="post" onsubmit="return validateForm()">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required placeholder="Enter your username"><br>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required placeholder="Enter your email"><br>

            <label for="phone_number">Phone Number:</label>
            <input type="text" id="phone_number" name="phone_number" required placeholder="Enter your phone number"><br>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required placeholder="Enter your password"><br>

            <label for="confirm_password">Confirm Password:</label>
            <input type="password" id="confirm_password" required placeholder="Confirm your password"><br>

            <button type="submit">Sign Up</button>
        </form>
        
        <p class="redirect-link">Already have an account? <a href="signin.jsp">Sign In</a></p>
    </div>
</body>
<%--<%@ include file="footer.jsp" %>--%>
</html>
