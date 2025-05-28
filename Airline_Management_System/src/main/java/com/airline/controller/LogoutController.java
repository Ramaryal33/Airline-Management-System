

package com.airline.controller;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@SuppressWarnings("serial")
@WebServlet("/logout")
public class LogoutController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        // Invalidate session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        request.getRequestDispatcher("/WEB-INF/page/logout.jsp").forward(request, response);
        // Clear rememberToken cookie
        Cookie rememberCookie = new Cookie("rememberToken", "");
        rememberCookie.setMaxAge(0);
        rememberCookie.setPath(request.getContextPath());
        response.addCookie(rememberCookie);

        // Redirect to home page after logout
        response.sendRedirect(request.getContextPath() + "/home");
    }
    
    
}

