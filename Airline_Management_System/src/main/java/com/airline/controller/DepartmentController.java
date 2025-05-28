package com.airline.controller;

import com.airline.config.DbConfig;
import com.airline.staff.model.Department;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@SuppressWarnings("serial")
@WebServlet("/staffDepartment")
public class DepartmentController extends HttpServlet {
    private static final Logger logger = Logger.getLogger(DepartmentController.class.getName());

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        String message = "";

        switch (action) {
            case "add":
                handleAdd(req);
                break;
            case "edit":
                handleEdit(req);
                break;
            case "update":
                handleUpdate(req);
                break;
            case "delete":
                handleDelete(req);
                break;
        }

        loadDepartments(req);
        req.getRequestDispatcher("/WEB-INF/page/staffDepartment.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        loadDepartments(req);
        req.getRequestDispatcher("/WEB-INF/page/staffDepartment.jsp").forward(req, resp);
    }

    private void handleAdd(HttpServletRequest req) {
        String name = req.getParameter("departmentName");
        String description = req.getParameter("departmentDescription");

        String sql = "INSERT INTO departments (name, description) VALUES (?, ?)";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, description);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                req.setAttribute("successMessage", "Department added successfully.");
            } else {
                req.setAttribute("errorMessage", "Failed to add department.");
            }

        } catch (SQLException e) {
            logger.severe("SQL error while inserting department: " + e.getMessage());
            req.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }
    }

    private void handleEdit(HttpServletRequest req) {
        int departmentId = Integer.parseInt(req.getParameter("departmentId"));

        String sql = "SELECT * FROM departments WHERE department_id = ?";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, departmentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Department dept = new Department();
                dept.setDepartmentId(rs.getInt("department_id"));
                dept.setName(rs.getString("name"));
                dept.setDescription(rs.getString("description"));
                req.setAttribute("departmentToEdit", dept);
            }

        } catch (SQLException e) {
            logger.severe("SQL error while fetching department for edit: " + e.getMessage());
            req.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }
    }

    private void handleUpdate(HttpServletRequest req) {
        int departmentId = Integer.parseInt(req.getParameter("departmentId"));
        String name = req.getParameter("departmentName");
        String description = req.getParameter("departmentDescription");

        String sql = "UPDATE departments SET name = ?, description = ? WHERE department_id = ?";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, description);
            stmt.setInt(3, departmentId);

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                req.setAttribute("successMessage", "Department updated successfully.");
            } else {
                req.setAttribute("errorMessage", "Failed to update department.");
            }

        } catch (SQLException e) {
            logger.severe("SQL error while updating department: " + e.getMessage());
            req.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }
    }

    private void handleDelete(HttpServletRequest req) {
        int departmentId = Integer.parseInt(req.getParameter("departmentId"));

        String sql = "DELETE FROM departments WHERE department_id = ?";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, departmentId);
            int rows = stmt.executeUpdate();

            if (rows > 0) {
                req.setAttribute("successMessage", "Department deleted successfully.");
            } else {
                req.setAttribute("errorMessage", "Failed to delete department.");
            }

        } catch (SQLException e) {
            logger.severe("SQL error while deleting department: " + e.getMessage());
            req.setAttribute("errorMessage", "Database error: " + e.getMessage());
        }
    }

    private void loadDepartments(HttpServletRequest req) {
        List<Department> departmentList = new ArrayList<>();
        String query = "SELECT * FROM departments";

        try (Connection conn = DbConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Department dept = new Department(
                        rs.getInt("department_id"),
                        rs.getString("name"),
                        rs.getString("description")
                );
                departmentList.add(dept);
            }
            req.setAttribute("departmentList", departmentList);

        } catch (SQLException e) {
            logger.severe("SQL error while fetching departments: " + e.getMessage());
            req.setAttribute("errorMessage", "Error fetching departments.");
        }
    }
}
