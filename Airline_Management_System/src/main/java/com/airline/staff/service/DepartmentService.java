package com.airline.staff.service;

import com.airline.config.DbConfig;
import com.airline.staff.model.Department;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class DepartmentService {
    private static final Logger logger = Logger.getLogger(DepartmentService.class.getName());

    // INSERT department (only if it doesn't exist)
    public boolean addDepartment(Department department) throws SQLException {
        String checkSql = "SELECT * FROM departments WHERE department_id = ?";
        String insertSql = "INSERT INTO departments (department_id, dname, description) VALUES (?, ?, ?)";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {

            checkStmt.setInt(1, department.getDepartmentId());
            ResultSet rs = checkStmt.executeQuery();

            if (!rs.next()) {
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, department.getDepartmentId());
                    insertStmt.setString(2, department.getDname());
                    insertStmt.setString(3, department.getDescription());
                    return insertStmt.executeUpdate() > 0;
                }
            } else {
                logger.info("Department already exists with ID: " + department.getDepartmentId());
                return false;
            }
        }
    }

    // GET ALL departments
    public List<Department> getAllDepartments() {
        List<Department> list = new ArrayList<>();
        String sql = "SELECT * FROM departments";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Department dept = new Department();
                dept.setDepartmentId(rs.getInt("department_id"));
                dept.setDname(rs.getString("dname"));
                dept.setDescription(rs.getString("description"));
                list.add(dept);
            }

        } catch (SQLException e) {
            logger.severe("Error fetching departments: " + e.getMessage());
        }

        return list;
    }

    // Optional: DELETE by ID
    public boolean deleteDepartment(int departmentId) {
        String sql = "DELETE FROM departments WHERE department_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, departmentId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            logger.severe("Error deleting department: " + e.getMessage());
            return false;
        }
    }

    // Optional: UPDATE department
    public boolean updateDepartment(Department department) {
        String sql = "UPDATE departments SET dname = ?, description = ? WHERE department_id = ?";
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, department.getDname());
            stmt.setString(2, department.getDescription());
            stmt.setInt(3, department.getDepartmentId());
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            logger.severe("Error updating department: " + e.getMessage());
            return false;
        }
    }
}
