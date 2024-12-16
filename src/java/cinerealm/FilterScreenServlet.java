package cinerealm;

import dao.MovieDAO;
import dao.LocationDAO;
import dao.ScreeningDAO;
import model.Screening;
import model.Movie;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FilterScreenServlet extends HttpServlet {

    private ScreeningDAO screeningDAO = new ScreeningDAO();
    private MovieDAO movieDAO = new MovieDAO();
    private LocationDAO locationDAO = new LocationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String movieIdParam = request.getParameter("id");
        int movieId = 0;

        // Check if 'id' parameter exists and is a valid number
        if (movieIdParam != null && !movieIdParam.isEmpty()) {
            try {
                movieId = Integer.parseInt(movieIdParam);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid movie ID");
                return;
            }
        }

        // Fetch dropdown options with exception handling
        List<String> movieTitles = movieDAO.getAllMovieTitles();
        List<String> locations = locationDAO.getAllLocations();
        List<String> experiences = screeningDAO.getAllExperiences();

        // Ensure lists are not null
        if (movieTitles == null) movieTitles = List.of();
        if (locations == null) locations = List.of();
        if (experiences == null) experiences = List.of();

        request.setAttribute("movieTitles", movieTitles);
        request.setAttribute("locations", locations);
        request.setAttribute("experiences", experiences);

        List<Screening> screenings = new ArrayList<>();
        if (movieId > 0) {
            // If a specific movie ID is provided, show screenings related to that movie
            screenings = screeningDAO.getScreeningsByMovieId(movieId);
            request.setAttribute("selectedMovieId", movieId);
        } else {
            // If no specific movie ID, fetch all screenings or based on filters (if any)
            String movieName = request.getParameter("movieName");
            String locationName = request.getParameter("location");
            String experience = request.getParameter("experience");

            screenings = screeningDAO.getScreenings(movieName, locationName, experience);
        }
        request.setAttribute("screenings", screenings);

        // Forward to the JSP page
        request.getRequestDispatcher("book-ticket.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String movieName = request.getParameter("movieName");
        String locationName = request.getParameter("location");
        String experience = request.getParameter("experience");

        try {
            // Fetch screenings from database based on selected filters
            List<Screening> screenings = screeningDAO.getScreenings(movieName, locationName, experience);
            List<Movie> movies = movieDAO.getAllMovies();

            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                // For AJAX request, return JSON
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                // Map movie titles to screenings (for movie titles to be included in screenings)
                screenings.forEach(screening -> {
                    for (Movie movie : movies) {
                        if (movie.getId() == screening.getMovieID()) {
                            screening.setMovieTitle(movie.getTitle()); // Assuming setMovieTitle exists
                            screening.setMoviePoster(movie.getPosterURL());
                        }
                    }
                });

                // Convert the list of screenings to JSON
                Gson gson = new Gson();
                String json = gson.toJson(screenings);
                response.getWriter().write(json);
            } else {
                // For normal form submission
                request.setAttribute("screenings", screenings);
                doGet(request, response); // forward back to doGet to display results on the same page
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error while fetching screenings.");
        }
    }
}
