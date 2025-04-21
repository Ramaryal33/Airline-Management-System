package com.airline.controller;

import com.airline.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@SuppressWarnings("serial")
@WebServlet("/forgotPassword")
public class ForgotPasswordController extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	 request.setAttribute("pageTitle", "Forgot Password - Dawn Airlines");
         request.setAttribute("cssPath", request.getContextPath() + "/css/register.css");
         request.setAttribute("basePath", request.getContextPath());

        request.getRequestDispatcher("/WEB-INF/page/forgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email").trim().toLowerCase();

        try {
            boolean result = userService.sendTemporaryPassword(email);

            if (result) {
                request.setAttribute("message", "Temporary password sent to your email.");
            } else {
                request.setAttribute("message", "Email not found.");
            }

        } catch (Exception e) {
            request.setAttribute("message", "Something went wrong. Please try again.");
            e.printStackTrace();
        }

        request.getRequestDispatcher("/WEB-INF/page/forgotPassword.jsp").forward(request, response);
    }
}
