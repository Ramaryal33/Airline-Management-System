package com.airline.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/About")
public class AboutUsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Default constructor
    public AboutUsController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the context path to dynamically set the base path and CSS path
        String contextPath = request.getContextPath();
        
        // Set attributes for the JSP page
        request.setAttribute("pageTitle", "About Us - Dawn Airlines");
//        request.setAttribute("cssPath", contextPath + "/css/airline.css");
        request.setAttribute("basePath", contextPath);
        
        // Forward the request to the About.jsp page
        request.getRequestDispatcher("/WEB-INF/page/About.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Just redirect to doGet as no additional handling is needed
        doGet(request, response);
    }
}
