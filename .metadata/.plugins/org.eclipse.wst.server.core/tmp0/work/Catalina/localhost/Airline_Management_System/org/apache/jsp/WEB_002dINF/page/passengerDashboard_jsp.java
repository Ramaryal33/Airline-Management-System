/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/10.1.28
 * Generated at: 2025-05-08 01:23:36 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.page;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.jsp.*;

public final class passengerDashboard_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports,
                 org.apache.jasper.runtime.JspSourceDirectives {

  private static final jakarta.servlet.jsp.JspFactory _jspxFactory =
          jakarta.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(4);
    _jspx_imports_packages.add("jakarta.servlet");
    _jspx_imports_packages.add("jakarta.servlet.http");
    _jspx_imports_packages.add("jakarta.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile jakarta.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public boolean getErrorOnELNotFound() {
    return false;
  }

  public jakarta.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final jakarta.servlet.http.HttpServletRequest request, final jakarta.servlet.http.HttpServletResponse response)
      throws java.io.IOException, jakarta.servlet.ServletException {

    if (!jakarta.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
        return;
      }
    }

    final jakarta.servlet.jsp.PageContext pageContext;
    jakarta.servlet.http.HttpSession session = null;
    final jakarta.servlet.ServletContext application;
    final jakarta.servlet.ServletConfig config;
    jakarta.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    jakarta.servlet.jsp.JspWriter _jspx_out = null;
    jakarta.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"en\">\r\n");
      out.write("\r\n");
      out.write("<head>\r\n");
      out.write("    <meta charset=\"UTF-8\" />\r\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n");
      out.write("    <title>Passenger Dashboard</title>\r\n");
      out.write("    <style>\r\n");
      out.write("        /* RESET & GLOBAL STYLES */\r\n");
      out.write("        * {\r\n");
      out.write("            margin: 0;\r\n");
      out.write("            padding: 0;\r\n");
      out.write("            box-sizing: border-box;\r\n");
      out.write("            font-family: 'Open Sans', Arial, sans-serif;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        body {\r\n");
      out.write("            color: #333;\r\n");
      out.write("            background: #f7f9fc;\r\n");
      out.write("            transition: all 0.3s ease;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        /* SIDEBAR */\r\n");
      out.write("        .sidebar {\r\n");
      out.write("            position: fixed;\r\n");
      out.write("            top: 0;\r\n");
      out.write("            left: 0;\r\n");
      out.write("            width: 250px;\r\n");
      out.write("            height: 100vh;\r\n");
      out.write("            padding: 20px;\r\n");
      out.write("            color: #ecf0f1;\r\n");
      out.write("            background: linear-gradient(135deg, #2c3e50 0%, #3d566e 100%);\r\n");
      out.write("            display: flex;\r\n");
      out.write("            flex-direction: column;\r\n");
      out.write("            align-items: center;\r\n");
      out.write("            transition: width 0.3s ease, padding 0.3s ease;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .sidebar nav .bottom {\r\n");
      out.write("            margin-top: 240px;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .sidebar nav .bottom img {\r\n");
      out.write("            display: block;\r\n");
      out.write("            margin: 0 auto 20px auto;\r\n");
      out.write("            border: 2px solid #ccc;\r\n");
      out.write("            width: 70px;\r\n");
      out.write("            border-radius: 10%;\r\n");
      out.write("            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .sidebar img {\r\n");
      out.write("            width: 100px;\r\n");
      out.write("            margin-bottom: 10px;\r\n");
      out.write("            border-radius: 50%;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .sidebar .logo {\r\n");
      out.write("            width: 100px;\r\n");
      out.write("            margin-bottom: 55px;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .sidebar nav a {\r\n");
      out.write("            display: block;\r\n");
      out.write("            color: #ecf0f1;\r\n");
      out.write("            text-decoration: none;\r\n");
      out.write("            padding: 10px 15px;\r\n");
      out.write("            margin: 8px 0;\r\n");
      out.write("            border-radius: 5px;\r\n");
      out.write("            transition: background 0.3s, transform 0.3s;\r\n");
      out.write("            text-align: center;\r\n");
      out.write("            font-weight: 600;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .sidebar nav a:hover {\r\n");
      out.write("            background: rgba(255, 255, 255, 0.1);\r\n");
      out.write("            transform: translateX(5px);\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        /* MAIN CONTENT */\r\n");
      out.write("        .main {\r\n");
      out.write("            margin-left: 250px;\r\n");
      out.write("            padding: 20px;\r\n");
      out.write("            transition: padding 0.3s ease;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .page-header {\r\n");
      out.write("            display: flex;\r\n");
      out.write("            align-items: center;\r\n");
      out.write("            margin-bottom: 20px;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .page-title {\r\n");
      out.write("            font-size: 1.5rem;\r\n");
      out.write("            color: #444;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        /* SEARCH BAR */\r\n");
      out.write("        .search-bar {\r\n");
      out.write("            display: flex;\r\n");
      out.write("            margin-bottom: 20px;\r\n");
      out.write("            gap: 0.5rem;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .search-bar input {\r\n");
      out.write("            flex: 1;\r\n");
      out.write("            padding: 10px;\r\n");
      out.write("            border: 2px solid #ccc;\r\n");
      out.write("            border-radius: 8px;\r\n");
      out.write("            outline: none;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .search-bar button {\r\n");
      out.write("            padding: 10px 18px;\r\n");
      out.write("            border: none;\r\n");
      out.write("            border-radius: 8px;\r\n");
      out.write("            background: #1A73E8;\r\n");
      out.write("            color: #fff;\r\n");
      out.write("            font-weight: 600;\r\n");
      out.write("            cursor: pointer;\r\n");
      out.write("            transition: background 0.3s, transform 0.3s;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .search-bar button:hover {\r\n");
      out.write("            background: #1667c1;\r\n");
      out.write("            transform: scale(1.03);\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        /* ACTIVITY SECTION */\r\n");
      out.write("        .activity h3 {\r\n");
      out.write("            margin-bottom: 10px;\r\n");
      out.write("            font-weight: 600;\r\n");
      out.write("            color: #555;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .activity-grid {\r\n");
      out.write("            display: flex;\r\n");
      out.write("            gap: 15px;\r\n");
      out.write("            flex-wrap: wrap;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .activity-item {\r\n");
      out.write("            flex: 1;\r\n");
      out.write("            min-width: 140px;\r\n");
      out.write("            background: #fff;\r\n");
      out.write("            border-radius: 10px;\r\n");
      out.write("            padding: 15px;\r\n");
      out.write("            text-align: center;\r\n");
      out.write("            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);\r\n");
      out.write("            transition: transform 0.3s;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .activity-item:hover {\r\n");
      out.write("            transform: translateY(-3px);\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        /* PLANNING JOURNEY SECTION */\r\n");
      out.write("        .planning-journey {\r\n");
      out.write("            display: flex;\r\n");
      out.write("            gap: 20px;\r\n");
      out.write("            margin-top: 20px;\r\n");
      out.write("            flex-wrap: wrap;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .planning-form,\r\n");
      out.write("        .calendar {\r\n");
      out.write("            background: #fff;\r\n");
      out.write("            border-radius: 10px;\r\n");
      out.write("            padding: 20px;\r\n");
      out.write("            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);\r\n");
      out.write("            flex: 1;\r\n");
      out.write("            min-width: 250px;\r\n");
      out.write("            transition: all 0.3s ease;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .planning-form h3 {\r\n");
      out.write("            margin-bottom: 10px;\r\n");
      out.write("            color: #444;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .planning-form p {\r\n");
      out.write("            margin-bottom: 15px;\r\n");
      out.write("            color: #777;\r\n");
      out.write("            font-size: 0.95rem;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .planning-form img {\r\n");
      out.write("            width: 100%;\r\n");
      out.write("            max-width: 500px;\r\n");
      out.write("            display: block;\r\n");
      out.write("            margin-bottom: 15px;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .planning-form label {\r\n");
      out.write("            display: block;\r\n");
      out.write("            margin-top: 10px;\r\n");
      out.write("            font-weight: 600;\r\n");
      out.write("            color: #555;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .planning-form input {\r\n");
      out.write("            width: 100%;\r\n");
      out.write("            padding: 8px;\r\n");
      out.write("            margin-top: 5px;\r\n");
      out.write("            border: 2px solid #ccc;\r\n");
      out.write("            border-radius: 8px;\r\n");
      out.write("            outline: none;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .calendar h3 {\r\n");
      out.write("            margin-bottom: 10px;\r\n");
      out.write("            color: #444;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        .calendar input {\r\n");
      out.write("            width: 100%;\r\n");
      out.write("            padding: 8px;\r\n");
      out.write("            border: 2px solid #ccc;\r\n");
      out.write("            border-radius: 8px;\r\n");
      out.write("            outline: none;\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        /* RESPONSIVE DESIGN */\r\n");
      out.write("        @media (max-width: 900px) {\r\n");
      out.write("            .sidebar {\r\n");
      out.write("                position: static;\r\n");
      out.write("                width: 100%;\r\n");
      out.write("                height: auto;\r\n");
      out.write("                flex-direction: row;\r\n");
      out.write("                flex-wrap: wrap;\r\n");
      out.write("                justify-content: center;\r\n");
      out.write("                padding: 10px;\r\n");
      out.write("                box-shadow: 0 2px 5px rgba(0,0,0,0.1);\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("            .sidebar nav {\r\n");
      out.write("                flex-direction: row;\r\n");
      out.write("                flex-wrap: wrap;\r\n");
      out.write("                justify-content: center;\r\n");
      out.write("                width: 100%;\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("            .sidebar nav a {\r\n");
      out.write("                margin: 5px;\r\n");
      out.write("                padding: 8px 10px;\r\n");
      out.write("                font-size: 0.9rem;\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("            .sidebar nav .bottom {\r\n");
      out.write("                margin-top: 0;\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("            .main {\r\n");
      out.write("                margin-left: 0;\r\n");
      out.write("                padding: 10px;\r\n");
      out.write("            }\r\n");
      out.write("        }\r\n");
      out.write("\r\n");
      out.write("        @media (min-width: 1200px) {\r\n");
      out.write("            .sidebar {\r\n");
      out.write("                padding: 25px;\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("            .search-bar input,\r\n");
      out.write("            .search-bar button {\r\n");
      out.write("                padding: 12px;\r\n");
      out.write("                font-size: 1.1rem;\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("            .activity-item {\r\n");
      out.write("                padding: 20px;\r\n");
      out.write("                min-width: 160px;\r\n");
      out.write("            }\r\n");
      out.write("\r\n");
      out.write("            .planning-form,\r\n");
      out.write("            .calendar {\r\n");
      out.write("                padding: 25px;\r\n");
      out.write("            }\r\n");
      out.write("        }\r\n");
      out.write("    </style>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("    <div class=\"sidebar\">\r\n");
      out.write("        <img src=\"plane.png\" alt=\"Airline Logo\" class=\"logo\" />\r\n");
      out.write("        <nav>\r\n");
      out.write("            <a href=\"#\">Dashboard</a>\r\n");
      out.write("            <a href=\"#\">Search Flights</a>\r\n");
      out.write("            <a href=\"#\">Flight Details</a>\r\n");
      out.write("            <a href=\"#\">Payment Page</a>\r\n");
      out.write("            <a href=\"#\">My Bookings</a>\r\n");
      out.write("            <a href=\"#\">Online Check-in</a>\r\n");
      out.write("            <div class=\"bottom\">\r\n");
      out.write("                <img src=\"m.jpg\" alt=\"Profile Picture\" />\r\n");
      out.write("                <a href=\"#\">Settings</a>\r\n");
      out.write("            </div>\r\n");
      out.write("        </nav>\r\n");
      out.write("    </div>\r\n");
      out.write("\r\n");
      out.write("    <div class=\"main\">\r\n");
      out.write("        <!-- Page Header -->\r\n");
      out.write("        <div class=\"page-header\">\r\n");
      out.write("            <h1 class=\"page-title\">Passenger Dashboard</h1>\r\n");
      out.write("        </div>\r\n");
      out.write("\r\n");
      out.write("        <!-- Search Bar -->\r\n");
      out.write("        <div class=\"search-bar\">\r\n");
      out.write("            <input type=\"text\" placeholder=\"Search by Flight No.\" />\r\n");
      out.write("            <button>Search</button>\r\n");
      out.write("        </div>\r\n");
      out.write("\r\n");
      out.write("        <!-- Activity Section -->\r\n");
      out.write("        <div class=\"activity\">\r\n");
      out.write("            <h3>Activity</h3>\r\n");
      out.write("            <div class=\"activity-grid\">\r\n");
      out.write("                <div class=\"activity-item\">\r\n");
      out.write("                    <strong>Passengers</strong><br><small>Date</small>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"activity-item\">\r\n");
      out.write("                    <strong>Flight</strong><br><small>Date</small>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"activity-item\">\r\n");
      out.write("                    <strong>Waiting List</strong><br><small>Date</small>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"activity-item\">\r\n");
      out.write("                    <strong>Revenue</strong><br><small>Date</small>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("\r\n");
      out.write("        <!-- Planning Journey Section -->\r\n");
      out.write("        <div class=\"planning-journey\">\r\n");
      out.write("            <div class=\"planning-form\">\r\n");
      out.write("                <h3>Where To?</h3>\r\n");
      out.write("                <p>Book a Flight</p>\r\n");
      out.write("                <img src=\"plane.png\" alt=\"Plane Illustration\" />\r\n");
      out.write("\r\n");
      out.write("                <label for=\"from\">From:</label>\r\n");
      out.write("                <input id=\"from\" type=\"text\" placeholder=\"From\" />\r\n");
      out.write("\r\n");
      out.write("                <label for=\"to\">To:</label>\r\n");
      out.write("                <input id=\"to\" type=\"text\" placeholder=\"To\" />\r\n");
      out.write("\r\n");
      out.write("                <label for=\"date\">Date:</label>\r\n");
      out.write("                <input id=\"date\" type=\"date\" />\r\n");
      out.write("\r\n");
      out.write("                <label for=\"passengers\">Passengers:</label>\r\n");
      out.write("                <input id=\"passengers\" type=\"number\" min=\"1\" value=\"1\" />\r\n");
      out.write("            </div>\r\n");
      out.write("\r\n");
      out.write("            <div class=\"calendar\">\r\n");
      out.write("                <h3>Select Date</h3>\r\n");
      out.write("                <input type=\"date\" />\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("</body>\r\n");
      out.write("\r\n");
      out.write("</html>\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof jakarta.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
