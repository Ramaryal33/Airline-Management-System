<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Logout Confirmation</title>
    <script>
        window.onload = function () {
            const confirmed = confirm("Are you sure you want to log out?");
            if (confirmed) {
                // Already logged out, now redirect to home
                window.location.href = "<%= request.getContextPath() %>/home";
            } else {
                // Stay on the same page or go back
                window.history.back();
            }
        };
    </script>
</head>
</html>
