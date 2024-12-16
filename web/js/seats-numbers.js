const rows = 8; // Number of rows
const seatsPerRow = 12; // 12 seats per row for the main section
const aisleGap = 4; // Aisle gap after the 4th seat
const seatsLeft = 6; // 6 seats for the left section
const seatsRight = 6; // 6 seats for the right section

const seatGrid = document.getElementById('seatGrid');

// Loop through each row
for (let row = 1; row <= rows; row++) {
    const rowDiv = document.createElement('div');
    rowDiv.classList.add('row');

    // Left section seats
    for (let seat = 1; seat <= seatsLeft; seat++) {
        const seatButton = document.createElement('button');
        seatButton.classList.add('seat', 'available');
        seatButton.setAttribute('data-seat', `L${row}-${seat}`);
        seatButton.textContent = `L${row}-${seat}`;
        rowDiv.appendChild(seatButton);
    }

    // Aisle between sections
    const aisle = document.createElement('div');
    aisle.classList.add('aisle');
    rowDiv.appendChild(aisle);

    // Right section seats
    for (let seat = 1; seat <= seatsRight; seat++) {
        const seatButton = document.createElement('button');
        seatButton.classList.add('seat', 'available');
        seatButton.setAttribute('data-seat', `R${row}-${seat}`);
        seatButton.textContent = `R${row}-${seat}`;
        rowDiv.appendChild(seatButton);
    }

    seatGrid.appendChild(rowDiv);
}
