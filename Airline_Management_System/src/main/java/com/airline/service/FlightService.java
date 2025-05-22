package com.airline.service;

import com.airline.model.Flight;
import com.airline.config.DbConfig;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class FlightService {
	
	
	// In com.airline.service.FlightService.java
	public boolean addFlight(Flight flight) {
	    String sql = "INSERT INTO flights (flight_id, from_city, to_city, departure_date, departure_time, price, travel_class) "
	               + "VALUES (?, ?, ?, ?, ?, ?, ?)";
	    try (Connection conn = DbConfig.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setString(1, flight.getFlightId());
	        stmt.setString(2, flight.getFromCity());
	        stmt.setString(3, flight.getToCity());
	        stmt.setDate(4, Date.valueOf(flight.getDepartureDate()));
	        stmt.setTime(5, Time.valueOf(flight.getDepartureTime()));
	        stmt.setDouble(6, flight.getPrice());
	        stmt.setString(7, flight.getTravelClass());
	        return stmt.executeUpdate() == 1;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    }
	}


    public List<Flight> searchFlights(String fromCity, String toCity, LocalDate departureDate, String travelClass) {
        List<Flight> flights = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM flights WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (fromCity != null && !fromCity.isEmpty()) {
            sql.append(" AND from_city LIKE ?");
            params.add("%" + fromCity + "%");
        }
        if (toCity != null && !toCity.isEmpty()) {
            sql.append(" AND to_city LIKE ?");
            params.add("%" + toCity + "%");
        }
        if (departureDate != null) {
            sql.append(" AND departure_date = ?");
            params.add(Date.valueOf(departureDate));
        }
        if (travelClass != null && !travelClass.isEmpty()) {
            sql.append(" AND travel_class = ?");
            params.add(travelClass);
        }

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Flight flight = new Flight(
                    rs.getString("flight_id"),
                    rs.getString("from_city"),
                    rs.getString("to_city"),
                    rs.getDate("departure_date").toLocalDate(),
                    rs.getTime("departure_time").toLocalTime(),
                    rs.getDouble("price"),
                    rs.getString("travel_class")
                );
                flights.add(flight);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
                    rs.getDouble("price"),
                    rs.getString("travel_class")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}