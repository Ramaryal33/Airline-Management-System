<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Cancel Booking - Dawn Airlines</title>
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
                        transition: all 0.3s ease;
                    }

                    /* SIDEBAR (copied exactly from passenger profile) */
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
                        transition: width 0.3s ease, padding 0.3s ease;
                    }

                    .sidebar nav .bottom {
                        margin-top: 300px;
                    }

                    .sidebar img {
                        width: 100px;
                        margin: 0px 0;
                        border-radius: 50%;
                    }

                    .sidebar .logo {
                        width: 100px;
                        margin-bottom: 55px;
                    }

                    .sidebar nav a {
                        display: block;
                        color: #ecf0f1;
                        text-decoration: none;
                        padding: 10px 15px;
                        margin: 8px 0;
                        border-radius: 5px;
                        transition: background 0.3s, transform 0.3s;
                        text-align: center;
                        font-weight: 600;
                    }

                    .sidebar nav a:hover {
                        background: rgba(255, 255, 255, 0.1);
                        transform: translateX(5px);
                    }

                    /* MAIN CONTENT */
                    .main {
                        margin-left: 250px;
                        flex: 1;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        padding: 20px;
                        transition: padding 0.3s ease;
                    }

                    /* CANCEL CARD */
                    .cancel-card {
                        background: #fff;
                        border-radius: 10px;
                        padding: 25px;
                        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
                        max-width: 600px;
                        width: 100%;
                    }

                    .cancel-card h2 {
                        margin-bottom: 20px;
                        color: #444;
                        font-size: 1.3rem;
                        font-weight: 600;
                    }

                    /* INFO GRID */
                    .info-list {
                        display: flex;
                        gap: 40px;
                        margin-bottom: 20px;
                    }

                    .info-list .left-info {
                        flex: 1;
                    }

                    .info-list .right-info {
                        flex: 1;
                        display: flex;
                        flex-direction: column;
                        justify-content: flex-end;
                    }

                    .info-list p {
                        margin-bottom: 12px;
                        color: #555;
                        white-space: nowrap;
                    }

                    .info-list p strong {
                        width: 140px;
                        display: inline-block;
                    }

                    .info-list hr {
                        border: none;
                        border-top: 1px solid #ccc;
                        margin: 16px 0;
                    }

                    /* FORM ELEMENTS */
                    label {
                        display: block;
                        font-weight: 600;
                        color: #555;
                        margin-bottom: 8px;
                    }

                    select {
                        width: 100%;
                        padding: 10px;
                        border: 2px solid #ccc;
                        border-radius: 8px;
                        font-size: 1rem;
                        outline: none;
                        margin-bottom: 20px;
                    }

                    .confirm-box {
                        display: flex;
                        align-items: center;
                        margin-bottom: 20px;
                    }

                    .confirm-box input {
                        margin-right: 10px;
                        transform: scale(1.2);
                    }

                    /* BUTTON GROUP */
                    .button-group {
                        display: flex;
                        justify-content: flex-end;
                        gap: 15px;
                    }

                    .button-group button.cancel-booking {
                        padding: 10px 20px;
                        border: none;
                        border-radius: 8px;
                        font-weight: 600;
                        cursor: pointer;
                        transition: background 0.3s, transform 0.3s;
                        background: #dc3545;
                        color: #fff;
                    }

                    .button-group button.cancel-booking:disabled {
                        opacity: 0.6;
                        cursor: not-allowed;
                    }

                    .button-group button.cancel-booking:hover {
                        background: #b2223a;
                        transform: scale(1.05);
                    }

                    .button-group button.go-back {
                        padding: 10px 20px;
                        border: none;
                        border-radius: 8px;
                        font-weight: 600;
                        cursor: pointer;
                        transition: background 0.3s, transform 0.3s;
                        background: #1A73E8;
                        color: #fff;
                    }

                    .button-group button.go-back:hover {
                        background: #155cb0;
                        transform: scale(1.05);
                    }

                    .cancel-booking {
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

                    .cancel-booking {
                        background: #f44336;
                    }

                    .cancel-booking:hover {
                        background: #d32f2f;
                        transform: scale(1.05);
                    }

                    .go-back {
                        padding: 10px 20px;
                        border: none;
                        border-radius: 8px;
                        font-weight: 600;
                        cursor: pointer;
                        transition: background 0.3s, transform 0.3s;
                        background: #1A73E8;
                        color: #fff;
                    }

                    .go-back:hover {
                        background: #155cb0;
                        transform: scale(1.05);
                    }

                    /* RESPONSIVE */
                    @media(max-width:900px) {
                        .sidebar {
                            position: static;
                            width: 100%;
                            height: auto;
                            flex-direction: row;
                            flex-wrap: wrap;
                            justify-content: center;
                            padding: 10px;
                            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
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
                            padding: 10px;
                        }

                        .info-list {
                            flex-direction: column;
                            gap: 10px;
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
                        <a href="${basePath}/cancelBooking" class="active">Cancel Bookings</a>
                        <a href="${basePath}/contact">Contact Us</a>
                        <a href="${basePath}/logout">Log out</a>
                        <div class="bottom">
                            <a href="${basePath}/passengerProfile">Settings</a>
                        </div>
                    </nav>
                </div>

                <div class="main">
                    <div class="cancel-card">
                        <h2>Cancel Booking</h2>

                        <c:choose>
                            <c:when test="${empty bookedFlight}">
                                <p style="text-align:center; color:#555;">You have no booking to cancel.</p>
                                <div style="text-align:center; margin-top:20px;">
                                    <a class="go-back" href="${basePath}/passengerDashboard">Go Back</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="info-list">
                                    <div class="left-info">
                                        <p><strong>Name:</strong>
                                            <c:out value="${user.fullName}" />
                                        </p>
                                        <p><strong>Booking Ref:</strong>
                                            <c:out value="${bookingRef}" />
                                        </p>
                                        <p><strong>Flight Number:</strong>
                                            <c:out value="${bookedFlight.flightId}" />
                                        </p>
                                        <p><strong>From:</strong>
                                            <c:out value="${bookedFlight.fromCity}" />
                                        </p>
                                        <p><strong>To:</strong>
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
                                    <div class="right-info">
                                        <p><strong>Ticket Price:</strong> NPR
                                            <fmt:formatNumber value="${totalFare}" minFractionDigits="2" />
                                        </p>
                                        <p><strong>Cancellation Fee:</strong> NPR
                                            <fmt:formatNumber value="${cancellationFee}" minFractionDigits="2" />
                                        </p>
                                        <hr />
                                        <p><strong>Refund Amount:</strong> NPR
                                            <fmt:formatNumber value="${refundAmount}" minFractionDigits="2" />
                                        </p>
                                    </div>
                                </div>

                                <form id="cancelForm" method="post" action="${basePath}/cancelBooking">
                                    <label for="reason">Select reason for cancellation:</label>
                                    <select id="reason" name="reason" required>
                                        <option value="">CHOOSE REASONS...</option>
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
                                        <label for="confirm">Are you sure you want to cancel this flight?</label>
                                    </div>

                                    <div class="button-group">
                                        <a href="${basePath}/passengerDashboard" id="cancelLink" class="cancel-booking"
                                            style="pointer-events: none; opacity: 0.6;">Cancel Booking</a>
                                        <a href="${basePath}/passengerDashboard" class="go-back">Go Back</a>
                                    </div>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        const confirmCb = document.getElementById('confirm');
                        const cancelLink = document.getElementById('cancelLink');
                        const form = document.getElementById('cancelForm');

                        confirmCb?.addEventListener('change', function () {
                            if (this.checked) {
                                cancelLink.style.pointerEvents = 'auto';
                                cancelLink.style.opacity = '1.0';
                            } else {
                                cancelLink.style.pointerEvents = 'none';
                                cancelLink.style.opacity = '0.6';
                            }
                        });

                        cancelLink.addEventListener('click', function (e) {
                            e.preventDefault();
                            form.submit();
                        });
                    });
                </script>
            </body>

            </html>