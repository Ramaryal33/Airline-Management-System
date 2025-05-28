<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Management</title>
    <style>
        .container {
            max-width: 900px;
            margin: auto;
        }
        .form-group {
            margin-bottom: 1em;
        }
        .form-group label {
            display: block;
        }
        .btn {
            padding: 6px 12px;
            text-decoration: none;
            border: 1px solid #ccc;
            margin-right: 5px;
        }
        .btn-primary { background: #007bff; color: #fff; }
        .btn-success { background: #28a745; color: #fff; }
        .btn-danger { background: #dc3545; color: #fff; }
        .btn-warning { background: #ffc107; color: #000; }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 2em;
        }
        th, td {
            padding: 8px;
            border: 1px solid #ddd;
            text-align: left;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Staff Management</h1>

    <!-- Button to add new staff -->
    <a href="staff?action=new" class="btn btn-primary">Add New Employee</a>

    <!-- Form for adding new staff or editing existing staff -->
    <c:if test="${param.action == 'new' || param.action == 'edit'}">
        <div class="staff-form">
            <h2>${empty staff ? 'Add New' : 'Edit'} Employee</h2>
            <form action="staff?action=${empty staff ? 'add' : 'update'}" method="post" enctype="multipart/form-data">

                <!-- Hidden staffId input for edit -->
                <c:if test="${not empty staff}">
                    <input type="hidden" name="staffId" value="${staff.staffId}" />
                </c:if>

                <!-- Staff details form fields -->
                <div class="form-group">
                    <label>First Name:</label>
                    <input type="text" name="firstName" value="${staff.firstName}" required />
                </div>

                <div class="form-group">
                    <label>Last Name:</label>
                    <input type="text" name="lastName" value="${staff.lastName}" required />
                </div>

                <div class="form-group">
                    <label>Email:</label>
                    <input type="email" name="email" value="${staff.email}" required />
                </div>

                <div class="form-group">
                    <label>Phone:</label>
                    <input type="text" name="phone" value="${staff.phone}" />
                </div>

                <div class="form-group">
                    <label>Position:</label>
                    <input type="text" name="position" value="${staff.position}" />
                </div>

                <!-- Department ID input -->
                <div class="form-group">
                    <label>Department ID:</label>
                    <input type="number" name="departmentId" value="${staff.departmentId}" required />
                </div>

                <div class="form-group">
                    <label>Hire Date:</label>
                    <input type="date" name="hireDate" value="${staff.hireDate != null ? staff.hireDate : ''}" />
                </div>

                <div class="form-group">
                    <label>Status:</label>
                    <select name="status">
                        <option value="Active" ${staff.status == 'Active' ? 'selected' : ''}>Active</option>
                        <option value="Inactive" ${staff.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Profile Image:</label>
                    <input type="file" name="profileImage" />
                    <c:if test="${not empty staff.profileImage}">
                        <br><img src="${staff.profileImage}" alt="Profile Image" style="max-width: 100px;" />
                    </c:if>
                </div>

                <button type="submit" class="btn btn-success">Save</button>
                <a href="staff" class="btn btn-danger">Cancel</a>
            </form>
        </div>
    </c:if>

    <!-- Staff List Table -->
    <table>
        <thead>
        <tr>
            <th>Staff ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Position</th>
            <th>Department ID</th>
            <th>Hire Date</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${staffList}" var="staff">
            <tr>
                <td>${staff.staffId}</td>
                <td>${staff.firstName}</td>
                <td>${staff.lastName}</td>
                <td>${staff.email}</td>
                <td>${staff.phone}</td>
                <td>${staff.position}</td>
                <td>${staff.departmentId}</td>
                <td><fmt:formatDate value="${staff.hireDate}" pattern="yyyy-MM-dd" /></td>
                <td>${staff.status}</td>
                <td>
                    <a href="staff?action=edit&id=${staff.staffId}" class="btn btn-warning">Edit</a>
                    <a href="staff?action=delete&id=${staff.staffId}" class="btn btn-danger"
                       onclick="return confirm('Are you sure you want to delete this employee?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
