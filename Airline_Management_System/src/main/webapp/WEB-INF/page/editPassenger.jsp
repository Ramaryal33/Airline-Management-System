<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Passenger</title>
    <style>
        /* Styling for edit form */
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        .edit-form {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            width: 50%;
            margin-bottom: 30px;
        }

        .edit-form input[type="text"],
        .edit-form input[type="email"] {
            width: 100%;
            padding: 8px;
            margin: 5px 0 10px 0;
            box-sizing: border-box;
        }

        .edit-form input[type="submit"] {
            padding: 10px 20px;
            background-color: #0077cc;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .edit-form input[type="submit"]:hover {
            background-color: #005fa3;
        }
    </style>
</head>
<body>

    <h2>Edit Passenger</h2>

    <%
        Map<String, String> passenger = (Map<String, String>) request.getAttribute("editPassenger");
        String fullName = passenger.get("fullName");
        String email = passenger.get("email");
        String phone = passenger.get("phone");
        int id = Integer.parseInt(passenger.get("id"));
    %>

    <form action="managePassenger" method="post" class="edit-form">
        <input type="hidden" name="action" value="update" />
        <input type="hidden" name="id" value="<%= id %>" />

        <label for="fullName">Full Name:</label>
        <input type="text" name="fullName" value="<%= fullName %>" required />

        <label for="email">Email:</label>
        <input type="email" name="email" value="<%= email %>" required />

        <label for="phone">Phone:</label>
        <input type="text" name="phone" value="<%= phone %>" />

        <input type="submit" value="Save Changes" />
    </form>

</body>
</html>
