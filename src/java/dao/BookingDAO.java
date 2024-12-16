package dao;

import java.sql.*;

public class BookingDAO {
    private Connection connection;

    // Constructor that accepts a Connection object
    public BookingDAO(Connection connection) {
        this.connection = connection;
    }

    // Method to book seats
    public boolean bookSeats(int screeningId, String[] selectedSeats) throws SQLException {
        // SQL query to insert a booking entry for each seat
        String query = "INSERT INTO bookings (screening_id, seat_id) VALUES (?, ?)";
        
        // Using try-with-resources to automatically close resources
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            // Loop through the selected seats and add each booking to the batch
            for (String seatId : selectedSeats) {
                // Assuming selectedSeats contains the seat IDs (in String format)
                statement.setInt(1, screeningId);  // Set screening ID
                statement.setInt(2, Integer.parseInt(seatId));  // Set seat ID after parsing it to Integer
                statement.addBatch();  // Add to batch
            }
            // Execute the batch of insert statements
            int[] result = statement.executeBatch();
            
            // Check if all insertions were successful (result.length should match selectedSeats length)
            return result.length == selectedSeats.length;
        } catch (SQLException e) {
            // Print exception if an error occurs
            e.printStackTrace();
            throw e;  // Rethrow the exception to handle it at a higher level
        }
    }
}
