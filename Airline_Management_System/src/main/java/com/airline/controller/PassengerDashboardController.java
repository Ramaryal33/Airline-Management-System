package com.airline.controller;

import com.airline.model.Flight;

import com.airline.service.PassengerService;

import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "PassengerDashboard", urlPatterns = { "/passengerDashboard" })
public class PassengerDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final PassengerService service = new PassengerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 0) Ensure user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 1) Base path for assets/links
        request.setAttribute("basePath", request.getContextPath());

        // 2) Pull last booking from session
        String bookedFlightId = (String) session.getAttribute("bookedFlightId");
        String bookingRef    = (String) session.getAttribute("bookingRef");
        Flight bookedFlight  = null;
        String depDateStr    = "";
        String depTimeStr    = "";

        DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("MMM dd, yyyy");
        DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("hh:mm a");

        if (bookedFlightId != null && !bookedFlightId.isEmpty()) {
            // Direct lookup instead of filtering full list
            bookedFlight = service.findFlightById(bookedFlightId);
            if (bookedFlight != null) {
                depDateStr = bookedFlight.getDepartureDate().format(dateFmt);
                depTimeStr = bookedFlight.getDepartureTime().format(timeFmt);
            }
        }

        request.setAttribute("bookedFlight", bookedFlight);
        request.setAttribute("bookingRef",   bookingRef);
        request.setAttribute("depDateStr",   depDateStr);
        request.setAttribute("depTimeStr",   depTimeStr);

        // 3) Build dropdown data
        List<Flight> allFlights = service.getAllFlights();
        Set<String> fromCities    = new TreeSet<>();
        Set<String> toCities      = new TreeSet<>();
        Set<String> travelClasses = new TreeSet<>();

        for (Flight f : allFlights) {
            if (f.getFromCity()    != null) fromCities.add(f.getFromCity());
            if (f.getToCity()      != null) toCities.add(f.getToCity());
            if (f.getTravelClass()!= null) travelClasses.add(f.getTravelClass());
        }

        request.setAttribute("fromCities",    fromCities);
        request.setAttribute("toCities",      toCities);
        request.setAttribute("travelClasses", travelClasses);

        // 4) Dispatch to JSP
        request.getRequestDispatcher("/WEB-INF/page/passengerDashboard.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // treat POST same as GET
        doGet(request, response);
    }
}
