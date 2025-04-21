<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
</head>
<body>
    <div class="register-container">
        <h2>Register</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if (session.getAttribute("success") != null) { %>
            <div class="success"><%= session.getAttribute("success") %></div>
            <% session.removeAttribute("success"); %>
        <% } %>

        <form method="post" action="register">
            <div class="form-group">
                <label for="fullname">Full Name:</label>
                <input type="text" name="fullname" id="fullname" required>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" name="email" id="email" required>
            </div>

            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="tel" name="phone" id="phone" required>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" name="password" id="password" required>
            </div>

            <div class="form-group">
                <label for="confirm_password">Confirm Password:</label>
                <input type="password" name="confirm_password" id="confirm_password" required>
            </div>

            <button type="submit">Register</button>
        </form>

        <div class="login-link">
            Already have an account? <a href="login">Login</a>
        </div>
    </div>
</body>
</html>
