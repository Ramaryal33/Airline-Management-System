<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Booking Confirmation - Dawn Airlines</title>
                <style>
                    /* RESET & GLOBAL STYLES */
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                        font-family: 'Open Sans', Arial, sans-serif;
                    }

                    body {
                        display: flex;
                        min-height: 100vh;
                        background: #f7f9fc;
                        color: #333;
                    }

                    /* SIDEBAR */
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

                    .sidebar nav .bottom {
                        margin-top: 300px;
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

                    /* MAIN CONTENT */
                    .main {
                        margin-left: 250px;
                        flex: 1;
                        padding: 40px;
                    }

                    .confirmation-box {
                        background: #fff;
                        padding: 30px;
                        border-radius: 8px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                        max-width: 700px;
                        margin: 0 auto;
                        text-align: center;
                    }

                    .confirmation-box h2 {
                        color: #0a1c2c;
                        margin-bottom: 20px;
                    }

                    .confirmation-msg {
                        font-size: 1.1rem;
                        color: #555;
                        margin-bottom: 30px;
                    }

                    .booking-ref {
                        font-weight: bold;
                        color: #1976d2;
                        margin-bottom: 30px;
                    }

                    .flight-summary {
                        background: #fafafa;
                        padding: 20px;
                        border-radius: 6px;
                        margin-bottom: 30px;
                        text-align: left;
                    }

                    .flight-summary h4 {
                        margin-bottom: 15px;
                        color: #0a1c2c;
                    }

                    .flight-summary p {
                        margin: 8px 0;
                        color: #555;
                    }

                    .flight-summary .summary-price {
                        font-weight: bold;
                        margin-top: 10px;
                        color: #1976d2;
                    }

                    .btn-continue {
                        background: #28a745;
                        color: #fff;
                        padding: 10px 20px;
                        border: none;
                        border-radius: 4px;
                        font-weight: 600;
                        cursor: pointer;
                        text-decoration: none;
                        transition: background .3s, transform .2s;
                    }

                    .btn-continue:hover {
                        background: #1e7e34;
                        transform: scale(1.03);
                    }

                    @media(max-width:900px) {
                        .sidebar {
                            position: static;
                            width: 100%;
                            height: auto;
                            flex-direction: row;
                            flex-wrap: wrap;
                            justify-content: center;
                            padding: 10px;
                        }

                        .sidebar nav {
                            flex-direction: row;
                            flex-wrap: wrap;
                            justify-content: center;
                            width: 100%;
                        }

                        .sidebar nav a {
                            margin: 5px;
                            padding: 8px 10px;
                            font-size: .9rem;
                        }

                        .sidebar nav .bottom {
                            margin-top: 0;
                        }

                        .main {
                            margin-left: 0;
                            padding: 20px;
                        }
                    }
                </style>
            </head>

            <body>
                <div class="sidebar">
                    <img src="${basePath}/images/plane.png" alt="Airline Logo" class="logo" />
                    <nav>
                        <a href="${basePath}/passengerDashboard">Dashboard</a>
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
                    <div class="confirmation-box">
                        <h2>Booking Confirmed!</h2>

                        <c:choose>
                            <c:when test="${empty selectedFlight}">
                                <p class="confirmation-msg">
                                    Oops! We couldn’t retrieve your flight details. Please go back and try again.
                                </p>
                                <a href="${basePath}/passengerDashboard" class="btn-continue">
                                    Go to Dashboard
                                </a>
                            </c:when>
                            <c:otherwise>
                                <p class="confirmation-msg">
                                    Thank you for booking with Dawn Airlines! Your booking reference is:
                                </p>
                                <p class="booking-ref">
                                    <c:out value="${bookingRef}" />
                                </p>

                                <div class="flight-summary">
                                    <h4>Flight Summary</h4>
                                    <p><strong>Flight Number:</strong>
                                        <c:out value="${selectedFlight.flightId}" />
                                    </p>
                                    <p><strong>Route:</strong>
                                        <c:out value="${selectedFlight.fromCity}" /> →
                                        <c:out value="${selectedFlight.toCity}" />
                                    </p>
                                    <p><strong>Date:</strong>
                                        <c:out value="${depDateStr}" />, <strong>Time:</strong>
                                        <c:out value="${depTimeStr}" />
                                    </p>
                                    <p><strong>Class:</strong>
                                        <c:out value="${selectedFlight.travelClass}" />
                                    </p>
                                    <p class="summary-price">
                                        <strong>Total Paid:</strong> NPR 
                                        <fmt:formatNumber value="${totalPaid}" minFractionDigits="2" />
                                    </p>
                                </div>

                                <a href="${basePath}/passengerDashboard" class="btn-continue">
                                    Go to Dashboard
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </body>

            </html>