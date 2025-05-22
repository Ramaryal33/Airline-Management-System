package com.airline.service;

import com.airline.config.DbConfig;
import com.airline.model.Flight;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class PassengerService {

    public List<Flight> getAllFlights() {
        List<Flight> list = new ArrayList<>();
        String sql = "SELECT * FROM flights";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Flight flight = new Flight();
                flight.setFlightId(rs.getInt("flight_id"));
                flight.setFromCity(rs.getString("from_city"));
                flight.setToCity(rs.getString("to_city"));
                flight.setDepartureDate(rs.getDate("departure_date").toLocalDate());
                flight.setDepartureTime(rs.getTime("departure_time").toLocalTime());
                flight.setTravelClass(rs.getString("travel_class"));
                flight.setPrice(rs.getDouble("price"));

                list.add(flight);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
