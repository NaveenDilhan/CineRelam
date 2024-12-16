<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Page</title>
    <link rel="stylesheet" href="css/payment.css">
    <script src="https://www.paypal.com/sdk/js?client-id=AZ-Fh_Zk-6q6dC8-RRsummxuZIohQOYlH4AA_LVnYn70fqT0QuxdvwYZR5toKIAItXxgyIjkGlceHdLs&currency=USD"></script>
    <script defer src="js/payment.js"></script>
</head>
<body>
    <div class="container">
        <h1>Trusted Payment with Cinerealme</h1>
        <p>Your total is: <span id="price">$0.00</span></p>

        <!-- Hidden input to store the total price value dynamically -->
        <input type="hidden" id="totalPriceHidden" name="totalPrice" value="0.00">

        <div class="payment-options">
            <h2>How would you like to pay?</h2>
            <div class="payment-buttons">
                <button type="button" id="card-option" class="payment-btn">
                    <span class="payment-icon">💳</span>
                    Credit/Debit Card
                </button>
                <button type="button" id="paypal-option" class="payment-btn">
                    <span class="payment-icon">🅿️</span>
                    PayPal
                </button>
            </div>
        </div>

        <!-- Card Payment Section -->
        <div id="card-payment" class="payment-section hidden">
            <h3>Card Payment</h3>
            <form action="ProcessPaymentServlet" method="post">
                <label for="card-number">Card Number:</label>
                <input type="text" id="card-number" name="card-number" placeholder="xxxx xxxx xxxx xxxx" required>

                <label for="expiry-date">Expiry Date:</label>
                <input type="text" id="expiry-date" name="expiry-date" required>

                <label for="cvv">CVV:</label>
                <input type="text" id="cvv" name="cvv" placeholder="XXX" required>

                <label for="store-card">Save card for future payments
                    <input type="checkbox" id="store-card" name="storeCard">
                </label>

                <button type="submit">Pay Now</button>
            </form>
        </div>

        <!-- PayPal Payment Section -->
        <div id="paypal-payment" class="payment-section hidden">
            <h3>PayPal Payment</h3>
            <div id="paypal-button-container"></div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const priceElement = document.getElementById('price');
            const totalPriceHidden = document.getElementById('totalPriceHidden');
            
            // Fetch the price from sessionStorage
            const totalPrice = parseFloat(sessionStorage.getItem('totalPrice') || '0.00');
            
            // Update the displayed price
            priceElement.textContent = `$${totalPrice.toFixed(2)}`;
            totalPriceHidden.value = totalPrice.toFixed(2);
        });
    </script>
</body>
</html>
