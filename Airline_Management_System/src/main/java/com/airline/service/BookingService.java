package com.airline.service;

import com.airline.model.Booking;
import com.airline.model.Flight;
import com.airline.config.DbConfig;
import java.sql.*;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

public class BookingService {
    private FlightService flightService = new FlightService();

    // Create a new booking
    public boolean createBooking(int userId, String flightId, int numOfPassengers) {
        String sql = "INSERT INTO bookings (user_id, flight_id, booking_date, amount, status) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            Flight flight = flightService.getFlightById(flightId);
            if (flight == null) return false;
            
            double totalAmount = flight.getPrice() * numOfPassengers;
            
            stmt.setInt(1, userId);
            stmt.setString(2, flightId);
            stmt.setDate(3, Date.valueOf(LocalDate.now()));
            stmt.setDouble(4, totalAmount);
            stmt.setString(5, "CONFIRMED");
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return true;
                    }
                }
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all bookings for a user
    public List<Booking> getUserBookings(int userId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE user_id = ? ORDER BY booking_date DESC";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Booking booking = new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getString("flight_id"),
                    rs.getDate("booking_date").toLocalDate(),
                    rs.getDouble("amount"),
                    rs.getString("status")
                );
                bookings.add(booking);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Get booking details
    public Map<String, Object> getBookingDetails(int bookingId) {
        Map<String, Object> details = new HashMap<>();
        String sql = "SELECT b.*, f.from_city, f.to_city, f.departure_date, f.departure_time, f.travel_class " +
                     "FROM bookings b JOIN flights f ON b.flight_id = f.flight_id " +
                     "WHERE b.booking_id = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                details.put("bookingId", rs.getInt("booking_id"));
                details.put("flightId", rs.getString("flight_id"));
                details.put("fromCity", rs.getString("from_city"));
                details.put("toCity", rs.getString("to_city"));
                details.put("departureDate", rs.getDate("departure_date"));
                details.put("departureTime", rs.getTime("departure_time"));
                details.put("travelClass", rs.getString("travel_class"));
                details.put("amount", rs.getDouble("amount"));
                details.put("status", rs.getString("status"));
                details.put("bookingDate", rs.getDate("booking_date"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return details;
    }

    // Cancel a booking
    public boolean cancelBooking(int bookingId) {
        String sql = "UPDATE bookings SET status = 'CANCELLED' WHERE booking_id = ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, bookingId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}