package com.airline.service;

import com.airline.config.DbConfig;
import java.sql.*;
import java.util.*;

public class managePassengerService {

    // Get all passengers
    public List<Map<String, String>> getAllPassengers() throws SQLException {
        List<Map<String, String>> passengers = new ArrayList<>();

        String query = "SELECT id, FullName, Email, Phone FROM users WHERE userType = 'user'";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, String> passenger = new HashMap<>();
                passenger.put("id", String.valueOf(rs.getInt("id")));
                passenger.put("fullName", rs.getString("FullName"));
                passenger.put("email", rs.getString("Email"));
                passenger.put("phone", rs.getString("Phone"));
                passengers.add(passenger);
            }
        }

        return passengers;
    }

    // Get a passenger by ID
    public Map<String, String> getPassengerById(int id) throws SQLException {
        Map<String, String> passenger = null;

        String query = "SELECT id, FullName, Email, Phone FROM users WHERE id = ? AND userType = 'user'";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    passenger = new HashMap<>();
                    passenger.put("id", String.valueOf(rs.getInt("id")));
                    passenger.put("fullName", rs.getString("FullName"));
                    passenger.put("email", rs.getString("Email"));
                    passenger.put("phone", rs.getString("Phone"));
                }
            }
        }

        return passenger;
    }

    // Add passenger
    public boolean addPassenger(String fullName, String email, String phone, String password) throws SQLException {
        String query = "INSERT INTO users (FullName, Email, Phone, Password, userType) VALUES (?, ?, ?, ?, 'user')";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, password);

            return ps.executeUpdate() > 0;
        }
    }

    // Update passenger
    public boolean updatePassenger(int id, String fullName, String email, String phone) throws SQLException {
        String query = "UPDATE users SET FullName = ?, Email = ?, Phone = ? WHERE id = ? AND userType = 'user'";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setInt(4, id);

            return ps.executeUpdate() > 0;
        }
    }

    // Delete passenger
    public boolean deletePassenger(int id) throws SQLException {
        String query = "DELETE FROM users WHERE id = ? AND userType = 'user'";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);

            return ps.executeUpdate() > 0;
        }
    }
}
