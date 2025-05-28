<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>

        /* Base Setup */

        body {

            background-color: #f5deb3; /* light brown */

            font-family: Arial, sans-serif;

            display: flex;

            justify-content: center;

            align-items: center;

            height: 100vh;

            margin: 0;

            padding: 0;

        }



        /* Container */

        .register-container {

            background-color: #ffffff;

            padding: 40px 30px;

            border-radius: 12px;

            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);

            width: 100%;

            max-width: 450px;

            animation: fadeIn 0.4s ease-out;

        }



        /* Header */

        .register-container h2 {

            margin-bottom: 25px;

            color: #2c3e50;

            text-align: center;

            font-size: 28px;

        }



        /* Form Elements */

        form {

            display: flex;

            flex-direction: column;

        }



        .form-group {

            margin-bottom: 18px;

        }



        .form-group label {

            font-weight: 600;

            margin-bottom: 6px;

            display: block;

            color: #34495e;

        }



        .form-group input,

        .form-group select {

            width: 100%;

            padding: 12px 14px;

            border: 1px solid #ccc;

            border-radius: 6px;

            font-size: 15px;

            background-color: #fff;

            transition: 0.3s;

            box-sizing: border-box;

        }



        .form-group input:focus,

        .form-group select:focus {

            border-color: #3498db;

            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.15);

            outline: none;

        }



        /* Submit Button */

        button[type="submit"] {

            width: 100%;

            padding: 12px;

            font-size: 16px;

            font-weight: 600;

            background-color: #3498db;

            color: white;

            border: none;

            border-radius: 6px;

            cursor: pointer;

            transition: background-color 0.3s;

            margin-top: 10px;

        }



        button[type="submit"]:hover {

            background-color: #2980b9;

        }



        /* Message Boxes */

        .error,

        .success {

            padding: 12px 16px;

            border-radius: 6px;

            margin-bottom: 20px;

            border-left: 5px solid;

            font-size: 15px;

        }



        .error {

            background-color: #fdecea;

            color: #e74c3c;

            border-color: #e74c3c;

        }



        .success {

            background-color: #eafaf1;

            color: #27ae60;

            border-color: #27ae60;

        }



        /* Login Link */

        .login-link {

            text-align: center;

            margin-top: 20px;

            font-size: 14px;

            color: #7f8c8d;

        }



        .login-link a {

            color: #3498db;

            text-decoration: none;

            font-weight: 500;

        }



        .login-link a:hover {

            text-decoration: underline;

        }



        /* Animation */

        @keyframes fadeIn {

            from {

                opacity: 0;

                transform: translateY(-10px);

            }

            to {

                opacity: 1;

                transform: translateY(0);

            }

        }



        /* Responsive */

        @media (max-width: 480px) {

            .register-container {

                padding: 25px 20px;

                margin: 15px;

            }



            .register-container h2 {

                font-size: 22px;

            }

        }

    </style>
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
