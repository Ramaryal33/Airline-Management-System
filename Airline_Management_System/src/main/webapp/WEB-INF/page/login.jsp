<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Airline System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/userlogin.css">
</head>
<body>
    <div class="login-wrapper">

        <!-- Image Section -->
        <div class="login-hero">
            <img src="${pageContext.request.contextPath}/image/login.jpg" 
                 alt="Airline Login Background"
                 class="hero-image">
            <div class="hero-overlay">
                
            </div>
        </div>

        <!-- Login Form -->
        <div class="login-form">
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert error"><%= request.getAttribute("error") %></div>
            <% } %>
            <% if (session.getAttribute("success") != null) { %>
                <div class="alert success"><%= session.getAttribute("success") %></div>
                <% session.removeAttribute("success"); %>
            <% } %>

            <h2>Welcome Back to Dawn Airline</h2>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <input type="hidden" name="redirect" value="${param.redirect}">

                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" name="email" id="email" 
                           value="${cookie.rememberedEmail.value}" required>
                </div>

                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" name="password" id="password" required>
                </div>

                <div class="form-options">
                    <label class="remember-me">
                        <input type="checkbox" name="remember"> Remember me
                    </label>
                    <a href="${pageContext.request.contextPath}/forgotPassword" class="forgot-password">
                        Forgot password?
                    </a>
                </div>

                <button type="submit" class="login-btn">Login</button>

                <div class="register-link">
                    Don't have an account? 
                    <a href="${pageContext.request.contextPath}/register">Register</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
