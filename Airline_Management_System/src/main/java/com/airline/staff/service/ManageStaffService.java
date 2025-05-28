package com.airline.staff.service;

import com.airline.model.ManageStaffModel;
import com.airline.config.DbConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ManageStaffService {

    // Add new staff member
    public boolean addStaff(ManageStaffModel staff) {
        String sql = "INSERT INTO staff (first_name, last_name, email, phone, position, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, staff.getFirstName());
            stmt.setString(2, staff.getLastName());
            stmt.setString(3, staff.getEmail());
            stmt.setString(4, staff.getPhone());
            stmt.setString(5, staff.getPosition());
            stmt.setString(6, staff.getStatus());
            stmt.setTimestamp(7, new java.sql.Timestamp(System.currentTimeMillis())); // created_at
            stmt.setTimestamp(8, new java.sql.Timestamp(System.currentTimeMillis())); // updated_at

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete staff member by staffId
    public boolean deleteStaff(int staffId) {
        String sql = "DELETE FROM staff WHERE staffId = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, staffId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all staff members
    public List<ManageStaffModel> getAllStaff() {
        List<ManageStaffModel> staffList = new ArrayList<>();
        String sql = "SELECT * FROM staff";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ManageStaffModel staff = new ManageStaffModel();
                staff.setStaffId(rs.getInt("staffId"));
                staff.setFirstName(rs.getString("first_name"));
                staff.setLastName(rs.getString("last_name"));
                staff.setEmail(rs.getString("email"));
                staff.setPhone(rs.getString("phone"));
                staff.setPosition(rs.getString("position"));
                staff.setStatus(rs.getString("status"));
                staff.setCreatedAt(rs.getTimestamp("created_at"));
                staff.setUpdatedAt(rs.getTimestamp("updated_at"));
                staffList.add(staff);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList;
    }

    // Get staff by ID for editing
    public ManageStaffModel getStaffById(int staffId) {
        ManageStaffModel staff = null;
        String sql = "SELECT * FROM staff WHERE staffId = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, staffId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                staff = new ManageStaffModel();
                staff.setStaffId(rs.getInt("staffId"));
                staff.setFirstName(rs.getString("first_name"));
                staff.setLastName(rs.getString("last_name"));
                staff.setEmail(rs.getString("email"));
                staff.setPhone(rs.getString("phone"));
                staff.setPosition(rs.getString("position"));
                staff.setStatus(rs.getString("status"));
                staff.setCreatedAt(rs.getTimestamp("created_at"));
                staff.setUpdatedAt(rs.getTimestamp("updated_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staff;
    }

    // Update staff information
    public boolean updateStaff(ManageStaffModel staff) {
        String sql = "UPDATE staff SET first_name = ?, last_name = ?, email = ?, phone = ?, position = ?, status = ?, updated_at = ? WHERE staffId = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, staff.getFirstName());
            stmt.setString(2, staff.getLastName());
            stmt.setString(3, staff.getEmail());
            stmt.setString(4, staff.getPhone());
            stmt.setString(5, staff.getPosition());
            stmt.setString(6, staff.getStatus());
            stmt.setTimestamp(7, new java.sql.Timestamp(System.currentTimeMillis())); // updated_at
            stmt.setInt(8, staff.getStaffId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
