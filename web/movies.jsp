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
        <link rel="stylesheet" href="css/movies.css"> 
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="main-content">
            <h2 class="page-title">Now Showing</h2>

            <!-- Movie container with professional design -->
            <div class="movie-container">
                <%
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        conn = Databaseconnection.getConnection(); // Ensure Databaseconnection is set up correctly
                        String sql = "SELECT MovieID, Title, Description, Genre, ReleaseDate, PosterURL FROM Movies";
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();

                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                        while (rs.next()) {
                            int id = rs.getInt("MovieID");
                            String title = rs.getString("Title");
                            String description = rs.getString("Description");
                            String genre = rs.getString("Genre");
                            Date releaseDate = rs.getDate("ReleaseDate");
                            String posterURL = rs.getString("PosterURL");
                            String formattedDate = (releaseDate != null) ? sdf.format(releaseDate) : "";
                %>
                <!-- Movie card structure -->
                <div class="movie-card" style="background-image: url('<%= posterURL %>')">
                    <div class="movie-overlay">
                        <div class="movie-header">
                            <h3><%= title %></h3>
                            <span class="movie-genre"><%= genre %></span>
                        </div>
                        <div class="movie-actions">
                            <a href="movieDetails.jsp?id=<%= id %>" class="btn info-btn">More Info</a>
                            <a href="bookTicket.jsp?id=<%= id %>" class="btn book-btn">Book Ticket</a>
                        </div>
                    </div>
                </div>
                <%
                        }
                    } catch (SQLException e) {
                        out.println("<p class='error'>Error fetching data: " + e.getMessage() + "</p>");
                        e.printStackTrace(); // Log error
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </div>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>
