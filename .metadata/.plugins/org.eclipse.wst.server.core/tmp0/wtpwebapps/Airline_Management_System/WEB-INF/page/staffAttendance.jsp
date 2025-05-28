<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*, com.airline.staff.model.*" %>

<html>
<head>
    <title>Staff Attendance</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 30px;">

<h1>Attendance Management</h1>

<!-- Button to add attendance -->
<a href="staffAttendance?action=new" style="background-color: #007bff; color: white; padding: 8px 16px; text-decoration: none; border-radius: 4px;">Add Attendance</a>

<!-- Form for add or edit attendance -->
<c:if test="${param.action == 'new' || param.action == 'edit'}">
    <div style="margin-top: 20px; padding: 20px; border: 1px solid #ccc; background-color: #f9f9f9;">
        <h2>${empty attendance ? 'Add New' : 'Edit'} Attendance</h2>
        <form action="staffAttendance?action=${empty attendance ? 'add' : 'update'}" method="post">
            <c:if test="${not empty attendance}">
                <input type="hidden" name="attendanceId" value="${attendance.attendanceId}" />
            </c:if>

            <div style="margin-bottom: 10px;">
                <label>Staff:</label>
                <select name="staffId" required>
                    <c:forEach var="staff" items="${staffList}">
                        <option value="${staff.userId}" ${attendance.staffId == staff.userId ? 'selected' : ''}>
                            ${staff.firstName} ${staff.lastName}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div style="margin-bottom: 10px;">
                <label>Date:</label>
                <input type="date" name="date" value="${attendance.date}" required />
            </div>

            <div style="margin-bottom: 10px;">
                <label>Clock In:</label>
                <input type="time" name="clockIn" value="${attendance.clockIn}" required />
            </div>

            <div style="margin-bottom: 10px;">
                <label>Clock Out:</label>
                <input type="time" name="clockOut" value="${attendance.clockOut}" required />
            </div>

            <div style="margin-bottom: 10px;">
                <label>Status:</label>
                <select name="status">
                    <option value="Present" ${attendance.status == 'Present' ? 'selected' : ''}>Present</option>
                    <option value="Absent" ${attendance.status == 'Absent' ? 'selected' : ''}>Absent</option>
                </select>
            </div>

            <div style="margin-bottom: 10px;">
                <label>Working Hours:</label>
                <input type="number" step="0.1" name="workingHours" value="${attendance.workingHours}" />
            </div>

            <div style="margin-bottom: 10px;">
                <label>Remarks:</label>
                <input type="text" name="remarks" value="${attendance.remarks}" />
            </div>

            <button type="submit" style="background-color: green; color: white; padding: 6px 12px; border: none; border-radius: 3px;">Save</button>
            <a href="staffAttendance" style="background-color: red; color: white; padding: 6px 12px; text-decoration: none; border-radius: 3px;">Cancel</a>
        </form>
    </div>
</c:if>

<!-- Table of attendance records -->
<h3 style="margin-top: 30px;">Attendance Records</h3>
<table border="1" cellpadding="8" cellspacing="0" style="width: 100%; border-collapse: collapse;">
    <thead style="background-color: #e0e0e0;">
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
                    <!-- Edit button -->
                    <a href="staffAttendance?action=edit&attendanceId=${a.attendanceId}"
                       style="background-color: #007bff; color: white; padding: 4px 10px; text-decoration: none; border-radius: 3px; margin-right: 5px;">Edit</a>

                    <!-- Delete button -->
                    <form method="post" action="staffAttendance" style="display:inline;">
                        <input type="hidden" name="attendanceId" value="${a.attendanceId}" />
                        <input type="hidden" name="action" value="delete" />
                        <button type="submit" onclick="return confirm('Are you sure?');"
                                style="background-color: red; color: white; border: none; padding: 4px 10px; border-radius: 3px;">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</body>
</html>
