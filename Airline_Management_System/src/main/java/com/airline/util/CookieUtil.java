package com.airline.util;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CookieUtil {

    /**
     * Sets a cookie with the given name, value, and maximum age.
     *
     * @param response         The HttpServletResponse object to which the cookie will be added.
     * @param name             The name of the cookie.
     * @param value            The value of the cookie.
     * @param maxAgeInSeconds The maximum age of the cookie in seconds.  If negative, the
     * cookie is not stored. If zero, the cookie is deleted.
     */
    public static void setCookie(HttpServletResponse response, String name, String value, int maxAgeInSeconds) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAgeInSeconds);
        cookie.setPath("/"); // Makes the cookie accessible throughout the application
        response.addCookie(cookie);
    }

    /**
     * Gets the value of a cookie with the given name from the request.
     *
     * @param request The HttpServletRequest object from which to retrieve the cookie.
     * @param name    The name of the cookie to retrieve.
     * @return The value of the cookie, or null if the cookie is not found.
     */
    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (name.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    /**
     * Deletes a cookie with the given name by setting its maximum age to zero.
     *
     * @param response The HttpServletResponse object to which the cookie deletion
     * instruction will be added.
     * @param name     The name of the cookie to delete.
     */
    public static void deleteCookie(HttpServletResponse response, String name) {
        setCookie(response, name, "", 0);
    }
}
