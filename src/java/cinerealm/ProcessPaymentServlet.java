package cinerealm;

import dao.PaymentDAO;
import model.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/ProcessPaymentServlet")
public class ProcessPaymentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve input data from the payment form
            String paymentMethod = request.getParameter("paymentMethod"); // card or paypal
            String totalPriceParam = request.getParameter("totalPrice");
            String bookingIdParam = request.getParameter("bookingId");  // Assuming bookingId is passed in the form

            // Check if required parameters are present
            if (paymentMethod == null || totalPriceParam == null || bookingIdParam == null) {
                request.setAttribute("message", "Missing payment details. Please try again.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            // Validate total price conversion safely
            double totalPrice;
            try {
                totalPrice = Double.parseDouble(totalPriceParam);
            } catch (NumberFormatException e) {
                request.setAttribute("message", "Invalid total price. Please try again.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            // If the payment method is "Card Payment"
            if ("card".equals(paymentMethod)) {
                String cardNumber = request.getParameter("card-number");
                String expiryDate = request.getParameter("expiry-date");
                String cvv = request.getParameter("cvv");

                // Validate card details
                if (validateCardDetails(cardNumber, expiryDate, cvv)) {
                    // Create a Payment object
                    Payment payment = new Payment();
                    payment.setBookingId(Integer.parseInt(bookingIdParam));  // Set booking ID from the request
                    payment.setPaymentMethod("Card Payment");  // Set payment method
                    payment.setPaymentStatus("Completed");  // Set payment status to 'Completed' for successful payment
                    payment.setPaymentDate(LocalDateTime.now().toString());  // Set current timestamp

                    // Save payment to the database
                    PaymentDAO paymentDAO = new PaymentDAO();
                    boolean isPaymentSaved = paymentDAO.savePayment(payment);

                    // Forward to success or error page based on payment status
                    if (isPaymentSaved) {
                        request.setAttribute("message", "Payment processed successfully! Total: $" + totalPrice);
                        request.getRequestDispatcher("success.jsp").forward(request, response);
                    } else {
                        request.setAttribute("message", "Payment failed! Please try again.");
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("message", "Invalid card details. Please try again.");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            }
            // If the payment method is "PayPal"
            else if ("paypal".equals(paymentMethod)) {
                String transactionId = request.getParameter("transactionId");

                // Validate PayPal transaction ID (you would typically verify it with PayPal API)
                if (transactionId != null && !transactionId.isEmpty()) {
                    // Create a Payment object
                    Payment payment = new Payment();
                    payment.setBookingId(Integer.parseInt(bookingIdParam));  // Set booking ID from the request
                    payment.setPaymentMethod("PayPal");  // Set payment method to PayPal
                    payment.setPaymentStatus("Completed");  // Set payment status to 'Completed' for successful payment
                    payment.setPaymentDate(LocalDateTime.now().toString());  // Set current timestamp
                    payment.setTransactionId(transactionId);  // Save the PayPal transaction ID

                    // Save payment to the database
                    PaymentDAO paymentDAO = new PaymentDAO();
                    boolean isPaymentSaved = paymentDAO.savePayment(payment);

                    // Forward to success or error page based on payment status
                    if (isPaymentSaved) {
                        request.setAttribute("message", "PayPal payment processed successfully! Total: $" + totalPrice);
                        request.getRequestDispatcher("success.jsp").forward(request, response);
                    } else {
                        request.setAttribute("message", "Payment failed! Please try again.");
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("message", "Invalid PayPal transaction ID. Please try again.");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("message", "Invalid payment method. Please try again.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    // Validate card details
    private boolean validateCardDetails(String cardNumber, String expiryDate, String cvv) {
        return cardNumber.matches("\\d{16}") && expiryDate.matches("\\d{4}-\\d{2}") && cvv.matches("\\d{3}");
    }

    // Mask card number for security
    private String maskCardNumber(String cardNumber) {
        return "**** **** **** " + cardNumber.substring(cardNumber.length() - 4);
    }
}
