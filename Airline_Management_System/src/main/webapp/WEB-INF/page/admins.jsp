<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 2em;
        }
        .container {
            display: flex;
            gap: 2em;
        }
        .form-container, .list-container {
            flex: 1;
            border: 1px solid #ddd;
            padding: 1em;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h2 {
            margin-top: 0;
        }
        label {
            display: block;
            margin-top: 1em;
            font-weight: bold;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 0.5em;
            margin-top: 0.25em;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .actions {
            margin-top: 1.5em;
        }
        .btn {
            padding: 0.5em 1em;
            background: #27ae60;
            color: #fff;
            text-decoration: none;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn.cancel {
            background: #888;
            margin-left: 0.5em;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1em;
        }
        th, td {
            padding: 0.75em;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background: #f4f4f4;
        }
        a.action {
            margin-right: 0.5em;
            color: #3498db;
            text-decoration: none;
        }
        a.action:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1>Admin Management</h1>
    <div class="container">

        <!-- Form Section -->
        <div class="form-container">
            <h2>
                <c:choose>
                    <c:when test="${admin.adminId != 0}">Edit Admin</c:when>
                    <c:otherwise>New Admin</c:otherwise>
                </c:choose>
            </h2>

            <form action="${pageContext.request.contextPath}/admins" method="post">
                <input type="hidden" name="adminId" value="${admin.adminId}" />

                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" value="${admin.fullName}" required />

                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="${admin.email}" required />

                <label for="passwordHash">Password</label>
                <input type="password" id="passwordHash" name="passwordHash"
                       placeholder="<c:if test='${admin.adminId != 0}'>Leave blank to keep current</c:if>" />

                <label for="role">Role</label>
                <input type="text" id="role" name="role" value="${admin.role}" required />

                <div class="actions">
                    <button type="submit" class="btn">
                        <c:choose>
                            <c:when test="${admin.adminId != 0}">Update</c:when>
                            <c:otherwise>Create</c:otherwise>
                        </c:choose>
                    </button>
                    <a href="${pageContext.request.contextPath}/admins" class="btn cancel">Cancel</a>
                </div>
            </form>
        </div>

        <!-- List Section -->
        <div class="list-container">
            <h2>Admins</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="adm" items="${admins}">
                        <tr>
                            <td>${adm.adminId}</td>
                            <td>${adm.fullName}</td>
                            <td>${adm.email}</td>
                            <td>${adm.role}</td>
                            <td>
                                <a class="action" href="${pageContext.request.contextPath}/admins?action=edit&id=${adm.adminId}">Edit</a>
                                <a class="action" href="${pageContext.request.contextPath}/admins?action=delete&id=${adm.adminId}"
                                   onclick="return confirm('Delete this admin?');">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </div>
</body>
</html>
	