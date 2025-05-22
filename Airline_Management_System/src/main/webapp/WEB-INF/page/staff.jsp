<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Staff Management</title>
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
        
        /* Form Box Styling */
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
        
        .form-box h3 {
            margin-top: 0;
            color: #333;
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
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        
        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }
        
        .btn-primary {
            background-color: #2196F3;
            color: white;
        }
        
        .btn-danger {
            background-color: #f44336;
            color: white;
        }
        
        .btn-success {
            background-color: #4CAF50;
            color: white;
        }
        
        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 999;
        }
    </style>
</head>
<body>

<c:if test="${not empty dbError}">
    <script>
        alert("<c:out value='${dbError}'/>");
    </script>
</c:if>

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
    <form action="staff" method="post">
        <input type="hidden" name="action" value="${empty staff ? 'add' : 'edit'}" />
        <c:if test="${not empty staff}">
            <input type="hidden" name="staffId" value="${staff.staffId}" />
        </c:if>

        <div class="form-group">
            <label for="userId">User ID:</label>
            <input type="number" id="userId" name="userId" class="form-control" 
                   value="${staff.userId}" required />
        </div>

        <div class="form-group">
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" class="form-control" 
                   value="${staff.firstName}" required />
        </div>

        <div class="form-group">
            <label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" class="form-control" 
                   value="${staff.lastName}" required />
        </div>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" class="form-control" 
                   value="${staff.email}" required />
        </div>

        <div class="form-group">
            <label for="phone">Phone:</label>
            <input type="text" id="phone" name="phone" class="form-control" 
                   value="${staff.phone}" required />
        </div>

        <div class="form-group">
            <label for="position">Position:</label>
            <input type="text" id="position" name="position" class="form-control" 
                   value="${staff.position}" required />
        </div>

        <div class="form-group">
            <label for="departmentId">Department ID:</label>
            <input type="number" id="departmentId" name="departmentId" class="form-control" 
                   value="${staff.departmentId}" required />
        </div>

        <div class="form-group">
            <label for="hireDate">Hire Date:</label>
            <input type="date" id="hireDate" name="hireDate" class="form-control" 
                   value="${staff.hireDate}" required />
        </div>

        <div class="form-group">
            <label for="status">Status:</label>
            <select id="status" name="status" class="form-control" required>
                <option value="Active" ${staff.status eq 'Active' ? 'selected' : ''}>Active</option>
                <option value="Inactive" ${staff.status eq 'Inactive' ? 'selected' : ''}>Inactive</option>
            </select>
        </div>

        <div class="form-group">
            <label for="profileImage">Profile Image URL:</label>
            <input type="text" id="profileImage" name="profileImage" class="form-control" 
                   value="${staff.profileImage}" />
        </div>
        
        <button type="submit" class="btn btn-primary">Save</button>
        <button type="button" class="btn btn-danger" onclick="hideForm()">Cancel</button>
    </form>
</div>

<!-- Staff Table -->
<table class="table" border="1" cellpadding="5" cellspacing="0">
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
            <th>Profile Image</th>
            <th>Created At</th>
            <th>Updated At</th>
            <th>Action</th>
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
                <td>
                    <img src="${staff.profileImage}" alt="Profile" width="50" height="50" />
                </td>
                <td>${staff.createdAt}</td>
                <td>${staff.updatedAt}</td>
                <td>
                    <a href="staff?action=edit&staffId=${staff.staffId}" class="btn btn-primary">Edit</a>
                    <a href="#" class="btn btn-danger" onclick="confirmDelete(${staff.staffId})">Delete</a>
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
    
    function confirmDelete(staffId) {
        if (confirm('Are you sure you want to delete this staff member?')) {
            window.location.href = 'staff?action=delete&staffId=' + staffId;
        }
    }
    
    // Show form if staff object exists (for editing)
    window.onload = function() {
        if (${not empty staff}) {
            showForm();
        }
    };
</script>

</body>
</html>