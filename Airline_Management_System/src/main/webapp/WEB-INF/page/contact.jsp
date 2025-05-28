<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Contact Us - Dawn Airlines</title>
   <style>
  body {
    font-family: 'Segoe UI', sans-serif;
    background-color: #0a0a0a;
    color: #fff;
    margin: 0;
    padding: 0;
  }

  .navbar {
    background: #0a1c2c;
    padding: 1.2rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
  }

  .navbar .logo {
    color: #f6c90e;
    font-size: 1.8rem;
    font-weight: bold;
  }

  .navbar ul {
    list-style: none;
    display: flex;
    gap: 1.5rem;
    flex-wrap: wrap;
  }

  .navbar a {
    color: white;
    text-decoration: none;
    transition: color 0.3s ease;
  }

  .navbar a.active, .navbar a:hover {
    color: #f6c90e;
  }

  .contact-section {
    padding: 3rem 1rem;
    background-color: #0a0a0a;
    color: #fff;
  }

  .contact-form-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
    gap: 2rem;
    margin-top: 2rem;
    align-items: flex-start;
  }

  .form-side {
    max-width: 450px;
    width: 100%;
  }

  .form-side h1 {
    font-size: 2rem;
    margin-bottom: 0.5rem;
  }

  .form-side p {
    margin-bottom: 1.5rem;
    color: #ccc;
  }

  .contact-form {
    background: #111;
    padding: 2rem;
    border-radius: 12px;
  }

  .contact-form input,
  .contact-form textarea {
    width: 100%;
    padding: 0.7rem;
    margin-bottom: 1rem;
    background: #222;
    border: none;
    border-radius: 6px;
    color: #fff;
  }

  .contact-form button {
    width: 100%;
    padding: 0.8rem;
    background: #f6c90e;
    border: none;
    border-radius: 6px;
    color: #000;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }

  .contact-form button:hover {
    background-color: #ffd700;
  }

  .departments {
    max-width: 300px;
  }

  .departments h3 {
    margin-top: 1rem;
    color: #f6c90e;
  }

  .departments ul {
    list-style: none;
    padding: 0;
  }

  .departments li {
    margin: 0.5rem 0;
  }

  .departments a {
    color: #fff;
    text-decoration: none;
  }

  .departments a:hover {
    text-decoration: underline;
  }

  .social-icons {
    margin-top: 1rem;
  }

  .social-icons a {
    font-size: 1.5rem;
    margin-right: 1rem;
    color: #f6c90e;
  }

  @media (max-width: 768px) {
    .contact-form-container {
      flex-direction: column;
      align-items: center;
    }

    .form-side, .departments {
      max-width: 100%;
    }
  }
</style>
   
</head>
<body class="contact">

  <!-- Navbar -->
  <header class="navbar">
    <div class="logo">Dawn Airlines</div>
 <nav class="navbar">
 
  <ul>
    <li><a href="home">Home</a></li>
    <li><a href="contact" class="active">Contact Us</a></li>
    <li><a href="About">About Us</a></li>
    <li><a href="login">Login</a></li>
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
