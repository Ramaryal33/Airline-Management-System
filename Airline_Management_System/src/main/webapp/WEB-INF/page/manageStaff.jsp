<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Staff Management</title>
    <style>
        /* Basic Reset */
        body, h2, table, th, td, form, input, select, button {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        /* Page Layout */
        body {
            background-color: #f4f4f4;
            padding: 20px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        /* Success and Error messages */
        .alert {
            padding: 10px;
            margin: 15px 0;
            border-radius: 5px;
            font-size: 14px;
        }

        .alert-success {
            background-color: #4CAF50;
            color: white;
        }

        .alert-error {
            background-color: #f44336;
            color: white;
        }

        /* Button Styles */
        .btn {
            padding: 10px 15px;
            margin: 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-success {
            background-color: #4CAF50;
            color: white;
        }

        .btn-danger {
            background-color: #f44336;
            color: white;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
        }

        .btn:hover {
            opacity: 0.8;
        }

        /* Form Box */
        .form-box {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            display: none;
            z-index: 1000;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .form-group input[type="text"],
        .form-group input[type="email"] {
            margin-bottom: 10px;
        }

        .form-group select {
            margin-top: 10px;
        }

        /* Overlay */
        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }

        /* Table Styles */
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            background-color: white;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }

        /* Responsive Design */
        @media screen and (max-width: 768px) {
            .form-box {
                width: 90%;
            }

            table, th, td {
                font-size: 12px;
            }
        }
    </style>
</head>
<body>

<h2>Staff List</h2>

<!-- Display success or error messages -->
<c:if test="${not empty successMessage}">
    <div class="alert alert-success">
        ${successMessage}
    </div>
</c:if>

<c:if test="${not empty errorMessage}">
    <div class="alert alert-error">
        ${errorMessage}
    </div>
</c:if>

<button class="btn btn-success" onclick="showForm()">Add Employee</button>

<!-- Overlay -->
<div class="overlay" id="overlay" onclick="hideForm()"></div>

<!-- Staff Form Box -->
<div class="form-box" id="staffForm">
    <h3>${empty staff ? 'Add Staff' : 'Edit Staff'}</h3>
    <form action="ManageStaffController" method="post">
        <input type="hidden" name="action" value="${empty staff ? 'add' : 'edit'}" />
        <c:if test="${not empty staff}">
            <input type="hidden" name="staffId" value="${staff.staffId}" />
        </c:if>

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
<table border="1" cellpadding="5" cellspacing="0">
    <thead>
        <tr>
            <th>Staff ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Position</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="staff" items="${staffList}">
            <tr>
                <td>${staff.staffId}</td>
                <td>${staff.firstName}</td>
                <td>${staff.lastName}</td>
                <td>${staff.email}</td>
                <td>${staff.phone}</td>
                <td>${staff.position}</td>
                <td>${staff.status}</td>
                <td>
                    <a href="ManageStaffController?action=edit&staffId=${staff.staffId}" class="btn btn-primary">Edit</a>
                    <a href="ManageStaffController?action=delete&staffId=${staff.staffId}" class="btn btn-danger">Delete</a>
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
</script>

</body>
</html>
