package com.airline.controller;

import com.airline.model.Flight;

import com.airline.service.PassengerService;

import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "cancelBooking", urlPatterns = { "/cancelBooking" })
public class CancelBookingController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final PassengerService service = new PassengerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1) Ensure existing session and logged-in user
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("basePath", request.getContextPath());

        // 2) If no booking in session, show the JSP message
        if (session.getAttribute("bookedFlightId") == null) {
            request.getRequestDispatcher("/WEB-INF/page/cancelBooking.jsp")
                   .forward(request, response);
            return;
        }

        // 3) Load booking details from session
        String bookedFlightId = (String) session.getAttribute("bookedFlightId");
        String bookingRef     = (String) session.getAttribute("bookingRef");

        Flight bookedFlight = null;
        List<Flight> allFlights = service.getAllFlights();
        for (Flight f : allFlights) {
            if (bookedFlightId.equalsIgnoreCase(f.getFlightId())) {
                bookedFlight = f;
                break;
            }
        }

        // 4) Format date/time and compute fares
        DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("MMM dd, yyyy");
        DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("hh:mm a");

        String depDateStr = bookedFlight != null
            ? bookedFlight.getDepartureDate().format(dateFmt)
            : "";
        String depTimeStr = bookedFlight != null
            ? bookedFlight.getDepartureTime().format(timeFmt)
            : "";

        double baseFare        = bookedFlight != null ? bookedFlight.getPrice() : 0.0;
        double cancellationFee = 300.0;
        double totalFare       = baseFare + cancellationFee;
        double refundAmount    = totalFare - cancellationFee;

        // 5) Expose to JSP
        request.setAttribute("bookedFlight",    bookedFlight);
        request.setAttribute("bookingRef",      bookingRef);
        request.setAttribute("depDateStr",      depDateStr);
        request.setAttribute("depTimeStr",      depTimeStr);
        request.setAttribute("totalFare",       totalFare);
        request.setAttribute("cancellationFee", cancellationFee);
        request.setAttribute("refundAmount",    refundAmount);

        // 6) Forward to JSP
        request.getRequestDispatcher("/WEB-INF/page/cancelBooking.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1) Ensure existing session and logged-in user
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2) Remove booking-related session attributes
        session.removeAttribute("bookedFlightId");
        session.removeAttribute("bookingRef");

        // 3) Redirect to passenger dashboard
        response.sendRedirect(request.getContextPath() + "/passengerDashboard");
    }
}
