package com.airline.controller;

import com.airline.model.Flight;
import com.airline.service.FlightService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * URL:  /searchFlight
 * Method: GET (because all our forms use GET for searching)
 *
 * Reads parameters:
 *   - flightId         (may be non‐null if user typed “NP100” in the dashboard’s top box)
 *   - from, to         (from “Find Your Flight” form)
 *   - departureDate
 *   - travelClass
 *   - tripTypeHidden   (“oneWay” or “roundTrip”, from hidden field)
 *   - returnDate       (only if tripTypeHidden == “roundTrip”)
 *   - passengers
 *
 * Then calls flightService.searchFlights(...) and forwards the results to searchFlight.jsp
 */
@WebServlet("/searchFlight")
public class SearchFlightController extends HttpServlet {
    private final FlightService flightService = new FlightService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. Read all query parameters
        String flightId      = request.getParameter("flightId");
        String fromCity      = request.getParameter("from");
        String toCity        = request.getParameter("to");
        String departureDate = request.getParameter("departureDate");
        String travelClass   = request.getParameter("travelClass");
        String tripType      = request.getParameter("tripTypeHidden");
        String returnDate    = request.getParameter("returnDate");
        String passengers    = request.getParameter("passengers");

        try {
            // 2. Call service to search. We’ll ignore “returnDate” in the backend since our
            //    FlightService.searchFlights() only looks at flightId, fromCity, toCity, departureDate, travelClass.
            List<Flight> results = flightService.searchFlights(
                (flightId != null && !flightId.isBlank()) ? flightId : null,
                (fromCity != null && !fromCity.isBlank()) ? fromCity : null,
                (toCity   != null && !toCity.isBlank())   ? toCity   : null,
                (departureDate != null && !departureDate.isBlank()) ? departureDate : null,
                (travelClass   != null && !travelClass.isBlank())   ? travelClass   : null
            );

            // 3. Convert each Flight → Map<String,String> for display
            List<Map<String,String>> flightsView = new ArrayList<>();
            DateTimeFormatter df = DateTimeFormatter.ofPattern("MMM dd, yyyy");
            DateTimeFormatter tf = DateTimeFormatter.ofPattern("hh:mm a");

            for (Flight f : results) {
                Map<String,String> m = new HashMap<>();
                m.put("flightId",               f.getFlightId());
                m.put("fromCity",               f.getFromCity());
                m.put("toCity",                 f.getToCity());
                m.put("departureDateFormatted", f.getDepartureDate().format(df));
                m.put("departureTimeFormatted", f.getDepartureTime().format(tf));
                m.put("travelClass",            f.getTravelClass());
                m.put("price",                  String.valueOf(f.getPrice()));
                flightsView.add(m);
            }

            request.setAttribute("flights", flightsView);
            request.getRequestDispatcher("/WEB-INF/views/searchFlight.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("DB error searching flights", e);
        }
    }
}
