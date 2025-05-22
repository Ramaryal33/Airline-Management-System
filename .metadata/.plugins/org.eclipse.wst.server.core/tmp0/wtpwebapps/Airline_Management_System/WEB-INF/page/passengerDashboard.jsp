<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    // Demo Ticket List
    java.util.List<java.util.Map<String,String>> demoTickets = new java.util.ArrayList<>();
    {
        java.util.Map<String, String> t1 = new java.util.HashMap<>();
        t1.put("flightId", "NP100");
        t1.put("departureDateFormatted", "Jun 06, 2024");
        t1.put("departureTimeFormatted", "03:00 PM");
        t1.put("travelClass", "Economy");
        demoTickets.add(t1);
        java.util.Map<String, String> t2 = new java.util.HashMap<>();
        t2.put("flightId", "NP200");
        t2.put("departureDateFormatted", "Jun 07, 2024");
        t2.put("departureTimeFormatted", "09:30 AM");
        t2.put("travelClass", "Business");
        demoTickets.add(t2);
    }
    request.setAttribute("tickets", demoTickets);

    java.util.Map<String, String> recentTicket = new java.util.HashMap<>();
    recentTicket.put("bookingRef", "REF11395260");
    recentTicket.put("flightId", "NP100");
    recentTicket.put("fromCity", "Kathmandu");
    recentTicket.put("toCity", "Bhairahawa");
    recentTicket.put("departureDateFormatted", "Jun 06, 2024");
    recentTicket.put("departureTimeFormatted", "03:00 PM");
    recentTicket.put("travelClass", "Economy");
    recentTicket.put("status", "CONFIRMED");
    request.setAttribute("recentTicket", recentTicket);
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Dashboard - Dawn Airlines</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #f4f6f9;
      color: #333;
      padding: 20px;
    }
    h1, h2 {
      color: #2c3e50;
    }
    .search-section, .finder, .ticket-card, table {
      margin-bottom: 30px;
    }
    .search-section input, .finder input, .finder select {
      padding: 10px;
      margin-right: 10px;
      border-radius: 4px;
      border: 1px solid #ccc;
    }
    .search-section button, .finder button {
      padding: 10px 20px;
      background: #1976d2;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }
    .overview-table {
      width: 100%;
      border-collapse: collapse;
    }
    .overview-table th, .overview-table td {
      border: 1px solid #ddd;
      padding: 10px;
    }
    .overview-table th {
      background: #ecf0f1;
    }
    .ticket-card {
      background: #fff;
      padding: 20px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
      border-radius: 8px;
    }
    .ticket-card p {
      margin: 8px 0;
    }
  </style>
</head>

<body>
  <!-- Welcome Header -->
  <h1>WELCOME, <c:out value="${sessionScope.user.fullName != null ? sessionScope.user.fullName : 'Guest'}" /></h1>

  <!-- Flight Search by Flight Number -->
  <div class="search-section">
    <form action="${pageContext.request.contextPath}/flight" method="get">
      <input type="text" name="flightId" placeholder="Search by Flight No." value="${fn:escapeXml(param.flightId)}" />
      <button type="submit">Search</button>
    </form>
  </div>

  <!-- Ticket Overview Table -->
  <h2>Your Ticket Overview</h2>
  <table class="overview-table">
    <thead>
      <tr>
        <th>Flight Number</th>
        <th>Date</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="ticket" items="${tickets}">
        <tr>
          <td><c:out value="${ticket.flightId}" /></td>
          <td><c:out value="${ticket.departureDateFormatted}" /></td>
        </tr>
      </c:forEach>
      <c:if test="${empty tickets}">
        <tr><td colspan="2">No tickets found.</td></tr>
      </c:if>
    </tbody>
  </table>

  <!-- Ticket Details Card -->
  <c:forEach var="ticket" items="${tickets}">
    <div class="ticket-card">
      <p><strong>Flight ID:</strong> <c:out value="${ticket.flightId}" /></p>
      <p><strong>Date:</strong> <c:out value="${ticket.departureDateFormatted}" /></p>
      <p><strong>Time:</strong> <c:out value="${ticket.departureTimeFormatted}" /></p>
      <p><strong>Class:</strong> <c:out value="${ticket.travelClass}" /></p>
    </div>
  </c:forEach>

  <!-- Trip Search -->
  <h2>Find Your Flight</h2>
  <form class="finder" action="${pageContext.request.contextPath}/flight" method="get">
    <div>
      <label><input type="radio" name="tripType" value="oneWay" checked /> One Way</label>
      <label><input type="radio" name="tripType" value="roundTrip" /> Round Trip</label>
    </div>
    <div>
      <input type="text" name="from" placeholder="From?" value="${fn:escapeXml(param.from)}" />
      <input type="text" name="to" placeholder="To?" value="${fn:escapeXml(param.to)}" />
    </div>
    <div>
      <input type="date" name="departureDate" value="${param.departureDate}" />
      <input type="date" name="returnDate" value="${param.returnDate}" />
    </div>
    <div>
      <select name="travelClass">
        <option value="">Select Class</option>
        <option value="Economy" ${param.travelClass == 'Economy' ? 'selected' : ''}>Economy</option>
        <option value="Business" ${param.travelClass == 'Business' ? 'selected' : ''}>Business</option>
      </select>
      <input type="number" name="passengers" min="1" max="10" value="${param.passengers != null ? param.passengers : 1}" />
    </div>
    <button type="submit">Search Flights</button>
  </form>

  <!-- Recent Ticket Section -->
  <h2>Your Recent Ticket</h2>
  <c:choose>
    <c:when test="${not empty recentTicket}">
      <div class="ticket-card">
        <p><strong>Booking Ref:</strong> <c:out value="${recentTicket.bookingRef}" /></p>
        <p><strong>Flight No:</strong> <c:out value="${recentTicket.flightId}" /></p>
        <p><strong>Route:</strong> <c:out value="${recentTicket.fromCity}" /> → <c:out value="${recentTicket.toCity}" /></p>
        <p><strong>Date:</strong> <c:out value="${recentTicket.departureDateFormatted}" /></p>
        <p><strong>Time:</strong> <c:out value="${recentTicket.departureTimeFormatted}" /></p>
        <p><strong>Class:</strong> <c:out value="${recentTicket.travelClass}" /></p>
        <p><strong>Status:</strong> <c:out value="${recentTicket.status}" /></p>

        <!-- Cancel Form -->
        <form action="${pageContext.request.contextPath}/cancelBooking" method="post">
          <input type="hidden" name="bookingRef" value="${fn:escapeXml(recentTicket.bookingRef)}" />
          <button type="submit" style="background:#e74c3c;color:white;padding:8px 16px;border:none;border-radius:5px;">
            Cancel Booking
          </button>
        </form>
      </div>
    </c:when>
    <c:otherwise>
      <p style="text-align:center;">You have no recent ticket.</p>
    </c:otherwise>
  </c:choose>
</body>
</html>
