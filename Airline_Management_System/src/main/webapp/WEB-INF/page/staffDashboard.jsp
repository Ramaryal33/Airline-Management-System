<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Staff Dashboard | Dawn Airlines</title>
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f5f7fa;
      display: flex;
      min-height: 100vh;
    }

    .sidebar {
      background-color: #0047AB;
      color: white;
      width: 220px;
      padding: 20px;
      height: 100vh;
      position: fixed;
    }

    .sidebar h2 {
      margin-bottom: 30px;
      font-size: 1.5rem;
    }

    .sidebar ul {
      list-style: none;
      padding: 0;
    }

    .sidebar li {
      margin: 15px 0;
    }

    .sidebar a {
      color: white;
      text-decoration: none;
      display: block;
      padding: 8px 12px;
      border-radius: 4px;
    }

    .sidebar a:hover {
      background-color: rgba(255, 255, 255, 0.15);
    }

    .main-content {
      margin-left: 220px;
      padding: 30px;
      width: calc(100% - 220px);
    }

    .cards {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      margin-bottom: 30px;
    }

    .card {
      background: white;
      border-radius: 8px;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
      padding: 20px;
      flex: 1;
      min-width: 180px;
    }

    .card h3 {
      margin-bottom: 12px;
      font-size: 1rem;
      color: #333;
    }

    .card p {
      margin: 0;
      font-size: 1.7rem;
      font-weight: bold;
      color: #0047AB;
    }

    .dashboard-section {
      background: white;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
      margin-bottom: 30px;
    }

    .dashboard-section h3 {
      margin-bottom: 20px;
      font-size: 1.3rem;
      color: #0a1c2c;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 15px;
    }

    th, td {
      padding: 10px 12px;
      border-bottom: 1px solid #ddd;
      text-align: left;
    }

    th {
      background: #f0f4f8;
      color: #333;
    }

    tbody tr:hover {
      background-color: #f5faff;
    }

    .status-badge {
      padding: 4px 10px;
      border-radius: 12px;
      color: white;
      font-weight: bold;
      font-size: 0.85rem;
      display: inline-block;
    }

    .present { background-color: #4CAF50; }
    .late { background-color: #FFC107; }
    .absent { background-color: #F44336; }

    .summary-cards {
      display: flex;
      gap: 20px;
      margin-bottom: 20px;
      flex-wrap: wrap;
    }
  </style>
</head>
<body>

<%
  String url = "jdbc:mysql://localhost:3306/airline management";
  String user = "root";
  String pass = "";

  int totalEmployees = 0, activeTasks = 0, pendingTasks = 0, completedTasks = 0, overdueTasks = 0;
  double totalHours = 0;

  List<Map<String, Object>> recentAttendance = new ArrayList<>();
  Map<String, Integer> performanceDistribution = new LinkedHashMap<>();

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, user, pass);
    Statement stmt = conn.createStatement();

    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM staff");
    if (rs.next()) totalEmployees = rs.getInt(1);
    rs.close();

    rs = stmt.executeQuery("SELECT SUM(working_hours) FROM attendance");
    if (rs.next()) totalHours = rs.getDouble(1);
    rs.close();

    rs = stmt.executeQuery("SELECT COUNT(*) FROM task WHERE status = 'Active'");
    if (rs.next()) activeTasks = rs.getInt(1);
    rs.close();

    rs = stmt.executeQuery("SELECT COUNT(*) FROM task WHERE status = 'Pending'");
    if (rs.next()) pendingTasks = rs.getInt(1);
    rs.close();

    rs = stmt.executeQuery("SELECT COUNT(*) FROM task WHERE status = 'Completed'");
    if (rs.next()) completedTasks = rs.getInt(1);
    rs.close();

    rs = stmt.executeQuery("SELECT COUNT(*) FROM task WHERE dueDate < CURDATE() AND status != 'Completed'");
    if (rs.next()) overdueTasks = rs.getInt(1);
    rs.close();

    rs = stmt.executeQuery("SELECT date, clock_in, clock_out, status, working_hours FROM attendance ORDER BY date DESC LIMIT 5");
    while (rs.next()) {
      Map<String, Object> record = new HashMap<>();
      record.put("date", rs.getDate("date"));
      record.put("clockIn", rs.getTime("clock_in"));
      record.put("clockOut", rs.getTime("clock_out"));
      record.put("status", rs.getString("status"));
      record.put("hours", rs.getDouble("working_hours"));
      recentAttendance.add(record);
    }
    rs.close();

    rs = stmt.executeQuery("SELECT rating, COUNT(*) FROM performance_review GROUP BY rating");
    while (rs.next()) {
      performanceDistribution.put(rs.getString("rating"), rs.getInt(2));
    }

    stmt.close();
    conn.close();
  } catch (Exception e) {
    e.printStackTrace();
  }
%>

<div class="sidebar">
  <h2>Dawn Airline</h2>
<ul>
  <li><a>Dashboard</a></li>
  <li><a href="${pageContext.request.contextPath}/manageStaff">Staff</a></li>
  <li><a href="${pageContext.request.contextPath}/staffTask">Tasks</a></li>
  <li><a href="${pageContext.request.contextPath}/staffDepartment">Department</a></li>
  <li><a href="${pageContext.request.contextPath}/staffAttendance">Attendance</a></li>
  <li><a href="${pageContext.request.contextPath}/staffPerformanceReview">Performance</a></li>
  <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
</ul>

</div>

<div class="main-content">
  <!-- KPI Cards -->
  <div class="cards">
    <div class="card"><h3>Total Employees</h3><p><%= totalEmployees %></p></div>
    <div class="card"><h3>Total Hours</h3><p><%= String.format("%.2f", totalHours) %></p></div>
    <div class="card"><h3>Active Tasks</h3><p><%= activeTasks %></p></div>
    <div class="card"><h3>Pending Tasks</h3><p><%= pendingTasks %></p></div>
  </div>

  <!-- Recent Attendance -->
  <div class="dashboard-section">
    <h3>Recent Attendance</h3>

    <%
      double totalHrs = 0;
      Map<String, Integer> statusMap = new HashMap<>();
      for (Map<String, Object> a : recentAttendance) {
        totalHrs += (double) a.get("hours");
        String status = (String) a.get("status");
        statusMap.put(status, statusMap.getOrDefault(status, 0) + 1);
      }
      double avgHours = recentAttendance.size() > 0 ? totalHrs / recentAttendance.size() : 0;
      String frequentStatus = statusMap.entrySet().stream()
                                .max(Map.Entry.comparingByValue())
                                .map(Map.Entry::getKey)
                                .orElse("N/A");
    %>

    <div class="summary-cards">
      <div class="card"><h3>Average Hours</h3><p><%= String.format("%.2f", avgHours) %></p></div>
      <div class="card"><h3>Most Frequent Status</h3><p><%= frequentStatus %></p></div>
      <div class="card"><h3>Records Count</h3><p><%= recentAttendance.size() %></p></div>
    </div>

    <table>
      <thead><tr><th>Date</th><th>Clock In</th><th>Clock Out</th><th>Status</th><th>Hours</th></tr></thead>
      <tbody>
        <% for (Map<String, Object> row : recentAttendance) {
             String status = ((String) row.get("status")).toLowerCase();
        %>
        <tr>
          <td><%= row.get("date") %></td>
          <td><%= row.get("clockIn") %></td>
          <td><%= row.get("clockOut") %></td>
          <td><span class="status-badge <%= status %>"><%= row.get("status") %></span></td>
          <td><%= row.get("hours") %></td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>

  <!-- Performance Distribution -->
  <div class="dashboard-section">
    <h3>Performance Distribution</h3>

    <%
      String top = null, low = null;
      int max = Integer.MIN_VALUE, min = Integer.MAX_VALUE, total = 0;

      for (Map.Entry<String, Integer> e : performanceDistribution.entrySet()) {
        int val = e.getValue();
        total += val;
        if (val > max) { max = val; top = e.getKey(); }
        if (val < min) { min = val; low = e.getKey(); }
      }
    %>

    <div class="summary-cards">
      <div class="card"><h3>Top Rating</h3><p><%= top != null ? top : "N/A" %></p></div>
      <div class="card"><h3>Lowest Rating</h3><p><%= low != null ? low : "N/A" %></p></div>
      <div class="card"><h3>Total Reviews</h3><p><%= total %></p></div>
    </div>

    <table>
      <thead><tr><th>Rating</th><th>Count</th></tr></thead>
      <tbody>
        <% for (Map.Entry<String, Integer> entry : performanceDistribution.entrySet()) { %>
        <tr>
          <td><%= entry.getKey() %></td>
          <td><%= entry.getValue() %></td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>
</div>
</body>
</html>
