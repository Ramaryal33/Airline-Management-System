<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <base href="${basePath}">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${pageTitle}</title>
  <link rel="stylesheet" href="${cssPath}?v=1.0">
</head>
<body class="about">

  <header class="navbar">
    <div class="logo">Dawn Airlines</div>
    <nav>
      <ul>
        <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
        
        <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
        <li><a href="${pageContext.request.contextPath}/about" class="active">About Us</a></li>
        <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
      </ul>
    </nav>
  </header>

  <section class="about-section">
    <h1>About Dawn Airlines</h1>
    <p>
      At Dawn Airlines, we're redefining air travel with innovation, care, and excellence. 
      From domestic routes to global destinations, we aim to make your journey memorable.
    </p>

    <h2>Meet the Team</h2>
    <div class="team-grid">
      <div class="team-member">
        <img src="${pageContext.request.contextPath}/image/leader.jpg" alt="Member 1">
        <h4>Ram Aryal</h4>
        <p>Leader</p>
      </div>
      <div class="team-member">
        <img src="${pageContext.request.contextPath}/images/member2.jpg" alt="Member 2">
        <h4>Suyash Pokheral</h4>
        <p>Member</p>
      </div>
      <div class="team-member">
        <img src="${pageContext.request.contextPath}/image/aayush.jpg" alt="Member 3">
        <h4>Aauysh Kumar Gupta</h4>
        <p>Member</p>
      </div>
      <div class="team-member">
        <img src="${pageContext.request.contextPath}/images/member4.jpg" alt="Member 4">
        <h4>Aabhinna Maharjan</h4>
        <p>Member</p>
      </div>
    </div>
  </section>

</body>
</html>