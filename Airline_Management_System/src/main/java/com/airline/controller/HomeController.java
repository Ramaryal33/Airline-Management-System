package com.airline.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(asyncSupported = true, urlPatterns = { "/home", "/" })
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	// Set CSS path as request attribute
        request.setAttribute("cssPath", request.getContextPath() + "/css/airline.css");
        // Forward to the JSP page
        request.getRequestDispatcher("/WEB-INF/page/home.jsp").forward(request, response);
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // You can either:
        // 1. Call doGet to handle POST the same way as GET
        doGet(request, response);

        // OR 2. Handle form submissions differently if needed
        // String action = request.getParameter("action");
        // if("login".equals(action)) {
        //     // Handle login logic
        // }
    }
}