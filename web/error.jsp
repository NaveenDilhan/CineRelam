<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Error - CineRealm</title>
        <link rel="stylesheet" href="css/error.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f8f9fa;
                color: #333;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .error-container {
                text-align: center;
                max-width: 600px;
                background-color: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }
            .error-container h1 {
                font-size: 36px;
                color: #e74c3c;
                margin-bottom: 20px;
            }
            .error-container p {
                font-size: 18px;
                color: #555;
                margin-bottom: 20px;
            }
            .error-container a {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                font-size: 16px;
                color: #fff;
                background-color: #3498db;
                text-decoration: none;
                border-radius: 4px;
                transition: background-color 0.3s;
            }
            .error-container a:hover {
                background-color: #2980b9;
            }
        </style>
    </head>
    <body>
        <div class="error-container">
            <h1>Oops! Something went wrong</h1>
            <p><%= request.getAttribute("error") %></p>
            <a href="movies.jsp">Back to Movies</a>
        </div>
    </body>
</html>
