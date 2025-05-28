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



@WebServlet(name = "BookingConfirmation", urlPatterns = { "/bookingConfirmation" })
public class BookingConfirmationController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final PassengerService service = new PassengerService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1) Ensure existing session (do not create new) and logged-in user
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2) Read flightId from form POST
        String flightId = request.getParameter("flightId");

        // 3) Generate bookingRef and store in session
        String bookingRef = "REF"
                + (System.currentTimeMillis() % 100000)
                + (int)(Math.random() * 900 + 100);
        session.setAttribute("bookedFlightId", flightId);
        session.setAttribute("bookingRef", bookingRef);

        // 4) Lookup Flight
        Flight selectedFlight = null;
        if (flightId != null && !flightId.isEmpty()) {
            List<Flight> allFlights = service.getAllFlights();
            for (Flight f : allFlights) {
                if (flightId.equalsIgnoreCase(f.getFlightId())) {
                    selectedFlight = f;
                    break;
                }
            }
        }

        // 5) Compute date/time strings and totalPaid
        String depDateStr = "";
        String depTimeStr = "";
        double totalPaid = 0.0;
        if (selectedFlight != null) {
            DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("MMM dd, yyyy");
            DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("hh:mm a");
            depDateStr = selectedFlight.getDepartureDate().format(dateFmt);
            depTimeStr = selectedFlight.getDepartureTime().format(timeFmt);
            totalPaid = selectedFlight.getPrice() + 300.0; // base fare + fees
        }

        // 6) Expose attributes for JSP
        request.setAttribute("selectedFlight", selectedFlight);
        request.setAttribute("bookingRef", bookingRef);
        request.setAttribute("depDateStr", depDateStr);
        request.setAttribute("depTimeStr", depTimeStr);
        request.setAttribute("totalPaid", totalPaid);
        request.setAttribute("basePath", request.getContextPath());

        // 7) Forward to JSP
        request.getRequestDispatcher("/WEB-INF/page/bookingConfirmation.jsp")
               .forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Reject GET on this URL by redirecting to dashboard (or could be login)
        response.sendRedirect(request.getContextPath() + "/passengerDashboard");
    }
}
