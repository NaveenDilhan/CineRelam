<%@ include file="header.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Locations</title>
    <link rel="stylesheet" href="css/location.css">
</head>
<body>
    <div class="container">
        <div class="locations">
            <h2>Movie Locations</h2>
            <ul>
                <li class="location-item">
                    <h3>Downtown Cinema</h3>
                    <p>Address: 123 Main St</p>
                </li>
                <li class="location-item">
                    <h3>Uptown Theater</h3>
                    <p>Address: 456 Film Avenue</p>
                </li>
                <li class="location-item">
                    <h3>Central Mall Cineplex</h3>
                    <p>Address: 789 Screen Blvd</p>
                </li>
                <!-- More locations can be added here -->
            </ul>
        </div>
    </div>
    <%@ include file="footer.jsp" %>
</body>
</html>
