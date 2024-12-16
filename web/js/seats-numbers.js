let totalPrice = 0; // Initialize total price

/**
 * Toggles seat selection and updates total price.
 * @param {Event} event 
 */
function toggleSeatSelection(event) {
    const seat = event.target;
    const bookSeatsBtn = document.getElementById('bookSeatsBtn');
    const totalPriceSpan = document.getElementById('totalPrice');
    const seatPrice = parseFloat(seat.getAttribute('data-price'));

    // Handle available seats
    if (seat.classList.contains('available')) {
        totalPrice += updateSeatSelection(seat, seatPrice);
    } else if (seat.classList.contains('booked')) {
        alert('This seat is already booked.');
    }

    // Update total price and button state
    totalPriceSpan.innerText = totalPrice.toFixed(2);
    bookSeatsBtn.disabled = totalPrice <= 0;

    // Update hidden total price input
    document.getElementById('totalPriceHidden').value = totalPrice.toFixed(2);
}

/**
 * Updates seat selection state and returns the price adjustment.
 * @param {HTMLElement} seat - The seat element.
 * @param {number} price - The price of the seat.
 * @returns {number} - Price adjustment (+ or -).
 */
function updateSeatSelection(seat, price) {
    seat.classList.toggle('selected');
    return seat.classList.contains('selected') ? price : -price;
}

/**
 * Handles booking of selected seats via AJAX.
 */
function bookSeats() {
    const selectedSeats = Array.from(document.querySelectorAll('.seat.selected'))
        .map(seat => seat.getAttribute('data-seat-id'));

    if (selectedSeats.length === 0) {
        alert('Please select seats to book.');
        return;
    }

    // Get the total price
    totalPrice = parseFloat(document.getElementById('totalPrice').innerText);

    // Store the total price in sessionStorage
    sessionStorage.setItem('totalPrice', totalPrice.toFixed(2));

    // Redirect to the payment page
    window.location.href = 'payment.jsp';
}