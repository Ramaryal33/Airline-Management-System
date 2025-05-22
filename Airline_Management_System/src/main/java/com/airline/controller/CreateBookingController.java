package com.airline.controller;

import com.airline.model.Booking;
import com.airline.service.BookingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

/**
 * URL:  /createBooking
 * Method: POST
 *
 * Reads:
 *   - flightId
 *   - numOfPassengers
 * Calls bookingService.createBooking(...) which inserts into the DB.
 * Then puts the new Booking into session (session.setAttribute("selectedBooking", booking))
 * and redirects to /bookingConfirmation
 */
@WebServlet("/searchFlight")
public class CreateBookingController extends HttpServlet {
    private final BookingService bookingService = new BookingService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String flightIdParam = request.getParameter("flightId");
        String numParam      = request.getParameter("numOfPassengers");
        int numOfPassengers  = 1;
        try {
            numOfPassengers = Integer.parseInt(numParam);
            if (numOfPassengers < 1) numOfPassengers = 1;
        } catch (NumberFormatException ignored) { }

        try {
            Booking booking = bookingService.createBooking(flightIdParam, numOfPassengers);
            // Put the booking into session so payment.jsp can use it
            HttpSession session = request.getSession();
            session.setAttribute("selectedBooking", booking);

            // Redirect to bookingConfirmation
            response.sendRedirect(request.getContextPath() + "/bookingConfirmation");
        } catch (IllegalArgumentException e) {
            // Flight was not found or some other error
            request.setAttribute("error", "Booking failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/page/searchFlight.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("DB error creating booking", e);
        }
    }
}
