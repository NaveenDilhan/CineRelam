package cinerealm;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt; // BCrypt for password hashing

@WebServlet("/SigninServlet")
public class SigninServlet extends HttpServlet {

    // The method to handle POST requests
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate inputs to prevent empty/invalid inputs
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect("signin.jsp?error=empty_fields");
            return;
        }
        
        try (Connection con = Databaseconnection.getConnection()) {
            String query = "SELECT user_id, password_hash, role FROM users WHERE username = ?";
            try (PreparedStatement pst = con.prepareStatement(query)) {
                pst.setString(1, username);
                ResultSet rs = pst.executeQuery();
                
                // Check if user exists
                if (rs.next()) {
                    String storedPasswordHash = rs.getString("password_hash");
                    // Check if password matches the hashed value stored in the database
                    if (BCrypt.checkpw(password, storedPasswordHash)) {
                        // Create a session for the authenticated user
                        HttpSession session = request.getSession();
                        session.setAttribute("user_id", rs.getInt("user_id"));
                        String role = rs.getString("role");
                        session.setAttribute("role", role);
                        
                        // Redirect based on the role
                        if ("admin".equals(role)) {
                            response.sendRedirect("admin/adminpanel.jsp");  // Redirect to admin page
                        } else {
                            response.sendRedirect("homepage");  // Redirect to homepage for non-admin users
                        }
                    } else {
                        // Invalid password
                        response.sendRedirect("signin.jsp?error=invalid_credentials");
                    }
                } else {
                    // Invalid username
                    response.sendRedirect("signin.jsp?error=invalid_credentials");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("signin.jsp?error=database_error");
        }
    }
}

