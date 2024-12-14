package dao;

import model.Screening;
import cinerealm.Databaseconnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ScreeningDAO {
    public List<Screening> getScreenings(String movieName, String location, String experience) {
        List<Screening> screenings = new ArrayList<>();
        try (Connection conn = Databaseconnection.getConnection()) {
            String query = "SELECT scr.*, mv.Title, loc.LocationName " +
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
                screening.setLocationID(rs.getInt("LocationID"));
                screening.setExperience(rs.getString("Experience"));
                screening.setScreeningDate(rs.getString("ScreeningDate"));
                screening.setScreeningTime(rs.getString("ScreeningTime"));
                screenings.add(screening);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return screenings;
    }

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
}
