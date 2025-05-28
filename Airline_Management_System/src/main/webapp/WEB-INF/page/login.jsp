<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html>

<head>

    <title>Login - Airline System</title>

    

    <!-- Internal CSS -->

    <style>

    /* Base Styles */

    * {

        box-sizing: border-box;

        margin: 0;

        padding: 0;

    }



    body {

        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;

        background-color: rgb(241, 251, 254);

        height: 100vh;

        display: flex;

        justify-content: center;

        align-items: center;

        line-height: 1.6;

    }



    /* Main Wrapper */

    .login-wrapper {

        display: flex;

        width: 900px;

        height: 550px;

        box-shadow: 0 5px 30px rgba(0, 0, 0, 0.1);

        border-radius: 10px;

        overflow: hidden;

    }



    /* Hero/Image Section */

    .login-hero {

        flex: 1;

        position: relative;

    }



    .hero-image {

        width: 100%;

        height: 100%;

        object-fit: cover;

        display: block;

    }



    .hero-overlay {

        position: absolute;

        top: 0;

        left: 0;

        width: 100%;

        height: 100%;

        background: rgba(0, 0, 0, 0.4);

        display: flex;

        flex-direction: column;

        justify-content: center;

        align-items: center;

        color: white;

        text-align: center;

        padding: 2rem;

    }



    .hero-overlay h1 {

        font-size: 2.5rem;

        margin-bottom: 1rem;

        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);

    }



    .hero-overlay p {

        font-size: 1.2rem;

        max-width: 80%;

        text-shadow: 0 1px 3px rgba(0, 0, 0, 0.5);

    }



    /* Form Section */

    .login-form {

        flex: 1;

        padding: 2.5rem;

        background: white;

        display: flex;

        flex-direction: column;

        justify-content: center;

    }



    .login-form h2 {

        color: #2c3e50;

        margin-bottom: 1.5rem;

        text-align: center;

        font-size: 1.8rem;

    }



    /* Form Elements */

    .form-group {

        margin-bottom: 1.25rem;

    }



    .form-group label {

        display: block;

        margin-bottom: 0.5rem;

        color: #2c3e50;

        font-weight: 500;

        font-size: 0.95rem;

    }



    .form-group input[type="email"],

    .form-group input[type="password"] {

        width: 100%;

        padding: 0.75rem;

        border: 1px solid #ddd;

        border-radius: 4px;

        font-size: 1rem;

        transition: border-color 0.3s;

    }



    .form-group input:focus {

        outline: none;

        border-color: #3498db;

        box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);

    }



    /* Form Options */

    .form-options {

        display: flex;

        justify-content: space-between;

        align-items: center;

        margin: 1.5rem 0;

    }



    .remember-me {

        display: flex;

        align-items: center;

        gap: 0.5rem;

        font-size: 0.9rem;

        color: #7f8c8d;

    }



    .forgot-password {

        color: #3498db;

        text-decoration: none;

        font-size: 0.9rem;

    }



    .forgot-password:hover {

        text-decoration: underline;

    }



    /* Buttons */

    .login-btn {

        width: 100%;

        padding: 0.75rem;

        background-color: #3498db;

        color: white;

        border: none;

        border-radius: 4px;

        font-size: 1rem;

        font-weight: 500;

        cursor: pointer;

        transition: background-color 0.3s;

    }



    .login-btn:hover {

        background-color: #2980b9;

    }



    /* Register Link */

    .register-link {

        text-align: center;

        margin-top: 1.5rem;

        color: #7f8c8d;

        font-size: 0.95rem;

    }



    .register-link a {

        color: #3498db;

        text-decoration: none;

        font-weight: 500;

    }



    .register-link a:hover {

        text-decoration: underline;

    }



    /* Alerts */

    .alert {

        padding: 0.75rem;

        margin-bottom: 1.5rem;

        border-radius: 4px;

        font-size: 0.9rem;

    }



    .error {

        background-color: #fdecea;

        color: #d32f2f;

        border: 1px solid #ef9a9a;

    }



    .success {

        background-color: #e8f5e9;

        color: #388e3c;

        border: 1px solid #a5d6a7;

    }

    </style>

</head>

<body>

    <div class="login-wrapper">



        <!-- Image Section -->

        <div class="login-hero">

            <img src="<%= request.getContextPath() %>/image/loginbg.jpg" 

                 alt="Airline Login Background"

                 class="hero-image">

            <div class="hero-overlay">

                <h1>Welcome to Dawn Airline</h1>

                <p>Your journey begins here.</p>

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



            <h2>Welcome Back</h2>



            <form action="<%= request.getContextPath() %>/login" method="post">

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

                    <a href="<%= request.getContextPath() %>/forgotPassword" class="forgot-password">

                        Forgot password?

                    </a>

                </div>



                <button type="submit" class="login-btn">Login</button>



                <div class="register-link">

                    Don't have an account? 

                    <a href="<%= request.getContextPath() %>/register">Register</a>

                </div>

            </form>

        </div>

    </div>

</body>

</html>