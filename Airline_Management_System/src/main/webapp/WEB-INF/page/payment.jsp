<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>Payment - Dawn Airlines</title>
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

                    .a {
                        color: #ffffff;
                    }

                    /* SIDEBAR (same as flightDetails/searchFlight) */
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

                    /* PAYMENT BOX SETTINGS */
                    .payment-box {
                        width: 420px;
                        background: #fff;
                        border-radius: 20px;
                        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                        padding: 30px;
                    }

                    /* HEADER */
                    .payment-box .header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 20px;
                    }

                    .payment-box .header .title {
                        font-size: 24px;
                        font-weight: bold;
                        color: #0277bd;
                    }

                    .payment-box .header a.cancel {
                        text-decoration: none;
                        color: #f44336;
                        font-weight: bold;
                        transition: color 0.3s;
                    }

                    .payment-box .header a.cancel:hover {
                        color: #c62828;
                    }

                    .payment-box h2 {
                        color: #00796b;
                        margin-bottom: 20px;
                        text-align: center;
                    }

                    .methods label {
                        display: block;
                        margin: 10px 0;
                        cursor: pointer;
                    }

                    .methods hr {
                        margin: 20px 0;
                    }

                    .icons {
                        display: flex;
                        gap: 10px;
                        margin-bottom: 20px;
                        justify-content: center;
                    }

                    .icons div {
                        font-size: 24px;
                    }

                    .fields {
                        margin-bottom: 20px;
                    }

                    .fields label {
                        display: block;
                        margin-bottom: 5px;
                        color: #555;
                    }

                    .fields input {
                        width: 100%;
                        padding: 10px;
                        border: 1px solid #ccc;
                        border-radius: 8px;
                        transition: border-color 0.3s;
                    }

                    .fields input:focus {
                        border-color: #00796b;
                        outline: none;
                    }

                    .pay-btn {
                        display: block;
                        width: 60%;
                        margin: 20px auto 0;
                        background: #00796b;
                        color: white;
                        padding: 12px;
                        font-size: 16px;
                        border: none;
                        border-radius: 10px;
                        text-align: center;
                        text-decoration: none;
                        font-weight: 600;
                        transition: background 0.3s, transform 0.2s;
                        cursor: pointer;
                    }

                    .pay-btn:hover {
                        background: #005b4f;
                        transform: scale(1.02);
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

                        .payment-box {
                            width: 100%;
                            padding: 20px;
                            border-radius: 0;
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
                        <a href="${basePath}/payment" class="active">Payment</a>
                        <a href="${basePath}/cancelBooking">Cancel Bookings</a>
                        <a href="${basePath}/contact">Contact Us</a>
                        <a href="${basePath}/logout">Log out</a>
                        <div class="bottom">
                            <a href="${basePath}/passengerProfile">Settings</a>
                        </div>
                    </nav>
                </div>

                <div class="main">
                    <div class="payment-box">
                        <div class="header">
                            <div class="title">💳 PayNow</div>
                            <a href="${basePath}/flightDetails?flightId=${selectedFlight.flightId}"
                                class="cancel">Cancel Booking</a>
                        </div>

                        <h2>Have A Good Time</h2>

                        <div class="flight-summary">
                            <p><strong>Flight:</strong>
                                <c:out value="${selectedFlight.flightId}" />
                            </p>
                            <p><strong>Total Fare:</strong> NPR
                                <fmt:formatNumber value="${totalFare}" type="number" minFractionDigits="2" />
                            </p>
                        </div>

                        <form onsubmit="return validatePayment()" action="${basePath}/bookingConfirmation"
                            method="post">
                            <input type="hidden" name="flightId" value="${selectedFlight.flightId}" />

                            <div class="methods">
                                <label><input type="radio" name="payment" value="paypal"
                                        onclick="showFields('paypal')" /> PayPal</label>
                                <label><input type="radio" name="payment" value="esewa" onclick="showFields('esewa')" />
                                    eSewa</label>
                                <hr />
                                <label><input type="radio" name="payment" value="card" onclick="showFields('card')"
                                        checked /> Debit / Credit Card</label>
                            </div>

                            <!-- payment fields -->
                            <div id="paypal-fields" class="fields" style="display:none;">
                                <label>PayPal Email</label>
                                <input type="email" name="paypalEmail" />
                                <label>Password</label>
                                <input type="password" name="paypalPass" />
                            </div>

                            <div id="esewa-fields" class="fields" style="display:none;">
                                <label>eSewa ID</label>
                                <input type="text" name="esewaId" />
                                <label>Password</label>
                                <input type="password" name="esewaPass" />
                            </div>

                            <div id="card-fields" class="fields">
                                <label>Card Number</label>
                                <input type="text" name="cardNumber" placeholder="XXXX XXXX XXXX XXXX" />
                                <div class="split">
                                    <div><label>Expiry</label><input type="text" name="expiry" placeholder="MM/YY" />
                                    </div>
                                    <div><label>CVC</label><input type="text" name="cvc" placeholder="CVC" /></div>
                                </div>
                            </div>

                            <button type="submit" class="pay-btn">Pay Now</button>
                        </form>
                    </div>
                </div>

                <script>
                    function showFields(method) {
                        document.getElementById('paypal-fields').style.display = (method === 'paypal' ? 'block' : 'none');
                        document.getElementById('esewa-fields').style.display = (method === 'esewa' ? 'block' : 'none');
                        document.getElementById('card-fields').style.display = (method === 'card' ? 'block' : 'none');
                    }

                    function validatePayment() {
                        const method = document.querySelector('input[name="payment"]:checked').value;
                        if (method === 'paypal') {
                            const email = document.querySelector('input[name="paypalEmail"]').value.trim();
                            const pass = document.querySelector('input[name="paypalPass"]').value.trim();
                            if (!email || !pass) { alert("Please fill out all PayPal fields."); return false; }
                        }
                        if (method === 'esewa') {
                            const id = document.querySelector('input[name="esewaId"]').value.trim();
                            const pass = document.querySelector('input[name="esewaPass"]').value.trim();
                            if (!id || !pass) { alert("Please fill out all eSewa fields."); return false; }
                        }
                        if (method === 'card') {
                            const num = document.querySelector('input[name="cardNumber"]').value.trim();
                            const exp = document.querySelector('input[name="expiry"]').value.trim();
                            const cvc = document.querySelector('input[name="cvc"]').value.trim();
                            if (!num || !exp || !cvc) { alert("Please fill out all card details."); return false; }
                        }
                        return true;
                    }
                </script>
            </body>

            </html>