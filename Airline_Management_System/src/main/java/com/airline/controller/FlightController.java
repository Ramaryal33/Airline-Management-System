package com.airline.controller;

import com.airline.model.Flight;
import com.airline.service.PassengerService;

import java.io.IOException;
import java.time.format.DateTimeFormatter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "FlightDetails", urlPatterns = { "/flightDetails" })
public class FlightController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final PassengerService service = new PassengerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1) Read the flightId
        String flightId = request.getParameter("flightId");
        Flight selectedFlight = null;
        if (flightId != null && !flightId.isEmpty()) {
            for (Flight f : service.getAllFlights()) {
                if (flightId.equalsIgnoreCase(f.getFlightId())) {
                    selectedFlight = f;
                    break;
                }
            }
        }

        // 2) Compute fares
        double baseFare  = (selectedFlight != null) ? selectedFlight.getPrice() : 0.0;
        double taxesFees = 300.0;
        double totalFare = baseFare + taxesFees;

        // 3) Pre-format date/time for the JSP
        String depDateStr = "";
        String depTimeStr = "";
        if (selectedFlight != null) {
            DateTimeFormatter dateFmt = DateTimeFormatter.ofPattern("MMM dd, yyyy");
            DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("hh:mm a");
            depDateStr = selectedFlight.getDepartureDate().format(dateFmt);
            depTimeStr = selectedFlight.getDepartureTime().format(timeFmt);
        }

        // 4) Expose everything
        request.setAttribute("selectedFlight", selectedFlight);
        request.setAttribute("baseFare",       baseFare);
        request.setAttribute("taxesFees",      taxesFees);
        request.setAttribute("totalFare",      totalFare);
        request.setAttribute("depDateStr",     depDateStr);
        request.setAttribute("depTimeStr",     depTimeStr);
        request.setAttribute("basePath",       request.getContextPath());

        // 5) Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/page/flightDetails.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
