<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Search Flights - Dawn Airlines</title>
                <style>
                    /* [Styles unchanged for brevity — core additions at bottom] */
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                        font-family: 'Open Sans', Arial, sans-serif;
                    }

                    sbody {
                        display: flex;
                        min-height: 100vh;
                        background: #f7f9fc;
                        color: #333;
                    }

                    .sidebar {
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 250px;
                        height: 100vh;
                        padding: 20px;
                        color: #ecf0f1;
                        background: linear-gradient(135deg, #2c3e50 0%, #3d566e 100%);
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                    }

                    .sidebar img.logo {
                        width: 100px;
                        margin-bottom: 55px;
                        border-radius: 50%;
                    }

                    .sidebar nav a {
                        display: block;
                        color: #ecf0f1;
                        text-decoration: none;
                        padding: 10px 15px;
                        margin: 8px 0;
                        border-radius: 5px;
                        text-align: center;
                        font-weight: 600;
                        transition: background 0.3s, transform 0.3s;
                    }

                    .sidebar nav a:hover {
                        background: rgba(255, 255, 255, 0.1);
                        transform: translateX(5px);
                    }

                    .sidebar nav .bottom {
                        margin-top: 300px;
                    }

                    .main {
                        margin-left: 250px;
                        flex: 1;
                        padding: 40px;
                    }

                    .search-box {
                        background: #fff;
                        padding: 30px;
                        border-radius: 8px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                        max-width: 700px;
                        margin: 0 auto 40px;
                    }

                    .search-box h2 {
                        margin-bottom: 20px;
                        color: #0a1c2c;
                    }

                    .form-row {
                        display: flex;
                        gap: 15px;
                        margin-bottom: 15px;
                    }

                    .form-row input,
                    .form-row select {
                        flex: 1;
                        padding: 10px;
                        border-radius: 4px;
                        border: 1px solid #ccc;
                    }

                    .trip-type {
                        display: flex;
                        gap: 20px;
                        margin-bottom: 20px;
                    }

                    .trip-type label {
                        font-weight: 500;
                    }

                    .search-box button {
                        background-color: #1976d2;
                        color: white;
                        padding: 10px 20px;
                        border: none;
                        border-radius: 4px;
                        font-weight: 600;
                        cursor: pointer;
                        display: block;
                        margin: 0 auto;
                        transition: background-color 0.3s, transform 0.2s;
                    }

                    .search-box button:hover {
                        background-color: #1256a2;
                        transform: translateY(-2px);
                    }

                    .flight-results {
                        max-width: 800px;
                        margin: 0 auto;
                    }

                    .flight-card {
                        background: white;
                        padding: 20px;
                        border-radius: 6px;
                        box-shadow: 0 1px 6px rgba(0, 0, 0, 0.08);
                        margin-bottom: 20px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        transition: box-shadow 0.3s, transform 0.3s;
                    }

                    .flight-card:hover {
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                        transform: translateY(-4px);
                    }

                    .flight-info {
                        flex: 1;
                    }

                    .flight-info h4 {
                        margin: 0;
                        color: #333;
                    }

                    .flight-info p {
                        margin: 5px 0;
                        color: #666;
                    }

                    .flight-price {
                        font-weight: bold;
                        font-size: 1.1rem;
                        margin-bottom: 10px;
                    }

                    .btn-book {
                        background-color: #28a745;
                        color: white;
                        padding: 8px 14px;
                        border: none;
                        border-radius: 4px;
                        font-weight: 500;
                        cursor: pointer;
                        transition: background-color 0.3s, transform 0.2s;
                    }

                    .btn-book:hover {
                        background-color: #1e7e34;
                        transform: scale(1.05);
                    }

                    .disabled-input {
                        opacity: 0.5;
                        pointer-events: none;
                    }

                    @media(max-width:900px) {
                        /* responsive styles */
                    }
                </style>

                <script>
                    function toggleReturnDate() {
                        const roundTrip = document.querySelector('input[value="round"]');
                        const returnDateInput = document.querySelector('input[name="returnDate"]');

                        if (roundTrip.checked) {
                            returnDateInput.disabled = false;
                            returnDateInput.classList.remove('disabled-input');
                        } else {
                            returnDateInput.disabled = true;
                            returnDateInput.classList.add('disabled-input');
                            returnDateInput.value = '';
                        }
                    }

                    window.onload = toggleReturnDate;
                </script>
            </head>

            <body>
                <div class="sidebar">
                    <img src="plane.png" alt="Airline Logo" class="logo" />
                    <nav>
                        <a href="${pageContext.request.contextPath}/passengerDashboard">Dashboard</a>
                        <a href="${pageContext.request.contextPath}/searchFlight" class="active">Search Flights</a>
                        <a href="${pageContext.request.contextPath}/payment">Payment</a>
                        <a href="${pageContext.request.contextPath}/cancelBooking">Cancel Bookings</a>
                        <a href="${pageContext.request.contextPath}/contact">Contact Us</a>
                        <a href="${pageContext.request.contextPath}/logout">Log out</a>
                        <div class="bottom">
                            <a href="${pageContext.request.contextPath}/passengerProfile">Settings</a>
                        </div>
                    </nav>
                </div>

                <div class="main">
                    <div class="search-box">
                        <h2>Find Your Flight</h2>
                        <form action="${pageContext.request.contextPath}/searchFlight" method="post">
                            <div class="form-row trip-type">
                                <label>
                                    <input type="radio" name="tripType" value="oneway" checked
                                        onchange="toggleReturnDate()" />
                                    One Way
                                </label>
                                <label>
                                    <input type="radio" name="tripType" value="round" onchange="toggleReturnDate()" />
                                    Round Trip
                                </label>
                            </div>

                            <div class="form-row">
                                <select name="from" required>
                                    <option value="">From?</option>
                                    <c:forEach var="city" items="${fromCities}">
                                        <option value="${city}" <c:if test="${city==paramFrom}">selected</c:if>>${city}
                                        </option>
                                    </c:forEach>
                                </select>
                                <select name="to" required>
                                    <option value="">To?</option>
                                    <c:forEach var="city" items="${toCities}">
                                        <option value="${city}" <c:if test="${city==paramTo}">selected</c:if>>${city}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-row">
                                <input type="date" name="departureDate" value="${paramDateStr}" required />
                                <input type="date" name="returnDate" title="Leave blank for one-way trips"
                                    class="disabled-input" disabled />
                            </div>

                            <div class="form-row">
                                <select name="travelClass" required>
                                    <option value="">Select Class</option>
                                    <c:forEach var="cls" items="${travelClasses}">
                                        <option value="${cls}" <c:if test="${cls==paramClass}">selected</c:if>>${cls}
                                        </option>
                                    </c:forEach>
                                </select>
                                <input type="number" name="passengers" min="1" max="10"
                                    value="${paramPassengers != null ? paramPassengers : 1}" required />
                            </div>

                            <button type="submit">Search Flights</button>
                        </form>
                    </div>

                    <div class="flight-results">
                        <c:choose>
                            <c:when test="${empty paramFrom}">
                                <p style="text-align:center; color:#666; margin-top:20px;">
                                    Please fill in the form above to search for flights.
                                </p>
                            </c:when>
                            <c:when test="${not empty paramFrom and empty filteredFlights}">
                                <p style="text-align:center; color:#666; margin-top:20px;">
                                    No flights found for <strong>${paramFrom} → ${paramTo}</strong> on
                                    <strong>${paramDateStr}</strong> (Class: ${paramClass}).
                                </p>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="f" items="${filteredFlights}">
                                    <div class="flight-card">
                                        <div class="flight-info">
                                            <h4>Flight:
                                                <c:out value="${f.flightId}" />
                                            </h4>
                                            <p>From:
                                                <c:out value="${f.fromCity}" /> –
                                                <c:out value="${f.toCity}" />
                                            </p>
                                            <p>Date:
                                                <c:out value="${f.departureDate}" /> | Time:
                                                <c:out value="${f.departureTime}" />
                                            </p>
                                            <p class="flight-price">NPR
                                                <fmt:formatNumber value="${f.price}" type="number"
                                                    minFractionDigits="2" />
                                            </p>
                                        </div>
                                        <form method="get" action="${pageContext.request.contextPath}/flightDetails">
                                            <input type="hidden" name="flightId" value="${f.flightId}" />
                                            <button type="submit" class="btn-book">Book Flight</button>
                                        </form>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <script>
                    function toggleReturnDate() {
                        const roundTrip = document.querySelector('input[value="round"]');
                        const returnDateInput = document.querySelector('input[name="returnDate"]');

                        if (roundTrip.checked) {
                            returnDateInput.disabled = false;
                            returnDateInput.classList.remove('disabled-input');
                        } else {
                            returnDateInput.disabled = true;
                            returnDateInput.classList.add('disabled-input');
                            returnDateInput.value = '';
                        }
                    }

                    window.onload = toggleReturnDate;
                </script>
            </body>

            </html>