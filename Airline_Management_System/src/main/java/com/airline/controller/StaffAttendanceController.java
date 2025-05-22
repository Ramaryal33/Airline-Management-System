package com.airline.controller;

import com.airline.staff.model.Attendance;
import com.airline.staff.service.AttendanceService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

@SuppressWarnings("serial")
@WebServlet("/staffAttendance")
public class StaffAttendanceController extends HttpServlet {
    private final AttendanceService attendanceService = new AttendanceService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("edit".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(req.getParameter("attendanceId"));
            Attendance attendance = attendanceService.getAttendanceById(id);
            req.setAttribute("attendance", attendance);
        }
        List<Attendance> list = attendanceService.getAllAttendances();
        req.setAttribute("attendanceList", list);
        req.getRequestDispatcher("/WEB-INF/page/staffAttendance.jsp").forward(req, resp);
    }

    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            int id = Integer.parseInt(req.getParameter("attendanceId"));
            attendanceService.deleteAttendance(id);
        } else {
            int attendanceId = req.getParameter("attendanceId") != null && !req.getParameter("attendanceId").isEmpty()
                    ? Integer.parseInt(req.getParameter("attendanceId")) : 0;
            int staffId = Integer.parseInt(req.getParameter("staffId"));
            Date date = Date.valueOf(req.getParameter("date"));
            Time clockIn = Time.valueOf(req.getParameter("clockIn").length() == 5 ? req.getParameter("clockIn") + ":00" : req.getParameter("clockIn"));
            Time clockOut = Time.valueOf(req.getParameter("clockOut").length() == 5 ? req.getParameter("clockOut") + ":00" : req.getParameter("clockOut"));
            String status = req.getParameter("status");
            double hours = Double.parseDouble(req.getParameter("workingHours"));
            String remarks = req.getParameter("remarks");

            Attendance a = new Attendance();
            a.setAttendanceId(attendanceId);
            a.setStaffId(staffId);
            a.setDate(date);
            a.setClockIn(clockIn);
            a.setClockOut(clockOut);
            a.setStatus(status);
            a.setWorkingHours(hours);
            a.setRemarks(remarks);

            if ("edit".equalsIgnoreCase(action)) {
                attendanceService.updateAttendance(a);
            } else {
                attendanceService.addAttendance(a);
            }
        }

        // Important: Reload updated list and forward to display page
        List<Attendance> list = attendanceService.getAllAttendances();
        req.setAttribute("attendanceList", list);
        req.getRequestDispatcher("/WEB-INF/page/staffAttendance.jsp").forward(req, resp);
    }

    
}
