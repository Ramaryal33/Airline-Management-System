package com.airline.controller;

import com.airline.model.Flight;
import com.airline.service.PassengerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.DateTimeException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

@WebServlet("/searchFlight")
public class SearchFlightController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final PassengerService service = new PassengerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1) fetch all flights
        List<Flight> allFlights = service.getAllFlights();

        // 2) build distinct, sorted sets for dropdowns
        Set<String> fromCities    = new TreeSet<>();
        Set<String> toCities      = new TreeSet<>();
        Set<String> travelClasses = new TreeSet<>();
        for (Flight f : allFlights) {
            if (f.getFromCity()    != null) fromCities.add(f.getFromCity());
            if (f.getToCity()      != null) toCities.add(f.getToCity());
            if (f.getTravelClass()!= null) travelClasses.add(f.getTravelClass());
        }

        // 3) read submitted form parameters (will be null on first load)
        String paramFrom       = request.getParameter("from");
        String paramTo         = request.getParameter("to");
        String paramDateStr    = request.getParameter("departureDate");
        String paramClass      = request.getParameter("travelClass");
        String paramTripType   = request.getParameter("tripType");
        String paramReturnDate = request.getParameter("returnDate");
        String paramPassengers = request.getParameter("passengers");

        // 4) filter flights if required fields are present
        List<Flight> filteredFlights = new ArrayList<>();
        if (paramFrom != null && !paramFrom.isEmpty()
         && paramTo   != null && !paramTo.isEmpty()
         && paramDateStr != null && !paramDateStr.isEmpty()
         && paramClass    != null && !paramClass.isEmpty()) {

            try {
                LocalDate depDate = LocalDate.parse(paramDateStr);

                for (Flight f : allFlights) {
                    boolean matchesFrom  = f.getFromCity().equalsIgnoreCase(paramFrom);
                    boolean matchesTo    = f.getToCity().equalsIgnoreCase(paramTo);
                    boolean matchesDate  = f.getDepartureDate() != null
                                           && f.getDepartureDate().equals(depDate);
                    boolean matchesClass = f.getTravelClass().equalsIgnoreCase(paramClass);

                    if (matchesFrom && matchesTo && matchesDate && matchesClass) {
                        filteredFlights.add(f);
                    }
                }
            } catch (DateTimeException e) {
                // invalid date format: leave filteredFlights empty
            }
        }

        // 5) expose everything as request attributes for the JSP
        request.setAttribute("fromCities",     fromCities);
        request.setAttribute("toCities",       toCities);
        request.setAttribute("travelClasses",  travelClasses);

        request.setAttribute("paramFrom",       paramFrom);
        request.setAttribute("paramTo",         paramTo);
        request.setAttribute("paramDateStr",    paramDateStr);
        request.setAttribute("paramClass",      paramClass);
        request.setAttribute("paramTripType",   paramTripType);
        request.setAttribute("paramReturnDate", paramReturnDate);
        request.setAttribute("paramPassengers", paramPassengers);

        request.setAttribute("filteredFlights", filteredFlights);

        // 6) forward to your JSP (under /WEB-INF/page/searchFlight.jsp)
        request.getRequestDispatcher("/WEB-INF/page/searchFlight.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // delegate POST to GET so form submissions are handled the same
        doGet(request, response);
    }
}
