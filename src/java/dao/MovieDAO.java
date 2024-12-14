package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import cinerealm.Databaseconnection;
import model.Movie;

public class MovieDAO {

    // Fetch all movies
    public List<Movie> getAllMovies() throws SQLException {
        List<Movie> movies = new ArrayList<>();
        String sql = "SELECT MovieID, Title, Description, Genre, ReleaseDate, PosterURL, DurationMinutes FROM Movies";
        
        try (Connection conn = Databaseconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                movies.add(extractMovieFromResultSet(rs));
            }
        }
        return movies;
    }

    // Fetch all movie titles
    public List<String> getAllMovieTitles() {
        List<String> movieTitles = new ArrayList<>();
        String query = "SELECT Title FROM movies";
        
        try (Connection conn = Databaseconnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                movieTitles.add(rs.getString("Title"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movieTitles;
    }

    // Fetch movie by ID
    public Movie getMovieById(int movieId) throws SQLException {
        Movie movie = null;
        String sql = "SELECT MovieID, Title, Description, Genre, ReleaseDate, PosterURL, DurationMinutes FROM Movies WHERE MovieID = ?";
        
        try (Connection conn = Databaseconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, movieId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    movie = extractMovieFromResultSet(rs);
                }
            }
        }
        return movie;
    }

    // Fetch movies that are currently showing
    public List<Movie> getNowShowingMovies() throws SQLException {
        List<Movie> movies = new ArrayList<>();
        String sql = "SELECT * FROM Movies WHERE Date(ReleaseDate) <= CURDATE()"; // Customize as needed
        
        try (Connection conn = Databaseconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                movies.add(extractMovieFromResultSet(rs));
            }
        }
        return movies;
    }

    // Fetch movies that are coming soon
    public List<Movie> getComingSoonMovies() throws SQLException {
        List<Movie> movies = new ArrayList<>();
        String sql = "SELECT * FROM Movies WHERE Date(ReleaseDate) > CURDATE()"; // Customize as needed
        
        try (Connection conn = Databaseconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                movies.add(extractMovieFromResultSet(rs));
            }
        }
        return movies;
    }

    // Helper method to extract movie details from ResultSet
    private Movie extractMovieFromResultSet(ResultSet rs) throws SQLException {
        Movie movie = new Movie();
        movie.setId(rs.getInt("MovieID"));
        movie.setTitle(rs.getString("Title"));
        movie.setDescription(rs.getString("Description"));
        movie.setGenre(rs.getString("Genre"));
        movie.setReleaseDate(rs.getDate("ReleaseDate"));
        movie.setPosterURL(rs.getString("PosterURL"));
        movie.setDurationMinutes(rs.getInt("DurationMinutes"));
        return movie;
    }
}
