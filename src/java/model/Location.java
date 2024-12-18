package model;

public class Location {
    private int locationID;
    private String locationName;

    // Constructor
    public Location(int locationID, String locationName) {
        this.locationID = locationID;
        this.locationName = locationName;
    }

    // Getters and Setters
    public int getLocationID() {
        return locationID;
    }

    public void setLocationID(int locationID) {
        this.locationID = locationID;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    @Override
    public String toString() {
        return "Location{" +
                "locationID=" + locationID +
                ", locationName='" + locationName + '\'' +
                '}';
    }
}
