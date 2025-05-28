<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Staff</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
            background: #f0f2f5;
        }

        form, table {
            background: #fff;
            padding: 20px;
            margin-bottom: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        h2 {
            color: #333;
        }

        label {
            margin-top: 10px;
            display: block;
        }

        input, select {
            padding: 8px;
            width: 100%;
            margin-top: 5px;
        }

        input[type=submit] {
            background: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            margin-top: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #007bff;
            color: white;
            padding: 10px;
        }

        td {
            padding: 10px;
            border-bottom: 1px solid #ccc;
        }

        a {
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>${staff != null ? "Edit Staff" : "Add New Staff"}</h2>
<form method="post" action="manageStaff">
    <input type="hidden" name="action" value="${staff != null ? 'edit' : 'add'}" />
    <c:if test="${staff != null}">
        <input type="hidden" name="staffId" value="${staff.staffId}" />
    </c:if>

    <label>First Name:</label>
    <input type="text" name="firstName" value="${staff.firstName}" required />

    <label>Last Name:</label>
    <input type="text" name="lastName" value="${staff.lastName}" required />

    <label>Email:</label>
    <input type="email" name="email" value="${staff.email}" required />

    <label>Phone:</label>
    <input type="text" name="phone" value="${staff.phone}" />

    <label>Position:</label>
    <input type="text" name="position" value="${staff.position}" />

    <label>Status:</label>
    <select name="status">
        <option value="active" ${staff.status == 'active' ? 'selected' : ''}>Active</option>
        <option value="inactive" ${staff.status == 'inactive' ? 'selected' : ''}>Inactive</option>
    </select>

    <input type="submit" value="${staff != null ? 'Update Staff' : 'Add Staff'}" />
</form>

<h2>Staff List</h2>
<table>
    <tr>
        <th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Position</th><th>Status</th><th>Actions</th>
    </tr>
    <c:forEach var="s" items="${staffList}">
        <tr>
            <td>${s.staffId}</td>
            <td>${s.firstName} ${s.lastName}</td>
            <td>${s.email}</td>
            <td>${s.phone}</td>
            <td>${s.position}</td>
            <td>${s.status}</td>
            <td>
                <a href="manageStaff?action=edit&staffId=${s.staffId}">Edit</a> |
                <a href="manageStaff?action=delete&staffId=${s.staffId}" onclick="return confirm('Delete this staff?');">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
