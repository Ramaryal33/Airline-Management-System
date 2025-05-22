<%@ page import="java.sql.*" %>
<%@ page import="com.airline.config.DbConfig" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Passengers</title>
    <style>
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

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .action-buttons a,
        .action-buttons form {
            display: inline-block;
            margin-right: 5px;
        }

        .btn-view,
        .btn-edit,
        .btn-delete {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            color: white;
            font-size: 0.9rem;
            cursor: pointer;
            text-decoration: none;
        }

        .btn-view {
            background-color: #28a745;
        }
        .btn-view:hover {
            background-color: #218838;
        }

        .btn-edit {
            background-color: #ffc107;
            color: #212529;
        }
        .btn-edit:hover {
            background-color: #e0a800;
        }

        .btn-delete {
            background-color: #dc3545;
        }
        .btn-delete:hover {
            background-color: #c82333;
        }

        /* Inline edit form styling */
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

    <h2>Manage Passengers</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Actions</th>
        </tr>

    <%
        try (Connection conn = DbConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "SELECT id, FullName, Email, Phone FROM users WHERE userType = 'user'");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("FullName");
                String mail = rs.getString("Email");
                String ph = rs.getString("Phone");
    %>
        <tr>
            <td><%= id %></td>
            <td><%= name %></td>
            <td><%= mail %></td>
            <td><%= ph %></td>
            <td class="action-buttons">
                <!-- Edit Action -->
                <a href="managePassenger?action=edit&id=<%= id %>" class="btn-edit">Edit</a>

                <!-- Delete Form -->
                <form action="managePassenger" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete" />
                    <input type="hidden" name="id" value="<%= id %>" />
                    <input type="submit" value="Delete" />
                </form>
            </td>
        </tr>
    <%
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='5' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
        }
    %>
    </table>

</body>
</html>
