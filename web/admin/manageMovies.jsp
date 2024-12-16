<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Movies - ABC Cinema</title>
    <link rel="stylesheet" href="../css/admin-styles.css">
    <style>
        .movies-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .movies-table th, .movies-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        .movies-table th {
            background-color: #222;
            color: white;
            cursor: pointer;
        }

        .action-buttons a {
            text-decoration: none;
            margin: 0 5px;
            padding: 5px 10px;
            border-radius: 4px;
            color: white;
        }

        .action-buttons .edit {
            background-color: #28a745;
        }

        .action-buttons .delete {
            background-color: #dc3545;
        }

        .add-movie-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin: 20px 0;
            transition: background-color 0.3s ease;
        }

        .add-movie-btn:hover {
            background-color: #0056b3;
        }

        .stats-section {
            margin: 20px 0;
            display: flex;
            justify-content: space-around;
        }

        .stats-card {
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 200px;
        }

        .sidebar {
            width: 250px;
            height: 100vh;
            background-color: #222;
            color: white;
            position: fixed;
            top: 0;
            left: -250px;
            transition: left 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px 0;
            z-index: 1000;
        }

        .sidebar.active {
            left: 0;
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

        .sidebar-toggle {
            position: fixed;
            top: 20px;
            left: 20px;
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            z-index: 1001;
        }

        .sidebar-toggle:hover {
            background-color: #0056b3;
        }

        .search-bar {
            margin: 20px 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .search-bar input {
            padding: 10px;
            width: 80%;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .search-bar button {
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .search-bar button:hover {
            background-color: #0056b3;
        }

        header {
            text-align: center;
            padding: 20px;
            background: linear-gradient(90deg, #007BFF, #0056b3);
            color: white;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        header h1 {
            font-size: 2.5em;
            margin: 0;
        }

        header p {
            font-size: 1.2em;
            margin: 10px 0 0;
            font-style: italic;
        }
    </style>
    <script>
        function toggleSidebar() {
            document.querySelector('.sidebar').classList.toggle('active');
        }

        function sortTable(columnIndex) {
            const table = document.querySelector('.movies-table tbody');
            const rows = Array.from(table.rows);
            const isAscending = table.getAttribute('data-sort-order') !== 'asc';
            rows.sort((a, b) => {
                const aText = a.cells[columnIndex].textContent.trim();
                const bText = b.cells[columnIndex].textContent.trim();
                return isAscending ? aText.localeCompare(bText) : bText.localeCompare(aText);
            });
            rows.forEach(row => table.appendChild(row));
            table.setAttribute('data-sort-order', isAscending ? 'asc' : 'desc');
        }

        function searchMovies() {
            const query = document.querySelector('#searchInput').value.toLowerCase();
            const rows = document.querySelectorAll('.movies-table tbody tr');
            rows.forEach(row => {
                const title = row.cells[1].textContent.toLowerCase();
                row.style.display = title.includes(query) ? '' : 'none';
            });
        }
    </script>
</head>
<body>
    <button class="sidebar-toggle" onclick="toggleSidebar()">Menu</button>
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
            <h1>Manage Movies</h1>
            <p>ABC Cinema</p>
        </header>

        <div class="stats-section">
            <div class="stats-card">
                <h3>Total Movies</h3>
                
            </div>
            <div class="stats-card">
                <h3>Genres</h3>
                
            </div>
            <div class="stats-card">
                <h3>Avg Duration</h3>
                
            </div>
        </div>

        <div class="search-bar">
            <input type="text" id="searchInput" placeholder="Search movies by title..." oninput="searchMovies()">
            <button onclick="searchMovies()">Search</button>
        </div>

        <a href="addMovie.jsp" class="add-movie-btn">Add New Movie</a>

        <table class="movies-table" data-sort-order="asc">
            <thead>
                <tr>
                    <th onclick="sortTable(0)">Movie ID</th>
                    <th onclick="sortTable(1)">Title</th>
                    <th onclick="sortTable(2)">Genre</th>
                    <th onclick="sortTable(3)">Duration (min)</th>
                    <th onclick="sortTable(4)">Release Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                
                    java.sql.Connection conn = (java.sql.Connection) application.getAttribute("DBConnection");
                    if (conn != null) {
                        java.sql.Statement stmt = conn.createStatement();
                        java.sql.ResultSet rs = stmt.executeQuery("SELECT * FROM Movies");
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("movie_id") %></td>
                    <td><%= rs.getString("title") %></td>
                    <td><%= rs.getString("genre") %></td>
                    <td><%= rs.getInt("duration") %></td>
                    <td><%= rs.getDate("release_date") %></td>
                    <td class="action-buttons">
                        <a href="editMovie.jsp?id=<%= rs.getInt("movie_id") %>" class="edit">Edit</a>
                        <a href="deleteMovie.jsp?id=<%= rs.getInt("movie_id") %>" class="delete" onclick="return confirm('Are you sure you want to delete this movie?');">Delete</a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="6">No movies found or database connection issue.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
