<%@ include file="header.jsp" %> <!-- Include header -->
 <!-- Include footer -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Deals and Exclusives</title>
    <link rel="stylesheet" href="css/deals.css">
</head>
<body>
    <div class="header-section">
                <h2 class="page-title">Deals & Exclusive</h2>

    <!-- Breadcrumb Section -->
    <section class="breadcrumb-section">
        <div class="breadcrumb-container">
            <a href="homepage">Home</a> &gt; <a href="deals.jsp">Deals & Exclusives</a>
        </div>
    </section>

    <!-- Divider -->
    <hr class="divider">

    <!-- Deals Section -->
    <section class="deals-section">
        <div class="deals-container">

            <!-- Deal 1 -->
            <div class="deal-container">
                <img src="img/Discount-1.jpg" alt="Deal 1" class="deal-image">
                <div class="deal-info">
                    <h4 class="deal-title">Exclusive 20% Off</h4>
                    <p class="deal-description">Get 20% off on your next purchase. Limited time offer!</p>
                </div>
            </div>

            <!-- Deal 2 -->
            <div class="deal-container">
                <img src="img/Discount-2.jpg" alt="Deal 2" class="deal-image">
                <div class="deal-info">
                    <h4 class="deal-title">Buy One Get One Free</h4>
                    <p class="deal-description">Buy one item and get another free. Don't miss this amazing offer!</p>
                </div>
            </div>

            <!-- Deal 3 -->
            <div class="deal-container">
                <img src="img/Discount-3.jpg" alt="Deal 3" class="deal-image">
                <div class="deal-info">
                    <h4 class="deal-title">Free Shipping</h4>
                    <p class="deal-description">Enjoy free shipping on all orders. No minimum required!</p>
                </div>
            </div>

            <!-- Add more deals as needed -->

        </div>
    </section>

</body>
<%@ include file="footer.jsp" %>
</html>
