<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="en">

<head>

 <meta charset="UTF-8" />

 <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

 <title>Dawn Airlines</title>

 <style>

 * {

 margin: 0;

 padding: 0;

 box-sizing: border-box;

 }



 body, html {

 font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;

 background: url('https://wallpaperaccess.com/full/445724.jpg  ') no-repeat center center fixed;

 background-size: cover;

 color: #333;

 line-height: 1.6;

 }



 .navbar {

 background: rgba(255, 255, 255, 0.95);

 padding: 1.2rem 2rem;

 display: flex;

 justify-content: space-between;

 align-items: center;

 position: sticky;

 top: 0;

 z-index: 100;

 box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);

 }



 .navbar .logo {

 color: #0077b6;

 font-size: 1.8rem;

 font-weight: bold;

 text-decoration: none;

 }



 .navbar ul {

 list-style: none;

 display: flex;

 gap: 1.5rem;

 }



 .navbar a {

 color: #333;

 text-decoration: none;

 transition: color 0.3s ease;

 font-size: 1.1rem;

 }



 .navbar a.active,

 .navbar a:hover {

 color: #0077b6;

 }



 .hero {

 height: 80vh;

 display: flex;

 align-items: center;

 justify-content: center;

 text-align: center;

 background: rgba(255, 255, 255, 0.8);

 padding: 2rem;

 }



 .hero-content {

 background: rgba(255, 255, 255, 0.95);

 padding: 2.5rem;

 border-radius: 16px;

 max-width: 700px;

 box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);

 }



 .hero-content h1 {

 font-size: 2.8rem;

 margin-bottom: 1rem;

 color: #0077b6;

 }



 .hero-content p {

 font-size: 1.2rem;

 margin-bottom: 1.5rem;

 }



 .btn {

 padding: 0.8rem 2rem;

 background: #0077b6;

 color: #fff;

 font-weight: bold;

 border: none;

 border-radius: 6px;

 text-decoration: none;

 font-size: 1rem;

 transition: background-color 0.3s ease;

 }



 .btn:hover {

 background-color: #005f87;

 }



 .booking-section {

 background: rgba(255, 255, 255, 0.92);

 padding: 3rem 1rem;

 display: flex;

 justify-content: center;

 }



 .booking-form {

 background: #f9f9f9;

 padding: 2rem;

 border-radius: 12px;

 max-width: 500px;

 width: 100%;

 box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);

 }



 .booking-form h2 {

 text-align: center;

 margin-bottom: 1.5rem;

 color: #0077b6;

 }



 .booking-form input {

 width: 100%;

 padding: 0.7rem;

 margin-bottom: 1rem;

 border: 1px solid #ccc;

 border-radius: 6px;

 background-color: #fff;

 color: #333;

 font-size: 1rem;

 }



 .booking-form button {

 width: 100%;

 padding: 0.8rem;

 background: #0077b6;

 border: none;

 border-radius: 6px;

 color: #fff;

 font-weight: bold;

 font-size: 1rem;

 cursor: pointer;

 }



 .booking-form button:hover {

 background-color: #005f87;

 }



 .features {

 padding: 3rem 1rem;

 background: rgba(255, 255, 255, 0.94);

 text-align: center;

 }



 .features h2 {

 color: #0077b6;

 margin-bottom: 2rem;

 font-size: 2rem;

 }



 .features-container {

 display: flex;

 flex-wrap: wrap;

 justify-content: center;

 gap: 2rem;

 max-width: 1200px;

 margin: 0 auto;

 }



 .feature {

 background: #fff;

 border-radius: 12px;

 padding: 1rem;

 max-width: 180px;

 box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);

 transition: transform 0.3s ease;

 }



 .feature:hover {

 transform: translateY(-5px);

 }



 .feature img {

 width: 100px;

 height: 130px;

 object-fit: cover;

 border-radius: 8px;

 margin-bottom: 0.8rem;

 }



 .feature h3 {

 color: #0077b6;

 font-size: 1rem;

 margin-bottom: 0.5rem;

 }



 .feature p {

 color: #555;

 font-size: 0.9rem;

 }



 /* Unified Wavy Footer Styles */

 .footer {

 position: relative;

 background: linear-gradient(135deg, #6e45e2 0%, #88d3ce 100%);

 color: white;

 padding: 120px 0 0;

 margin-top: 80px;

 }



 .footer::before {

 content: "";

 position: absolute;

 top: -80px;

 left: 0;

 width: 100%;

 height: 80px;

 background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none"><path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" fill="%236e45e2"></path></svg>');

 background-size: cover;

 background-repeat: no-repeat;

 background-position: center;

 }



 .footer-container {

 display: flex;

 flex-wrap: wrap;

 justify-content: space-between;

 gap: 2rem;

 max-width: 1100px;

 margin: 0 auto;

 padding: 0 1rem 2rem;

 position: relative;

 }



 .footer-col {

 flex: 1;

 min-width: 200px;

 padding: 20px;

 }



 .footer-col h4 {

 color: white;

 margin-bottom: 1.5rem;

 font-size: 1.2rem;

 position: relative;

 padding-bottom: 10px;

 }



 .footer-col h4::after {

 content: "";

 position: absolute;

 left: 0;

 bottom: 0;

 width: 50px;

 height: 2px;

 background: rgba(255, 255, 255, 0.5);

 }



 .footer-col ul {

 list-style: none;

 padding: 0;

 }



 .footer-col ul li {

 margin-bottom: 0.8rem;

 }



 .footer-col ul a {

 color: rgba(255, 255, 255, 0.8);

 text-decoration: none;

 transition: all 0.3s ease;

 display: inline-block;

 }



 .footer-col ul a:hover {

 color: white;

 transform: translateX(5px);

 }



 .subscribe-form input {

 width: 100%;

 padding: 10px;

 margin-bottom: 10px;

 border: none;

 border-radius: 4px;

 background: rgba(255, 255, 255, 0.9);

 }



 .subscribe-form button {

 width: 100%;

 padding: 10px;

 background: white;

 color: #6e45e2;

 border: none;

 border-radius: 4px;

 font-weight: bold;

 cursor: pointer;

 transition: all 0.3s ease;

 }



 .subscribe-form button:hover {

 background: #f0f0f0;

 transform: translateY(-2px);

 }



 .copyright {

 text-align: center;

 padding: 1.5rem;

 background: rgba(0, 0, 0, 0.1);

 margin-top: 2rem;

 font-size: 0.9rem;

 }



 @media (max-width: 768px) {

 .footer {

 padding: 100px 0 0;

 margin-top: 60px;

 }

 

 .footer::before {

 height: 60px;

 top: -60px;

 }

 

 .footer-col {

 min-width: 100%;

 text-align: center;

 }

 

 .footer-col h4::after {

 left: 50%;

 transform: translateX(-50%);

 }

 }

 </style>

</head>

<body class="Home">



 <!-- Navbar -->

 <header class="navbar">

 <div class="logo">Dawn Airlines</div>

 <nav>

 <ul>

 <li><a href="${pageContext.request.contextPath}/home" class="active">Home</a></li>

 <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>

 <li><a href="${pageContext.request.contextPath}/About">About Us</a></li>

 <li><a href="${pageContext.request.contextPath}/login">Login</a></li>

 </ul>

 </nav>

 </header>



 <!-- Hero -->

 <section class="hero">

 <div class="hero-content">

 <h1>Fly the Future with Dawn Airlines</h1>

 <p>Experience comfort, speed, and reliability on every journey.</p>

 <a href="${pageContext.request.contextPath}/login" class="btn">Book Now</a>

 </div>

 </section>



 <!-- Booking Form -->

 <section class="booking-section">

 <div class="booking-form">

 <h2>Book Your Flight</h2>

 <form action="${pageContext.request.contextPath}/login">

 <input type="text" placeholder="From" required />

 <input type="text" placeholder="To" required />

 <input type="date" required />

 <input type="date" />

 <button type="submit">Search Flights</button>

 </form>

 </div>

 </section>



 <!-- Features -->

 <section class="features">

 <h2>Why Choose Dawn Airlines</h2>

 <div class="features-container">

 <div class="feature">

 <img src="https://images.pexels.com/photos/46148/aircraft-jet-landing-cloud-46148.jpeg?auto=compress&cs=tinysrgb&w=100&h=130&fit=crop" alt="Direct Flights">

 <h3>Direct Flights</h3>

 <p>80+ cities connected with non-stop convenience.</p>

 </div>

 <div class="feature">

 <img src="https://images.pexels.com/photos/1433316/pexels-photo-1433316.jpeg?auto=compress&cs=tinysrgb&w=100&h=130&fit=crop" alt="Modern Jet">

 <h3>Modern Aircraft</h3>

 <p>New-generation planes for safe, smooth travel.</p>

	</div>

 <div class="feature">

 <img src="https://images.pexels.com/photos/4502133/pexels-photo-4502133.jpeg?auto=compress&cs=tinysrgb&w=100&h=130&fit=crop" alt="Expert Crew">

 <h3>Expert Crew</h3>

 <p>Friendly and highly trained in-flight team.</p>

 </div>

 <div class="feature">

 <img src="https://images.pexels.com/photos/3769138/pexels-photo-3769138.jpeg?auto=compress&cs=tinysrgb&w=100&h=130&fit=crop" alt="Loyalty Program">

 <h3>Flyer Rewards</h3>

 <p>Earn points and perks on every flight</p>

 </div>

 </div>

</section>

<!-- Footer -->

<footer class="footer">

 <div class="footer-container">

 <div class="footer-col">

 <h4>About Us</h4>

 <ul>

 <li><a href="${pageContext.request.contextPath}/About">Our Crew</a></li>

 <li><a href="${pageContext.request.contextPath}/login">Annual Report</a></li>

 </ul>

 </div>

 <div class="footer-col">

 <h4>Contact Us</h4>

 <ul>

 <li><a href="${pageContext.request.contextPath}/contact">Contact with us</a></li>

 <li><a href="${pageContext.request.contextPath}/login">Login</a></li>

 </ul>

 </div>

 <div class="footer-col">

 <h4>Subscribe</h4>

 <p>Get the latest offers and updates</p>

 <div class="subscribe-form">

 <input type="email" placeholder="Your email address">

 <button>Subscribe</button>

 </div>

 </div>

 </div>

 <div class="copyright">

 &copy; 2023 Dawn Airlines. All rights reserved.

 </div>

</footer>





</body>

</html>