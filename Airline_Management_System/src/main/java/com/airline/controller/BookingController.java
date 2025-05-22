// BookingController.java
package com.airline.controller;

import com.airline.model.Booking;
import com.airline.service.BookingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet({"/createBooking", "/cancelBooking"})
public class BookingController extends HttpServlet {
    private BookingService bookingService = new BookingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/cancelBooking".equals(path)) {
            // show cancel form
            String bookingId = req.getParameter("bookingId");
            var details = bookingService.getBookingDetails(Integer.parseInt(bookingId));
            req.setAttribute("bookingToCancel", details);
            req.getRequestDispatcher("/WEB-INF/views/cancelBooking.jsp")
               .forward(req, resp);
        } else {
            // fallback: redirect to dashboard
            resp.sendRedirect(req.getContextPath() + "/passengerDashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        String path = req.getServletPath();
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if ("/createBooking".equals(path)) {
            String flightId = req.getParameter("flightId");
            int pax = Integer.parseInt(req.getParameter("numOfPassengers"));
            boolean ok = bookingService.createBooking(userId, flightId, pax);
            if (ok) {
                // reload the most recent booking into session for confirmation page
                List<Booking> userBookings = bookingService.getUserBookings(userId);
                Booking last = userBookings.get(0);
                session.setAttribute("selectedBooking", last);
                resp.sendRedirect(req.getContextPath() + "/bookingConfirmation");
            } else {
                req.setAttribute("error", "Unable to create booking. Try again.");
                resp.sendRedirect(req.getContextPath() + "/flight");
            }

        } else if ("/cancelBooking".equals(path)) {
            int bookingId = Integer.parseInt(req.getParameter("bookingId"));
            boolean cancelled = bookingService.cancelBooking(bookingId);
            session.setAttribute("cancelResult", cancelled);
            resp.sendRedirect(req.getContextPath() + "/passengerDashboard");
        }
    }
}
