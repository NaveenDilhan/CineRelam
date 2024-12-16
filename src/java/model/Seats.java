package model;

public class Seats {
    private int seatID;
    private String seatNumber;
    private String rowNumber;
    private int screeningID;
    private boolean isBooked;

    // Constructor
    public Seats(int seatID, String seatNumber, String rowNumber, int screeningID, boolean isBooked) {
        this.seatID = seatID;
        this.seatNumber = seatNumber;
        this.rowNumber = rowNumber;
        this.screeningID = screeningID;
        this.isBooked = isBooked;
    }

    // Getters
    public int getSeatID() {
        return seatID;
    }

    public String getSeatNumber() {
        return seatNumber;
    }

    public String getRowNumber() {
        return rowNumber;
    }

    public int getScreeningID() {
        return screeningID;
    }

    public boolean isBooked() {
        return isBooked;
    }

    // Setters
    public void setSeatID(int seatID) {
        this.seatID = seatID;
    }

    public void setSeatNumber(String seatNumber) {
        this.seatNumber = seatNumber;
    }

    public void setRowNumber(String rowNumber) {
        this.rowNumber = rowNumber;
    }

    public void setScreeningID(int screeningID) {
        this.screeningID = screeningID;
    }

    public void setBooked(boolean isBooked) {
        this.isBooked = isBooked;
    }

    @Override
    public String toString() {
        return "Seat{" +
                "seatID=" + seatID +
                ", seatNumber='" + seatNumber + '\'' +
                ", rowNumber='" + rowNumber + '\'' +
                ", screeningID=" + screeningID +
                ", isBooked=" + isBooked +
                '}';
    }
}
