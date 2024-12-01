package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import cinerealm.Databaseconnection;

public class LocationDAO {
    public List<String> getAllLocations() throws SQLException {
        List<String> locations = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            conn = Databaseconnection.getConnection();
            String query = "SELECT Name FROM locations";
            pst = conn.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                locations.add(rs.getString("Name"));
            }
        } finally {
            if (rs != null) rs.close();
            if (pst != null) pst.close();
            if (conn != null) conn.close();
        }

        return locations;
    }
}
