<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Staff Task Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        h1, h2 {
            text-align: center;
        }

        form {
            margin-bottom: 30px;
        }

        input[type="text"],
        input[type="number"],
        input[type="date"],
        textarea,
        select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 15px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        input[readonly] {
            background-color: #eee;
        }

        button,
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            color: white;
            cursor: pointer;
        }

        .btn-add {
            background: #007bff;
            margin-bottom: 10px;
            display: inline-block;
        }

        .btn-save {
            background: #28a745;
        }

        .btn-cancel {
            background: #dc3545;
        }

        .btn-edit {
            background-color: #007bff;
        }

        .btn-delete {
            background-color: #dc3545;
        }

        .btn-back {
            background-color: #6c757d;
        }

        .back-container {
            text-align: left;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Staff Task Management</h1>

    <!-- Back to Dashboard -->
    <div class="back-container">
        <a href="staffDashboard" class="btn btn-back">← Back to Dashboard</a>
    </div>

    <!-- Task Form -->
    <c:if test="${param.action == 'new' || param.action == 'edit'}">
        <h2>${empty task ? 'Add New Task' : 'Edit Task'}</h2>
        <form action="staffTask?action=${empty task ? 'add' : 'update'}" method="post">
            <c:if test="${not empty task}">
                <input type="hidden" name="id" value="${task.taskId}" />
            </c:if>

            <label>Title:</label>
            <input type="text" name="title" value="${task.title}" required />

            <label>Description:</label>
            <textarea name="description" rows="3">${task.description}</textarea>

            <label>Assigned To (Staff ID):</label>
            <input type="number" name="assignedTo" value="${task.assignedTo}" required />

            <label>Assigned By (Staff ID):</label>
            <input type="number" name="assignedBy" value="${task.assignedBy}" required />

            <label>Due Date:</label>
            <input type="date" name="dueDate" value="${task.dueDate}" required />

            <label>Status:</label>
            <select name="status">
                <option value="Pending" ${task.status == 'Pending' ? 'selected' : ''}>Pending</option>
                <option value="In Progress" ${task.status == 'In Progress' ? 'selected' : ''}>In Progress</option>
                <option value="Completed" ${task.status == 'Completed' ? 'selected' : ''}>Completed</option>
            </select>

            <label>Priority:</label>
            <select name="priority">
                <option value="Low" ${task.priority == 'Low' ? 'selected' : ''}>Low</option>
                <option value="Medium" ${task.priority == 'Medium' ? 'selected' : ''}>Medium</option>
                <option value="High" ${task.priority == 'High' ? 'selected' : ''}>High</option>
            </select>

            <label>Progress (%):</label>
            <input type="number" name="progress" value="${task.progress}" min="0" max="100" />

            <c:if test="${not empty task}">
                <label>Created At:</label>
                <input type="text" readonly value="${task.createdAt}" />

                <label>Completed At:</label>
                <input type="text" readonly value="${task.completedAt}" />

                <label>Last Updated At:</label>
                <input type="text" readonly value="${task.lastUpdatedAt}" />
            </c:if>

            <button type="submit" class="btn btn-save">Save</button>
            <a href="staffTask" class="btn btn-cancel">Cancel</a>
        </form>
    </c:if>

    <!-- Task List -->
    <h2>Task List</h2>
    <a href="staffTask?action=new" class="btn btn-add">Add Task</a>

    <table>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Assigned To</th>
            <th>Status</th>
            <th>Priority</th>
            <th>Due Date</th>
            <th>Progress</th>
            <th>Actions</th>
        </tr>
        <c:forEach items="${taskList}" var="task">
            <tr>
                <td>${task.taskId}</td>
                <td>${task.title}</td>
                <td>${task.assignedTo}</td>
                <td>${task.status}</td>
                <td>${task.priority}</td>
                <td>${task.dueDate}</td>
                <td>${task.progress}%</td>
                <td>
                    <a href="staffTask?action=edit&id=${task.taskId}" class="btn btn-edit">Edit</a>
                    <a href="staffTask?action=delete&id=${task.taskId}" onclick="return confirm('Delete this task?')" class="btn btn-delete">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

</body>
</html>
