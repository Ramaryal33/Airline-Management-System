package com.airline.controller;

import com.airline.staff.model.Attendance;
import com.airline.staff.service.AttendanceService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@SuppressWarnings("serial")
@WebServlet("/staffAttendance")
public class AttendanceController extends HttpServlet {

    private final AttendanceService attendanceService = new AttendanceService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "edit" -> {
                int id = Integer.parseInt(request.getParameter("attendanceId"));
                Attendance a = attendanceService.getAttendanceById(id);
                request.setAttribute("attendance", a);
                List<Attendance> list = attendanceService.getAllAttendance();
                request.setAttribute("attendanceList", list);
                request.getRequestDispatcher("/WEB-INF/page/staffAttendance.jsp").forward(request, response);
            }
            case "delete" -> {
                int id = Integer.parseInt(request.getParameter("attendanceId"));
                attendanceService.deleteAttendance(id);
                response.sendRedirect("staffAttendance");
            }
            default -> {
                List<Attendance> list = attendanceService.getAllAttendance();
                request.setAttribute("attendanceList", list);
                request.getRequestDispatcher("/WEB-INF/page/staffAttendance.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("add".equalsIgnoreCase(action)) {
                Attendance a = new Attendance();
                populateAttendanceFromRequest(a, request);
                attendanceService.addAttendance(a);

            } else if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("attendanceId"));
                Attendance a = attendanceService.getAttendanceById(id);
                populateAttendanceFromRequest(a, request);
                a.setAttendanceId(id);
                attendanceService.updateAttendance(a);
            }
            response.sendRedirect("staffAttendance");

        } catch (Exception e) {
            throw new ServletException("Error processing attendance", e);
        }
    }

    private void populateAttendanceFromRequest(Attendance attendance, HttpServletRequest req)
            throws ServletException {

        try {
            attendance.setStaffId(Integer.parseInt(req.getParameter("staffId")));
            attendance.setDate(Date.valueOf(req.getParameter("date")));

            SimpleDateFormat tf = new SimpleDateFormat("HH:mm");
            attendance.setClockIn(new Time(tf.parse(req.getParameter("clockIn")).getTime()));
            attendance.setClockOut(new Time(tf.parse(req.getParameter("clockOut")).getTime()));

            attendance.setStatus(req.getParameter("status"));
            attendance.setWorkingHours(Double.parseDouble(req.getParameter("workingHours")));
            attendance.setRemarks(req.getParameter("remarks"));

        } catch (ParseException | NumberFormatException e) {
            throw new ServletException("Invalid form input", e);
        }
    }
}
