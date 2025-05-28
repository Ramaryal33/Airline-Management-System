package com.airline.controller;

import com.airline.model.ManageStaffModel;
import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

//@WebServlet("/manageStaff")
public class ManageStaffController extends HttpServlet {

    private Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/airline management";
        String user = "root";
        String password = ""; // replace with your DB password
        return DriverManager.getConnection(url, user, password);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try (Connection conn = getConnection()) {

            if ("edit".equalsIgnoreCase(action)) {
                int staffId = Integer.parseInt(request.getParameter("staffId"));
                String sql = "SELECT * FROM staff WHERE staffId = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, staffId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    ManageStaffModel staff = new ManageStaffModel();
                    staff.setStaffId(rs.getInt("staffId"));
                    staff.setFirstName(rs.getString("firstName"));
                    staff.setLastName(rs.getString("lastName"));
                    staff.setEmail(rs.getString("email"));
                    staff.setPhone(rs.getString("phone"));
                    staff.setPosition(rs.getString("position"));
                    staff.setStatus(rs.getString("status"));
                    request.setAttribute("staff", staff);
                }
            } else if ("delete".equalsIgnoreCase(action)) {
                int staffId = Integer.parseInt(request.getParameter("staffId"));
                String sql = "DELETE FROM staff WHERE staffId = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, staffId);
                ps.executeUpdate();
            }

            String sql = "SELECT * FROM staff";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            List<ManageStaffModel> staffList = new ArrayList<>();
            while (rs.next()) {
                ManageStaffModel staff = new ManageStaffModel();
                staff.setStaffId(rs.getInt("staffId"));
                staff.setFirstName(rs.getString("firstName"));
                staff.setLastName(rs.getString("lastName"));
                staff.setEmail(rs.getString("email"));
                staff.setPhone(rs.getString("phone"));
                staff.setPosition(rs.getString("position"));
                staff.setStatus(rs.getString("status"));
                staffList.add(staff);
            }
            request.setAttribute("staffList", staffList);
            request.getRequestDispatcher("/WEB-INF/page/manageStaff.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try (Connection conn = getConnection()) {

            String sql;
            PreparedStatement ps;

            if ("edit".equalsIgnoreCase(action)) {
                sql = "UPDATE staff SET firstName=?, lastName=?, email=?, phone=?, position=?, status=? WHERE staffId=?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, request.getParameter("firstName"));
                ps.setString(2, request.getParameter("lastName"));
                ps.setString(3, request.getParameter("email"));
                ps.setString(4, request.getParameter("phone"));
                ps.setString(5, request.getParameter("position"));
                ps.setString(6, request.getParameter("status"));
                ps.setInt(7, Integer.parseInt(request.getParameter("staffId")));
            } else {
                sql = "INSERT INTO staff (firstName, lastName, email, phone, position, status) VALUES (?, ?, ?, ?, ?, ?)";
                ps = conn.prepareStatement(sql);
                ps.setString(1, request.getParameter("firstName"));
                ps.setString(2, request.getParameter("lastName"));
                ps.setString(3, request.getParameter("email"));
                ps.setString(4, request.getParameter("phone"));
                ps.setString(5, request.getParameter("position"));
                ps.setString(6, request.getParameter("status"));
            }

            ps.executeUpdate();
            response.sendRedirect("manageStaff");

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
