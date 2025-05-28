package com.airline.service;

import com.airline.model.Flight;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class PassengerService {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/airline management";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Unable to load MySQL JDBC driver", e);
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }

    public List<Flight> getAllFlights() {
        List<Flight> flights = new ArrayList<>();

        String sql = "SELECT flight_id, from_city, to_city, departure_date, departure_time, " +
                     "arrival_date, arrival_time, price, travel_class, seats_available FROM flights";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                LocalDate depDate = null;
                LocalTime depTime = null;
                LocalDate arrDate = null;
                LocalTime arrTime = null;

                Date sqlDepDate = rs.getDate("departure_date");
                Time sqlDepTime = rs.getTime("departure_time");
                Date sqlArrDate = rs.getDate("arrival_date");
                Time sqlArrTime = rs.getTime("arrival_time");

                if (sqlDepDate != null) depDate = sqlDepDate.toLocalDate();
                if (sqlDepTime != null) depTime = sqlDepTime.toLocalTime();
                if (sqlArrDate != null) arrDate = sqlArrDate.toLocalDate();
                if (sqlArrTime != null) arrTime = sqlArrTime.toLocalTime();

                Flight flight = new Flight(
                    rs.getString("flight_id"),
                    rs.getString("from_city"),
                    rs.getString("to_city"),
                    depDate,
                    depTime,
                    arrDate,
                    arrTime,
                    rs.getDouble("price"),
                    rs.getString("travel_class"),
                    rs.getInt("seats_available")
                );

                flights.add(flight);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return flights;
    }

    public boolean insertFlight(Flight flight) {
        String sql = "INSERT INTO flights (flight_id, from_city, to_city, departure_date, departure_time, " +
                     "arrival_date, arrival_time, price, travel_class, seats_available) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, flight.getFlightId());
            ps.setString(2, flight.getFromCity());
            ps.setString(3, flight.getToCity());

            if (flight.getDepartureDate() != null)
                ps.setDate(4, Date.valueOf(flight.getDepartureDate()));
            else
                ps.setNull(4, Types.DATE);

            if (flight.getDepartureTime() != null)
                ps.setTime(5, Time.valueOf(flight.getDepartureTime()));
            else
                ps.setNull(5, Types.TIME);

            if (flight.getArrivalDate() != null)
                ps.setDate(6, Date.valueOf(flight.getArrivalDate()));
            else
                ps.setNull(6, Types.DATE);

            if (flight.getArrivalTime() != null)
                ps.setTime(7, Time.valueOf(flight.getArrivalTime()));
            else
                ps.setNull(7, Types.TIME);

            ps.setDouble(8, flight.getPrice());
            ps.setString(9, flight.getTravelClass());
            ps.setInt(10, flight.getSeatsAvailable());

            return ps.executeUpdate() == 1;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Flight findFlightById(String flightId) {
        String sql = "SELECT flight_id, from_city, to_city, departure_date, departure_time, " +
                     "arrival_date, arrival_time, price, travel_class, seats_available " +
                     "FROM flights WHERE flight_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, flightId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    LocalDate depDate = null;
                    LocalTime depTime = null;
                    LocalDate arrDate = null;
                    LocalTime arrTime = null;

                    Date sqlDepDate = rs.getDate("departure_date");
                    Time sqlDepTime = rs.getTime("departure_time");
                    Date sqlArrDate = rs.getDate("arrival_date");
                    Time sqlArrTime = rs.getTime("arrival_time");

                    if (sqlDepDate != null) depDate = sqlDepDate.toLocalDate();
                    if (sqlDepTime != null) depTime = sqlDepTime.toLocalTime();
                    if (sqlArrDate != null) arrDate = sqlArrDate.toLocalDate();
                    if (sqlArrTime != null) arrTime = sqlArrTime.toLocalTime();

                    return new Flight(
                        rs.getString("flight_id"),
                        rs.getString("from_city"),
                        rs.getString("to_city"),
                        depDate,
                        depTime,
                        arrDate,
                        arrTime,
                        rs.getDouble("price"),
                        rs.getString("travel_class"),
                        rs.getInt("seats_available")
                    );
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}
