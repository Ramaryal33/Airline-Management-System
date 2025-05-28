package com.airline.controller;

import com.airline.model.Flight;
import com.airline.service.PassengerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class PaymentController
 */
@WebServlet(name = "Payment", urlPatterns = { "/payment" })
public class PaymentController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final PassengerService service = new PassengerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1) Read flightId from query
        String flightId = request.getParameter("flightId");
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
        
        // 2) Compute and format
        double baseFare  = (selectedFlight != null) ? selectedFlight.getPrice() : 0.0;
        double taxesFees = 300.0;
        double totalFare = baseFare + taxesFees;

        // 3) Set attributes
        request.setAttribute("selectedFlight", selectedFlight);
        request.setAttribute("totalFare", totalFare);
        request.setAttribute("basePath", request.getContextPath());

        // 4) Forward to JSP
        request.getRequestDispatcher("/WEB-INF/page/payment.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // handle form submission or just redirect back
        doGet(request, response);
    }
}
