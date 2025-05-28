<!DOCTYPE html>


  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
    // ==== JDBC SETUP & DATA FETCH ====
    String url       = "jdbc:mysql://localhost:3306/airline management";
    String dbUser    = "root";
    String dbPass    = "";              // <-- set if you have one
    int totalFlights = 0;
    int totalBookings= 0;
    double totalRevenue = 0.0;
    int totalUsers   = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, dbUser, dbPass);
        Statement  stmt = conn.createStatement();

        // 1) Flights count
        ResultSet rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM flights");
        if(rs.next()) totalFlights = rs.getInt("cnt");
        rs.close();

        // 2) Bookings count & revenue
        rs = stmt.executeQuery("SELECT COUNT(*) AS cnt, IFNULL(SUM(amount),0) AS rev FROM bookings");
        if(rs.next()) {
            totalBookings = rs.getInt("cnt");
            totalRevenue  = rs.getDouble("rev");
        }
        rs.close();

        // 3) Registered users
        rs = stmt.executeQuery("SELECT COUNT(*) AS cnt FROM users WHERE userType='user'");
        if(rs.next()) totalUsers = rs.getInt("cnt");
        rs.close();

        stmt.close();
        conn.close();

    } catch(Exception e) {
        e.printStackTrace();
    }
%>


<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <title>Admin Dashboard | Dawn Airlines</title>

  <!-- Font Awesome -->
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">



  <style>
    

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', sans-serif;
    }

    body {
      display: flex;
      background-color: #f4f6f8;
      color: #333;
      min-height: 100vh;
    }

    /* Sidebar */
    .sidebar {
      width: 220px;
      background: linear-gradient(180deg, #0a1c2c, #123456);
      color: white;
      height: 100vh;
      position: fixed;
      top: 0;
      left: 0;
      padding: 20px;
    }

    .sidebar h2 {
      color: #f6c90e;
      margin-bottom: 30px;
      font-size: 1.3rem;
      text-align: center;
    }

    .sidebar ul {
      list-style: none;
      padding: 0;
    }

    .sidebar ul li {
      margin-bottom: 15px;
    }

    .sidebar ul li a {
      color: white;
      text-decoration: none;
      font-weight: 500;
      display: flex;
      align-items: center;
      padding: 10px;
      border-radius: 4px;
      transition: background 0.3s ease;
    }

    .sidebar ul li a i {
      margin-right: 10px;
      font-size: 1.1rem;
      color: #f6c90e;
    }

    .sidebar ul li a:hover,
    .sidebar ul li.active a {
      background-color: rgba(255, 255, 255, 0.1);
    }

    /* Main content */
    .main-content {
      flex-grow: 1;
      margin-left: 220px;
      padding: 20px;
      background-color: #f5f7fa;
      min-height: 100vh;
    }

    /* ===== ADMIN DASHBOARD SPECIFIC STYLES ===== */

    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 15px 20px;
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      margin-bottom: 20px;
    }

    .user-info {
      display: flex;
      align-items: center;
    }

    .user-info img {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      margin-right: 10px;
    }

    .stats-container {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 20px;
      margin-bottom: 30px;
    }

    .stat-card {
      background-color: white;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      display: flex;
      align-items: center;
    }

    .stat-icon {
      width: 60px;
      height: 60px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 15px;
      font-size: 1.5rem;
    }

    .stat-icon.flights { background-color: #e3f2fd; color: #1976d2; }
    .stat-icon.bookings { background-color: #e8f5e9; color: #388e3c; }
    .stat-icon.revenue  { background-color: #fff8e1; color: #ffa000; }
    .stat-icon.users    { background-color: #f3e5f5; color: #8e24aa; }

    .stat-info h3 {
      font-size: 1.8rem;
      margin-bottom: 5px;
    }

    .stat-info p {
      color: #666;
    }

    .dashboard-section {
      background-color: white;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      margin-bottom: 20px;
    }

    .section-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      padding-bottom: 10px;
      border-bottom: 1px solid #eee;
    }

    .section-header h3 {
      color: #0a1c2c;
    }

    .section-header a {
      color: #f6c90e;
      text-decoration: none;
      font-weight: 500;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    table th, table td {
      padding: 12px 15px;
      text-align: left;
      border-bottom: 1px solid #eee;
    }

    table th {
      background-color: #f9f9f9;
      color: #555;
      font-weight: 600;
    }

    table tr:hover {
      background-color: #f5f7fa;
    }

    .status {
      padding: 5px 10px;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: 500;
    }

    .status.confirmed { background-color: #e8f5e9; color: #388e3c; }
    .status.pending   { background-color: #fff8e1; color: #ffa000; }
    .status.cancelled { background-color: #ffebee; color: #d32f2f; }

    .btn {
      padding: 8px 15px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-weight: 500;
      transition: background 0.3s ease;
    }

    .btn-view {
      background-color: #e3f2fd;
      color: #1976d2;
    }

    .btn-view:hover {
      background-color: #bbdefb;
    }

    .charts-container {
      display: grid;
      grid-template-columns: 2fr 1fr;
      gap: 20px;
    }

    .chart-container {
      background-color: white;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }

    .chart-wrapper {
      height: 300px;
      margin-top: 20px;
      position: relative;
    }

    @media (max-width: 992px) {
      .charts-container {
        grid-template-columns: 1fr;
      }
    }

    @media (max-width: 768px) {
      .sidebar {
        width: 70px;
        overflow: hidden;
      }
      .sidebar h2, .nav-menu li span {
        display: none;
      }
      .sidebar ul li {
        text-align: center;
        padding: 15px 0;
      }
      .sidebar ul li i {
        margin-right: 0;
        font-size: 1.2rem;
      }
      .main-content {
        margin-left: 70px;
      }
    }
  </style>
  
</head>
<body>
<!-- ===== SIDEBAR ===== -->
<!-- Sidebar -->
<div class="sidebar">
    <h2>Dawn Airlines</h2>
   <ul class="nav-menu">
    <li class="active">
        <a>
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span>
       </a>
    </li>
    <li>
    <a href="${pageContext.request.contextPath}/flightManagement?action=list">
            <i class="fas fa-plane"></i>
            <span>Flights</span>
        </a>
    </li>
    <li>
        <a href="${pageContext.request.contextPath}/manageBookings">
            <i class="fas fa-ticket-alt"></i>
            <span>Bookings</span>
        </a>
    </li>
    <li>
        <a href="${pageContext.request.contextPath}/managePassengers">
            <i class="fas fa-users"></i>
            <span>Passengers</span>
        </a>
    </li>
    <li>
        <a href="${pageContext.request.contextPath}/manageStaff">
            <i class="fas fa-user-tie"></i>
            <span>Staff</span>
        </a>
    </li>
    <li>
        <a href="${pageContext.request.contextPath}/logout">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </li>
</ul>

</div>


  <!-- ===== MAIN CONTENT ===== -->
  <div class="main-content">

    <!-- Header -->
    <div class="header">
      <h2>Admin Dashboard</h2>
      <div class="user-info">
       
        <div>
          <h4>${sessionScope.admin.name}</h4>
          <p>Administrator</p>
        </div>
      </div>
    </div>

    <!-- Stats Cards -->
    <div class="stats-container">
      <div class="stat-card">
        <div class="stat-icon flights">
          <i class="fas fa-plane"></i>
        </div>
        <div class="stat-info">
          <h3><%= totalFlights %></h3>
          <p>Total Flights</p>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-icon bookings">
          <i class="fas fa-ticket-alt"></i>
        </div>
        <div class="stat-info">
          <h3><%= totalBookings %></h3>
          <p>Total Bookings</p>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-icon revenue">
          <i class="fas fa-dollar-sign"></i>
        </div>
        <div class="stat-info">
          <h3>$<%= String.format("%.2f", totalRevenue) %></h3>
          <p>Total Revenue</p>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-icon users">
          <i class="fas fa-users"></i>
        </div>
        <div class="stat-info">
          <h3><%= totalUsers %></h3>
          <p>Registered Users</p>
        </div>
      </div>
    </div>
<%
    List<Map<String, String>> recentFlights = new ArrayList<>();
    try {
        Connection conn = DriverManager.getConnection(url, dbUser, dbPass);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT flight_id, from_city, to_city, departure_time FROM flights ORDER BY created_at DESC LIMIT 5");
        while (rs.next()) {
            Map<String, String> flight = new HashMap<>();
            flight.put("id", rs.getString("flight_id"));
            flight.put("from", rs.getString("from_city"));
            flight.put("to", rs.getString("to_city"));
            flight.put("time", rs.getString("departure_time"));
            recentFlights.add(flight);
        }
        rs.close(); stmt.close(); conn.close();
    } catch(Exception e) { e.printStackTrace(); }
%>

<div class="dashboard-section">
  <div class="section-header">
    <h3>Recent Flights</h3>
  </div>
  <table>
    <thead>
      <tr>
        <th>Flight ID</th>
        <th>From</th>
        <th>To</th>
        <th>Departure</th>
      </tr>
    </thead>
    <tbody>
      <%
        for(Map<String, String> flight : recentFlights) {
      %>
        <tr>
          <td><%= flight.get("id") %></td>
          <td><%= flight.get("from") %></td>
          <td><%= flight.get("to") %></td>
          <td><%= flight.get("time") %></td>
        </tr>
      <%
        }
      %>
    </tbody>
  </table>
</div>

<%
    List<Map<String, String>> popularRoutes = new ArrayList<>();
    try {
        Connection conn = DriverManager.getConnection(url, dbUser, dbPass);
        Statement stmt = conn.createStatement();

        ResultSet rs = stmt.executeQuery(
            "SELECT f.from_city, f.to_city, COUNT(*) AS total " +
            "FROM bookings b " +
            "JOIN flights f ON b.flight_id = f.flight_id " +
            "GROUP BY f.from_city, f.to_city " +
            "ORDER BY total DESC " +
            "LIMIT 5"
        );

        while (rs.next()) {
            Map<String, String> route = new HashMap<>();
            route.put("from", rs.getString("from_city"));
            route.put("to", rs.getString("to_city"));
            route.put("count", rs.getString("total"));
            popularRoutes.add(route);
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!-- Display the top 5 most booked routes -->
<div class="dashboard-section">
  <div class="section-header">
    <h3>Top 5 Most Booked Routes</h3>
  </div>
  <table>
    <thead>
      <tr>
        <th>#</th>
        <th>From</th>
        <th>To</th>
        <th>Bookings</th>
      </tr>
    </thead>
    <tbody>
      <%
        int index = 1;
        for (Map<String, String> route : popularRoutes) {
      %>
      <tr>
        <td><%= index++ %></td>
        <td><%= route.get("from") %></td>
        <td><%= route.get("to") %></td>
        <td><%= route.get("count") %></td>
      </tr>
      <%
        }
      %>
    </tbody>
  </table>
</div>

 
</div>

</body>
</html>
