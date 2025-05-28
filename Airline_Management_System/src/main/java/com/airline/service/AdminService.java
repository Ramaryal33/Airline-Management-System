package com.airline.service;

import com.airline.config.DbConfig;
import com.airline.model.Admin;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminService {

    // Fetch all active admins
    public List<Admin> getAllAdmins() {
        List<Admin> admins = new ArrayList<>();
        String sql = "SELECT id, FullName, Email, Password AS passwordHash, userType AS role " +
                     "FROM users WHERE userType = 'admin' AND Active = 1";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Admin a = new Admin();
                a.setAdminId(rs.getInt("id"));
                a.setFullName(rs.getString("FullName"));
                a.setEmail(rs.getString("Email"));
                a.setPasswordHash(rs.getString("passwordHash"));
                a.setRole(rs.getString("role"));
                admins.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admins;
    }

    // Fetch one admin by ID
    public Admin getAdminById(int id) {
        Admin admin = null;
        String sql = "SELECT id, FullName, Email, Password AS passwordHash, userType AS role " +
                     "FROM users WHERE id = ? AND userType = 'admin' AND Active = 1";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    admin = new Admin();
                    admin.setAdminId(rs.getInt("id"));
                    admin.setFullName(rs.getString("FullName"));
                    admin.setEmail(rs.getString("Email"));
                    admin.setPasswordHash(rs.getString("passwordHash"));
                    admin.setRole(rs.getString("role"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admin;
    }

    // Create a new admin user
    public void createAdmin(Admin admin) {
        String sql = "INSERT INTO users (FullName, Email, Password, userType, Active) " +
                     "VALUES (?, ?, ?, 'admin', 1)";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, admin.getFullName());
            ps.setString(2, admin.getEmail());
            ps.setString(3, admin.getPasswordHash());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update an existing admin; if password empty, do not change it
    public void updateAdmin(Admin admin) {
        String sqlWithPassword = "UPDATE users SET FullName = ?, Email = ?, Password = ? WHERE id = ? AND userType = 'admin' AND Active = 1";
        String sqlNoPassword   = "UPDATE users SET FullName = ?, Email = ? WHERE id = ? AND userType = 'admin' AND Active = 1";

        try (Connection conn = DbConfig.getConnection()) {
            PreparedStatement ps;
            if (admin.getPasswordHash() != null && !admin.getPasswordHash().isEmpty()) {
                ps = conn.prepareStatement(sqlWithPassword);
                ps.setString(1, admin.getFullName());
                ps.setString(2, admin.getEmail());
                ps.setString(3, admin.getPasswordHash());
                ps.setInt(4, admin.getAdminId());
            } else {
                ps = conn.prepareStatement(sqlNoPassword);
                ps.setString(1, admin.getFullName());
                ps.setString(2, admin.getEmail());
                ps.setInt(3, admin.getAdminId());
            }
            ps.executeUpdate();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Soft-delete an admin user by setting Active=0
    public void deleteAdmin(int id) {
        String sql = "UPDATE users SET Active = 0 WHERE id = ? AND userType = 'admin'";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
