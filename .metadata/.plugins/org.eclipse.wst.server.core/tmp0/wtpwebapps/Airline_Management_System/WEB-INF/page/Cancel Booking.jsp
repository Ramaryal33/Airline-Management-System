<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Cancel Booking - Dawn Airlines</title>
  <style>
    /* Base styles */
    body {
      background: #f7f9fc;
      font-family: 'Open Sans', Arial, sans-serif;
      color: #333;
      margin: 0;
      padding: 20px;
      box-sizing: border-box;
    }
    .cancel-card {
      background: #fff;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      width: 90%;
      max-width: 600px;
      margin: 20px auto;
      padding: 20px;
      box-sizing: border-box;
    }
    .cancel-card h2 {
      color: #2c3e50;
      margin-bottom: 20px;
      text-align: center;
      font-size: 1.5rem;
    }
    .info-list {
      display: flex;
      justify-content: space-between;
      gap: 20px;
      margin-bottom: 20px;
      flex-wrap: wrap;
    }
    .info-list .left-info,
    .info-list .right-info {
      flex: 1;
      background: #fafafa;
      padding: 15px;
      border-radius: 6px;
      box-sizing: border-box;
      min-width: 250px;
    }
    .info-list p {
      margin: 8px 0;
      font-size: 0.95rem;
      line-height: 1.4;
    }
    .info-list strong {
      color: #2c3e50;
      display: inline-block;
      width: 100px;
    }
    label {
      display: block;
      margin-bottom: 8px;
      font-weight: bold;
    }
    select {
      width: 100%;
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 4px;
      font-size: 1rem;
      box-sizing: border-box;
      margin-bottom: 15px;
    }
    .confirm-box {
      margin: 15px 0;
      display: flex;
      align-items: center;
    }
    .confirm-box input {
      margin-right: 6px;
    }
    .button-group {
      display: flex;
      justify-content: center;
      gap: 15px;
      flex-wrap: wrap;
      margin-top: 20px;
    }
    .button-group button {
      padding: 12px 24px;
      border: none;
      border-radius: 6px;
      font-weight: bold;
      cursor: pointer;
      font-size: 1rem;
      transition: background 0.3s;
      box-sizing: border-box;
      white-space: nowrap;
    }
    .cancel-booking {
      background: #e74c3c;
      color: #fff;
    }
    .cancel-booking:disabled {
      background: #f5a6a4;
      cursor: not-allowed;
    }
    .cancel-booking:hover:enabled {
      background: #c0392b;
    }
    .go-back {
      background: #7f8c8d;
      color: #fff;
    }
    .go-back:hover {
      background: #606a6d;
    }

    /* Responsive adjustments */
    @media (max-width: 480px) {
      .cancel-card {
        padding: 15px;
      }
      .cancel-card h2 {
        font-size: 1.3rem;
      }
      .info-list {
        flex-direction: column;
        gap: 15px;
      }
      .info-list .left-info,
      .info-list .right-info {
        min-width: auto;
      }
      .button-group {
        flex-direction: column;
      }
      .button-group button {
        width: 100%;
        padding: 12px;
      }
    }
  </style>
</head>
<body>
  <div class="cancel-card">
    <h2>Cancel Booking</h2>

    <c:if test="${not empty requestScope.bookingToCancel}">
      <div class="info-list">
        <div class="left-info">
          <p><strong>Booking Ref:</strong> <c:out value="${bookingToCancel.bookingRef}" /></p>
          <p><strong>Flight #:</strong> <c:out value="${bookingToCancel.flightId}" /></p>
          <p><strong>From:</strong> <c:out value="${bookingToCancel.fromCity}" /></p>
          <p><strong>To:</strong> <c:out value="${bookingToCancel.toCity}" /></p>
          <p><strong>Date:</strong> <c:out value="${bookingToCancel.departureDateFormatted}" /></p>
          <p><strong>Time:</strong> <c:out value="${bookingToCancel.departureTimeFormatted}" /></p>
          <p><strong>Class:</strong> <c:out value="${bookingToCancel.travelClass}" /></p>
        </div>
        <div class="right-info">
          <p><strong>Passengers:</strong> <c:out value="${bookingToCancel.numOfPassengers}" /></p>
          <p><strong>Total Paid:</strong>
            <fmt:formatNumber
              value="${bookingToCancel.totalPrice}"
              type="currency"
              currencySymbol="NPR "
            />
          </p>
          <p><strong>Status:</strong> <c:out value="${bookingToCancel.status}" /></p>
        </div>
      </div>

      <form action="${pageContext.request.contextPath}/cancelBooking" method="post">
        <input type="hidden" name="bookingId" value="${bookingToCancel.bookingId}" />

        <label for="reason">Select reason for cancellation:</label>
        <select name="reason" id="reason" required>
          <option value="">CHOOSE REASON…</option>
          <option>Schedule issues</option>
          <option>Health issue</option>
          <option>Family issue</option>
          <option>Changed plans</option>
          <option>Service issues</option>
          <option>Personal</option>
          <option>Other</option>
        </select>

        <div class="confirm-box">
          <input type="checkbox" id="confirm" name="confirm" />
          <label for="confirm">I confirm I want to cancel this booking</label>
        </div>

        <div class="button-group">
          <button
            id="cancel-btn"
            class="cancel-booking"
            type="submit"
            disabled
          >
            Cancel Booking
          </button>
          <button
            type="button"
            class="go-back"
            onclick="location.href='${pageContext.request.contextPath}/passengerDashboard'"
          >
            Go Back
          </button>
        </div>
      </form>

      <script>
        const chk = document.getElementById('confirm');
        const btnCancel = document.getElementById('cancel-btn');
        chk.addEventListener('change', () => {
          btnCancel.disabled = !chk.checked;
        });
      </script>
    </c:if>

    <c:if test="${empty requestScope.bookingToCancel}">
      <p style="text-align:center; color:#555;">
        No booking found to cancel.
      </p>
      <div style="text-align:center; margin-top:20px;">
        <button
          class="go-back"
          onclick="location.href='${pageContext.request.contextPath}/passengerDashboard'"
        >
          Go Back
        </button>
      </div>
    </c:if>
  </div>
</body>
</html>
