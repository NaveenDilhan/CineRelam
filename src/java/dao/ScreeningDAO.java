package dao;

import model.Screening;
import model.Seats;
import cinerealm.Databaseconnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ScreeningDAO {

    // Get screenings based on filters (movieName, location, experience)
    public List<Screening> getScreenings(String movieName, String location, String experience) {
    List<Screening> screenings = new ArrayList<>();
    try (Connection conn = Databaseconnection.getConnection()) {
        String query = "SELECT scr.*, mv.Title, mv.PosterURL, loc.LocationName " +
                       "FROM screenings scr " +
                       "JOIN movies mv ON scr.MovieID = mv.MovieID " +
                       "JOIN locations loc ON scr.LocationID = loc.LocationID " +
                       "WHERE (? IS NULL OR mv.Title LIKE ?) " +
                       "AND (? IS NULL OR loc.LocationName LIKE ?) " +
                       "AND (? IS NULL OR scr.Experience LIKE ?)";

        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, movieName);
        pstmt.setString(2, movieName == null ? null : "%" + movieName + "%");
        pstmt.setString(3, location);
        pstmt.setString(4, location == null ? null : "%" + location + "%");
        pstmt.setString(5, experience);
        pstmt.setString(6, experience == null ? null : "%" + experience + "%");

        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Screening screening = new Screening();
            screening.setScreeningID(rs.getInt("ScreeningID"));
            screening.setMovieID(rs.getInt("MovieID"));
            screening.setExperience(rs.getString("Experience"));
            screening.setScreeningTime(rs.getString("ScreeningTime"));
            screening.setMovieTitle(rs.getString("Title"));
            screening.setMoviePoster(rs.getString("PosterURL"));
            screenings.add(screening);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return screenings;
}

    // Get screenings by movie ID (for a specific movie)
    public List<Screening> getScreeningsByMovieId(int movieId) {
        List<Screening> screenings = new ArrayList<>();
        try (Connection conn = Databaseconnection.getConnection()) {
            String query = "SELECT scr.*, mv.Title, mv.PosterURL, loc.LocationName " +
                           "FROM screenings scr " +
                           "JOIN movies mv ON scr.MovieID = mv.MovieID " +
                           "JOIN locations loc ON scr.LocationID = loc.LocationID " +
                           "WHERE mv.MovieID = ?";

            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, movieId);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Screening screening = new Screening();
                screening.setScreeningID(rs.getInt("ScreeningID"));
                screening.setMovieID(rs.getInt("MovieID"));
                screening.setExperience(rs.getString("Experience"));
                screening.setScreeningDate(rs.getString("ScreeningDate"));
                screening.setScreeningTime(rs.getString("ScreeningTime"));
                screening.setMovieTitle(rs.getString("Title"));
                screening.setLocationID(rs.getInt("LocationID"));
                screening.setLocationName(rs.getString("LocationName"));
                screening.setMoviePoster(rs.getString("PosterURL")); // Fetch movie poster

                screenings.add(screening);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return screenings;
    }

    // Fetch all experiences (for dropdown)
    public List<String> getAllExperiences() {
        List<String> experiences = new ArrayList<>();
        try (Connection conn = Databaseconnection.getConnection()) {
            String query = "SELECT DISTINCT Experience FROM screenings";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                experiences.add(rs.getString("Experience"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return experiences;
    }
        // Fetch seats for a specific screening
    public List<Seats> getSeatsForScreening(int screeningId) {
        List<Seats> seats = new ArrayList<>();
        try (Connection conn = Databaseconnection.getConnection()) {
            String query = "SELECT seatID, seatNumber, rowNumber, isBooked, SeatPrice FROM seats WHERE screeningID = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, screeningId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Seats seat = new Seats(
                        rs.getInt("seatID"),
                        rs.getString("seatNumber"),
                        rs.getString("rowNumber"),
                        screeningId,
                        rs.getBoolean("isBooked"),
                        rs.getDouble("Seatprice")
                );
                seats.add(seat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seats;
    }
    
    public Screening getScreeningById(int screeningId) {
    Screening screening = null;
    try (Connection conn = Databaseconnection.getConnection()) {
        String query = "SELECT scr.*, mv.Title, mv.PosterURL, loc.LocationName " +
                       "FROM screenings scr " +
                       "JOIN movies mv ON scr.MovieID = mv.MovieID " +
                       "JOIN locations loc ON scr.LocationID = loc.LocationID " +
                       "WHERE scr.ScreeningID = ?";

        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, screeningId);

        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            screening = new Screening();
            screening.setScreeningID(rs.getInt("ScreeningID"));
            screening.setMovieID(rs.getInt("MovieID"));
            screening.setExperience(rs.getString("Experience"));
            screening.setScreeningTime(rs.getString("ScreeningTime"));
            screening.setMovieTitle(rs.getString("Title"));
            screening.setMoviePoster(rs.getString("PosterURL"));
            screening.setLocationName(rs.getString("LocationName"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return screening;
}
}
