<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Manage Bookings</title>
         <style>
         * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Open Sans', Arial, sans-serif;
        }

        body {
            background-color: #f7f9fc;
            color: #333;
            transition: all .3s ease;
        }

        .main {
            padding: 20px;
            margin: auto;
            max-width: 1000px;
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

        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 0.95rem;
        }

        .data-table thead {
            background: #f2f2f2;
        }

        .data-table th,
        .data-table td {
            padding: 12px;
            border-bottom: 1px solid #ccc;
            text-align: left;
        }

        .data-table tbody tr:hover {
            background-color: #f1f1f1;
        }

        .edit-btn, .delete-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            color: #fff;
            font-weight: bold;
            cursor: pointer;
        }

        .edit-btn {
            background-color: #007bff;
        }

        .edit-btn:hover {
            background-color: #0056b3;
        }

        .delete-btn {
            background-color: #dc3545;
        }

        .delete-btn:hover {
            background-color: #bd2130;
        }

        .modal {
            display: none;
            position: fixed;
            top: 10%;
            left: 50%;
            transform: translateX(-50%);
            width: 400px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            z-index: 1000;
        }

        .modal form input,
        .modal form select {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .modal form button {
            padding: 10px;
            border: none;
            background: #28a745;
            color: white;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .modal form button:hover {
            background: #218838;
        }

        .modal-close {
            float: right;
            font-size: 1.2rem;
            font-weight: bold;
            cursor: pointer;
        }
        .alert {
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            font-weight: bold;
        }
        .success { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
<div class="main">
    <h1>Booking Management</h1>

    <c:if test="${param.status == 'success'}">
        <div class="alert success">Booking saved successfully!</div>
    </c:if>
    <c:if test="${param.status == 'error'}">
        <div class="alert error">Something went wrong. Please try again.</div>
    </c:if>
    <c:if test="${param.status == 'deleted'}">
        <div class="alert success">Booking deleted successfully.</div>
    </c:if>

    <button class="add-btn" onclick="openModal()">Add Booking</button>
    <a class="add-btn" style="background:#007bff; margin-left:10px; text-decoration:none;" href="adminDashboard">Go to Dashboard</a>

    <table class="data-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>User</th>
            <th>Flight</th>
            <th>Date</th>
            <th>Amount</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="booking" items="${bookings}">
            <tr>
                <td>${booking.bookingId}</td>
                <td>${booking.userId}</td>
                <td>${booking.flightId}</td>
                <td>${booking.bookingDate}</td>
                <td>${booking.amount}</td>
                <td>${booking.status}</td>
                <td>
                    <a class="edit-btn" href="manageBookings?action=edit&bookingId=${booking.bookingId}">Edit</a>
                    <a class="delete-btn" href="manageBookings?action=delete&bookingId=${booking.bookingId}" 
                       onclick="return confirm('Are you sure you want to delete this booking?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- === Modal === -->
<div class="modal" id="bookingFormModal">
    <span class="modal-close" onclick="closeModal()">×</span>
    <form action="manageBookings" method="post">
        <input type="hidden" name="bookingId" value="${editBooking.bookingId}" />
        <input type="hidden" name="action" value="${editBooking != null ? 'update' : 'add'}" />

        <label>User:</label>
        <select name="userId" required>
            <c:forEach var="user" items="${users}">
                <option value="${user.id}" <c:if test="${editBooking.userId == user.id}">selected</c:if>>
                    ${user.fullName} (ID: ${user.id})
                </option>
            </c:forEach>
        </select>

        <label>Flight:</label>
        <select name="flightId" required>
            <c:forEach var="flight" items="${flights}">
                <option value="${flight.flightId}" <c:if test="${editBooking.flightId == flight.flightId}">selected</c:if>>
                    ${flight.flightId} (${flight.fromCity} → ${flight.toCity})
                </option>
            </c:forEach>
        </select>

        <label>Booking Date:</label>
        <input type="date" name="bookingDate" value="${editBooking.bookingDate}" required />

        <label>Amount:</label>
        <input type="number" step="0.01" name="amount" value="${editBooking.amount}" required />

        <label>Status:</label>
        <select name="status">
            <option value="CONFIRMED" <c:if test="${editBooking.status == 'CONFIRMED'}">selected</c:if>>Confirmed</option>
            <option value="PENDING" <c:if test="${editBooking.status == 'PENDING'}">selected</c:if>>Pending</option>
            <option value="CANCELLED" <c:if test="${editBooking.status == 'CANCELLED'}">selected</c:if>>Cancelled</option>
        </select>

        <button type="submit">${editBooking != null ? "Update" : "Add"} Booking</button>
    </form>
</div>

<script>
    function openModal() {
        document.getElementById("bookingFormModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("bookingFormModal").style.display = "none";
    }

    <% if (request.getAttribute("editBooking") != null) { %>
    window.onload = function() {
        openModal();
    }
    <% } %>
</script>
</body>
</html>
