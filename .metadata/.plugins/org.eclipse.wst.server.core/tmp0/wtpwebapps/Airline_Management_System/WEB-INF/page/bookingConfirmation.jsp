<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Booking Confirmation - Dawn Airlines</title>
  <style>
    /* Base styles */
    body {
      background: #f7f9fc;
      font-family: 'Open Sans', Arial, sans-serif;
      color: #333;
      padding: 20px;
      margin: 0;
    }
    .confirmation-box {
      background: #fff;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      width: 90%;
      max-width: 600px;
      margin: 20px auto;
      padding: 30px;
      box-sizing: border-box;
      text-align: center;
    }
    .confirmation-box h2 {
      color: #2c3e50;
      margin-bottom: 20px;
      font-size: 1.5rem;
    }
    .flight-summary {
      background: #fafafa;
      padding: 20px;
      text-align: left;
      border-radius: 6px;
      margin: 20px 0;
    }
    .flight-summary p {
      margin: 8px 0;
      line-height: 1.4;
    }
    .flight-summary strong {
      display: inline-block;
      width: 100px;
    }
    .summary-price {
      font-weight: bold;
      margin-top: 10px;
      color: #1976d2;
    }
    .btn-continue {
      background: #28a745;
      color: white;
      padding: 12px 24px;
      border: none;
      border-radius: 6px;
      font-size: 1rem;
      text-decoration: none;
      cursor: pointer;
      transition: background 0.3s;
      display: inline-block;
      box-sizing: border-box;
      white-space: nowrap;
    }
    .btn-continue:hover {
      background: #1e7e34;
    }

    /* Responsive adjustments */
    @media (max-width: 480px) {
      .confirmation-box {
        padding: 20px;
      }
      .confirmation-box h2 {
        font-size: 1.3rem;
      }
      .flight-summary {
        padding: 15px;
      }
      .flight-summary strong {
        width: 80px;
      }
      .btn-continue {
        width: 100%;
        padding: 12px 0;
        font-size: 1rem;
      }
    }
  </style>
</head>
<body>
  <div class="confirmation-box">
    <h2>Booking Confirmed!</h2>

    <c:choose>
      <c:when test="${empty sessionScope.selectedBooking}">
        <p>Oops! We couldn’t retrieve your booking details.</p>
        <a href="${pageContext.request.contextPath}/passengerDashboard" class="btn-continue">
          Go to Dashboard
        </a>
      </c:when>
      <c:otherwise>
        <c:set var="b" value="${sessionScope.selectedBooking}" />
        <jsp:useBean id="fService" class="com.airline.service.FlightService" scope="page" />
        <c:set var="flight" value="${fService.getFlightById(b.flightId)}" />

        <p>
          Thank you for booking with Dawn Airlines!<br/>
          Your booking reference is:
        </p>
        <p style="font-size:1.2rem; font-weight:bold; color:#1976d2;">
          <c:out value="${b.bookingRef}" />
        </p>

        <div class="flight-summary">
          <p><strong>Flight No:</strong> <c:out value="${b.flightId}" /></p>
          <p><strong>Route:</strong> <c:out value="${flight.fromCity}" /> → <c:out value="${flight.toCity}" /></p>
          <p>
            <strong>Date:</strong>
            <fmt:formatDate value="${flight.departureDate}" pattern="MMM dd, yyyy" /><br/>
            <strong>Time:</strong>
            <fmt:formatDate value="${flight.departureTime}" pattern="hh:mm a" />
          </p>
          <p><strong>Class:</strong> <c:out value="${flight.travelClass}" /></p>
          <p class="summary-price">
            Total Paid:
            <fmt:formatNumber value="${b.totalPrice}" type="currency" currencySymbol="NPR " />
          </p>
        </div>

        <form action="${pageContext.request.contextPath}/payment" method="get">
          <button type="submit" class="btn-continue">Proceed to Payment</button>
        </form>
      </c:otherwise>
    </c:choose>
  </div>
</body>
</html>