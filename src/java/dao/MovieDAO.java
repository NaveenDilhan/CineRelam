package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import cinerealm.Databaseconnection;
import model.Movie;

public class MovieDAO {
    public List<Movie> getAllMovies() throws SQLException {
        List<Movie> movies = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = Databaseconnection.getConnection();
            String sql = "SELECT MovieID, Title, Description, Genre, ReleaseDate, PosterURL, DurationMinutes FROM Movies";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Movie movie = new Movie();
                movie.setId(rs.getInt("MovieID"));
                movie.setTitle(rs.getString("Title"));
                movie.setDescription(rs.getString("Description"));
                movie.setGenre(rs.getString("Genre"));
                movie.setReleaseDate(rs.getDate("ReleaseDate"));
                movie.setPosterURL(rs.getString("PosterURL"));
                movie.setDurationMinutes(rs.getInt("DurationMinutes"));
                movies.add(movie);
            }
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return movies;
    }

    public Movie getMovieById(int movieId) throws SQLException {
        Movie movie = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = Databaseconnection.getConnection();
            String sql = "SELECT MovieID, Title, Description, Genre, ReleaseDate, PosterURL, DurationMinutes FROM Movies WHERE MovieID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, movieId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                movie = new Movie();
                movie.setId(rs.getInt("MovieID"));
                movie.setTitle(rs.getString("Title"));
                movie.setDescription(rs.getString("Description"));
                movie.setGenre(rs.getString("Genre"));
                movie.setReleaseDate(rs.getDate("ReleaseDate"));
                movie.setPosterURL(rs.getString("PosterURL"));
                movie.setDurationMinutes(rs.getInt("DurationMinutes"));
            }
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return movie;
    }
}
