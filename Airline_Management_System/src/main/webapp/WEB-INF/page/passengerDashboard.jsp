<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Passenger Dashboard</title>
                <style>
                    /* (CSS unchanged except below) */
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                        font-family: 'Open Sans', Arial, sans-serif;
                    }

                    body {
                        color: #333;
                        background: #f7f9fc;
                    }

                    .sidebar {
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 250px;
                        height: 100vh;
                        padding: 20px;
                        color: #ecf0f1;
                        background: linear-gradient(135deg, #2c3e50, #3d566e);
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
                        font-weight: 600;
                        text-align: center;
                        transition: background .3s, transform .3s;
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
                        padding: 20px;
                    }

                    .page-title {
                        font-size: 1.5rem;
                        color: #444;
                        margin-bottom: 20px;
                    }

                    .search-bar {
                        display: flex;
                        margin-bottom: 20px;
                        gap: .5rem;
                    }

                    .search-bar input {
                        flex: 1;
                        padding: 10px;
                        border: 2px solid #ccc;
                        border-radius: 8px;
                    }

                    .search-bar button {
                        padding: 10px 18px;
                        border: none;
                        border-radius: 8px;
                        background: #1A73E8;
                        color: #fff;
                        font-weight: 600;
                        cursor: pointer;
                        transition: background .3s, transform .3s;
                    }

                    .search-bar button:hover {
                        background: #1667c1;
                        transform: scale(1.03);
                    }

                    .activity h3 {
                        margin-bottom: 10px;
                        font-weight: 600;
                        color: #555;
                    }

                    .activity-grid {
                        display: flex;
                        gap: 15px;
                        flex-wrap: wrap;
                        margin-bottom: 30px;
                    }

                    .activity-item {
                        flex: 1;
                        min-width: 140px;
                        background: #fff;
                        border-radius: 10px;
                        padding: 15px;
                        text-align: center;
                        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
                        transition: transform .3s, box-shadow .3s;
                    }

                    .activity-item:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                    }

                    .journey-wrapper {
                        display: flex;
                        gap: 20px;
                        margin-top: 20px;
                        width: 100%;
                    }

                    .search-box,
                    .calendar {
                        flex: 1;
                        background: #fff;
                        padding: 25px;
                        border-radius: 10px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                    }

                    .search-box h2,
                    .calendar h3 {
                        margin-bottom: 20px;
                        color: #0a1c2c;
                    }

                    .trip-type {
                        display: flex;
                        gap: 20px;
                        margin-bottom: 20px;
                    }

                    .trip-type label {
                        display: flex;
                        align-items: center;
                        gap: 5px;
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
                        border: 1px solid #ccc;
                        border-radius: 4px;
                    }

                    .search-box button {
                        background: #1976d2;
                        color: #fff;
                        padding: 10px 20px;
                        border: none;
                        border-radius: 4px;
                        font-weight: 600;
                        cursor: pointer;
                        display: block;
                        margin: 20px auto 0;
                        transition: background .3s, transform .3s;
                    }

                    .search-box button:hover {
                        background: #145ca8;
                        transform: scale(1.03);
                    }

                    .ticket-details {
                        background: #eef6ff;
                        border: 2px dashed #1A73E8;
                        padding: 20px;
                        border-radius: 8px;
                        margin-top: 10px;
                    }

                    .ticket-details h4 {
                        margin-bottom: 10px;
                        color: #1A73E8;
                    }

                    .ticket-details p {
                        margin: 6px 0;
                        color: #333;
                    }

                    .ticket-section {
                        border: 1px solid #ccc;
                        padding: 15px;
                        margin: 20px 0;
                        border-radius: 8px;
                        background-color: #f9f9f9;
                    }

                    .ticket-section h2 {
                        margin-top: 0;
                    }

                    .ticket-section p {
                        margin: 5px 0;
                    }

                    .disabled-date {
                        background-color: #eee;
                        pointer-events: none;
                        opacity: 0.6;
                    }

                    @media (max-width:900px) {
                        .journey-wrapper {
                            flex-direction: column;
                        }
                    }
                </style>
            </head>

            <body>
                <div class="sidebar">
                    <img src="${basePath}/image/plane.png" alt="Airline Logo" class="logo" />
                    <nav>
                        <a href="${basePath}/passengerDashboard" class="active">Dashboard</a>
                        <a href="${basePath}/searchFlight">Search Flights</a>
                        <a href="${basePath}/payment">Payment</a>
                        <a href="${basePath}/cancelBooking">Cancel Bookings</a>
                        <a href="${basePath}/contact">Contact Us</a>
                        <a href="${basePath}/logout">Log out</a>
                        <div class="bottom">
                            <a href="${basePath}/passengerProfile">Settings</a>
                        </div>
                    </nav>
                </div>

                <div class="main">
                    <h1 class="page-title">WELCOME,
                        <c:out value="${sessionScope.user.fullName}" />
                    </h1>

                    <div class="search-bar">
                        <input type="text" placeholder="Search by Flight No." />
                        <button>Search</button>
                    </div>

                    <div class="activity">
                        <h3>Your Ticket Overview</h3>
                        <div class="activity-grid">
                            <c:choose>
                                <c:when test="${not empty bookedFlight}">
                                    <div class="activity-item">
                                        <strong>Flight Number</strong><br>
                                        <small>
                                            <c:out value="${bookedFlight.flightId}" />
                                        </small>
                                    </div>
                                    <div class="activity-item">
                                        <strong>Date</strong><br>
                                        <small>
                                            <c:out value="${depDateStr}" />
                                        </small>
                                    </div>
                                    <div class="activity-item">
                                        <strong>Time</strong><br>
                                        <small>
                                            <c:out value="${depTimeStr}" />
                                        </small>
                                    </div>
                                    <div class="activity-item">
                                        <strong>Class</strong><br>
                                        <small>
                                            <c:out value="${bookedFlight.travelClass}" />
                                        </small>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="activity-item"><strong>Flight Number</strong><br><small>N/A</small>
                                    </div>
                                    <div class="activity-item"><strong>Date</strong><br><small>N/A</small></div>
                                    <div class="activity-item"><strong>Time</strong><br><small>N/A</small></div>
                                    <div class="activity-item"><strong>Class</strong><br><small>N/A</small></div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="journey-wrapper">
                        <div class="search-box">
                            <h2>Find Your Flight</h2>
                            <form action="${basePath}/searchFlight" method="post">
                                <div class="trip-type">
                                    <label><input type="radio" name="tripType" value="oneway" checked /> One Way</label>
                                    <label><input type="radio" name="tripType" value="round" /> Round Trip</label>
                                </div>

                                <div class="form-row">
                                    <select name="from" required>
                                        <option value="">From?</option>
                                        <c:forEach var="city" items="${fromCities}">
                                            <option value="${city}">
                                                <c:out value="${city}" />
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <select name="to" required>
                                        <option value="">To?</option>
                                        <c:forEach var="city" items="${toCities}">
                                            <option value="${city}">
                                                <c:out value="${city}" />
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="form-row">
                                    <input type="date" name="departureDate" value="${param.departureDate}" required />
                                    <input type="date" name="returnDate" value="${param.returnDate}"
                                        title="Only for round trips" />
                                </div>

                                <div class="form-row">
                                    <select name="travelClass" required>
                                        <option value="">Select Class</option>
                                        <c:forEach var="cls" items="${travelClasses}">
                                            <option value="${cls}">
                                                <c:out value="${cls}" />
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <input type="number" name="passengers" min="1" max="10" value="${param.passengers}"
                                        required />
                                </div>

                                <button type="submit">Search Flights</button>
                            </form>
                        </div>

                        <div class="calendar">
                            <h3>Your Ticket</h3>
                            <c:choose>
                                <c:when test="${not empty bookedFlight}">
                                    <div class="ticket-details">
                                        <p><strong>Booking Ref:</strong>
                                            <c:out value="${bookingRef}" />
                                        </p>
                                        <p><strong>Flight No:</strong>
                                            <c:out value="${bookedFlight.flightId}" />
                                        </p>
                                        <p><strong>Route:</strong>
                                            <c:out value="${bookedFlight.fromCity}" /> →
                                            <c:out value="${bookedFlight.toCity}" />
                                        </p>
                                        <p><strong>Date:</strong>
                                            <c:out value="${depDateStr}" />
                                        </p>
                                        <p><strong>Time:</strong>
                                            <c:out value="${depTimeStr}" />
                                        </p>
                                        <p><strong>Class:</strong>
                                            <c:out value="${bookedFlight.travelClass}" />
                                        </p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="ticket-details">
                                        <p>No recent booking found. Book a flight to see details here.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <script>
                    function toggleReturnDate(enable) {
                        const returnInput = document.querySelector('input[name="returnDate"]');
                        if (enable) {
                            returnInput.disabled = false;
                            returnInput.classList.remove("disabled-date");
                        } else {
                            returnInput.disabled = true;
                            returnInput.classList.add("disabled-date");
                        }
                    }

                    window.addEventListener("DOMContentLoaded", () => {
                        const tripRadios = document.querySelectorAll('input[name="tripType"]');
                        tripRadios.forEach(radio => {
                            radio.addEventListener("change", () => {
                                toggleReturnDate(radio.value === "round");
                            });
                        });
                        // Set initial state on page load
                        const selected = document.querySelector('input[name="tripType"]:checked');
                        toggleReturnDate(selected && selected.value === "round");
                    });
                </script>
            </body>

            </html>