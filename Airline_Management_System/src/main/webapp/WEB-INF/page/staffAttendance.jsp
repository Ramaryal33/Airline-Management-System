<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.airline.staff.model.Attendance" %>

<html>
<head>
    <title>Staff Attendance</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .form-container { 
            margin-top: 20px; 
            padding: 20px; 
            border: 1px solid #ccc; 
            background-color: #f9f9f9; 
            width: 60%; 
            margin-left: auto; 
            margin-right: auto; 
            display: none; /* Initially hidden */
        }
        .form-container h2 { margin-bottom: 20px; }
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
        .form-container a.cancel-btn { 
            background-color: red; 
            color: white; 
            padding: 10px 20px; 
            text-decoration: none; 
            border-radius: 4px; 
            display: inline-block; 
            margin-left: 10px; 
        }
        table { width: 100%; border-collapse: collapse; margin-top: 40px; }
        th, td { padding: 8px; border: 1px solid #ccc; text-align: left; }
        th { background-color: #e0e0e0; }
        .action-btn { padding: 6px 12px; border-radius: 4px; text-decoration: none; color: white; }
        .edit-btn { background-color: #007bff; }
        .delete-btn { background-color: red; border: none; }
        .add-btn { 
            background-color: green; 
            color: white; 
            padding: 10px 20px; 
            margin-bottom: 20px; 
            display: inline-block; 
            text-decoration: none; 
            border-radius: 4px; 
            cursor: pointer;
        }
    </style>
</head>
<body>

<h1>Staff Attendance Management</h1>

<!-- Add Attendance Button -->
<button class="add-btn" id="addAttendanceBtn">Add Attendance</button>

<!-- Attendance Form -->
<div class="form-container" id="attendanceForm">
    <h2><c:choose><c:when test="${not empty attendance}">Edit Attendance</c:when><c:otherwise>Add Attendance</c:otherwise></c:choose></h2>
    <form action="staffAttendance" method="post">
        <input type="hidden" name="action" value="${empty attendance ? 'add' : 'edit'}" />
        <input type="hidden" name="attendanceId" value="${attendance.attendanceId}" />

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
            <option value="Present" <c:if test="${attendance.status == 'Present'}">selected</c:if>>Present</option>
            <option value="Absent" <c:if test="${attendance.status == 'Absent'}">selected</c:if>>Absent</option>
            <option value="Late" <c:if test="${attendance.status == 'Late'}">selected</c:if>>Late</option>
            <option value="On Leave" <c:if test="${attendance.status == 'On Leave'}">selected</c:if>>On Leave</option>
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
                    <form method="post" action="staffAttendance" style="display:inline;">
                        <input type="hidden" name="attendanceId" value="${a.attendanceId}" />
                        <input type="hidden" name="action" value="delete" />
                        <button type="submit" class="action-btn delete-btn" onclick="return confirm('Are you sure you want to delete this record?');">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<script>
    // Get elements
    const addAttendanceBtn = document.getElementById('addAttendanceBtn');
    const attendanceForm = document.getElementById('attendanceForm');

    // Show form when the "Add Attendance" button is clicked
    addAttendanceBtn.addEventListener('click', function() {
        attendanceForm.style.display = 'block'; // Show the form
        addAttendanceBtn.style.display = 'none'; // Hide the "Add Attendance" button
    });

    // Cancel form action - hide form and show the "Add Attendance" button again
    const cancelBtn = document.querySelector('.cancel-btn');
    cancelBtn.addEventListener('click', function(event) {
        event.preventDefault(); // Prevent form submission
        attendanceForm.style.display = 'none'; // Hide the form
        addAttendanceBtn.style.display = 'block'; // Show the "Add Attendance" button again
    });
</script>

</body>
</html>
