package com.airline.controller;

import com.airline.service.BookingService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "CancelBookingController", value = "/cancelBooking")
public class CancelBookingController extends HttpServlet {
    private BookingService bookingService = new BookingService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        Map<String, Object> bookingDetails = bookingService.getBookingDetails(Integer.parseInt(bookingId));
        
        if (bookingDetails != null) {
            request.setAttribute("bookingDetails", bookingDetails);
            request.getRequestDispatcher("/WEB-INF/views/cancelBooking.jsp").forward(request, response);
        } else {
            response.sendRedirect("passengerDashboard");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        
        boolean success = bookingService.cancelBooking(bookingId);
        if (success) {
            request.getSession().setAttribute("message", "Booking cancelled successfully!");
        } else {
            request.getSession().setAttribute("error", "Failed to cancel booking. Please try again.");
        }
        
        response.sendRedirect("passengerDashboard");
    }
}