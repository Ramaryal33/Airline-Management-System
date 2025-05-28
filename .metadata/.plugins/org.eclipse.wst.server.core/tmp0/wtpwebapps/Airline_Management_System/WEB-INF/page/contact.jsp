<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Contact Us - Dawn Airlines</title>
   <!-- External CSS -->
    <link rel="stylesheet" href="${cssPath}">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>
<body class="contact">

  <!-- Navbar -->
  <header class="navbar">
    <div class="logo">Dawn Airlines</div>
    <nav>
      <ul>
        <li><a href="home.html">Home</a></li>
       
        <li><a href="contact.html" class="active">Contact Us</a></li>
        <li><a href="about.html">About Us</a></li>
        <li><a href="login.html">Login</a></li>
      </ul>
    </nav>
  </header>

  <!-- Contact Section -->
  <section class="contact-section">
    <div class="contact-form-container">

      <!-- LEFT SIDE: FORM -->
      <div class="form-side">
        <h1>Get in Touch</h1>
        <p>We’re here to help. Reach out to us through the form below.</p>

        <form class="contact-form">
          <input type="text" placeholder="Your Name" required />
          <input type="email" placeholder="Your Email" required />
          <textarea placeholder="Your Message" required></textarea>
          <button type="submit">Send Message</button>
        </form>
      </div>

      <!-- RIGHT SIDE: SOCIAL AND DEPARTMENTS -->
      <div class="departments">
        <h3>Follow Our Teams:</h3>
        <ul>
          <li><i class="fab fa-instagram"></i> <a href="#">@dawn_support</a></li>
          <li><i class="fab fa-instagram"></i> <a href="#">@dawn_marketing</a></li>
          <li><i class="fab fa-instagram"></i> <a href="#">@dawn_hr</a></li>
          <li><i class="fab fa-instagram"></i> <a href="#">@dawn_crew</a></li>
        </ul>

        <h3>Corporate Accounts</h3>
        <div class="social-icons">
          <a href="#"><i class="fab fa-facebook"></i></a>
          <a href="#"><i class="fab fa-x-twitter"></i></a>
          <a href="#"><i class="fab fa-linkedin"></i></a>
          <a href="#"><i class="fab fa-youtube"></i></a>
        </div>
      </div>

    </div>
  </section>

</body>
</html>
