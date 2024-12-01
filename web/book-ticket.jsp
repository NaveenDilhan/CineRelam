<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Screening" %> <!-- Adjust package as per your project -->

<!DOCTYPE html>
<html>
    <head>
        <title>Select Screening</title>
        <link rel="stylesheet" type="text/css" href="css/book-ticket.css">
    </head>
    <body>
        <!-- Navigation Bar -->
        <header class="navbar">
            <div class="navbar-item dropdown">
                <button class="dropdown-btn">All Locations</button>
                <div class="dropdown-content">
                    <%
                        List<String> locations = (List<String>) request.getAttribute("locations");
                        if (locations != null && !locations.isEmpty()) {
                            for (String location : locations) {
                    %>
                        <a href="#"><%= location %></a>
                    <%
                            }
                        } else {
                    %>
                        <a href="#">No locations available</a>
                    <%
                        }
                    %>
                </div>
            </div>

            <div class="navbar-item dropdown">
                <button class="dropdown-btn">Today</button>
                <div class="dropdown-content">
                    <input type="date" id="date" name="date" class="date-picker">
                </div>
            </div>

            <div class="navbar-item dropdown">
                <button class="dropdown-btn">All Movies</button>
                <div class="dropdown-content">
                    <%
                        List<String> movies = (List<String>) request.getAttribute("movies");
                        if (movies != null && !movies.isEmpty()) {
                            for (String movie : movies) {
                    %>
                        <a href="#"><%= movie %></a>
                    <%
                            }
                        } else {
                    %>
                        <a href="#">No movies available</a>
                    <%
                        }
                    %>
                </div>
            </div>

            <div class="navbar-item dropdown">
                <button class="dropdown-btn">All Experiences</button>
                <div class="dropdown-content">
                    <%
                        List<String> experiences = (List<String>) request.getAttribute("experiences");
                        if (experiences != null && !experiences.isEmpty()) {
                            for (String experience : experiences) {
                    %>
                        <a href="#"><%= experience %></a>
                    <%
                            }
                        } else {
                    %>
                        <a href="#">No experiences available</a>
                    <%
                        }
                    %>
                </div>
            </div>

            <button class="offers-btn navbar-item">All Offers</button>
        </header>

        <!-- Movie Listings -->
        <main class="movie-listing">
            <section class="movie-header">
                <h1 class="movie-title">Now Showing</h1>
            </section>

            <div class="movie-content">
                <%
                    // Fetch the list of screenings passed from the servlet
                    List<Screening> screenings = (List<Screening>) request.getAttribute("screenings");
                    if (screenings != null && !screenings.isEmpty()) {
                        for (Screening screening : screenings) {
                %>
                <div class="movie-details">
                    <div class="theater">
                        <p class="theater-name"><%= screening.getTheaterName() %></p>
                        <button class="time-btn"><%= screening.getScreeningTime() %></button> <!-- Time of screening -->
                    </div>
                </div>
                <div class="movie-poster">
                    <img src="<%= screening.getPosterUrl() %>" alt="<%= screening.getMovieName() %> Poster" />
                </div>
                <%
                        }
                    } else {
                %>
                <p>No screenings available at the moment.</p>
                <%
                    }
                %>
            </div>
        </main>

        <!-- Footer -->
        <footer>
            <p>© 2024 Cinema Realm. All Rights Reserved.</p>
        </footer>
    </body>
</html>
