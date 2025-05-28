<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Flight Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            padding: 20px;
        }

        h2 {
            margin-bottom: 15px;
        }

        .btn {
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            margin-right: 10px;
        }

        .add-btn {
            background: #28a745;
            color: white;
        }

        .edit-btn {
            background: #007bff;
            color: white;
        }

        .delete-btn {
            background: #dc3545;
            color: white;
        }

        .back-btn {
            background: #6c757d;
            color: white;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: left;
        }

        th {
            background: #eee;
        }
    </style>
</head>
<body>

    <h2>Flight Management</h2>

    <!-- Back to Dashboard -->
    <a href="${pageContext.request.contextPath}/adminDashboard" class="btn back-btn">← Back to Dashboard</a>

    <!-- Add Flight -->
    <a href="${pageContext.request.contextPath}/flightManagement?action=add" class="btn add-btn">Add New Flight</a>

    <!-- Flight Table -->
    <table>
        <thead>
            <tr>
                <th>Flight No</th>
                <th>From</th>
                <th>To</th>
                <th>Departure</th>
                <th>Arrival</th>
                <th>Class</th>
                <th>Price</th>
                <th>Seats</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="flight" items="${flights}">
            <tr>
                <td>${flight.flightId}</td>
                <td>${flight.fromCity}</td>
                <td>${flight.toCity}</td>
                <td>${flight.departureDate} ${flight.departureTime}</td>
                <td>
                    <c:if test="${not empty flight.arrivalDate}">
                        ${flight.arrivalDate} ${flight.arrivalTime}
                    </c:if>
                </td>
                <td>${flight.travelClass}</td>
                <td>${flight.price}</td>
                <td>${flight.seatsAvailable}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/flightManagement?action=edit&flightId=${flight.flightId}"
                       class="btn edit-btn">Edit</a>
                    <a href="${pageContext.request.contextPath}/flightManagement?action=delete&flightId=${flight.flightId}"
                       class="btn delete-btn"
                       onclick="return confirm('Delete flight ${flight.flightId}?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</body>
</html>
