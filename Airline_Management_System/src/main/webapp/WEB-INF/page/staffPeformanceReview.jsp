<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Performance Review Management</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        .form-container { 
            margin-top: 20px; 
            padding: 20px; 
            border: 1px solid #ccc; 
            background-color: #f9f9f9; 
            width: 60%; 
            margin-left: auto; 
            margin-right: auto; 
            display: none;
        }
        .form-container h2 { margin-bottom: 20px; }
        .form-container input, .form-container select, .form-container textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        .form-container button {
            background-color: green;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .form-container a.cancel-btn {
            background-color: red;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
            margin-left: 10px;
        }
        table { width: 100%; border-collapse: collapse; margin-top: 40px; }
        th, td { padding: 8px; border: 1px solid #ccc; text-align: left; }
        th { background-color: #e0e0e0; }
        .add-btn {
            background-color: green;
            color: white;
            padding: 10px 20px;
            margin-bottom: 20px;
            display: inline-block;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<h1>Performance Review Management</h1>
<button class="add-btn" id="addReviewBtn">Add Review</button>

<div class="form-container" id="reviewForm">
    <h2>Add/Edit Performance Review</h2>
    <form action="staffPeformanceReview" method="post">
        <input type="hidden" name="reviewId" value="${review.reviewId}" />

        <label>Staff ID:</label>
        <input type="number" name="staffId" value="${review.staffId}" required />

        <label>Rating:</label>
        <input type="text" name="rating" value="${review.rating}" required />

        <label>Performance Score:</label>
        <input type="number" step="0.01" name="performanceScore" value="${review.performanceScore}" required />

        <label>Improvement Score:</label>
        <input type="number" step="0.01" name="improvementScore" value="${review.improvementScore}" required />

        <label>Review Period:</label>
        <input type="text" name="reviewPeriod" value="${review.reviewPeriod}" required />

        <label>Review Type:</label>
        <input type="text" name="reviewType" value="${review.reviewType}" required />

        <label>Review Date:</label>
        <input type="date" name="reviewDate" value="${review.reviewDate}" required />

        <label>Notes:</label>
        <textarea name="notes">${review.notes}</textarea>

       

        <button type="submit">${empty review ? 'Save' : 'Update'}</button>
        <a href="performanceReview" class="cancel-btn">Cancel</a>
    </form>
</div>

<table>
    <tr>
        <th>Staff ID</th>
        <th>Rating</th>
        <th>Performance Score</th>
        <th>Improvement Score</th>
        <th>Review Period</th>
        <th>Review Type</th>
        <th>Review Date</th>
        <th>Notes</th>
        <th>Created At</th>
        <th>Updated At</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="review" items="${reviewList}">
        <tr>
            <td>${review.staffId}</td>
            <td>${review.rating}</td>
            <td>${review.performanceScore}</td>
            <td>${review.improvementScore}</td>
            <td>${review.reviewPeriod}</td>
            <td>${review.reviewType}</td>
            <td>${review.reviewDate}</td>
            <td>${review.notes}</td>
            <td>${review.createdAt}</td>
            <td>${review.updatedAt}</td>
            <td>
                <a href="staffPeformanceReview?action=edit&id=${review.reviewId}">Edit</a>
                <a href="staffPeformanceReview?action=delete&id=${review.reviewId}" onclick="return confirm('Delete this review?');">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>

<script>
    const addReviewBtn = document.getElementById('addReviewBtn');
    const reviewForm = document.getElementById('reviewForm');

    addReviewBtn.addEventListener('click', function() {
        reviewForm.style.display = 'block';
        addReviewBtn.style.display = 'none';
    });
</script>

</body>
</html>
