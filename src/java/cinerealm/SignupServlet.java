package cinerealm;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt; // Import BCrypt

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone_number");
        String password = request.getParameter("password");

        // Hash the password using BCrypt
        String passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());

        try (Connection con = Databaseconnection.getConnection()) {
            // Use a prepared statement to prevent SQL injection
            String query = "INSERT INTO users (username, email, phone_number, password_hash) VALUES (?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, phoneNumber);
            pst.setString(4, passwordHash); // Store the hashed password
            pst.executeUpdate();

            // Redirect to the login page after successful signup
            response.sendRedirect("signin.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
