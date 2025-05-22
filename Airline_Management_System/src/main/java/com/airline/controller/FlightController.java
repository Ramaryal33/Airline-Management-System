package com.airline.controller;

import com.airline.model.Flight;
import com.airline.service.FlightService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet("/addFlight")
public class FlightController extends HttpServlet {
    private final FlightService service = new FlightService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        // Show the add-flight form
        req.getRequestDispatcher("/WEB-INF/views/flight.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        // Read form parameters
        String id    = req.getParameter("flightId").trim();
        String from  = req.getParameter("fromCity").trim();
        String to    = req.getParameter("toCity").trim();
        LocalDate date = LocalDate.parse(req.getParameter("departureDate"));
        LocalTime time = LocalTime.parse(req.getParameter("departureTime"));
        double price  = Double.parseDouble(req.getParameter("price"));
        String cls    = req.getParameter("travelClass");

        Flight f = new Flight(id, from, to, date, time, price, cls);
        boolean success = service.addFlight(f);

        if (success) {
            // redirect back to the add form with a success message
            resp.sendRedirect(req.getContextPath() + "/addFlight?added=" + id);
        } else {
            req.setAttribute("error", "Could not save flight. Try again.");
            req.getRequestDispatcher("/WEB-INF/views/flight.jsp")
               .forward(req, resp);
        }
    }
}
