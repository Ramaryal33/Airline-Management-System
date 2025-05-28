<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Performance Reviews</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
        }
        h1, h2 {
            text-align: center;
        }
        .form-container {
            background-color: #f9f9f9;
            padding: 20px;
            border: 1px solid #ccc;
            width: 600px;
            margin: 20px auto;
        }
        .form-container label {
            font-weight: bold;
        }
        .form-container input, .form-container textarea, .form-container select {
            width: 100%;
            padding: 8px;
            margin: 8px 0 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-container button, .form-container a.cancel {
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            cursor: pointer;
            margin-right: 10px;
        }
        .form-container button { background-color: #28a745; color: white; }
        .form-container a.cancel { background-color: #dc3545; color: white; }

        table {
            width: 100%;
            margin-top: 30px;
            border-collapse: collapse;
        }
        table th, table td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }
        table th {
            background-color: #eee;
        }
        .btn {
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            color: white;
        }
        .edit-btn { background-color: #007bff; }
        .delete-btn { background-color: #dc3545; }
        .back-btn {
            margin-bottom: 20px;
            display: block;
            text-align: center;
        }
        .add-btn {
            display: block;
            width: fit-content;
            margin: 10px auto;
            background-color: green;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            border: none;
            cursor: pointer;
        }
        
        .back-btn {
    text-align: center;
    margin-bottom: 20px;
}

.back-btn a {
    display: inline-block;
    background-color: #6c757d; /* Bootstrap gray */
    color: white;
    padding: 10px 20px;
    border-radius: 4px;
    text-decoration: none;
    font-weight: bold;
    transition: background-color 0.3s ease;
}

.back-btn a:hover {
    background-color: #5a6268; /* Darker gray on hover */
}
        
    </style>

    <script>
        function showAddForm() {
            document.getElementById('addFormContainer').style.display = 'block';
            document.getElementById('showAddBtn').style.display = 'none';
        }

        function hideAddForm() {
            document.getElementById('addFormContainer').style.display = 'none';
            document.getElementById('showAddBtn').style.display = 'inline-block';
        }

        // Automatically show form if editing
        window.onload = function () {
            const isEdit = document.getElementById('editFormContainer');
            if (isEdit) {
                document.getElementById('showAddBtn').style.display = 'none';
            }
        }
    </script>
</head>
<body>

<h1>Staff Performance Reviews</h1>

<!-- Back Button -->
<div class="back-btn">
    <a href="staffDashboard">← Back to Dashboard</a>
</div>

<!-- Show Add Button -->
<div style="text-align:center;">
    <button id="showAddBtn" class="add-btn" onclick="showAddForm()">+ Add Review</button>
</div>

<!-- Edit Form -->
<c:if test="${not empty review}">
    <div class="form-container" id="editFormContainer">
        <h2>Edit Review</h2>
        <form action="staffPerformanceReview" method="post">
            <input type="hidden" name="action" value="edit"/>
            <input type="hidden" name="reviewId" value="${review.reviewId}" />

            <label>Staff ID:</label>
            <input type="number" name="staffId" value="${review.staffId}" required />

            <label>Rating:</label>
            <input type="text" name="rating" value="${review.rating}" required />

            <label>Performance Score:</label>
            <input type="number" name="performanceScore" step="0.1" value="${review.performanceScore}" required />

            <label>Improvement Score:</label>
            <input type="number" name="improvementScore" step="0.1" value="${review.improvementScore}" required />

            <label>Review Period:</label>
            <input type="text" name="reviewPeriod" value="${review.reviewPeriod}" required />

            <label>Review Type:</label>
            <input type="text" name="reviewType" value="${review.reviewType}" required />

            <label>Review Date:</label>
            <input type="date" name="reviewDate" value="${review.reviewDate}" required />

            <label>Notes:</label>
            <textarea name="notes">${review.notes}</textarea>

            <button type="submit">Update</button>
            <a href="staffPerformanceReview" class="cancel">Cancel</a>
        </form>
    </div>
</c:if>

<!-- Add Form -->
<c:if test="${empty review}">
    <div class="form-container" id="addFormContainer" style="display:none;">
        <h2>Add Review</h2>
        <form action="staffPerformanceReview" method="post">
            <input type="hidden" name="action" value="add"/>

            <label>Staff ID:</label>
            <input type="number" name="staffId" required />

            <label>Rating:</label>
            <input type="text" name="rating" required />

            <label>Performance Score:</label>
            <input type="number" name="performanceScore" step="0.1" required />

            <label>Improvement Score:</label>
            <input type="number" name="improvementScore" step="0.1" required />

            <label>Review Period:</label>
            <input type="text" name="reviewPeriod" required />

            <label>Review Type:</label>
            <input type="text" name="reviewType" required />

            <label>Review Date:</label>
            <input type="date" name="reviewDate" required />

            <label>Notes:</label>
            <textarea name="notes"></textarea>

            <button type="submit">Add Review</button>
            <a href="#" class="cancel" onclick="hideAddForm(); return false;">Cancel</a>
        </form>
    </div>
</c:if>

<!-- Table -->
<h2>All Reviews</h2>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Staff ID</th>
        <th>Rating</th>
        <th>Performance</th>
        <th>Improvement</th>
        <th>Period</th>
        <th>Type</th>
        <th>Date</th>
        <th>Notes</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="r" items="${reviewList}">
        <tr>
            <td>${r.reviewId}</td>
            <td>${r.staffId}</td>
            <td>${r.rating}</td>
            <td>${r.performanceScore}</td>
            <td>${r.improvementScore}</td>
            <td>${r.reviewPeriod}</td>
            <td>${r.reviewType}</td>
            <td>${r.reviewDate}</td>
            <td>${r.notes}</td>
            <td>
                <a href="staffPerformanceReview?action=edit&id=${r.reviewId}" class="btn edit-btn">Edit</a>
                <a href="staffPerformanceReview?action=delete&id=${r.reviewId}" class="btn delete-btn" onclick="return confirm('Delete this review?');">Delete</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>
