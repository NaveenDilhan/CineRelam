<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MovieDAO, model.Movie" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CineRealm - Movie Details</title>
        <link rel="stylesheet" href="css/movie-details.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="main-content">
            <%
                try {
                    // Retrieve and validate the movie ID from the request
                    String movieId = request.getParameter("id");
                    if (movieId == null || movieId.trim().isEmpty()) {
                        throw new IllegalArgumentException("Movie ID is missing or invalid.");
                    }

                    // Parse the ID and fetch the movie details
                    int id = Integer.parseInt(movieId);
                    MovieDAO movieDAO = new MovieDAO();
                    Movie movie = movieDAO.getMovieById(id);

                    // Handle the case where no movie is found
                    if (movie == null) {
                        throw new Exception("Movie not found for the provided ID.");
                    }
            %>
            <div class="movie-details">
                <div class="movie-poster">
                    <img src="<%= movie.getPosterURL() %>" alt="<%= movie.getTitle() %> Poster">
                </div>
                <div class="movie-info">
                    <h1 class="movie-title"><%= movie.getTitle() %></h1>
                    <p class="movie-genre"><strong>Genre:</strong> <%= movie.getGenre() %></p>
                    <p class="movie-duration"><strong>Duration:</strong> <%= movie.getDurationMinutes() %> minutes</p>
                    <p class="movie-release-date"><strong>Release Date:</strong> <%= movie.getReleaseDate() %></p>
                    <p class="movie-description"><%= movie.getDescription() %></p>

                    <div class="movie-actions">
                        <a href="bookTicket.jsp?id=<%= movie.getId() %>" class="btn book-btn">Book Ticket</a>
                        <a href="movies.jsp" class="btn back-btn">Back to Movies</a>
                    </div>
                </div>
            </div>
            <%
                } catch (NumberFormatException e) {
            %>
            <p class="error">Invalid movie ID format. Please try again.</p>
            <%
                    e.printStackTrace();
                } catch (Exception e) {
            %>
            <p class="error">Error loading movie details: <%= e.getMessage() %></p>
            <%
                    e.printStackTrace();
                }
            %>
        </div>
        <%@ include file="footer.jsp" %>
    </body>
</html>
