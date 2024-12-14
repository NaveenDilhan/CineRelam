package model;

public class Screening {
    private int screeningID;
    private int movieID;
    private int locationID;
    private String experience;
    private String screeningDate;
    private String screeningTime;
    private String movieTitle;

    // Getters and Setters
    public int getScreeningID() { return screeningID; }
    public void setScreeningID(int screeningID) { this.screeningID = screeningID; }

    public int getMovieID() { return movieID; }
    public void setMovieID(int movieID) { this.movieID = movieID; }

    public int getLocationID() { return locationID; }
    public void setLocationID(int locationID) { this.locationID = locationID; }

    public String getExperience() { return experience; }
    public void setExperience(String experience) { this.experience = experience; }

    public String getScreeningDate() { return screeningDate; }
    public void setScreeningDate(String screeningDate) { this.screeningDate = screeningDate; }

    public String getScreeningTime() { return screeningTime; }
    public void setScreeningTime(String screeningTime) { this.screeningTime = screeningTime; }
    
    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }
}
