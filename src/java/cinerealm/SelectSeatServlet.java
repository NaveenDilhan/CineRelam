package cinerealm;

import dao.BookingDAO;
import dao.ScreeningDAO;
import model.Seats;
import model.Screening;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SelectSeatServlet extends HttpServlet {
    
    private Connection connection;

    @Override
    public void init() throws ServletException {
        try {
            // Initialize your DB connection
            connection = Databaseconnection.getConnection();
        } catch (SQLException ex) {
            Logger.getLogger(SelectSeatServlet.class.getName()).log(Level.SEVERE, null, ex);
            throw new ServletException("Unable to initialize DB connection.", ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int screeningId = Integer.parseInt(request.getParameter("screeningID"));
        
        // Create the ScreeningDAO with the DB connection
        ScreeningDAO screeningDAO = new ScreeningDAO(); // Pass connection here
        // Fetch the screening by its ID
        Screening screening = screeningDAO.getScreeningById(screeningId);
        List<Seats> seats = screeningDAO.getSeatsForScreening(screeningId); // Assuming this method exists
        if (screening != null && seats != null) {
            // Set the screening and seat data to request attributes
            request.setAttribute("screening", screening);
            request.setAttribute("seats", seats);
            // Forward to book-seat.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("book-seat.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "No data available for the selected screening.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int screeningId = Integer.parseInt(request.getParameter("screeningId"));
        String[] selectedSeats = request.getParameterValues("selectedSeats");

        if (selectedSeats == null || selectedSeats.length == 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No seats selected.");
            return;
        }

        // Create the BookingDAO with the DB connection
        BookingDAO bookingDAO = new BookingDAO(connection); // Pass connection here
        try {
            // Book the selected seats for the screening
            boolean success = bookingDAO.bookSeats(screeningId, selectedSeats);
            if (success) {
                response.getWriter().write("Success");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error booking seats.");
            }
        } catch (SQLException e) {
            Logger.getLogger(SelectSeatServlet.class.getName()).log(Level.SEVERE, null, e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error while processing booking.");
        }
    }

    @Override
    public void destroy() {
        // Ensure to close the connection after the servlet is destroyed
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            Logger.getLogger(SelectSeatServlet.class.getName()).log(Level.SEVERE, "Error closing DB connection.", e);
        }
    }
}
