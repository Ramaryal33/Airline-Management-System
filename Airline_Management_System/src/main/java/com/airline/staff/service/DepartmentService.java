package com.airline.staff.service;

import com.airline.staff.model.Department;
import com.airline.config.DbConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DepartmentService {

    public List<Department> getAllDepartments() {
        List<Department> list = new ArrayList<>();
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM departments");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Department d = new Department();
                d.setDepartmentId(rs.getInt("department_id"));
                d.setName(rs.getString("name"));
                d.setDescription(rs.getString("description"));
                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addDepartment(Department dept) {
        String sql = "INSERT INTO departments (name, description) VALUES (?, ?)";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, dept.getName());
            stmt.setString(2, dept.getDescription());
            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateDepartment(Department dept) {
        String sql = "UPDATE departments SET name = ?, description = ? WHERE department_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, dept.getName());
            stmt.setString(2, dept.getDescription());
            stmt.setInt(3, dept.getDepartmentId());
            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteDepartmentById(int id) {
        String sql = "DELETE FROM departments WHERE department_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Department getDepartmentById(int id) {
        String sql = "SELECT * FROM departments WHERE department_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Department d = new Department();
                d.setDepartmentId(rs.getInt("department_id"));
                d.setName(rs.getString("name"));
                d.setDescription(rs.getString("description"));
                return d;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
