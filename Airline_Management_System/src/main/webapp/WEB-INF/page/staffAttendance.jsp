<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Staff Attendance</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
        }

        h1 {
            text-align: center;
        }

        .form-container {
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            width: 60%;
            display: none;
        }

        .form-container input, .form-container select, .form-container textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        .form-container button {
            background-color: green;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .form-container .cancel-btn {
            background-color: red;
            text-decoration: none;
            padding: 10px 20px;
            color: white;
            border-radius: 4px;
            margin-left: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 40px;
        }

        th, td {
            padding: 8px;
            border: 1px solid #ccc;
            text-align: center;
        }

        th {
            background-color: #e0e0e0;
        }

        .action-btn {
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            color: white;
        }

        .edit-btn {
            background-color: #007bff;
        }

        .delete-btn {
            background-color: red;
            border: none;
            cursor: pointer;
        }

        .add-btn {
            background-color: green;
            color: white;
            padding: 10px 20px;
            margin-bottom: 20px;
            display: inline-block;
            border-radius: 4px;
            cursor: pointer;
        }

        .back-btn {
            background-color: #888;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            margin-left: 10px;
        }

        .top-bar {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<h1>Staff Attendance Management</h1>

<div class="top-bar">
    <button class="add-btn" id="addAttendanceBtn">Add Attendance</button>
    <a href="staffDashboard" class="back-btn">Back to Dashboard</a>
</div>

<!-- Attendance Form -->
<div class="form-container" id="attendanceForm">
    <h2><c:choose>
        <c:when test="${not empty attendance}">Edit Attendance</c:when>
        <c:otherwise>Add Attendance</c:otherwise>
    </c:choose></h2>

    <form action="staffAttendance" method="post">
        <input type="hidden" name="action" value="${empty attendance ? 'add' : 'update'}" />
        <c:if test="${not empty attendance}">
            <input type="hidden" name="attendanceId" value="${attendance.attendanceId}" />
        </c:if>

        <label for="staffId">Staff ID:</label>
        <input type="number" id="staffId" name="staffId" value="${attendance.staffId}" required />

        <label for="date">Date:</label>
        <input type="date" id="date" name="date" value="${attendance.date}" required />

        <label for="clockIn">Clock In:</label>
        <input type="time" id="clockIn" name="clockIn" value="${attendance.clockIn}" required />

        <label for="clockOut">Clock Out:</label>
        <input type="time" id="clockOut" name="clockOut" value="${attendance.clockOut}" required />

        <label for="status">Status:</label>
        <select id="status" name="status" required>
            <option value="Present" ${attendance.status eq 'Present' ? 'selected' : ''}>Present</option>
            <option value="Absent" ${attendance.status eq 'Absent' ? 'selected' : ''}>Absent</option>
            <option value="Late" ${attendance.status eq 'Late' ? 'selected' : ''}>Late</option>
            <option value="On Leave" ${attendance.status eq 'On Leave' ? 'selected' : ''}>On Leave</option>
        </select>

        <label for="workingHours">Working Hours:</label>
        <input type="number" step="0.1" id="workingHours" name="workingHours" value="${attendance.workingHours}" required />

        <label for="remarks">Remarks:</label>
        <textarea id="remarks" name="remarks" rows="3">${attendance.remarks}</textarea>

        <button type="submit">${empty attendance ? 'Save' : 'Update'}</button>
        <a href="staffAttendance" class="cancel-btn">Cancel</a>
    </form>
</div>

<!-- Attendance Table -->
<h2>Attendance Records</h2>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Staff ID</th>
            <th>Date</th>
            <th>Clock In</th>
            <th>Clock Out</th>
            <th>Status</th>
            <th>Hours</th>
            <th>Remarks</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="a" items="${attendanceList}">
            <tr>
                <td>${a.attendanceId}</td>
                <td>${a.staffId}</td>
                <td>${a.date}</td>
                <td>${a.clockIn}</td>
                <td>${a.clockOut}</td>
                <td>${a.status}</td>
                <td>${a.workingHours}</td>
                <td>${a.remarks}</td>
                <td>
                    <a href="staffAttendance?action=edit&attendanceId=${a.attendanceId}" class="action-btn edit-btn">Edit</a>
                    <a href="staffAttendance?action=delete&attendanceId=${a.attendanceId}" class="action-btn delete-btn" onclick="return confirm('Are you sure you want to delete this record?');">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<!-- Script to auto-show form if editing -->
<script>
    const addBtn = document.getElementById('addAttendanceBtn');
    const formDiv = document.getElementById('attendanceForm');

    addBtn.addEventListener('click', () => {
        formDiv.style.display = 'block';
        addBtn.style.display = 'none';
    });

    <c:if test="${not empty attendance}">
        document.addEventListener('DOMContentLoaded', function () {
            formDiv.style.display = 'block';
            addBtn.style.display = 'none';
        });
    </c:if>
</script>

</body>
</html>
