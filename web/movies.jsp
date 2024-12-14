<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MovieDAO, model.Movie, java.util.List" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CineRealm -Movies</title>
        <link rel="stylesheet" href="css/movies.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="main-content">
            <div class="header-section">
                <h2 class="page-title">Now Showing</h2>

                <!-- Breadcrumb Section -->
                <nav class="breadcrumb">
                    <a href="index.jsp">Home</a> &gt;
                    <span>Movies</span>
                </nav>
            </div>

            <!-- Separator Line -->
            <hr class="separator">

            <!-- Movie container -->
            <div class="movie-container">
                <%
                    try {
                        // Initialize DAO and fetch movies
                        MovieDAO movieDAO = new MovieDAO();
                        List<Movie> movies = movieDAO.getAllMovies();

                        // Loop through the movies and render them
                        for (Movie movie : movies) {
                %>
                <!-- Movie card structure -->
                <div class="movie-card" style="background-image: url('<%= movie.getPosterURL() %>')">
                    <div class="movie-overlay">
                        <div class="movie-header">
                            <h3><%= movie.getTitle() %></h3>
                            <span class="movie-genre"><%= movie.getGenre() %></span>
                        </div>
                        <div class="movie-actions">
                            <a href="movie-details.jsp?id=<%= movie.getId() %>" class="btn info-btn">More Info</a>
                            <a href="FilterScreenServlet?id=<%= movie.getId() %>" class="btn book-btn">Book Ticket</a>
                        </div>
                    </div>
                </div>
                <%
                        }
                    } catch (Exception e) {
                        // Display error message if fetching movies fails
                %>
                <p class="error">Error fetching movies: <%= e.getMessage() %></p>
                <%
                        e.printStackTrace(); // Log stack trace for debugging
                    }
                %>
            </div>
        </div>

        <%@ include file="footer.jsp" %>
    </body>
</html>
