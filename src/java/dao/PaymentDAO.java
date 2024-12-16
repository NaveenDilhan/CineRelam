package dao;

import cinerealm.Databaseconnection;
import model.Payment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

public class PaymentDAO {
    public boolean savePayment(Payment payment) {
        boolean isSuccess = false;
        String sql = "INSERT INTO payments (booking_id, payment_method, payment_status, payment_date, transaction_id) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = Databaseconnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            
            preparedStatement.setInt(1, payment.getBookingId());
            preparedStatement.setString(2, payment.getPaymentMethod());
            preparedStatement.setString(3, payment.getPaymentStatus());
            preparedStatement.setTimestamp(4, Timestamp.valueOf(payment.getPaymentDate()));

            // Include transaction ID for PayPal payments
            if (payment.getTransactionId() != null && !payment.getTransactionId().isEmpty()) {
                preparedStatement.setString(5, payment.getTransactionId());
            } else {
                preparedStatement.setNull(5, java.sql.Types.VARCHAR);  // If there's no transaction ID (e.g., for card payments)
            }

            isSuccess = preparedStatement.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSuccess;
    }
}
