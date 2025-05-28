package com.airline.controller;

import com.airline.staff.model.Staff;
import com.airline.staff.service.StaffService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@SuppressWarnings("serial")
@WebServlet("/staffDashboard")
public class StaffDashboardController extends HttpServlet {
    private final StaffService staffService = new StaffService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Staff> staffList = staffService.getAllStaff();
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("/WEB-INF/page/staffDashboard.jsp").forward(request, response);
    }
}
