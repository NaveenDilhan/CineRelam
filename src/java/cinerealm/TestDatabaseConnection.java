package cinerealm;

import cinerealm.Databaseconnection;
import java.sql.Connection;
import java.sql.SQLException;

public class TestDatabaseConnection {
    public static void main(String[] args) {
        try {
            // Get a connection to the database
            Connection conn = Databaseconnection.getConnection();
            
            // Print a success message
            System.out.println("Database connection established successfully!");
            
            // Close the connection
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
