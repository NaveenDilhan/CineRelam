package cinerealm;

import dao.MovieDAO;
import dao.DealDAO;
import model.Movie;
import model.Deal;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class HomepageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Create DAO instances
            MovieDAO movieDAO = new MovieDAO();

            // Fetch "Now Showing" movies
            List<Movie> nowShowing = movieDAO.getNowShowingMovies();

            // Fetch "Coming Soon" movies
            List<Movie> comingSoon = movieDAO.getComingSoonMovies();

            // Fetch deals
            List<Deal> deals = DealDAO.getAllDeals();

            // Set attributes to be accessed in JSP
            request.setAttribute("nowShowing", nowShowing);
            request.setAttribute("comingSoon", comingSoon);
            request.setAttribute("deals", deals);

            // Forward to the homepage JSP
            request.getRequestDispatcher("homepage.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Handle error (e.g., show an error page)
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while fetching data.");
        }
    }
}