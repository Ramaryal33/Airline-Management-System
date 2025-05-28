package com.airline.staff.service;

import com.airline.config.DbConfig;
import com.airline.staff.model.Staff;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StaffService {

    public List<Staff> getAllStaff() {
        List<Staff> staffList = new ArrayList<>();
        String sql = "SELECT * FROM staff";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                staffList.add(mapResultSetToStaff(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList;
    }

    public boolean addStaff(Staff staff) {
        String sql = "INSERT INTO staff (user_id, first_name, last_name, email, phone, position, department_id, hire_date, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, staff.getUserId());
            stmt.setString(2, staff.getFirstName());
            stmt.setString(3, staff.getLastName());
            stmt.setString(4, staff.getEmail());
            stmt.setString(5, staff.getPhone());
            stmt.setString(6, staff.getPosition());
            stmt.setInt(7, staff.getDepartmentId());
            stmt.setDate(8, staff.getHireDate());
            stmt.setString(9, staff.getStatus());
            stmt.setTimestamp(10, staff.getCreatedAt());
            stmt.setTimestamp(11, staff.getUpdatedAt());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateStaff(Staff staff) {
        String sql = "UPDATE staff SET user_id = ?, first_name = ?, last_name = ?, email = ?, phone = ?, position = ?, department_id = ?, hire_date = ?, status = ?, updated_at = ? WHERE staff_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, staff.getUserId());
            stmt.setString(2, staff.getFirstName());
            stmt.setString(3, staff.getLastName());
            stmt.setString(4, staff.getEmail());
            stmt.setString(5, staff.getPhone());
            stmt.setString(6, staff.getPosition());
            stmt.setInt(7, staff.getDepartmentId());
            stmt.setDate(8, staff.getHireDate());
            stmt.setString(9, staff.getStatus());
            stmt.setTimestamp(10, staff.getUpdatedAt());
            stmt.setInt(11, staff.getStaffId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteStaffById(int staffId) {
        String sql = "DELETE FROM staff WHERE staff_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, staffId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Staff getStaffById(int staffId) {
        String sql = "SELECT * FROM staff WHERE staff_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, staffId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToStaff(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Staff mapResultSetToStaff(ResultSet rs) throws SQLException {
        Staff staff = new Staff();
        staff.setStaffId(rs.getInt("staff_id"));
        staff.setUserId(rs.getInt("user_id"));
        staff.setFirstName(rs.getString("first_name"));
        staff.setLastName(rs.getString("last_name"));
        staff.setEmail(rs.getString("email"));
        staff.setPhone(rs.getString("phone"));
        staff.setPosition(rs.getString("position"));
        staff.setDepartmentId(rs.getInt("department_id"));
        staff.setHireDate(rs.getDate("hire_date"));
        staff.setStatus(rs.getString("status"));
        staff.setCreatedAt(rs.getTimestamp("created_at"));
        staff.setUpdatedAt(rs.getTimestamp("updated_at"));
        return staff;
    }
}
