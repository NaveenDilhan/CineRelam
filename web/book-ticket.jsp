<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Screening" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Movie" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Filter Screenings</title>
    <link rel="stylesheet" href="css/book-ticket.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        // Function to fetch screenings via AJAX
        function fetchScreenings() {
            var movieName = $("#movieName").val();
            var location = $("#location").val();
            var experience = $("#experience").val();

            // Disable the filter while waiting for the data
            $("#screeningsList").html("<li>Loading screenings...</li>");

            $.ajax({
                url: "FilterScreenServlet", // The servlet URL
                type: "POST",
                data: {
                    movieName: movieName,
                    location: location,
                    experience: experience
                },
                dataType: "json", // Expecting JSON response
                success: function(data) {
                    var screeningsList = $("#screeningsList");
                    screeningsList.empty(); // Clear the current list

                    if (data.length > 0) {
                        data.forEach(function(screening) {
                            var listItem = `
                                <li>
                                    <div class="screening-item">
                                        <h3>${screening.movieTitle}</h3>
                                        <p><strong>Location:</strong> ${screening.location} <strong>Experience:</strong> ${screening.experience}</p>
                                        <p><strong>Date:</strong> ${screening.screeningDate} <strong>Time:</strong> ${screening.screeningTime}</p>
                                        <p><a href="movie-details.jsp?movieId=${screening.movieID}">View Movie Details</a></p>
                                    </div>
                                </li>`;
                            screeningsList.append(listItem);
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

        // Attach event listeners to filter selects
        $(document).ready(function() {
            $("#movieName, #location, #experience").on("change", fetchScreenings);
        });
    </script>
</head>
<body>
    <h1>Filter Screenings</h1>

    <!-- Filter Form (no need for form submission) -->
    <div class="filter-section">
        <label for="movieName">Movie Name:</label>
        <select id="movieName">
            <option value="">-- Select Movie --</option>
            <%
                List<String> movieTitles = (List<String>) request.getAttribute("movieTitles");
                if (movieTitles != null && !movieTitles.isEmpty()) {
                    for (String title : movieTitles) {
                        out.println("<option value='" + title + "'>" + title + "</option>");
                    }
                } else {
                    out.println("<option>No movies available</option>");
                }
            %>
        </select>

        <label for="location">Location:</label>
        <select id="location">
            <option value="">-- Select Location --</option>
            <%
                List<String> locations = (List<String>) request.getAttribute("locations");
                if (locations != null && !locations.isEmpty()) {
                    for (String loc : locations) {
                        out.println("<option value='" + loc + "'>" + loc + "</option>");
                    }
                } else {
                    out.println("<option>No locations available</option>");
                }
            %>
        </select>

        <label for="experience">Experience:</label>
        <select id="experience">
            <option value="">-- Select Experience --</option>
            <%
                List<String> experiences = (List<String>) request.getAttribute("experiences");
                if (experiences != null && !experiences.isEmpty()) {
                    for (String exp : experiences) {
                        out.println("<option value='" + exp + "'>" + exp + "</option>");
                    }
                } else {
                    out.println("<option>No experiences available</option>");
                }
            %>
        </select>
    </div>

    <h2>Available Screenings</h2>
    <ul id="screeningsList">
        <!-- Screenings will be displayed here after AJAX call -->
    </ul>
</body>
</html>
