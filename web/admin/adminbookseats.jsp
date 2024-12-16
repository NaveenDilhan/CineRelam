<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="css/style.css" />
    <style>
      @import url('https://fonts.googleapis.com/css?family=Lato&display=swap');

      * {
        box-sizing: border-box;
      }

      body {
        background-color: #240a2e;
        display: flex;
        flex-direction: column;
        color: white;
        align-items: center;
        justify-content: center;
        height: 100vh;
        font-family: 'Lato', 'sans-serif';
      }

      .movie-container {
        margin: 20px 0;
      }

      .movie-container select {
        background-color: #fff;
        border: 0;
        border-radius: 5px;
        font-size: 14px;
        margin-left: 10px;
        padding: 5px 15px 5px 15px;
        -moz-appearance: none;
        -webkit-appearance: none;
        appearance: none;
      }

      .container {
        perspective: 1000px;
        margin-bottom: 30px;
      }

      .seat {
        background-color: #444451;
        height: 24px;
        width: 30px;
        margin: 6px;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
      }

      .seat.selected {
        background-color: #bf34ff;
      }

      .seat.occupied {
        background-color: #fff;
      }

      .row {
        display: flex;
      }

      .screen {
        background-color: #fff;
        height: 70px;
        width: 100%;
        margin: 15px 0;
        transform: rotateX(-45deg);
        box-shadow: 0 3px 10px rgba(255, 255, 255, 0.75);
      }

      .button-container {
        text-align: center;
        margin-top: 20px;
      }

      .custom-button {
        background-color: #1b0634;
        color: white;
        border: none;
        padding: 12px 20px;
        font-size: 16px;
        border-radius: 25px;
        cursor: pointer;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: background-color 0.3s, transform 0.2s;
      }

      .custom-button:hover {
        background-color: #810395;
        transform: scale(1.05);
      }

      .custom-button:active {
        background-color: #2e014a;
        transform: scale(0.95);
      }
    </style>
  </head>
  <body>
    <h1>Admin - Movie Seats Booking</h1>

    <div class="movie-container">
      <label>Pick a movie:</label>
      <select id="movie">
        <option value="10">We Are Vagos ($10)</option>
        <option value="15">Action Movie ($15)</option>
        <option value="12">Comedy Movie ($12)</option>
      </select>
    </div>

    <p>
      You have selected <span id="count">0</span> seats for a price of $<span id="total">0</span>
    </p>

    <ul class="showcase">
      <li><div class="seat"></div><small>Available</small></li>
      <li><div class="seat selected"></div><small>Selected</small></li>
      <li><div class="seat occupied"></div><small>Occupied</small></li>
    </ul>

    <div class="container">
      <div class="screen"></div>
      <div class="row">
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
      </div>

      <div class="row">
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat occupied"></div>
        <div class="seat occupied"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
      </div>

      <div class="row">
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat occupied"></div>
        <div class="seat occupied"></div>
      </div>

      <div class="row">
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
      </div>

      <div class="row">
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat occupied"></div>
        <div class="seat occupied"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
      </div>

      <div class="row">
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat"></div>
        <div class="seat occupied"></div>
        <div class="seat occupied"></div>
        <div class="seat occupied"></div>
        <div class="seat"></div>
      </div>
    </div>

    <div class="button-container">
      <button class="custom-button" onclick="updateSeatStatus()">Update Seat Status</button>
    </div>

    <script>
      const container = document.querySelector('.container');
      const seats = document.querySelectorAll('.row .seat:not(.occupied)');
      const count = document.getElementById('count');
      const total = document.getElementById('total');
      const movieSelect = document.getElementById('movie');

      let ticketPrice = +movieSelect.value;
      let selectedSeats = [];

      // Update count and total
      function updateSelectedCount() {
        selectedSeats = [];
        const selectedSeatElements = document.querySelectorAll('.row .seat.selected');
        selectedSeats = [...selectedSeatElements].map((seat) => seat.classList.contains('selected'));

        count.innerText = selectedSeats.length;
        total.innerText = selectedSeats.length * ticketPrice;
      }

      // Update seat status (occupied or not)
      function updateSeatStatus() {
        const selectedSeats = document.querySelectorAll('.row .seat.selected');

        selectedSeats.forEach((seat) => {
          seat.classList.add('occupied');  // Mark as occupied
          seat.classList.remove('selected');  // Remove selected status
        });

        updateSelectedCount();
      }

      // Movie select event
      movieSelect.addEventListener('change', (e) => {
        ticketPrice = +e.target.value;
        updateSelectedCount();
      });

      // Seat click event for admin to change seat status
      container.addEventListener('click', (e) => {
        if (e.target.classList.contains('seat') && !e.target.classList.contains('occupied')) {
          e.target.classList.toggle('selected');  // Toggle selected status for admin
          updateSelectedCount();
        }
      });

     
      updateSelectedCount();
    </script>
  </body>
</html>
