package dao;

import model.Deal;
import cinerealm.Databaseconnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DealDAO {

    public static List<Deal> getAllDeals() throws Exception {
        List<Deal> deals = new ArrayList<>();
        String query = "SELECT * FROM deals";
        try (Connection conn = Databaseconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
             while (rs.next()) {
            deals.add(new Deal(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("image_url"),
                rs.getString("description"),
                rs.getString("valid_from"),
                rs.getString("valid_to")
            ));
            }
        }
        return deals;
    }
}
