package cinerealm;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class ConfirmBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int screeningID = Integer.parseInt(request.getParameter("screeningID"));
        String[] seatIDs = request.getParameterValues("seatIDs");

        try (Connection conn = Databaseconnection.getConnection()) {
            conn.setAutoCommit(false);

            String insertBooking = "INSERT INTO Bookings (ScreeningID, UserID, SeatID) VALUES (?, ?, ?)";
            String updateSeat = "UPDATE Seats SET IsBooked = TRUE WHERE SeatID = ?";

            for (String seatID : seatIDs) {
                PreparedStatement pstmtBooking = conn.prepareStatement(insertBooking);
                pstmtBooking.setInt(1, screeningID);
                pstmtBooking.setInt(2, getUserID(request)); // Replace with session or other logic.
                pstmtBooking.setInt(3, Integer.parseInt(seatID));
                pstmtBooking.executeUpdate();

                PreparedStatement pstmtSeat = conn.prepareStatement(updateSeat);
                pstmtSeat.setInt(1, Integer.parseInt(seatID));
                pstmtSeat.executeUpdate();
            }
            conn.commit();
            response.sendRedirect("confirmation.jsp");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private int getUserID(HttpServletRequest request) {
        // Replace with session management logic.
        return (int) request.getSession().getAttribute("userID");
    }
}
