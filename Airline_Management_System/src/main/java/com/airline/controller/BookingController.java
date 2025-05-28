package com.airline.controller;

import com.airline.model.Booking;
import com.airline.model.Flight;
import com.airline.model.User;
import com.airline.service.BookingService;
import com.airline.service.FlightService;
import com.airline.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@SuppressWarnings("serial")
@WebServlet("/manageBookings")
public class BookingController extends HttpServlet {
    private BookingService bookingService = new BookingService();
    private UserService userService = new UserService();
    private FlightService flightService = new FlightService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("bookingId"));
                Booking booking = bookingService.getBookingById(id);
                request.setAttribute("editBooking", booking);
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("bookingId"));
                bookingService.deleteBooking(id);
                response.sendRedirect("manageBookings?status=deleted");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageBookings?status=error");
            return;
        }

        List<Booking> bookings = bookingService.getAllBookings();
        request.setAttribute("bookings", bookings);

        // Populate dropdowns
        request.setAttribute("users", userService.getBasicUsers());
        request.setAttribute("flights", flightService.getAllFlights());

        request.getRequestDispatcher("WEB-INF/page/manageBookings.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            int bookingId = request.getParameter("bookingId") != null && !request.getParameter("bookingId").isEmpty()
                    ? Integer.parseInt(request.getParameter("bookingId")) : 0;
            int userId = Integer.parseInt(request.getParameter("userId"));
            String flightId = request.getParameter("flightId");
            String bookingDateStr = request.getParameter("bookingDate");
            double amount = Double.parseDouble(request.getParameter("amount"));
            String status = request.getParameter("status");

            Booking booking = new Booking();
            booking.setBookingId(bookingId);
            booking.setUserId(userId);
            booking.setFlightId(flightId);
            booking.setBookingDate(new SimpleDateFormat("yyyy-MM-dd").parse(bookingDateStr));
            booking.setAmount(amount);
            booking.setStatus(status);

            if ("update".equals(action)) {
                bookingService.updateBooking(booking);
            } else {
                bookingService.addBooking(booking);
            }

            response.sendRedirect("manageBookings?status=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageBookings?status=error");
        }
    }
}
