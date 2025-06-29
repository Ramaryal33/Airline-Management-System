package com.airline.filter;

import com.airline.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;

@WebFilter({
    "/admin/*", 
    "/staff/*", 
    "/passenger/*"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String path = req.getRequestURI().substring(req.getContextPath().length());

        // Skip filtering for login and resources
        if (path.startsWith("/login") || path.startsWith("/resources/")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);

        // Check authentication
        if (session == null || session.getAttribute("user") == null) {
            String encodedPath = URLEncoder.encode(path, "UTF-8");
            res.sendRedirect(req.getContextPath() + "/login?redirect=" + encodedPath);
            return;
        }

        User user = (User) session.getAttribute("user");
        String userType = user.getUserType();

        // Check authorization
        if (!isAuthorized(userType, path)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        chain.doFilter(request, response);
    }

    // Authorization logic based on userType
    private boolean isAuthorized(String userType, String path) {
        if (path.startsWith("/admin")) {
            return "Admin".equalsIgnoreCase(userType);
        }
        if (path.startsWith("/staff")) {
            return "Staff".equalsIgnoreCase(userType);
        }
        return true; // All logged-in users can access passenger paths
    }
}
