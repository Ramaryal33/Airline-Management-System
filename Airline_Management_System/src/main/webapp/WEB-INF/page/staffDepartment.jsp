<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Manage Departments</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { color: #333; }
        form, table { margin-top: 20px; }
        input[type="text"], textarea {
            width: 300px;
            padding: 8px;
            margin-bottom: 10px;
        }
        input[type="submit"], .btn {
            padding: 6px 12px;
            background-color: #007bff;
            border: none;
            color: white;
            cursor: pointer;
        }
        .btn-delete {
            background-color: #dc3545;
        }
        .btn:hover {
            opacity: 0.9;
        }
        table {
            border-collapse: collapse;
            width: 80%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
        }
        th { background-color: #f2f2f2; }
        .message { color: green; }
        .error { color: red; }
    </style>
</head>
<body>

<h1>Department Management</h1>

<!-- Success or error messages -->
<c:if test="${not empty successMessage}">
    <p class="message">${successMessage}</p>
</c:if>
<c:if test="${not empty errorMessage}">
    <p class="error">${errorMessage}</p>
</c:if>

<!-- Department Form -->
<form action="staffDepartment" method="post">
    <input type="hidden" name="action" value="${departmentToEdit != null ? 'update' : 'add'}" />
    <c:if test="${departmentToEdit != null}">
        <input type="hidden" name="departmentId" value="${departmentToEdit.departmentId}" />
    </c:if>

    <label>Department Name:</label><br />
    <input type="text" name="departmentName" value="${departmentToEdit != null ? departmentToEdit.name : ''}" required /><br />

    <label>Description:</label><br />
    <textarea name="departmentDescription" rows="4" required>${departmentToEdit != null ? departmentToEdit.description : ''}</textarea><br />

    <input type="submit" value="${departmentToEdit != null ? 'Update Department' : 'Add Department'}" />
</form>

<!-- Department Table -->
<h2>All Departments</h2>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
    <c:forEach var="dept" items="${departmentList}">
        <tr>
            <td>${dept.departmentId}</td>
            <td>${dept.name}</td>
            <td>${dept.description}</td>
            <td>
                <form action="staffDepartment" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="edit" />
                    <input type="hidden" name="departmentId" value="${dept.departmentId}" />
                    <input type="submit" class="btn" value="Edit" />
                </form>
                <form action="staffDepartment" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this department?');">
                    <input type="hidden" name="action" value="delete" />
                    <input type="hidden" name="departmentId" value="${dept.departmentId}" />
                    <input type="submit" class="btn btn-delete" value="Delete" />
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>
