package com.airline.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConfig {
    private static final String URL = "jdbc:mysql://localhost:3306/airline management"; // Replace with your actual URL
    private static final String USERNAME = "root";             // Replace with your actual username
    private static final String PASSWORD = "";             // Replace with your actual password

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL driver
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found: " + e.getMessage());
            throw new RuntimeException("Failed to load JDBC driver", e); // Throw a RuntimeException to halt application startup
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    public static void main(String[] args) {
        try (Connection conn = DbConfig.getConnection()) {
            if (conn != null) {
                System.out.println("Successfully connected to the database!");
            } else {
                System.out.println("Connection failed.");
            }
        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}