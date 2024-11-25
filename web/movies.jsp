<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%@ page import="movieschedule.Databaseconnection" %> 
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Movie Schedule</title>
        <link rel="stylesheet" href="css/movies.css"> <!-- Link to the updated CSS file -->
        <!-- Google Fonts for modern typography -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="main-content">
            <h2 class="page-title">Movie Schedule</h2>

            <!-- Movie container with professional design -->
            <div class="movie-container">
                <%
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        conn = Databaseconnection.getConnection(); // Ensure your Databaseconnection is set up correctly
                        String sql = "SELECT id, title, description, genre, release_date FROM movies";
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();

                        // Date formatter
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String title = rs.getString("title");
                            String description = rs.getString("description");
                            String genre = rs.getString("genre");
                            Date releaseDate = rs.getDate("release_date");
                            String formattedDate = (releaseDate != null) ? sdf.format(releaseDate) : "";
                %>
                <!-- Movie card structure -->
                <div class="movie-card">
                    <div class="movie-header">
                        <h3><%= title%></h3>
                        <span class="movie-genre"><%= genre%></span>
                    </div>
                    <p class="movie-description"><%= description%></p>
                    <p class="release-date">Release Date: <%= formattedDate%></p>
                </div>
                <%
                        }
                    } catch (SQLException e) {
                        out.println("<p class='error'>Error fetching data: " + e.getMessage() + "</p>");
                        e.printStackTrace(); // To see detailed error
                    } catch (Exception e) {
                        out.println("<p class='error'>General error: " + e.getMessage() + "</p>");
                        e.printStackTrace(); // To see detailed error
                    } finally {
                        try {
                            if (rs != null) {
                                rs.close();
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        try {
                            if (stmt != null) {
                                stmt.close();
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        try {
                            if (conn != null) {
                                conn.close();
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </div>
        </div>

        <!-- Footer included from footer.jsp -->
        <%@ include file="footer.jsp" %>
    </body>
</html>
