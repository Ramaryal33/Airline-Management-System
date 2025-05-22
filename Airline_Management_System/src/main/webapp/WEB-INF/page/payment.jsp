<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <title>Payment - Dawn Airlines</title>
  <style>
    body { background:#f7f9fc; font-family:'Open Sans',Arial,sans-serif; color:#333; padding:40px; }
    .payment-container {
      background:#fff; padding:25px; border-radius:8px; max-width:500px; margin:auto;
      box-shadow:0 2px 8px rgba(0,0,0,0.1);
    }
    .payment-container h2 {
      margin-bottom:20px; color:#2c3e50; text-align:center;
    }
    .payment-container p { margin-bottom:15px; }
    .payment-container label {
      display:block; margin:10px 0 5px; font-weight:bold;
    }
    .payment-container input {
      width:100%; padding:10px; border:1px solid #ccc; border-radius:6px;
      margin-bottom:15px; font-size:1rem;
    }
    .payment-container button {
      background:#28a745; color:#fff; border:none; padding:12px 20px; border-radius:6px;
      font-size:1rem; cursor:pointer; transition:background .3s; width:100%;
    }
    .payment-container button:hover { background:#1e7e34; }
    .success { margin:15px 0; color:green; text-align:center; }
    .error { margin:15px 0; color:red; text-align:center; }
  </style>
</head>
<body>
  <div class="payment-container">
    <h2>Complete Payment</h2>

    <c:if test="${not empty requestScope.success}">
      <p class="success">${requestScope.success}</p>
    </c:if>
    <c:if test="${not empty requestScope.error}">
      <p class="error">${requestScope.error}</p>
    </c:if>

    <c:if test="${sessionScope.selectedBooking != null}">
      <p>
        Booking Ref: <strong><c:out value="${sessionScope.selectedBooking.bookingRef}" /></strong><br/>
        Amount Due:&nbsp;
        <fmt:formatNumber
          value="${sessionScope.selectedBooking.totalPrice}"
          type="currency"
          currencySymbol="NPR "
        />
      </p>

      <form method="post" action="${pageContext.request.contextPath}/payment">
        <label for="cardNumber">Card Number:</label>
        <input
          type="text"
          id="cardNumber"
          name="cardNumber"
          placeholder="XXXX-XXXX-XXXX-XXXX"
          required
        />

        <label for="expiry">Expiry (MM/YY):</label>
        <input type="text" id="expiry" name="expiry" placeholder="MM/YY" required/>

        <label for="cvv">CVV:</label>
        <input type="password" id="cvv" name="cvv" maxlength="3" required/>

        <button type="submit">Pay Now</button>
      </form>
    </c:if>
    <c:if test="${sessionScope.selectedBooking == null}">
      <p style="text-align:center; color:#555;">
        No booking found. Please <a href="${pageContext.request.contextPath}/searchFlight">search flights</a> first.
      </p>
    </c:if>
  </div>
</body>
</html>
