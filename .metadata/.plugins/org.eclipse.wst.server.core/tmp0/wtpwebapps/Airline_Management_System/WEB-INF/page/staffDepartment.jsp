<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Department Management</title>
    <style>
        .alert {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: bold;
        }
        .alert-success {
            background-color: #4CAF50;
            color: white;
        }
        .alert-error {
            background-color: #f44336;
            color: white;
        }
        .form-container {
            display: none;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 10px;
        }
        .btn {
            padding: 8px 15px;
            margin: 5px;
        }
    </style>
    <script>
        function showForm() {
            document.getElementById('departmentForm').style.display = 'block';
        }
        function hideForm() {
            document.getElementById('departmentForm').style.display = 'none';
        }
    </script>
</head>
<body>

<h2>Department List</h2>

<!-- Display success or error messages -->
<c:if test="${not empty successMessage}">
    <div class="alert alert-success">${successMessage}</div>
</c:if>
<c:if test="${not empty errorMessage}">
    <div class="alert alert-error">${errorMessage}</div>
</c:if>

<!-- Add Department Button -->
<button class="btn" onclick="showForm()">Add Department</button>

<!-- Department Form -->
<div class="form-container" id="departmentForm">
    <form action="staffDepartment" method="post">
        <input type="hidden" name="action" value="add" />

        <div class="form-group">
            <label for="departmentId">Department ID:</label>
            <input type="number" id="departmentId" name="departmentId" required />
        </div>

        <div class="form-group">
            <label for="departmentName">Department Name:</label>
            <input type="text" id="departmentName" name="departmentName" required />
        </div>

        <div class="form-group">
            <label for="departmentDescription">Department Description:</label>
            <input type="text" id="departmentDescription" name="departmentDescription" required />
        </div>

        <button type="submit" class="btn">Save</button>
        <button type="button" class="btn" onclick="hideForm()">Cancel</button>
    </form>
</div>

<!-- Department Table -->
<table border="1" cellpadding="8" cellspacing="0">
    <thead>
        <tr>
            <th>Department ID</th>
            <th>Department Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
    <c:forEach var="department" items="${departmentList}">
        <tr>
            <td>${department.departmentId}</td>
            <td>${department.dname}</td>
            <td>${department.description}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>
