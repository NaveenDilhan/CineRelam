package movieschedule;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Databaseconnection {

    // MySQL database connection details
    private static final String URL = "jdbc:mysql://localhost:3306/movie_schedule"; 
    private static final String USER = "root"; 
    private static final String PASSWORD = "naveen123"; 
    
    // Method to establish and return a connection to the database
    public static Connection getConnection() throws SQLException {
        try {
            // Load MySQL JDBC driver (Optional in recent versions of JDBC)
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish the connection
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }
    }
}
