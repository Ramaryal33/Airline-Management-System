package com.airline.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/adminDashboard")
public class AdminDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // JDBC credentials & URL — adjust as needed
    private static final String JDBC_URL      = "jdbc:mysql://localhost:3306/airline_management";
    private static final String JDBC_USER     = "root";
    private static final String JDBC_PASSWORD = "";

    public AdminDashboardController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int totalFlights   = 0;
        int totalBookings  = 0;
        double totalRevenue = 0.0;
        int totalUsers     = 0;

        try {
            // 1) Load driver & open connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            Statement stmt   = conn.createStatement();

            // 2) Fetch flight count
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM flights");
            if (rs.next()) totalFlights = rs.getInt("cnt");
            rs.close();

            // 3) Fetch booking count & revenue sum
            rs = stmt.executeQuery(
                "SELECT COUNT(*) AS cnt, IFNULL(SUM(amount),0) AS rev FROM bookings"
            );
            if (rs.next()) {
                totalBookings = rs.getInt("cnt");
                totalRevenue  = rs.getDouble("rev");
            }
            rs.close();

            // 4) Fetch registered user count
            rs = stmt.executeQuery(
                "SELECT COUNT(*) AS cnt FROM users WHERE userType = 'user'"
            );
            if (rs.next()) totalUsers = rs.getInt("cnt");
            rs.close();

            // 5) Clean up
            stmt.close();
            conn.close();

        } catch (Exception e) {
            // For debugging — consider logging instead
            e.printStackTrace();
        }

        // 6) Bind to request for the JSP
        request.setAttribute("totalFlights", totalFlights);
        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("totalUsers", totalUsers);

        // Also keep your existing attributes
        request.setAttribute("pageTitle", "Admin Dashboard - Dawn Airlines");
        request.setAttribute("cssPath", request.getContextPath() + "/css/style.css");
        request.setAttribute("basePath", request.getContextPath());

        // 7) Forward to JSP
        request.getRequestDispatcher("/WEB-INF/page/adminDashboard.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
