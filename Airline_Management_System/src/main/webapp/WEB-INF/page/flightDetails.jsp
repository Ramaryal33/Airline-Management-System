<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Flight Details - Dawn Airlines</title>
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

                    /* MAIN CONTENT */
                    .main {
                        margin-left: 250px;
                        flex: 1;
                        padding: 40px;
                    }

                    .details-box {
                        background: #fff;
                        padding: 30px;
                        border-radius: 8px;
                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                        max-width: 800px;
                        margin: 0 auto;
                    }

                    .details-box h2 {
                        margin-bottom: 20px;
                        color: #0a1c2c;
                        text-align: center;
                    }

                    /* FLIGHT INFO CARD */
                    .flight-card {
                        background: #fff;
                        padding: 20px;
                        border-radius: 6px;
                        box-shadow: 0 1px 6px rgba(0, 0, 0, 0.08);
                        margin-bottom: 20px;
                        transition: transform .3s, box-shadow .3s;
                    }

                    .flight-card:hover {
                        transform: translateY(-4px);
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
                    }

                    .flight-info {
                        margin-bottom: 10px;
                    }

                    .flight-info h4 {
                        margin-bottom: 10px;
                        color: #333;
                    }

                    .flight-info p {
                        margin: 5px 0;
                        color: #555;
                    }

                    .flight-price {
                        font-weight: bold;
                        font-size: 1.2rem;
                        color: #1976d2;
                        margin-top: 10px;
                    }

                    /* ITINERARY */
                    .itinerary {
                        background: #f0f4f8;
                        padding: 20px;
                        border-radius: 6px;
                        margin-bottom: 10px;
                    }

                    .itinerary h4 {
                        margin-bottom: 10px;
                        color: #0a1c2c;
                        text-align: center;
                    }

                    .itinerary p {
                        margin: 5px 0;
                        color: #555;
                    }

                    /* FARE BREAKDOWN */
                    .fare-breakdown {
                        background: #fafafa;
                        padding: 20px;
                        border-radius: 6px;
                        margin-bottom: 10px;
                    }

                    .fare-breakdown h4 {
                        margin-bottom: 10px;
                        color: #0a1c2c;
                        text-align: center;
                    }

                    .fare-breakdown table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    .fare-breakdown th,
                    .fare-breakdown td {
                        padding: 8px;
                        text-align: left;
                        border-bottom: 1px solid #ddd;
                    }

                    .fare-breakdown .total {
                        font-weight: bold;
                        color: #1976d2;
                    }

                    /* POLICY */
                    .policy {
                        background: #fff3e0;
                        padding: 20px;
                        border-radius: 6px;
                        margin-bottom: 10px;
                    }

                    .policy h4 {
                        margin-bottom: 10px;
                        color: #e65100;
                        text-align: center;
                    }

                    .policy p {
                        margin: 5px 0;
                        color: #5d4037;
                        text-align: center;
                    }

                    /* BUTTONS */
                    .btn {
                        padding: 10px 20px;
                        border: none;
                        border-radius: 4px;
                        font-weight: 600;
                        cursor: pointer;
                        text-decoration: none;
                        color: #fff;
                        display: inline-block;
                        margin-right: 10px;
                        transition: background-color .3s, transform .2s;
                    }

                    .btn-confirm {
                        background: #28a745;
                    }

                    .btn-confirm:hover {
                        background: #1e7e34;
                        transform: scale(1.05);
                    }

                    .btn-back {
                        background: #f44336;
                    }

                    .btn-back:hover {
                        background: #d32f2f;
                        transform: scale(1.05);
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
                    <div class="details-box">
                        <h2>Flight Details</h2>

                        <c:choose>
                            <c:when test="${empty selectedFlight}">
                                <p style="text-align:center;color:#e65100;margin-top:20px;">
                                    Sorry, we couldn’t find that flight. Please go back and select a valid flight.
                                </p>
                                <div style="text-align:center;margin-top:20px;">
                                    <a href="${basePath}/searchFlight" class="btn btn-back">Back</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="flight-card">
                                    <div class="flight-info">
                                        <h4>Flight Number:
                                            <c:out value="${selectedFlight.flightId}" />
                                        </h4>
                                        <p><strong>Route:</strong>
                                            <c:out value="${selectedFlight.fromCity}" /> →
                                            <c:out value="${selectedFlight.toCity}" />
                                        </p>
                                        <p class="flight-price">
                                            NPR
                                            <fmt:formatNumber value="${totalFare}" type="number"
                                                minFractionDigits="2" />
                                        </p>
                                    </div>
                                </div>

                                <div class="itinerary">
                                    <h4>Further Details:</h4>
                                    <p><strong>From:</strong>
                                        <c:out value="${selectedFlight.fromCity}" />
                                    </p>
                                    <p><strong>Date:</strong>
                                        <c:out value="${depDateStr}" />
                                    </p>
                                    <p><strong>Time:</strong>
                                        <c:out value="${depTimeStr}" />
                                    </p>
                                    <p><strong>To:</strong>
                                        <c:out value="${selectedFlight.toCity}" />
                                    </p>
                                    <p><strong>Baggage:</strong> 15Kg + 5Kg Carry-on</p>
                                </div>

                                <div class="fare-breakdown">
                                    <h4>Fare Breakdown:</h4>
                                    <table>
                                        <tr>
                                            <th>Description</th>
                                            <th>Amount</th>
                                        </tr>
                                        <tr>
                                            <td>Base Fare</td>
                                            <td>NPR
                                                <fmt:formatNumber value="${baseFare}" type="number"
                                                    minFractionDigits="2" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Taxes &amp; Fees</td>
                                            <td>NPR
                                                <fmt:formatNumber value="${taxesFees}" type="number"
                                                    minFractionDigits="2" />
                                            </td>
                                        </tr>
                                        <tr class="total">
                                            <td>Total</td>
                                            <td>NPR
                                                <fmt:formatNumber value="${totalFare}" type="number"
                                                    minFractionDigits="2" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <div class="policy">
                                    <h4>Cancellation Policy:</h4>
                                    <p><strong>Cancellations up to 24h before departure:</strong> Full refund minus NPR
                                        300 fee.</p>
                                    <p><strong>Less than 24h:</strong> 50% refund.</p>
                                </div>

                                <div style="text-align:center;margin-top:20px;">
                                    <a href="${basePath}/searchFlight" class="btn btn-back">Back</a>
                                    <a href="${basePath}/payment?flightId=${selectedFlight.flightId}"
                                        class="btn btn-confirm">Continue Booking</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </body>

            </html>