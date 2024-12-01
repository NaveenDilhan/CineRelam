package cinerealm;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class SelectSeatServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve user input from the form
        String movie = request.getParameter("movie");
        String location = request.getParameter("location");
        String date = request.getParameter("date");
        String experience = request.getParameter("experience");
        
        // Set attributes for the next page
        request.setAttribute("movie", movie);
        request.setAttribute("location", location);
        request.setAttribute("date", date);
        request.setAttribute("experience", experience);
        
        // Forward to the seat selection page
        RequestDispatcher dispatcher = request.getRequestDispatcher("book-seat.jsp");
        dispatcher.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect GET requests to the POST handler
        doPost(request, response);
    }
}
