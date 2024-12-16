package model;

import java.sql.Timestamp;

public class Bookings {
    private int bookingID;
    private int screeningID;
    private int seatID;
    private Timestamp bookingTime;

    // Constructor
    public Bookings(int bookingID, int screeningID, int seatID, Timestamp bookingTime) {
        this.bookingID = bookingID;
        this.screeningID = screeningID;
        this.seatID = seatID;
        this.bookingTime = bookingTime;
    }

    // Getters
    public int getBookingID() {
        return bookingID;
    }

    public int getScreeningID() {
        return screeningID;
    }

    public int getSeatID() {
        return seatID;
    }

    public Timestamp getBookingTime() {
        return bookingTime;
    }

    // Setters
    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public void setScreeningID(int screeningID) {
        this.screeningID = screeningID;
    }

    public void setSeatID(int seatID) {
        this.seatID = seatID;
    }

    public void setBookingTime(Timestamp bookingTime) {
        this.bookingTime = bookingTime;
    }

    @Override
    public String toString() {
        return "Booking{" +
                "bookingID=" + bookingID +
                ", screeningID=" + screeningID +
                ", seatID=" + seatID +
                ", bookingTime=" + bookingTime +
                '}';
    }
}
