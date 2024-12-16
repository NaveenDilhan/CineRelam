<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - ABC Cinema</title>
    <link rel="stylesheet" href="../css/admin-styles.css">
    
    <style>
        
        /* General Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Sidebar Styling */
.sidebar {
    width: 250px;
    height: 100vh;
    background-color: #222;
    color: white;
    position: fixed;
    top: 0;
    left: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 20px 0;
}

.sidebar h2 {
    margin-bottom: 30px;
    font-size: 24px;
}

.sidebar ul {
    list-style: none;
    width: 100%;
    padding: 0;
}

.sidebar ul li {
    width: 100%;
    margin: 10px 0;
}

.sidebar ul li a {
    text-decoration: none;
    color: white;
    padding: 10px 20px;
    display: block;
    width: 100%;
    border-radius: 4px;
    transition: background-color 0.3s ease;
}

.sidebar ul li a:hover {
    background-color: #444;
}

/* Main Content Styling */
.main-content {
    margin-left: 250px;
    padding: 20px;
    background-color: #f9f9f9;
    height: 100vh;
    overflow-y: auto;
}

header {
    margin-bottom: 20px;
}

header h1 {
    font-size: 28px;
    color: #333;
}

header p {
    color: #666;
}

/* Dashboard Cards */
.dashboard-cards {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
}

.card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
    text-align: center;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card h3 {
    color: #555;
    margin-bottom: 10px;
}

.card p {
    font-size: 24px;
    color: #007BFF;
}

.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
}

        
        
        
    </style>
    
    
    
</head>
<body>
    <div class="sidebar">
        <h2>ABC Cinema</h2>
        <ul>
            <li><a href="manageMovies.jsp">Manage Movies</a></li>
            <li><a href="manageReservations.jsp">Reservations</a></li>
            <li><a href="feedback.jsp">Feedback</a></li>
            <li><a href="reports.jsp">Reports</a></li>
            <li><a href="../logout.jsp">Logout</a></li>
        </ul>
    </div>
    <div class="main-content">
        <header>
            <h1>Welcome, Admin!</h1>
            <p>Here's a quick overview of the website's performance.</p>
        </header>
        <div class="dashboard-cards">
            <div class="card">
                <h3>Total Movies</h3>
                <p><%= request.getAttribute("totalMovies") != null ? request.getAttribute("totalMovies") : "Loading..." %></p>
            </div>
            <div class="card">
                <h3>Total Reservations</h3>
                <p><%= request.getAttribute("totalReservations") != null ? request.getAttribute("totalReservations") : "Loading..." %></p>
            </div>
            <div class="card">
                <h3>Customer Feedback</h3>
                <p><%= request.getAttribute("feedbackCount") != null ? request.getAttribute("feedbackCount") : "Loading..." %></p>
            </div>
            <div class="card">
                <h3>Total Revenue</h3>
                <p>Rs<%= request.getAttribute("totalRevenue") != null ? request.getAttribute("totalRevenue") : "Loading..." %></p>
            </div>
        </div>
    </div>
</body>
</html>
