package cinerealm;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.LocationDAO;
import dao.MovieDAO;
import dao.ScreensDAO;
import model.Movie;
import model.Screening;

public class SelectScreeningServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> movies = new ArrayList<>();
        List<String> locations = new ArrayList<>();
        List<String> experiences = new ArrayList<>();
        List<Screening> screenings = new ArrayList<>();

        try {
            // Instantiate DAOs
            MovieDAO movieDAO = new MovieDAO();
            LocationDAO locationDAO = new LocationDAO();
            ScreensDAO screeningDAO = new ScreensDAO();

            // Get all Movie objects and extract their titles
            List<Movie> movieList = movieDAO.getAllMovies();
            for (Movie movie : movieList) {
                movies.add(movie.getTitle());
            }

            // Get all locations
            locations = locationDAO.getAllLocations();

            // Define possible experiences
            experiences.add("IMAX 3D");
            experiences.add("3D");
            experiences.add("Standard");

            // Fetch screenings from the database
            screenings = screeningDAO.getAllScreenings();

            // Set the movie information in each screening
            for (Screening screening : screenings) {
                Movie movie = movieDAO.getMovieById(screening.getMovieId());  // Fetch movie details using its ID
                screening.setMovieName(movie.getTitle());  // Set the movie name
                screening.setPosterUrl(movie.getPosterURL());  // Set the poster URL
            }

        } catch (SQLException e) {
            e.printStackTrace();
            // Optionally, set an error attribute to display on the JSP
            request.setAttribute("errorMessage", "Unable to fetch data. Please try again later.");
        }

        // Set attributes for JSP
        request.setAttribute("movies", movies);
        request.setAttribute("locations", locations);
        request.setAttribute("experiences", experiences);
        request.setAttribute("screenings", screenings);

        // Forward request to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("book-ticket.jsp");
        dispatcher.forward(request, response);
    }
}
