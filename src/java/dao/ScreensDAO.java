package dao;

import model.Screening;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ScreensDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cinerealm";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "your_password";

    // Method to fetch all screenings
    public List<Screening> getAllScreenings() {
        List<Screening> screenings = new ArrayList<>();
        String query = "SELECT * FROM screening_times";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Screening screen = new Screening();
                screen.setScreeningId(rs.getInt("screening_id"));
                screen.setMovieId(rs.getInt("movie_id"));
                screen.setLocationId(rs.getInt("location_id"));
                screen.setScreeningDate(rs.getDate("screening_date"));
                screen.setScreeningTime(rs.getTime("screening_time"));
                screen.setExperienceType(rs.getString("experience_type"));

                screenings.add(screen);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return screenings;
    }

    // Method to fetch screenings by movie ID
    public List<Screening> getScreeningsByMovieId(int movieId) {
        List<Screening> screenings = new ArrayList<>();
        String query = "SELECT * FROM screening_times WHERE movie_id = ?";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, movieId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Screening screen = new Screening();
                    screen.setScreeningId(rs.getInt("screening_id"));
                    screen.setMovieId(rs.getInt("movie_id"));
                    screen.setLocationId(rs.getInt("location_id"));
                    screen.setScreeningDate(rs.getDate("screening_date"));
                    screen.setScreeningTime(rs.getTime("screening_time"));
                    screen.setExperienceType(rs.getString("experience_type"));

                    screenings.add(screen);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return screenings;
    }

    // Method to insert a new screening
    public boolean addScreening(Screening screen) {
        String query = "INSERT INTO screening_times (movie_id, location_id, screening_date, screening_time, experience_type) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, screen.getMovieId());
            ps.setInt(2, screen.getLocationId());
            ps.setDate(3, screen.getScreeningDate());
            ps.setTime(4, screen.getScreeningTime());
            ps.setString(5, screen.getExperienceType());

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to update an existing screening
    public boolean updateScreening(Screening screen) {
        String query = "UPDATE screening_times SET movie_id = ?, location_id = ?, screening_date = ?, screening_time = ?, experience_type = ? WHERE screening_id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, screen.getMovieId());
            ps.setInt(2, screen.getLocationId());
            ps.setDate(3, screen.getScreeningDate());
            ps.setTime(4, screen.getScreeningTime());
            ps.setString(5, screen.getExperienceType());
            ps.setInt(6, screen.getScreeningId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to delete a screening
    public boolean deleteScreening(int screeningId) {
        String query = "DELETE FROM screening_times WHERE screening_id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, screeningId);
            int rowsDeleted = ps.executeUpdate();
            return rowsDeleted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
