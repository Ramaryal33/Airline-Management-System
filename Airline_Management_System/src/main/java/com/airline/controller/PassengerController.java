package com.airline.controller;

import com.airline.service.managePassengerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.Map;

//@SuppressWarnings("serial")
@WebServlet("/managePassenger")
public class PassengerController extends HttpServlet {

    private final managePassengerService passengerService = new managePassengerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("edit".equalsIgnoreCase(action)) {
                // Fetch passenger data by ID
                int id = Integer.parseInt(request.getParameter("id"));
                Map<String, String> passenger = passengerService.getPassengerById(id);
                request.setAttribute("editPassenger", passenger);

                // Forward to the editPassenger.jsp page
                request.getRequestDispatcher("/WEB-INF/page/editPassenger.jsp").forward(request, response);
                return;
            }

            // Fetch all passengers
            List<Map<String, String>> passengers = passengerService.getAllPassengers();
            request.setAttribute("passengers", passengers);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
        }

        // Forward to managePassengers.jsp
        request.getRequestDispatcher("/WEB-INF/page/managePassengers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            boolean success = false;

            if ("add".equalsIgnoreCase(action)) {
                String fullName = request.getParameter("fullName");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String password = request.getParameter("password");

                success = passengerService.addPassenger(fullName, email, phone, password);

            } else if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String fullName = request.getParameter("fullName");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");

                success = passengerService.updatePassenger(id, fullName, email, phone);

            } else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                success = passengerService.deletePassenger(id);
            }

            if (!success) {
                request.setAttribute("error", "Action failed: " + action);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to process request: " + e.getMessage());
        }

        // Redirect to GET to refresh passenger list after POST
        response.sendRedirect("managePassenger");
    }
}
