package com.airline.service;

import com.airline.config.DbConfig;
import com.airline.model.Flight;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class FlightService {
    private static final Logger logger = Logger.getLogger(FlightService.class.getName());

    public List<Flight> getAllFlights() {
        List<Flight> flights = new ArrayList<>();
        String sql = "SELECT flight_id, from_city, to_city, departure_date, departure_time, arrival_date, arrival_time, price, travel_class, seats_available FROM flights";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Flight flight = new Flight(
                    rs.getString("flight_id"),
                    rs.getString("from_city"),
                    rs.getString("to_city"),
                    rs.getDate("departure_date").toLocalDate(),
                    rs.getTime("departure_time").toLocalTime(),
                    rs.getDate("arrival_date") != null ? rs.getDate("arrival_date").toLocalDate() : null,
                    rs.getTime("arrival_time") != null ? rs.getTime("arrival_time").toLocalTime() : null,
                    rs.getDouble("price"),
                    rs.getString("travel_class"),
                    rs.getInt("seats_available")
                );
                flights.add(flight);
            }

        } catch (SQLException e) {
            logger.severe("SQL error in getAllFlights: " + e.getMessage());
        }

        return flights;
    }

    public Flight getFlightById(String flightId) {
        String sql = "SELECT * FROM flights WHERE flight_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, flightId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Flight(
                    rs.getString("flight_id"),
                    rs.getString("from_city"),
                    rs.getString("to_city"),
                    rs.getDate("departure_date").toLocalDate(),
                    rs.getTime("departure_time").toLocalTime(),
                    rs.getDate("arrival_date") != null ? rs.getDate("arrival_date").toLocalDate() : null,
                    rs.getTime("arrival_time") != null ? rs.getTime("arrival_time").toLocalTime() : null,
                    rs.getDouble("price"),
                    rs.getString("travel_class"),
                    rs.getInt("seats_available")
                );
            }

        } catch (SQLException e) {
            logger.severe("SQL error in getFlightById: " + e.getMessage());
        }

        return null;
    }

    public void addFlight(String flightId, String fromCity, String toCity, String depDate, String depTime,
                          String arrDate, String arrTime, String travelClass, double price, int seats) {

        String sql = "INSERT INTO flights (flight_id, from_city, to_city, departure_date, departure_time, arrival_date, arrival_time, travel_class, price, seats_available) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, flightId);
            stmt.setString(2, fromCity);
            stmt.setString(3, toCity);
            stmt.setDate(4, Date.valueOf(depDate));
            stmt.setTime(5, (depTime != null && !depTime.isEmpty()) ? Time.valueOf(depTime + ":00") : null);
            stmt.setDate(6, (arrDate != null && !arrDate.isEmpty()) ? Date.valueOf(arrDate) : null);
            stmt.setTime(7, (arrTime != null && !arrTime.isEmpty()) ? Time.valueOf(arrTime + ":00") : null);
            stmt.setString(8, travelClass);
            stmt.setDouble(9, price);
            stmt.setInt(10, seats);

            stmt.executeUpdate();

        } catch (SQLException e) {
            logger.severe("SQL error in addFlight: " + e.getMessage());
        }
    }

    public void updateFlight(String flightId, String fromCity, String toCity, String depDate, String depTime,
                             String arrDate, String arrTime, String travelClass, double price, int seats) {
        String sql = "UPDATE flights SET from_city=?, to_city=?, departure_date=?, departure_time=?, arrival_date=?, arrival_time=?, travel_class=?, price=?, seats_available=? WHERE flight_id=?";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, fromCity);
            stmt.setString(2, toCity);
            stmt.setDate(3, Date.valueOf(depDate));
            stmt.setTime(4, (depTime != null && !depTime.isEmpty()) ? Time.valueOf(depTime + ":00") : null);
            stmt.setDate(5, (arrDate != null && !arrDate.isEmpty()) ? Date.valueOf(arrDate) : null);
            stmt.setTime(6, (arrTime != null && !arrTime.isEmpty()) ? Time.valueOf(arrTime + ":00") : null);
            stmt.setString(7, travelClass);
            stmt.setDouble(8, price);
            stmt.setInt(9, seats);
            stmt.setString(10, flightId);

            stmt.executeUpdate();
        } catch (SQLException e) {
            logger.severe("SQL error in updateFlight: " + e.getMessage());
        }
    }

    public void deleteFlight(String flightId) {
        String sql = "DELETE FROM flights WHERE flight_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, flightId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            logger.severe("SQL error in deleteFlight: " + e.getMessage());
        }
    }
}
