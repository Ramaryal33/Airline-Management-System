<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Flight Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Open Sans', Arial, sans-serif;
        }

        body {
            color: #333;
            background: #f7f9fc;
            transition: all 0.3s ease;
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
            transition: width .3s, padding .3s;
        }

        .sidebar nav .bottom {
            margin-top: 240px;
        }

        .sidebar nav .bottom img {
            display: block;
            margin: 0 auto 20px auto;
            border: 2px solid #ccc;
            width: 70px;
            border-radius: 10%;
            box-shadow: 0 4px 6px rgba(0, 0, 0, .1);
        }

        .sidebar img {
            width: 100px;
            margin-bottom: 10px;
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
            transition: background .3s, transform .3s;
            text-align: center;
            font-weight: 600;
        }

        .sidebar nav a:hover {
            background: rgba(255, 255, 255, .1);
            transform: translateX(5px);
        }

        .main {
            margin-left: 250px;
            padding: 20px;
            transition: padding .3s ease;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .page-title {
            font-size: 1.5rem;
            color: #444;
        }

        .add-btn {
            padding: 10px 15px;
            border: none;
            border-radius: 8px;
            background: #28a745;
            color: #fff;
            font-weight: 600;
            cursor: pointer;
            transition: background .3s, transform .3s;
        }

        .add-btn:hover {
            background: #218838;
            transform: scale(1.03);
        }

        .filter-section {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
        }

        .filter-group label {
            margin-bottom: 5px;
            font-weight: 600;
            color: #555;
        }

        .filter-group input {
            padding: 8px;
            border: 2px solid #ccc;
            border-radius: 8px;
            outline: none;
        }

        .table-container {
            background: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, .08);
            overflow-x: auto;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 650px;
            font-size: .95rem;
        }

        .data-table thead {
            background: #f2f2f2;
        }

        .data-table th,
        .data-table td {
            text-align: left;
            padding: 12px;
            border-bottom: 1px solid #ccc;
        }

        .data-table tbody tr:hover {
            background: #f9f9f9;
        }

        .edit-btn,
        .delete-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 8px;
            margin-right: 5px;
            cursor: pointer;
            transition: background .3s, transform .3s;
            font-weight: 600;
            font-size: .9rem;
        }

        .edit-btn {
            background: #1A73E8;
            color: #fff;
        }

        .edit-btn:hover {
            background: #1667c1;
            transform: scale(1.02);
        }

        .delete-btn {
            background: #dc3545;
            color: #fff;
        }

        .delete-btn:hover {
            background: #c82333;
            transform: scale(1.02);
        }
    </style>
</head>

<body>
    <div class="sidebar">
        <!-- Replace "logo‐filename.png" with your actual logo image if needed -->
        <img src="plane.png" alt="Airline Logo" class="logo" />
        <nav>
            <!-- Dashboard page -->
            <a href="${pageContext.request.contextPath}/passengerDashboard.jsp">Dashboard</a>
            <!-- Search Flights page -->
            <a href="${pageContext.request.contextPath}/searchFlights.jsp">Search Flights</a>
            <!-- Flight Details page -->
            <a href="${pageContext.request.contextPath}/flightDetails.jsp">Flight Details</a>
            <!-- Payment page -->
            <a href="${pageContext.request.contextPath}/payment.jsp">Payment Page</a>
            <!-- My Bookings page -->
            <a href="${pageContext.request.contextPath}/myBookings.jsp">My Bookings</a>
            <!-- Online Check-in page -->
            <a href="${pageContext.request.contextPath}/onlineCheckin.jsp">Online Check-in</a>
            <div class="bottom">
                <!-- Replace "profile.jpg" with your actual profile image if needed -->
                <img src="m.jpg" alt="Profile Picture" />
                <!-- Settings page -->
                <a href="${pageContext.request.contextPath}/settings.jsp">Settings</a>
            </div>
        </nav>
    </div>

    <div class="main">
        <div class="page-header">
            <h1 class="page-title">Flight Management</h1>
            <button class="add-btn" onclick="window.location='${pageContext.request.contextPath}/addFlight.jsp'">
                Add Flight
            </button>
        </div>

        <div class="filter-section">
            <div class="filter-group">
                <label for="filter-date">Filter by Date</label>
                <input type="date" id="filter-date" />
            </div>
            <div class="filter-group">
                <label for="filter-route">Filter by Route</label>
                <input type="text" id="filter-route" placeholder="e.g. KTM — DEL" />
            </div>
            <div class="filter-group">
                <label for="search-flight">Search Flight No.</label>
                <input type="text" id="search-flight" placeholder="e.g. F123" />
            </div>
        </div>

        <div class="table-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Flight No</th>
                        <th>Origin → Destination</th>
                        <th>Departure</th>
                        <th>Arrival</th>
                        <th>Status</th>
                        <th>Price</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Example rows; replace with dynamic JSP/Servlet data as needed -->
                    <tr>
                        <td>F123</td>
                        <td>KTM → DEL</td>
                        <td>10:00 AM</td>
                        <td>12:45 PM</td>
                        <td>On-time</td>
                        <td>$200</td>
                        <td>
                            <button class="edit-btn"
                                onclick="window.location='${pageContext.request.contextPath}/editFlight.jsp?flightNo=F123'">
                                Edit
                            </button>
                            <button class="delete-btn"
                                onclick="if(confirm('Delete flight F123?')) location.href='${pageContext.request.contextPath}/FlightController?action=delete&flightNo=F123';">
                                Delete
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>Q456</td>
                        <td>KTM → DOH</td>
                        <td>03:30 PM</td>
                        <td>07:00 PM</td>
                        <td>Delayed</td>
                        <td>$350</td>
                        <td>
                            <button class="edit-btn"
                                onclick="window.location='${pageContext.request.contextPath}/editFlight.jsp?flightNo=Q456'">
                                Edit
                            </button>
                            <button class="delete-btn"
                                onclick="if(confirm('Delete flight Q456?')) location.href='${pageContext.request.contextPath}/FlightController?action=delete&flightNo=Q456';">
                                Delete
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td>A789</td>
                        <td>DEL → KTM</td>
                        <td>09:00 AM</td>
                        <td>11:30 AM</td>
                        <td>Cancelled</td>
                        <td>$180</td>
                        <td>
                            <button class="edit-btn"
                                onclick="window.location='${pageContext.request.contextPath}/editFlight.jsp?flightNo=A789'">
                                Edit
                            </button>
                            <button class="delete-btn"
                                onclick="if(confirm('Delete flight A789?')) location.href='${pageContext.request.contextPath}/FlightController?action=delete&flightNo=A789';">
                                Delete
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>

</html>
