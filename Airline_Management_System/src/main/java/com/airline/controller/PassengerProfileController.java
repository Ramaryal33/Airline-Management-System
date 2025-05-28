// com/airline/controller/SearchFlightController.java
package com.airline.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/passenger profile")
public class PassengerProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;

        protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
            // Forward internally to your JSP under WEB-INF
            	request.getRequestDispatcher("/WEB-INF/page/passenger profile.jsp").forward(request, response);}



	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
    	doGet(request, response);
    	}

}


