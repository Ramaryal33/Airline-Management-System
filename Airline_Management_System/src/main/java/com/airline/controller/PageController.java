package com.airline.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "PageController", urlPatterns = {
	    "/adminDashboard",
	    "/managePassengers",
	    "/manageStaff",
	    "/flightManagement",
	    "/bookingManagement",
	    "/reportsAnalytics",
	    "/settings"
	})
public class PageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        // Map servlet path to corresponding JSP
        String viewPath = getJspPath(path);

        if (viewPath != null) {
            request.getRequestDispatcher(viewPath).forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Page not found for path: " + path);
        }
    }

    // Helper method to resolve JSP path
    private String getJspPath(String path) {
        return switch (path) {
            case "/adminDashboard" -> "/WEB-INF/page/adminDashboard.jsp";
            case "/managePassengers" -> "/WEB-INF/page/managePassengers.jsp";
            case "/manageStaff" -> "/WEB-INF/page/manageStaff.jsp";
            case "/flightManagement" -> "/WEB-INF/page/flightManagement.jsp";
            case "/bookingManagement" -> "/WEB-INF/page/bookingManagement.jsp";
            case "/reportsAnalytics" -> "/WEB-INF/page/reportsAndAnalytics.jsp"; // ✅ File should be renamed
            case "/settings" -> "/WEB-INF/page/settings.jsp";
            default -> null;
        };
    }
}
