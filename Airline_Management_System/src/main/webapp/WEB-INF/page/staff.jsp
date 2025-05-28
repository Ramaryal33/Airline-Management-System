<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Staff Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 20px;
        }

        h2 {
            text-align: center;
        }

        .alert {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: bold;
            text-align: center;
        }

        .alert-success { background-color: #4CAF50; color: white; }
        .alert-error { background-color: #f44336; color: white; }

        .form-box {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            z-index: 1000;
            width: 500px;
            max-width: 90%;
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 999;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-control {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
            text-decoration: none;
        }

        .btn-primary { background-color: #2196F3; }
        .btn-danger { background-color: #f44336; }
        .btn-success { background-color: #4CAF50; }
        .btn-back { background-color: #888; }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            margin-top: 20px;
        }

        table th, table td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }

        table th {
            background-color: #f0f0f0;
        }

        .actions {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<h2>Staff List</h2>

<c:if test="${not empty successMessage}">
    <div class="alert alert-success">${successMessage}</div>
</c:if>

<c:if test="${not empty errorMessage}">
    <div class="alert alert-error">${errorMessage}</div>
</c:if>

<div class="actions">
    <button class="btn btn-success" onclick="showForm()">Add Employee</button>
</div>

<!-- Overlay -->
<div class="overlay" id="overlay" onclick="hideForm()"></div>

<!-- Staff Form Modal -->
<div class="form-box" id="staffForm">
    <h3>${empty staff ? 'Add Staff' : 'Edit Staff'}</h3>
    <form action="staff" method="post">
        <input type="hidden" name="action" value="${empty staff ? 'add' : 'edit'}" />

        <c:if test="${not empty staff}">
            <input type="hidden" name="staffId" value="${staff.staffId}" />
        </c:if>

        <div class="form-group">
            <label for="userId">User ID:</label>
            <input type="number" id="userId" name="userId" class="form-control" value="${staff.userId}" required />
        </div>

        <div class="form-group">
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" class="form-control" value="${staff.firstName}" required />
        </div>

        <div class="form-group">
            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" class="form-control" value="${staff.lastName}" required />
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" class="form-control" value="${staff.email}" required />
        </div>

        <div class="form-group">
            <label for="phone">Phone:</label>
            <input type="text" id="phone" name="phone" class="form-control" value="${staff.phone}" required />
        </div>

        <div class="form-group">
            <label for="position">Position:</label>
            <input type="text" id="position" name="position" class="form-control" value="${staff.position}" required />
        </div>

        <div class="form-group">
            <label for="departmentId">Department ID:</label>
            <input type="number" id="departmentId" name="departmentId" class="form-control" value="${staff.departmentId}" required />
        </div>

        <div class="form-group">
            <label for="hireDate">Hire Date:</label>
            <input type="date" id="hireDate" name="hireDate" class="form-control" value="${staff.hireDate}" required />
        </div>

        <div class="form-group">
            <label for="status">Status:</label>
            <select id="status" name="status" class="form-control" required>
                <option value="Active" ${staff.status eq 'Active' ? 'selected' : ''}>Active</option>
                <option value="Inactive" ${staff.status eq 'Inactive' ? 'selected' : ''}>Inactive</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Save</button>
        <button type="button" class="btn btn-danger" onclick="hideForm()">Cancel</button>
    </form>
</div>

<!-- Staff Table -->
<table>
    <thead>
        <tr>
            <th>Staff ID</th>
            <th>User ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Position</th>
            <th>Department ID</th>
            <th>Hire Date</th>
            <th>Status</th>
            <th>Created At</th>
            <th>Updated At</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="staff" items="${staffList}">
            <tr>
                <td>${staff.staffId}</td>
                <td>${staff.userId}</td>
                <td>${staff.firstName}</td>
                <td>${staff.lastName}</td>
                <td>${staff.email}</td>
                <td>${staff.phone}</td>
                <td>${staff.position}</td>
                <td>${staff.departmentId}</td>
                <td>${staff.hireDate}</td>
                <td>${staff.status}</td>
                <td>${staff.createdAt}</td>
                <td>${staff.updatedAt}</td>
                <td>
                    <a href="staff?action=edit&staffId=${staff.staffId}" class="btn btn-primary">Edit</a>
                    <a href="staff?action=delete&staffId=${staff.staffId}" class="btn btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>



<script>
    function showForm() {
        document.getElementById('overlay').style.display = 'block';
        document.getElementById('staffForm').style.display = 'block';
    }

    function hideForm() {
        document.getElementById('overlay').style.display = 'none';
        document.getElementById('staffForm').style.display = 'none';
    }

    // ✅ Automatically show form if editing
    window.onload = function () {
        <c:if test="${not empty staff}">
            showForm();
        </c:if>
    }
</script>


</body>
</html>
