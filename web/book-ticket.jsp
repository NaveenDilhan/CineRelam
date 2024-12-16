<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Screening, java.util.List" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Filter Screenings</title>
    <link rel="stylesheet" href="css/book-ticket.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        function fetchScreenings() {
            var movieName = $("#movieName").val();
            var location = $("#location").val();
            var experience = $("#experience").val();

            $("#screeningsList").html("<li>Loading screenings...</li>");

            $.ajax({
                url: "FilterScreenServlet",
                type: "POST",
                data: { movieName: movieName, location: location, experience: experience },
                dataType: "json",
                success: function(data) {
                    var screeningsList = $("#screeningsList");
                    screeningsList.empty();

                    if (data.length > 0) {
                        data.forEach(function(screening) {
                            screeningsList.append(`
                                <li class='movie-item'>
                                    <div class='movie-header'>
                                        <h3>${screening.movieTitle}</h3>
                                        <img src='${screening.moviePoster}' class='movie-poster' alt='${screening.movieTitle}' onclick="window.location.href='movie-details.jsp?movieId=${screening.movieID}'">
                                    </div>
                                    <div class='screening-section'>
                                        <div class='screening-details'>
                                            <span class='location'>Location: ${screening.location}</span>
                                            <span class='experience'>Experience: ${screening.experience}</span>
                                        </div>
                                        <ul class='screening-times'>
                                            <li>
                                                <a href='seat-booking.jsp?screeningId=${screening.screeningID}' class='screening-button'>${screening.screeningTime}</a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                            `);
                        });
                    } else {
                        screeningsList.html("<li>No screenings available</li>");
                    }
                },
                error: function(xhr, status, error) {
                    console.error("AJAX Error: " + error);
                    $("#screeningsList").html("<li>Error loading screenings. Please try again later.</li>");
                }
            });
        }

        $(document).ready(function() {
            $("#movieName, #location, #experience").on("change", fetchScreenings);
        });
    </script>
</head>
<body>
    <div class="container">
         <div class="page-title">
            Book Your Ticket
        </div>
        <!-- Breadcrumb Section -->
        <div class="breadcrumb">
            <a href="home.jsp">Home</a> &gt;
            <span>Book Your Ticket</span>
        </div>

        <hr class="separator"> <!-- Divider -->
        <!-- Filter Section -->
        <div class="filter-section">
            <label for="movieName">Movie Name:</label>
            <select id="movieName">
                <option value="">-- Select Movie --</option>
                <% List<String> movieTitles = (List<String>) request.getAttribute("movieTitles");
                   if (movieTitles != null) {
                       for (String title : movieTitles) {
                           out.println("<option value='" + title + "'>" + title + "</option>");
                       }
                   } %>
            </select>

            <label for="location">Location:</label>
            <select id="location">
                <option value="">-- Select Location --</option>
                <% List<String> locations = (List<String>) request.getAttribute("locations");
                   if (locations != null) {
                       for (String loc : locations) {
                           out.println("<option value='" + loc + "'>" + loc + "</option>");
                       }
                   } %>
            </select>

            <label for="experience">Experience:</label>
            <select id="experience">
                <option value="">-- Select Experience --</option>
                <% List<String> experiences = (List<String>) request.getAttribute("experiences");
                   if (experiences != null) {
                       for (String exp : experiences) {
                           out.println("<option value='" + exp + "'>" + exp + "</option>");
                       }
                   } %>
            </select>
        </div>

        <!-- Available Screenings Section -->
        <h2>Available Screenings</h2>
        <ul id="screeningsList">
            <% List<Screening> screenings = (List<Screening>) request.getAttribute("screenings");
               if (screenings != null) {
                   for (Screening screening : screenings) { %>
                       <li class='movie-item'>
                           <div class='movie-header'>
                               <h3><%= screening.getMovieTitle() %></h3>
                               <img src="<%= screening.getMoviePoster() %>" class='movie-poster' alt="<%= screening.getMovieTitle() %>" onclick="window.location.href='movie-details.jsp?id=<%= screening.getMovieID() %>'">
                           </div>
                           <div class='screening-section'>
                               <div class='screening-details'>
                                   <span class='location'>Location: <%= screening.getLocationName() %></span>
                                   <span class='experience'>Experience: <%= screening.getExperience() %></span>
                               </div>
                               <ul class='screening-times'>
                                   <li>
                                       <a href='select-seat?screeningID=<%= screening.getScreeningID() %>' class='screening-button'><%= screening.getScreeningTime() %></a>
                                   </li>
                               </ul>
                           </div>
                       </li>
            <%     }
               } else { %>
                <li>No screenings available</li>
            <% } %>
        </ul>
    </div>
        <%@ include file="footer.jsp" %>
</body>
</html>