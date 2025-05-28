package com.airline.staff.service;

import com.airline.config.DbConfig;
import com.airline.staff.model.Attendance;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttendanceService {

    // ... existing methods ...

    /**
     * Get attendance records for a specific staff member within a date range
     */
    public List<Attendance> getAttendanceByDateRange(int staffId, Date startDate, Date endDate) {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE staff_id = ? AND date BETWEEN ? AND ? ORDER BY date DESC";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, staffId);
            stmt.setDate(2, startDate);
            stmt.setDate(3, endDate);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapAttendance(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Get total working hours for all staff within a date range
     */
    public double getTotalHoursForAllStaff(Date startDate, Date endDate) {
        String sql = "SELECT SUM(working_hours) FROM attendance WHERE status = 'Present' AND date BETWEEN ? AND ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setDate(1, startDate);
            stmt.setDate(2, endDate);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    /**
     * Get total working hours for a specific staff member within a date range
     */
    public double getTotalHoursForStaff(int staffId, Date startDate, Date endDate) {
        String sql = "SELECT SUM(working_hours) FROM attendance WHERE staff_id = ? AND status = 'Present' AND date BETWEEN ? AND ?";
        
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, staffId);
            stmt.setDate(2, startDate);
            stmt.setDate(3, endDate);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    private Attendance mapAttendance(ResultSet rs) throws SQLException {
        Attendance a = new Attendance();
        a.setAttendanceId(rs.getInt("attendance_id"));
        a.setStaffId(rs.getInt("staff_id"));
        a.setDate(rs.getDate("date"));
        a.setClockIn(rs.getTime("clock_in"));
        a.setClockOut(rs.getTime("clock_out"));
        a.setStatus(rs.getString("status"));
        a.setWorkingHours(rs.getDouble("working_hours"));
        a.setRemarks(rs.getString("remarks"));
        a.setCreatedAt(rs.getTimestamp("created_at"));
        a.setUpdatedAt(rs.getTimestamp("updated_at"));
        return a;
    }
}