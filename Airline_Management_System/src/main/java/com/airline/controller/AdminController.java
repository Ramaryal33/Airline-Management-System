package com.airline.controller;

import com.airline.model.Admin;
import com.airline.service.AdminService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@SuppressWarnings("serial")
@WebServlet("/admins")
public class AdminController extends HttpServlet {

    private final AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        Admin currentAdmin;

        if ("edit".equals(action)) {
            int editId = Integer.parseInt(request.getParameter("id"));
            currentAdmin = adminService.getAdminById(editId);

        } else if ("delete".equals(action)) {
            int delId = Integer.parseInt(request.getParameter("id"));
            adminService.deleteAdmin(delId);
            response.sendRedirect(request.getContextPath() + "/admins");
            return;

        } else {
            currentAdmin = new Admin();
        }

        List<Admin> admins = adminService.getAllAdmins();

        request.setAttribute("admin", currentAdmin);
        request.setAttribute("admins", admins);

        request.getRequestDispatcher("/WEB-INF/page/admins.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr     = request.getParameter("adminId");
        String fullName  = request.getParameter("fullName");
        String email     = request.getParameter("email");
        String password  = request.getParameter("passwordHash");
        String role      = request.getParameter("role");

        Admin admin = new Admin();
        admin.setFullName(fullName);
        admin.setEmail(email);
        admin.setPasswordHash(password);
        admin.setRole(role);

        if (idStr == null || idStr.isEmpty() || "0".equals(idStr)) {
            adminService.createAdmin(admin);
        } else {
            admin.setAdminId(Integer.parseInt(idStr));
            adminService.updateAdmin(admin);
        }

        response.sendRedirect(request.getContextPath() + "/admins");
    }
}
