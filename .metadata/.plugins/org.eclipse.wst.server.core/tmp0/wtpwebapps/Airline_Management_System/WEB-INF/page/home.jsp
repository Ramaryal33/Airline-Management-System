<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Dawn Airlines</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/airline.css">
</head>
<body class="Home" >

  <!-- Navbar -->
  <header class="navbar">
    <div class="logo">Dawn Airlines</div>
    <nav>
  <ul>
    <li><a href="${pageContext.request.contextPath}/home" class="active">Home</a></li>
    
    <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
    <li><a href="${pageContext.request.contextPath}/About">About Us</a></li>
    <li><a href="${pageContext.request.contextPath}/login">login</a></li>
  </ul>
</nav>
  </header>

  <!-- Hero Section -->
  <section class="hero">
    <div class="hero-content">
      <h1>Fly the Future with Dawn Airlines</h1>
      <p>Experience comfort, speed, and reliability on every journey.</p>
      <a href="#" class="btn">Book Now</a>
    </div>
  </section>

  <!-- Booking Form Section -->
  <section class="booking-section">
    <div class="booking-form">
      <h2>Book Your Flight</h2>
      <form>
        <input type="text" placeholder="From" required />
        <input type="text" placeholder="To" required />
        <input type="date" placeholder="Departure" required />
        <input type="date" placeholder="Return" />
        <button type="submit">Search Flights</button>
      </form>
    </div>
  </section>

  <!-- Features Section -->
  <section class="features">
    <h2>Why Choose Dawn Airlines</h2>
    <div class="features-container">
      <div class="feature">
        <img src="direct_flights.jpg" alt="Direct Flights">
        <h3>Direct Flights Worldwide</h3>
        <p>Connect to over 80 cities directly with ease and comfort.</p>
      </div>
      <div class="feature">
        <img src="modern-fleet.jpg" alt="Modern Fleet">
        <h3>Modern, Comfortable Aircraft</h3>
        <p>Fly with our latest aircraft models ensuring safety and comfort.</p>
      </div>
      <div class="feature">
        <img src="experienced-crew.jpg" alt="Experienced Crew">
        <h3>Experienced, Qualified Crew</h3>
        <p>Our professional crew is dedicated to providing exceptional service.</p>
      </div>
      <div class="feature">
        <img src="loyalty-program.jpg" alt="Loyalty Program">
        <h3>Rewarding Loyalty Program</h3>
        <p>Earn miles and enjoy exclusive benefits every time you travel with us.</p>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer class="footer">
    <div class="footer-container">
      <div class="footer-col">
        <h4>About Us</h4>
        <ul>
          <li><a href="#">News</a></li>
          <li><a href="#">Annual Report</a></li>
          <li><a href="#">Careers</a></li>
        </ul>
      </div>
      <div class="footer-col">
        <h4>Contact Us</h4>
        <ul>
          <li><a href="#">Contact with us</a></li>
          <li><a href="#">Feedback</a></li>
          <li><a href="#">Login</a></li>
        </ul>
      </div>
      <div class="footer-col subscribe">
        <h4>Subscribe to our offers</h4>
        <p>Subscribe and be the first to hear about the latest offers</p>
        <div class="subscribe-form">
          <input type="email" placeholder="Enter Your Email address">
          <button>Subscribe</button>
        </div>
      </div>
    </div>
  </footer>

</body>
</html>
