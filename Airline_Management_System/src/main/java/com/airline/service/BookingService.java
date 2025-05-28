package com.airline.service;

import com.airline.model.Booking;
import com.airline.config.DbConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingService {

    public boolean addBooking(Booking booking) {
        String sql = "INSERT INTO bookings (user_id, flight_id, booking_date, amount, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, booking.getUserId());
            stmt.setString(2, booking.getFlightId());
            stmt.setDate(3, new java.sql.Date(booking.getBookingDate().getTime()));
            stmt.setDouble(4, booking.getAmount());
            stmt.setString(5, booking.getStatus());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateBooking(Booking booking) {
        String sql = "UPDATE bookings SET user_id = ?, flight_id = ?, booking_date = ?, amount = ?, status = ? WHERE booking_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, booking.getUserId());
            stmt.setString(2, booking.getFlightId());
            stmt.setDate(3, new java.sql.Date(booking.getBookingDate().getTime()));
            stmt.setDouble(4, booking.getAmount());
            stmt.setString(5, booking.getStatus());
            stmt.setInt(6, booking.getBookingId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteBooking(int bookingId) {
        String sql = "DELETE FROM bookings WHERE booking_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, u.FullName AS user_name, f.from_city, f.to_city " +
                     "FROM bookings b " +
                     "JOIN users u ON b.user_id = u.ID " +
                     "JOIN flights f ON b.flight_id = f.flight_id";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setFlightId(rs.getString("flight_id"));
                booking.setBookingDate(rs.getDate("booking_date"));
                booking.setAmount(rs.getDouble("amount"));
                booking.setStatus(rs.getString("status"));

                // Extra fields for display
                booking.setUserFullName(rs.getString("user_name"));
                booking.setFlightRoute(rs.getString("from_city") + " → " + rs.getString("to_city"));

                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public Booking getBookingById(int bookingId) {
        String sql = "SELECT * FROM bookings WHERE booking_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setFlightId(rs.getString("flight_id"));
                booking.setBookingDate(rs.getDate("booking_date"));
                booking.setAmount(rs.getDouble("amount"));
                booking.setStatus(rs.getString("status"));
                return booking;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
