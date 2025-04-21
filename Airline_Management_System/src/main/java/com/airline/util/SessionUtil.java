package com.airline.util;

import com.airline.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {

    // Save user in session
    public static void createUserSession(HttpServletRequest request, User user) {
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
    }

    // Get user from session
    public static User getLoggedUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false); // don't create if doesn't exist
        return (session != null) ? (User) session.getAttribute("user") : null;
    }

    // Update user information in the session
    public static void updateUserSession(HttpServletRequest request, User updatedUser) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.setAttribute("user", updatedUser);
        }
    }

    // Invalidate session
    public static void destroySession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}