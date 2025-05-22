package com.airline.controller;

import com.airline.staff.service.ManageStaffService;
import com.airline.model.ManageStaffModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;


public class ManageStaffController extends HttpServlet {
    private final ManageStaffService staffService = new ManageStaffService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("edit".equalsIgnoreCase(action)) {
            int staffId = Integer.parseInt(request.getParameter("staffId"));
            ManageStaffModel staff = staffService.getStaffById(staffId);
            request.setAttribute("staff", staff);
            request.getRequestDispatcher("/WEB-INF/page/manageStaff.jsp").forward(request, response);
            return;
        }

        // Fetch all staff members and forward to JSP page
        List<ManageStaffModel> staffList = staffService.getAllStaff();
        request.setAttribute("staffList", staffList);
        request.getRequestDispatcher("/WEB-INF/page/manageStaff.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        boolean success = false;

        try {
            if ("add".equalsIgnoreCase(action)) {
                ManageStaffModel staff = new ManageStaffModel();
                staff.setFirstName(request.getParameter("firstName"));
                staff.setLastName(request.getParameter("lastName"));
                staff.setEmail(request.getParameter("email"));
                staff.setPhone(request.getParameter("phone"));
                staff.setPosition(request.getParameter("position"));
                staff.setStatus(request.getParameter("status"));

                success = staffService.addStaff(staff);
            } else if ("edit".equalsIgnoreCase(action)) {
                ManageStaffModel staff = new ManageStaffModel();
                staff.setStaffId(Integer.parseInt(request.getParameter("staffId")));
                staff.setFirstName(request.getParameter("firstName"));
                staff.setLastName(request.getParameter("lastName"));
                staff.setEmail(request.getParameter("email"));
                staff.setPhone(request.getParameter("phone"));
                staff.setPosition(request.getParameter("position"));
                staff.setStatus(request.getParameter("status"));

                success = staffService.updateStaff(staff);
            } else if ("delete".equalsIgnoreCase(action)) {
                int staffId = Integer.parseInt(request.getParameter("staffId"));
                success = staffService.deleteStaff(staffId);
            }

            if (success) {
                response.sendRedirect("manageStaff");
            } else {
                request.setAttribute("error", "Action failed");
                doGet(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error processing request");
            doGet(request, response);
        }
    }
}
