document.addEventListener('DOMContentLoaded', () => {
    const cardOption = document.getElementById('card-option');
    const paypalOption = document.getElementById('paypal-option');
    const cardPayment = document.getElementById('card-payment');
    const paypalPayment = document.getElementById('paypal-payment');
    const priceElement = document.getElementById('price');
    const totalPriceHidden = document.getElementById('totalPriceHidden');

    // Fetch the price from sessionStorage
    const totalPrice = parseFloat(sessionStorage.getItem('totalPrice') || '0.00');
    
    // Update the displayed price
    priceElement.textContent = `$${totalPrice.toFixed(2)}`;
    totalPriceHidden.value = totalPrice.toFixed(2);

    // Select payment method
    function selectPaymentMethod(selectedButton, showPayment) {
        cardOption.classList.remove('active');
        paypalOption.classList.remove('active');
        selectedButton.classList.add('active');

        if (showPayment === 'card') {
            cardPayment.classList.remove('hidden');
            paypalPayment.classList.add('hidden');
        } else {
            cardPayment.classList.add('hidden');
            paypalPayment.classList.remove('hidden');
        }
    }

    // Event listeners for payment method selection
    cardOption.addEventListener('click', () => {
        if (cardPayment.classList.contains('hidden')) {
            selectPaymentMethod(cardOption, 'card');
        }
    });

    paypalOption.addEventListener('click', () => {
        if (paypalPayment.classList.contains('hidden')) {
            selectPaymentMethod(paypalOption, 'paypal');
        }
    });

    // PayPal Payment Integration
    paypal.Buttons({
        createOrder: (data, actions) => {
            return actions.order.create({
                purchase_units: [{
                    amount: {
                        value: totalPrice.toFixed(2)  // Using the dynamic price
                    }
                }]
            });
        },
        onApprove: (data, actions) => {
            return actions.order.capture().then(() => {
                alert('Payment successful!');
                // You can add additional logic here, like redirecting to a thank you page
            });
        },
        onError: (err) => {
            console.error(err);
            alert('Payment failed!');
        }
    }).render('#paypal-button-container');
});
