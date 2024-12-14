package dao;

import cinerealm.Databaseconnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LocationDAO {
    public List<String> getAllLocations() {
        List<String> locations = new ArrayList<>();
        try (Connection conn = Databaseconnection.getConnection()) {
            String query = "SELECT DISTINCT LocationName FROM locations";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                locations.add(rs.getString("LocationName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return locations;
    }
}
