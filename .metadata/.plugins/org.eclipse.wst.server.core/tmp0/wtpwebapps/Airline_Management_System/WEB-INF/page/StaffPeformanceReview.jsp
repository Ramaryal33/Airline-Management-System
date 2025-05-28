<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.airline.staff.model.PerformanceReview" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Performance Review Management</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: left; }
        th { background-color: #f2f2f2; }
        form { margin-bottom: 20px; }
        input[type="text"], input[type="number"], input[type="date"], textarea {
            width: 100%; padding: 8px; margin-bottom: 10px;
        }
        button, a.button {
            padding: 8px 16px;
            background-color: #4CAF50;
            color: white; border: none;
            text-decoration: none; cursor: pointer;
        }
        a.button { display: inline-block; margin-top: 10px; }
        .danger { background-color: #f44336; }
    </style>
</head>
<body>

    <h2>Performance Reviews</h2>

    <c:choose>
        <c:when test="${not empty review}">
            <!-- CREATE/UPDATE FORM -->
            <form action="StaffPerformanceController" method="post">
                <input type="hidden" name="id" value="${review.reviewId}" />
                <label>Staff ID:</label>
                <input type="text" name="staffId" value="${review.staffId}" required />

                <label>Rating:</label>
                <input type="text" name="rating" value="${review.rating}" required />

                <label>Performance Score:</label>
                <input type="number" step="0.01" name="performanceScore" value="${review.performanceScore}" required />

                <label>Review Period:</label>
                <input type="text" name="reviewPeriod" value="${review.reviewPeriod}" required />

                <label>Review Date:</label>
                <input type="date" name="reviewDate" value="${review.reviewDate}" required />

                <label>Notes:</label>
                <textarea name="notes" rows="4">${review.notes}</textarea>

                <button type="submit">${review.reviewId == 0 ? "Create" : "Update"}</button>
                <a href="StaffPerformanceController" class="button danger">Cancel</a>
            </form>
        </c:when>
        <c:otherwise>
            <a href="StaffPerformanceController?action=new" class="button">Add New Review</a>
        </c:otherwise>
    </c:choose>

    <!-- REVIEWS TABLE -->
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Staff ID</th>
            <th>Rating</th>
            <th>Score</th>
            <th>Period</th>
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
                <td>${r.reviewPeriod}</td>
                <td>${r.reviewDate}</td>
                <td>${r.notes}</td>
                <td>
                    <a href="StaffPerformanceController?action=edit&id=${r.reviewId}" class="button">Edit</a>
                    <a href="StaffPerformanceController?action=delete&id=${r.reviewId}" class="button danger"
                       onclick="return confirm('Are you sure you want to delete this review?');">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</body>
</html>
