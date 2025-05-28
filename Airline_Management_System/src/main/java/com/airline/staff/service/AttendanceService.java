package com.airline.staff.service;

import com.airline.config.DbConfig;
import com.airline.staff.model.Attendance;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttendanceService {

    public void addAttendance(Attendance a) {
        String sql = "INSERT INTO attendance (staff_id, date, clock_in, clock_out, status, working_hours, remarks) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, a.getStaffId());
            stmt.setDate(2, a.getDate());
            stmt.setTime(3, a.getClockIn());
            stmt.setTime(4, a.getClockOut());
            stmt.setString(5, a.getStatus());
            stmt.setDouble(6, a.getWorkingHours());
            stmt.setString(7, a.getRemarks());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateAttendance(Attendance a) {
        String sql = "UPDATE attendance SET staff_id=?, date=?, clock_in=?, clock_out=?, status=?, working_hours=?, remarks=? WHERE attendance_id=?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, a.getStaffId());
            stmt.setDate(2, a.getDate());
            stmt.setTime(3, a.getClockIn());
            stmt.setTime(4, a.getClockOut());
            stmt.setString(5, a.getStatus());
            stmt.setDouble(6, a.getWorkingHours());
            stmt.setString(7, a.getRemarks());
            stmt.setInt(8, a.getAttendanceId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteAttendance(int id) {
        String sql = "DELETE FROM attendance WHERE attendance_id=?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Attendance getAttendanceById(int id) {
        String sql = "SELECT * FROM attendance WHERE attendance_id=?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapAttendance(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Attendance> getAllAttendance() {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance";
        try (Connection conn = DbConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapAttendance(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
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
        return a;
    }
}
