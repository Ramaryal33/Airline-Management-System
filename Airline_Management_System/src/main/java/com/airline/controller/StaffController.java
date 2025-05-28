package com.airline.controller;

import com.airline.staff.model.Staff;
import com.airline.staff.service.StaffService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@SuppressWarnings("serial")
@WebServlet("/staff")
public class StaffController extends HttpServlet {

    private final StaffService staffService = new StaffService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("edit".equalsIgnoreCase(action)) {
            int staffId = Integer.parseInt(request.getParameter("staffId"));
            Staff staff = staffService.getStaffById(staffId);
            request.setAttribute("staff", staff);
        } else if ("delete".equalsIgnoreCase(action)) {
            int staffId = Integer.parseInt(request.getParameter("staffId"));
            staffService.deleteStaffById(staffId);
        }

        List<Staff> staffList = staffService.getAllStaff();
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("/WEB-INF/page/staff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        boolean success;

        Staff staff = new Staff();

        String staffIdStr = request.getParameter("staffId");
        if (staffIdStr != null && !staffIdStr.isEmpty()) {
            staff.setStaffId(Integer.parseInt(staffIdStr));
        }

        staff.setUserId(Integer.parseInt(request.getParameter("userId")));
        staff.setFirstName(request.getParameter("firstName"));
        staff.setLastName(request.getParameter("lastName"));
        staff.setEmail(request.getParameter("email"));
        staff.setPhone(request.getParameter("phone"));
        staff.setPosition(request.getParameter("position"));
        staff.setDepartmentId(Integer.parseInt(request.getParameter("departmentId")));
        staff.setHireDate(Date.valueOf(request.getParameter("hireDate")));
        staff.setStatus(request.getParameter("status"));

        Timestamp now = Timestamp.valueOf(LocalDateTime.now());
        staff.setUpdatedAt(now);

        if ("add".equalsIgnoreCase(action)) {
            staff.setCreatedAt(now);
            success = staffService.addStaff(staff);
        } else {
            success = staffService.updateStaff(staff);
        }

        if (success) {
            request.setAttribute("successMessage", "Operation successful.");
        } else {
            request.setAttribute("errorMessage", "Operation failed.");
        }

        List<Staff> staffList = staffService.getAllStaff();
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("/WEB-INF/page/staff.jsp").forward(request, response);
    }
}
