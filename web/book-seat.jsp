<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Screening, model.Seats, dao.ScreeningDAO" %>
<%@ page import="java.util.List" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Your Seat</title>
    <link rel="stylesheet" href="css/book-seat.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="js/seats-numbers.js"></script>
</head>
<body class="booking_body">
    <div class="book">
        <!-- Page Title Section -->
        <div class="page-title">Book Your Seat</div>
        
        <!-- Breadcrumb Section -->
        <div class="breadcrumb">
            <a href="home.jsp">Home</a> &gt;
            <a href="screenings.jsp">Screenings</a> &gt;
            <span>Book Your Seat</span>
        </div>

        <hr class="separator">

        <%
            String screeningIdParam = request.getParameter("screeningID");
            int screeningId = 0;
            try {
                screeningId = Integer.parseInt(screeningIdParam);
            } catch (NumberFormatException e) {
                out.println("<p>Invalid screening ID format.</p>");
            }

            if (screeningId > 0) {
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

                    for (Seats seat : seats) {
                        // Start a new row if row changes
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

                        // Render a single seat
            %>
                        <div class="<%= seat.isBooked() ? "seat booked" : "seat available" %>" 
                             data-seat-id="<%= seat.getSeatID() %>" 
                             data-price="<%= seat.getPrice() %>" 
                             onclick="toggleSeatSelection(event)">
                            <%= seat.getRowNumber() %><%= seat.getSeatNumber() %>
                        </div>
            <%
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

        <!-- Total Price Section -->
        <div id="totalPriceSection" class="total-price-section">
            Total Price: $<span id="totalPrice">0.00</span>
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
        <div id="loadingIndicator" style="display:none;">Loading...</div>

        <%
                } else {
                    out.println("<p>No screening found for the given ID.</p>");
                }
            } else {
                out.println("<p>Invalid screening ID.</p>");
            }
        %>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
