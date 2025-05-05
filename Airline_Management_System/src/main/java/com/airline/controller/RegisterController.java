package com.airline.controller;

import com.airline.model.User;
import com.airline.service.RegisterService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.logging.Logger;

@SuppressWarnings("serial")
@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private static final Logger logger = Logger.getLogger(RegisterController.class.getName());
    private final RegisterService userService = new RegisterService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {

        String fullName = req.getParameter("fullname");
        String email = req.getParameter("email").trim().toLowerCase();
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirm_password");
        
        

       


        // Basic validation
        if (fullName == null || fullName.isEmpty() || 
            email == null || email.isEmpty() ||
            phone == null || phone.isEmpty() ||
            password == null || password.isEmpty()) {
            
            req.setAttribute("error", "All fields are required.");
            doGet(req, resp);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Passwords do not match.");
            doGet(req, resp);
            return;
        }

        try {
            User user = new User(fullName, email, phone, password, confirmPassword);
            user.setUserType("User"); // default type
            user.setActive(true);

            if (userService.register(user)) {
                req.getSession().setAttribute("success", "Registration successful! Please login.");
                resp.sendRedirect(req.getContextPath() + "/login");
            } else {
                req.setAttribute("error", "Registration failed. Please try again.");
                doGet(req, resp);
            }
        } catch (Exception e) {
            logger.severe("Registration error: " + e.getMessage());
            req.setAttribute("error", "Registration error: " + e.getMessage());
            doGet(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
    	
    	
    	 String contextPath = req.getContextPath();
    	 req.setAttribute("cssPath", contextPath + "/css/register.css");

         req.setAttribute("imagepath", contextPath + "/image/login.jpg");
        req.getRequestDispatcher("/WEB-INF/page/register.jsp").forward(req, resp);
    }
}
