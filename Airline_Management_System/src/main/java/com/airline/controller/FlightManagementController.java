package com.airline.controller;

import java.io.IOException;
import java.util.List;

import com.airline.model.Flight;
import com.airline.service.FlightService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/flightManagement")
public class FlightManagementController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final FlightService flightService = new FlightService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            List<Flight> flights = flightService.getAllFlights();
            request.setAttribute("flights", flights);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/page/flightManagement.jsp");
            dispatcher.forward(request, response);

        } else if (action.equals("add")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/page/addFlight.jsp");
            dispatcher.forward(request, response);

        } else if (action.equals("edit")) {
            String flightId = request.getParameter("flightId");
            Flight flight = flightService.getFlightById(flightId);
            request.setAttribute("flight", flight);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/page/editFlight.jsp");
            dispatcher.forward(request, response);

        } else if (action.equals("delete")) {
            String flightId = request.getParameter("flightId");
            flightService.deleteFlight(flightId);
            response.sendRedirect("flightManagement?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String flightId = request.getParameter("flight-number");
        String fromCity = request.getParameter("origin");
        String toCity = request.getParameter("destination");
        String departureDate = request.getParameter("departure-date");
        String departureTime = request.getParameter("departure-time");
        String arrivalDate = request.getParameter("arrival-date");
        String arrivalTime = request.getParameter("arrival-time");
        String travelClass = request.getParameter("travel-class");
        double price = Double.parseDouble(request.getParameter("price"));
        int seats = Integer.parseInt(request.getParameter("total-seats"));

        if (flightService.getFlightById(flightId) != null) {
            flightService.updateFlight(flightId, fromCity, toCity, departureDate, departureTime, arrivalDate, arrivalTime, travelClass, price, seats);
        } else {
            flightService.addFlight(flightId, fromCity, toCity, departureDate, departureTime, arrivalDate, arrivalTime, travelClass, price, seats);
        }

        response.sendRedirect("flightManagement?action=list");
    }
}
