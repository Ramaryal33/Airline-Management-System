package com.airline.controller;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/adminDashboard")
public class AdminDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/airline_management";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("flight".equalsIgnoreCase(action)) {
            request.getRequestDispatcher("/WEB-INF/page/flightManagement.jsp").forward(request, response);
            return;
        }

        int totalFlights = 0;
        int totalBookings = 0;
        double totalRevenue = 0.0;
        int totalUsers = 0;

        List<Map<String, Object>> recentBookings = new ArrayList<>();
        List<String> revenueLabels = new ArrayList<>();
        List<Double> revenueData = new ArrayList<>();
        List<Integer> flightStatusData = Arrays.asList(0, 0, 0, 0); // On Time, Delayed, Cancelled, Completed

        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             Statement stmt = conn.createStatement()) {

            Class.forName("com.mysql.cj.jdbc.Driver");

            // Total counts
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM flights");
            if (rs.next()) totalFlights = rs.getInt("cnt");
            rs.close();

            rs = stmt.executeQuery("SELECT COUNT(*) AS cnt, IFNULL(SUM(amount),0) AS rev FROM bookings");
            if (rs.next()) {
                totalBookings = rs.getInt("cnt");
                totalRevenue = rs.getDouble("rev");
            }
            rs.close();

            rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM users WHERE userType = 'user'");
            if (rs.next()) totalUsers = rs.getInt("cnt");
            rs.close();

            // Recent bookings (join with users and flights for names)
            rs = stmt.executeQuery("""
                SELECT b.booking_id, u.FullName AS user_name, f.from_city, f.to_city, b.amount, b.status, b.booking_date
                FROM bookings b
                JOIN users u ON b.user_id = u.ID
                JOIN flights f ON b.flight_id = f.flight_id
                ORDER BY b.booking_date DESC
                LIMIT 5
            """);
            while (rs.next()) {
                Map<String, Object> booking = new HashMap<>();
                booking.put("id", rs.getInt("booking_id"));
                booking.put("user", rs.getString("user_name"));
                booking.put("route", rs.getString("from_city") + " → " + rs.getString("to_city"));
                booking.put("amount", rs.getDouble("amount"));
                booking.put("status", rs.getString("status"));
                booking.put("date", rs.getDate("booking_date"));
                recentBookings.add(booking);
            }
            rs.close();

            // Revenue for last 30 days
            rs = stmt.executeQuery("""
                SELECT DATE(booking_date) as date, SUM(amount) as total
                FROM bookings
                WHERE booking_date >= CURDATE() - INTERVAL 30 DAY
                GROUP BY DATE(booking_date)
                ORDER BY DATE(booking_date)
            """);
            while (rs.next()) {
                revenueLabels.add(rs.getString("date"));
                revenueData.add(rs.getDouble("total"));
            }
            rs.close();

            // Flight status counts
            rs = stmt.executeQuery("""
                SELECT status, COUNT(*) as count
                FROM bookings
                GROUP BY status
            """);
            Map<String, Integer> statusMap = new HashMap<>();
            while (rs.next()) {
                statusMap.put(rs.getString("status"), rs.getInt("count"));
            }
            // Mapping: On Time, Delayed, Cancelled, Completed
            flightStatusData = Arrays.asList(
                statusMap.getOrDefault("ON TIME", 0),
                statusMap.getOrDefault("DELAYED", 0),
                statusMap.getOrDefault("CANCELLED", 0),
                statusMap.getOrDefault("COMPLETED", 0)
            );

            stmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("totalFlights", totalFlights);
        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalUsers", totalUsers);

        request.setAttribute("recentBookings", recentBookings);
        request.setAttribute("revenueLabels", revenueLabels);
        request.setAttribute("revenueData", revenueData);
        request.setAttribute("flightStatusData", flightStatusData);

        request.getRequestDispatcher("/WEB-INF/page/adminDashboard.jsp").forward(request, response);
    }
}
