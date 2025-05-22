<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Add New Flight</title>
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
            transition: all .3s;
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
            transition: padding .3s;
        }

        .page-title {
            font-size: 1.5rem;
            color: #444;
            margin-bottom: 20px;
        }

        .add-flight-container {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            max-width: 600px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, .08);
            margin: 20px auto;
        }

        .add-flight-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-weight: 600;
            color: #555;
            margin-bottom: 5px;
        }

        .form-group input,
        .form-group select {
            padding: 10px;
            border: 2px solid #ccc;
            border-radius: 8px;
            font-size: 1rem;
            outline: none;
            width: 100%;
        }

        .form-group-inline {
            display: flex;
            gap: 20px;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-start;
            margin-top: 20px;
        }

        .save-flight-btn,
        .cancel-flight-btn {
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: background .3s, transform .3s;
        }

        .save-flight-btn {
            background: #28a745;
            color: #fff;
        }

        .save-flight-btn:hover {
            background: #218838;
            transform: scale(1.03);
        }

        .cancel-flight-btn {
            background: #333;
            color: #fff;
        }

        .cancel-flight-btn:hover {
            background: #555;
            transform: scale(1.03);
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
        <div class="add-flight-container">
            <h1 class="page-title">Add New Flight</h1>
            <form class="add-flight-form" action="#" method="POST">
                <div class="form-group">
                    <label for="flight-number">Flight Number:</label>
                    <input type="text" id="flight-number" name="flight-number" placeholder="e.g. F123" />
                </div>
                <div class="form-group">
                    <label for="airline">Airline:</label>
                    <input type="text" id="airline" name="airline" placeholder="e.g. Nepal Airlines" />
                </div>
                <div class="form-group">
                    <label for="origin">Origin:</label>
                    <input type="text" id="origin" name="origin" placeholder="e.g. KTM" />
                </div>
                <div class="form-group">
                    <label for="destination">Destination:</label>
                    <input type="text" id="destination" name="destination" placeholder="e.g. DEL" />
                </div>

                <div class="form-group-inline">
                    <div class="form-group">
                        <label for="departure-date">Departure Date:</label>
                        <input type="date" id="departure-date" name="departure-date" />
                    </div>
                    <div class="form-group">
                        <label for="departure-time">Time:</label>
                        <input type="time" id="departure-time" name="departure-time" />
                    </div>
                </div>

                <div class="form-group-inline">
                    <div class="form-group">
                        <label for="arrival-date">Arrival Date:</label>
                        <input type="date" id="arrival-date" name="arrival-date" />
                    </div>
                    <div class="form-group">
                        <label for="arrival-time">Time:</label>
                        <input type="time" id="arrival-time" name="arrival-time" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="number" id="price" name="price" placeholder="e.g. 200" step="0.01" />
                </div>
                <div class="form-group">
                    <label for="aircraft-type">Aircraft Type:</label>
                    <input type="text" id="aircraft-type" name="aircraft-type" placeholder="e.g. Boeing 737" />
                </div>
                <div class="form-group">
                    <label for="total-seats">Total Seats:</label>
                    <input type="number" id="total-seats" name="total-seats" placeholder="e.g. 180" />
                </div>
                <div class="form-group">
                    <label for="status">Status:</label>
                    <select id="status" name="status">
                        <option value="Scheduled">Scheduled</option>
                        <option value="Delayed">Delayed</option>
                        <option value="Cancelled">Cancelled</option>
                    </select>
                </div>

                <div class="form-actions">
                    <button type="submit" class="save-flight-btn">Save Flight</button>
                    <button type="button" class="cancel-flight-btn">Cancel</button>
                </div>
            </form>
        </div>
    </div>
</body>

</html>