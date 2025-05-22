package com.airline.controller;

import com.airline.config.DbConfig;
import com.airline.staff.model.*;
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
        if ("add".equals(action)) {
            int departmentId = Integer.parseInt(req.getParameter("departmentId"));
            String dname = req.getParameter("departmentName");
            String description = req.getParameter("departmentDescription");

            try (Connection conn = DbConfig.getConnection()) {
                // Check if department exists
                String checkSql = "SELECT * FROM departments WHERE department_id = ?";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                    checkStmt.setInt(1, departmentId);
                    ResultSet rs = checkStmt.executeQuery();

                    if (!rs.next()) {
                        // Insert department
                        String insertSql = "INSERT INTO departments (department_id, dname, description) VALUES (?, ?, ?)";
                        try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                            insertStmt.setInt(1, departmentId);
                            insertStmt.setString(2, dname);
                            insertStmt.setString(3, description);
                            insertStmt.executeUpdate();
                            req.setAttribute("successMessage", "Department inserted successfully.");
                        }
                    } else {
                        req.setAttribute("errorMessage", "Department with ID " + departmentId + " already exists.");
                    }
                }

            } catch (SQLException e) {
                logger.severe("SQL error while inserting department: " + e.getMessage());
                req.setAttribute("errorMessage", "Database error: " + e.getMessage());
            }
        }

        // Load all departments after add
        loadDepartments(req);
        req.getRequestDispatcher("/WEB-INF/page/staffDepartment.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        loadDepartments(req);
        req.getRequestDispatcher("/WEB-INF/page/staffDepartment.jsp").forward(req, resp);
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
                        rs.getString("dname"),
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
