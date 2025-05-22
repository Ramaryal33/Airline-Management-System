<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Search Flights - Dawn Airlines</title>
  <style>
    /* Minimal table styling */
    body { background:#f7f9fc; font-family:'Open Sans',Arial,sans-serif; color:#333; padding:20px;}
    h2 { margin-bottom:20px; color:#2c3e50; }
    table { width:100%; border-collapse:collapse; margin-bottom:20px; }
    th, td { padding:12px; border:1px solid #ddd; text-align:left; }
    th { background:#ecf0f1; font-weight:bold; }
    tr:hover { background:#f1f1f1; }
    .book-form input[type="number"] { width:60px; padding:4px; margin-right:8px; border:1px solid #ccc; border-radius:4px; }
    .book-form button { background:#28a745; color:#fff; border:none; padding:6px 12px; border-radius:4px; cursor:pointer; transition:background .3s; }
    .book-form button:hover { background:#1e7e34; }
    .error { color:red; text-align:center; margin-bottom:15px; }
  </style>
</head>
<body>
  <h2>Available Flights</h2>

  <c:if test="${not empty requestScope.error}">
    <div class="error">${requestScope.error}</div>
  </c:if>

  <c:if test="${not empty requestScope.flights}">
    <table>
      <thead>
        <tr>
          <th>Flight #</th>
          <th>Route</th>
          <th>Date</th>
          <th>Time</th>
          <th>Class</th>
          <th>Price</th>
          <th>Book</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="f" items="${requestScope.flights}">
          <tr>
            <td><c:out value="${f.flightId}" /></td>
            <td><c:out value="${f.fromCity}" /> → <c:out value="${f.toCity}" /></td>
            <td><c:out value="${f.departureDateFormatted}" /></td>
            <td><c:out value="${f.departureTimeFormatted}" /></td>
            <td><c:out value="${f.travelClass}" /></td>
            <td>
              <fmt:formatNumber value="${f.price}" type="currency" currencySymbol="NPR " />
            </td>
            <td>
              <form class="book-form" action="${pageContext.request.contextPath}/createBooking" method="post">
                <input type="hidden" name="flightId" value="${f.flightId}" />
                <input type="number" name="numOfPassengers" value="1" min="1" required />
                <button type="submit">Book</button>
              </form>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </c:if>

  <c:if test="${empty requestScope.flights}">
    <p style="text-align:center; color:#555;">No flights found for your criteria.</p>
  </c:if>
</body>
</html>
