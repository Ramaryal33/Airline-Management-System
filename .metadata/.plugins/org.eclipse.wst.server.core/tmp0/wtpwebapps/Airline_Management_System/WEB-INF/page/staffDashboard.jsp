<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Staff Dashboard</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
        }
        
        .dashboard-container {
            display: grid;
            grid-template-columns: 250px 1fr;
            min-height: 100vh;
        }
        
        .sidebar {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
        }
        
        .sidebar-header {
            text-align: center;
            padding-bottom: 20px;
            border-bottom: 1px solid #34495e;
        }
        
        .sidebar-menu {
            margin-top: 20px;
        }
        
        .sidebar-menu a {
            display: block;
            color: #ecf0f1;
            padding: 10px;
            text-decoration: none;
            margin-bottom: 5px;
            border-radius: 4px;
        }
        
        .sidebar-menu a:hover {
            background-color: #34495e;
        }
        
        .main-content {
            padding: 20px;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #ddd;
        }
        
        .header h1 {
            margin: 0;
            color: #2c3e50;
        }
        
        .welcome-message {
            font-size: 16px;
            font-weight: bold;
            color: #2c3e50;
        }
        
        .stats-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .stat-card h3 {
            margin-top: 0;
            color: #7f8c8d;
            font-size: 16px;
        }
        
        .stat-card .value {
            font-size: 28px;
            font-weight: bold;
            color: #2c3e50;
            margin: 10px 0;
        }
        
        .graph-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .graph-card {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .graph-card h2 {
            margin-top: 0;
            color: #2c3e50;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        
        .chart-container {
            height: 300px;
            position: relative;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        
        table, th, td {
            border: 1px solid #ddd;
        }
        
        th, td {
            padding: 12px;
            text-align: left;
        }
        
        th {
            background-color: #2c3e50;
            color: white;
            font-weight: normal;
        }
        
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        tr:hover {
            background-color: #f1f1f1;
        }
        
        .section {
            margin-bottom: 30px;
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .section h2 {
            color: #2c3e50;
            border-bottom: 2px solid #2c3e50;
            padding-bottom: 10px;
            margin-top: 0;
        }
        
        .view-all {
            text-align: right;
            margin-top: 10px;
        }
        
        .view-all a {
            color: #3498db;
            text-decoration: none;
        }
        
        .view-all a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>Airline Staff</h2>
            </div>
            <div class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/staffDashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/staffPeformanceReview">Performance Review</a>
                <a href="${pageContext.request.contextPath}/staffAttendance">Attendance</a>
                <a href="${pageContext.request.contextPath}/staffTask">Tasks</a>
                <a href="${pageContext.request.contextPath}/staffprofile">Profile</a>
                <a href="${pageContext.request.contextPath}/flight">Flights</a>
            </div>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="header">
                <h1>Staff Dashboard</h1>
                <div class="welcome-message">Welcome, ${userName}!</div>
            </div>
            
            <!-- Statistics Cards -->
            <div class="stats-container">
                <div class="stat-card">
                    <h3>Total Flights</h3>
                    <div class="value">${totalFlights}</div>
                    <small>This Month: ${totalFlights}</small>
                </div>
                <div class="stat-card">
                    <h3>Total Staff</h3>
                    <div class="value">${totalStaff}</div>
                    <small>Active: ${totalStaff}</small>
                </div>
                <div class="stat-card">
                    <h3>Total Tasks</h3>
                    <div class="value">${totalTasks}</div>
                    <small>Pending: ${taskStatusData.Pending}</small>
                </div>
                <div class="stat-card">
                    <h3>Attendance Today</h3>
                    <div class="value">${todayAttendance}</div>
                    <small>Present: ${todayAttendance}</small>
                </div>
            </div>
            
            <!-- Graphs -->
            <div class="graph-container">
                <div class="graph-card">
                    <h2>Task Status Distribution</h2>
                    <div class="chart-container">
                        <canvas id="taskChart"></canvas>
                    </div>
                </div>
                <div class="graph-card">
                    <h2>Performance Distribution</h2>
                    <div class="chart-container">
                        <canvas id="performanceChart"></canvas>
                    </div>
                </div>
            </div>
            
            <!-- Recent Tasks -->
            <div class="section">
                <h2>Recent Tasks</h2>
                <table>
                    <tr>
                        <th>Task ID</th>
                        <th>Title</th>
                        <th>Assigned To</th>
                        <th>Due Date</th>
                        <th>Status</th>
                    </tr>
                    <c:forEach items="${tasks}" var="task" end="4">
                        <tr onclick="window.location='${pageContext.request.contextPath}/staffTask?action=view&id=${task.taskId}'" style="cursor:pointer;">
                            <td>${task.taskId}</td>
                            <td>${task.title}</td>
                            <td>${task.assignedTo}</td>
                            <td>${task.dueDate}</td>
                            <td>${task.status}</td>
                        </tr>
                    </c:forEach>
                </table>
                <div class="view-all">
                    <a href="${pageContext.request.contextPath}/staffTask">View All Tasks →</a>
                </div>
            </div>
            
            <!-- Upcoming Flights -->
            <div class="section">
                <h2>Upcoming Flights</h2>
                <table>
                    <tr>
                        <th>Flight ID</th>
                        <th>Flight Number</th>
                        <th>Departure</th>
                        <th>Arrival</th>
                        <th>Destination</th>
                    </tr>
                    <c:forEach items="${flights}" var="flight" end="4">
                        <tr>
                            <td>${flight.flightId}</td>
                            <td>${flight.flightNumber}</td>
                            <td>${flight.departureTime}</td>
                            <td>${flight.arrivalTime}</td>
                            <td>${flight.destination}</td>
                        </tr>
                    </c:forEach>
                </table>
                <div class="view-all">
                    <a href="${pageContext.request.contextPath}/flight">View All Flights →</a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Task Chart - Bar Graph
        const taskCtx = document.getElementById('taskChart').getContext('2d');
        const taskData = ${taskStatusData};
        const taskChart = new Chart(taskCtx, {
            type: 'bar',
            data: {
                labels: Object.keys(taskData),
                datasets: [{
                    label: 'Number of Tasks',
                    data: Object.values(taskData),
                    backgroundColor: [
                        'rgba(46, 204, 113, 0.7)',
                        'rgba(52, 152, 219, 0.7)',
                        'rgba(241, 196, 15, 0.7)',
                        'rgba(231, 76, 60, 0.7)'
                    ],
                    borderColor: [
                        'rgba(46, 204, 113, 1)',
                        'rgba(52, 152, 219, 1)',
                        'rgba(241, 196, 15, 1)',
                        'rgba(231, 76, 60, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        });
        
        // Performance Chart - Pie Chart
        const performanceCtx = document.getElementById('performanceChart').getContext('2d');
        const performanceData = ${performanceData};
        const performanceChart = new Chart(performanceCtx, {
            type: 'pie',
            data: {
                labels: Object.keys(performanceData),
                datasets: [{
                    data: Object.values(performanceData),
                    backgroundColor: [
                        'rgba(46, 204, 113, 0.7)',
                        'rgba(52, 152, 219, 0.7)',
                        'rgba(241, 196, 15, 0.7)',
                        'rgba(231, 76, 60, 0.7)'
                    ],
                    borderColor: [
                        'rgba(46, 204, 113, 1)',
                        'rgba(52, 152, 219, 1)',
                        'rgba(241, 196, 15, 1)',
                        'rgba(231, 76, 60, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'right',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                const label = context.label || '';
                                const value = context.raw || 0;
                                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                const percentage = Math.round((value / total) * 100);
                                return `${label}: ${value} (${percentage}%)`;
                            }
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>