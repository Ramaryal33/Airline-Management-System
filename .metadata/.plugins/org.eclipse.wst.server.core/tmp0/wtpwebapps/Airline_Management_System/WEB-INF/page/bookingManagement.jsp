<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Booking Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Open Sans', Arial, sans-serif;
        }

        body {
            color: #333;
            background: #f7f9fc;
            transition: all 0.3s ease;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100vh;
            padding: 20px;
            color: #ecf0f1;
            background: linear-gradient(135deg, #2c3e50 0%, #3d566e 100%);
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: width .3s, padding .3s;
        }

        .sidebar nav .bottom {
            margin-top: 240px;
        }

        .sidebar nav .bottom img {
            display: block;
            margin: 0 auto 20px auto;
            border: 2px solid #ccc;
            width: 70px;
            border-radius: 10%;
            box-shadow: 0 4px 6px rgba(0, 0, 0, .1);
        }

        .sidebar img {
            width: 100px;
            margin-bottom: 10px;
            border-radius: 50%;
        }

        .sidebar .logo {
            width: 100px;
            margin-bottom: 55px;
        }

        .sidebar nav a {
            display: block;
            color: #ecf0f1;
            text-decoration: none;
            padding: 10px 15px;
            margin: 8px 0;
            border-radius: 5px;
            transition: background .3s, transform .3s;
            text-align: center;
            font-weight: 600;
        }

        .sidebar nav a:hover {
            background: rgba(255, 255, 255, .1);
            transform: translateX(5px);
        }

        .main {
            margin-left: 250px;
            padding: 20px;
            transition: padding .3s ease;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .page-title {
            font-size: 1.5rem;
            color: #444;
        }

        .add-btn {
            padding: 10px 15px;
            border: none;
            border-radius: 8px;
            background: #28a745;
            color: #fff;
            font-weight: 600;
            cursor: pointer;
            transition: background .3s, transform .3s;
        }

        .add-btn:hover {
            background: #218838;
            transform: scale(1.03);
        }

        .search-bar {
            display: flex;
            margin-bottom: 20px;
            gap: .5rem;
        }

        .search-bar input {
            flex: 1;
            padding: 10px;
            border: 2px solid #ccc;
            border-radius: 8px;
            outline: none;
        }

        .search-bar button {
            padding: 10px 18px;
            border: none;
            border-radius: 8px;
            background: #1A73E8;
            color: #fff;
            font-weight: 600;
            cursor: pointer;
            transition: background .3s, transform .3s;
        }

        .search-bar button:hover {
            background: #1667c1;
            transform: scale(1.03);
        }

        .table-container {
            background: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, .08);
            overflow-x: auto;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 600px;
            font-size: .95rem;
        }

        .data-table thead {
            background: #f2f2f2;
        }

        .data-table th,
        .data-table td {
            text-align: left;
            padding: 12px;
            border-bottom: 1px solid #ccc;
        }

        .data-table tbody tr:hover {
            background: #f9f9f9;
        }

        .edit-btn,
        .delete-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 8px;
            margin-right: 5px;
            cursor: pointer;
            transition: background .3s, transform .3s;
            font-weight: 600;
            font-size: .9rem;
        }

        .edit-btn {
            background: #1A73E8;
            color: #fff;
        }

        .edit-btn:hover {
            background: #1667c1;
            transform: scale(1.02);
        }

        .delete-btn {
            background: #dc3545;
            color: #fff;
        }

        .delete-btn:hover {
            background: #c82333;
            transform: scale(1.02);
        }
    </style>
</head>

<body>
    <div class="sidebar">
        <img src="plane.png" alt="Airline Logo" class="logo" />
        <nav>
            <a href="#">Dashboard</a>
            <a href="#">Search Flights</a>
            <a href="#">Flight Details</a>
            <a href="#">Payment Page</a>
            <a href="#">My Bookings</a>
            <a href="#">Online Check-in</a>
            <div class="bottom">
                <img src="m.jpg" alt="Profile Picture" />
                <a href="#">Settings</a>
            </div>
        </nav>
    </div>

    <div class="main">
        <div class="page-header">
            <h1 class="page-title">Booking Management</h1>
            <button class="add-btn">Add Booking</button>
        </div>

        <div class="search-bar">
            <input type="text" placeholder="Booking ID or Passenger Name" />
            <button>Search</button>
        </div>

        <div class="table-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>BOOKING ID</th>
                        <th>Passenger</th>
                        <th>Flight No</th>
                        <th>Route</th>
                        <th>Status</th>
                        <th>Payment</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>BK1006</td>
                        <td>Suman Bohara</td>
                        <td>F123</td>
                        <td>KTM — DEL</td>
                        <td>Confirmed</td>
                        <td>Paid</td>
                        <td><button class="edit-btn">Edit</button><button class="delete-btn">Delete</button></td>
                    </tr>
                    <tr>
                        <td>BK1005</td>
                        <td>Aayush Kumar Gupta</td>
                        <td>Q456</td>
                        <td>KTM — DOH</td>
                        <td>Pending</td>
                        <td>Unpaid</td>
                        <td><button class="edit-btn">Edit</button><button class="delete-btn">Delete</button></td>
                    </tr>
                    <tr>
                        <td>BK1003</td>
                        <td>Babita Magar</td>
                        <td>A789</td>
                        <td>DEL — KTM</td>
                        <td>Cancelled</td>
                        <td>Refunded</td>
                        <td><button class="edit-btn">Edit</button><button class="delete-btn">Delete</button></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>

</html>