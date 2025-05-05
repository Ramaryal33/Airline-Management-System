<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Your Profile - Dawn Airlines</title>
  <link rel="stylesheet" href="style.css" />
</head>
<body class="contact-page">
  <div class="contact-container">
    <h2>Your Profile</h2>

    <form action="/update-profile" method="POST">
      <input type="text" name="fullName" value="John Doe" required />
      <input type="email" name="email" value="john@example.com" required />
      <input type="password" name="newPassword" placeholder="New Password" />
      <button type="submit">Update Profile</button>
    </form>
  </div>
</body>
</html>
