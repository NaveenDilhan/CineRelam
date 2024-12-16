<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Screening, model.Seats, dao.ScreeningDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Your Seat</title>
    <link rel="stylesheet" href="css/book-seat.css">
    <script src="js/seats-numbers.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="booking_body">
    <div class="book">
                <!-- Page Title Section -->
        <div class="page-title">
            Book Your Seat
        </div>
        <!-- Breadcrumb Section -->
        <div class="breadcrumb">
            <a href="home.jsp">Home</a> &gt;
            <a href="screenings.jsp">Screenings</a> &gt;
            <span>Book Your Seat</span>
        </div>

        <hr class="separator"> <!-- Divider -->

        <%
            String screeningIdParam = request.getParameter("screeningID");
            int screeningId = 0;
            try {
                screeningId = Integer.parseInt(screeningIdParam);
            } catch (NumberFormatException e) {
                out.println("<p>Invalid screening ID format.</p>");
            }

            if (screeningId > 0) {
                Connection conn = (Connection) getServletContext().getAttribute("Databaseconnection");
                ScreeningDAO screeningDAO = new ScreeningDAO();
                Screening screening = screeningDAO.getScreeningById(screeningId);
                List<Seats> seats = screeningDAO.getSeatsForScreening(screeningId);

                if (screening != null) {
        %>
        <!-- Film Information Section -->
        <div class="film-info">
            <h1 class="film-name"><%= screening.getMovieTitle() %></h1>
            <p class="film-location">Location: <%= screening.getLocationName() %></p>
            <p class="film-experience">Experience: <%= screening.getExperience() %></p>
        </div>

        <!-- Screen Section -->
        <div class="screen">Screen</div>

        <!-- Seat Grid -->
        <div class="seat-grid" id="seatGrid">
            <%
                if (seats != null && !seats.isEmpty()) {
                    String currentRow = "";
                    int leftSectionCount = 0;
                    int rightSectionCount = 0;

                    for (Seats seat : seats) {
                        // Check for row change and render a new row
                        if (!seat.getRowNumber().equals(currentRow)) {
                            if (!currentRow.isEmpty()) {
            %>
                                </div> <!-- End of Row -->
            <%
                            }
                            currentRow = seat.getRowNumber();
            %>
                            <div class="row"> <!-- Start of New Row -->
            <%
                        }

                        // If the seat is on the left section (6 seats in the left section)
                        if (leftSectionCount < 6) {
                            String seatClass = seat.isBooked() ? "seat booked" : "seat available";
            %>
                            <div class="<%= seatClass %>" 
                                 data-seat-id="<%= seat.getSeatID() %>" 
                                 onclick="toggleSeatSelection(event)" 
                                 aria-label="Seat Row <%= seat.getRowNumber() %>, Seat <%= seat.getSeatNumber() %>, <%= seat.isBooked() ? "Booked" : "Available" %>">
                                 <%= seat.getRowNumber() %><%= seat.getSeatNumber() %>
                            </div>
            <%
                            leftSectionCount++;
                        } else {
                            // If we've reached the 6th seat, add the aisle (without text) after the left section
                            if (leftSectionCount == 6 && rightSectionCount == 0) {
            %>
                                <div class="aisle"></div> <!-- Empty aisle for visual separation -->
            <%
                            }

                            // Right section (add right section seats)
                            String seatClass = seat.isBooked() ? "seat booked" : "seat available";
            %>
                            <div class="<%= seatClass %>" 
                                 data-seat-id="<%= seat.getSeatID() %>" 
                                 onclick="toggleSeatSelection(event)" 
                                 aria-label="Seat Row <%= seat.getRowNumber() %>, Seat <%= seat.getSeatNumber() %>, <%= seat.isBooked() ? "Booked" : "Available" %>">
                                 <%= seat.getRowNumber() %><%= seat.getSeatNumber() %>
                            </div>
            <%
                            rightSectionCount++;
                        }
                    }

                    if (!currentRow.isEmpty()) {
            %>
                        </div> <!-- End of Last Row -->
            <%
                    }
                } else {
                    out.println("<p>No seats available for this screening.</p>");
                }
            %>
        </div>

        <!-- Seat Status Legend -->
        <div class="details">
            <div class="details_chair">
                <div class="status-item"><span class="available"></span> Available</div>
                <div class="status-item"><span class="booked"></span> Booked</div>
                <div class="status-item"><span class="selected"></span> Selected</div>
            </div>
        </div>

        <!-- Booking Button -->
        <button id="bookSeatsBtn" disabled onclick="bookSeats()">Book Seats</button>

        <!-- Loading Indicator -->
        <div id="loadingIndicator">Loading...</div>

        <%
                } else {
                    out.println("<p>No screening found for the given ID.</p>");
                }
            } else {
                out.println("<p>Invalid screening ID.</p>");
            }
        %>
    </div>

    <script>
function toggleSeatSelection(event) {
    const seat = event.target;
    const bookSeatsBtn = document.getElementById('bookSeatsBtn');
    
    // Toggle the selected class on the clicked seat if it's available
    if (seat.classList.contains('available')) {
        seat.classList.toggle('selected');
    } else if (seat.classList.contains('booked')) {
        alert('This seat is already booked.');
    }

    // Enable or disable the button based on selected seats count
    const selectedSeats = document.querySelectorAll('.seat.selected');
    bookSeatsBtn.disabled = selectedSeats.length === 0;  // Enable button if at least one seat is selected
}

function bookSeats() {
    const selectedSeats = [];
    document.querySelectorAll('.seat.selected').forEach(seat => {
        selectedSeats.push(seat.getAttribute('data-seat-id'));
    });

    if (selectedSeats.length > 0) {
        document.getElementById('bookSeatsBtn').disabled = true;
        document.getElementById('loadingIndicator').style.display = 'block';
        $.ajax({
            url: 'BookSeatsServlet',
            type: 'POST',
            data: {
                screeningId: <%= screeningId %>,
                selectedSeats: selectedSeats.join(',')
            },
            success: function (response) {
                document.getElementById('loadingIndicator').style.display = 'none';
                alert('Seats booked successfully!');
                window.location.href = 'confirmation.jsp';
            },
            error: function () {
                document.getElementById('loadingIndicator').style.display = 'none';
                alert('An error occurred. Please try again.');
                document.getElementById('bookSeatsBtn').disabled = false;
            }
        });
    } else {
        alert('Please select seats to book.');
    }
}
    </script>
    <%@ include file="footer.jsp" %>
</body>
</html>
