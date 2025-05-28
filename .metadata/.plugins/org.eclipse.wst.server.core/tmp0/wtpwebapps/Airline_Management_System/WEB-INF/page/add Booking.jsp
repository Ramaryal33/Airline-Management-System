<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Add Booking</title>
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
            transition: all .3s ease;
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

        .page-title {
            font-size: 1.5rem;
            color: #444;
            margin-bottom: 20px;
        }

        .add-booking-container {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            max-width: 600px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, .08);
            margin: 20px auto;
        }

        .add-booking-form {
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

        .form-group-radio div {
            display: flex;
            gap: 15px;
            margin-top: 8px;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: flex-start;
            margin-top: 20px;
        }

        .save-booking-btn,
        .cancel-booking-btn {
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: background .3s, transform .3s;
        }

        .save-booking-btn {
            background: #28a745;
            color: #fff;
        }

        .save-booking-btn:hover {
            background: #218838;
            transform: scale(1.03);
        }

        .cancel-booking-btn {
            background: #333;
            color: #fff;
        }

        .cancel-booking-btn:hover {
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
        <div class="add-booking-container">
            <h1 class="page-title">Add Booking</h1>
            <form class="add-booking-form" action="#" method="POST">
                <div class="form-group">
                    <label for="booking-id"><b>Booking ID:</b></label>
                    <input type="text" id="booking-id" name="booking-id" placeholder="e.g. BK1010" />
                </div>
                <div class="form-group">
                    <label for="passenger-name"><b>Passenger Name:</b></label>
                    <input type="text" id="passenger-name" name="passenger-name" placeholder="e.g. John Doe" />
                </div>
                <div class="form-group">
                    <label for="flight-number"><b>Flight Number:</b></label>
                    <select id="flight-number" name="flight-number">
                        <option value="">Select Flight No</option>
                        <option value="F123">F123</option>
                        <option value="Q456">Q456</option>
                        <option value="A789">A789</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="route"><b>Route:</b></label>
                    <input type="text" id="route" name="route" placeholder="e.g. KTM — DEL" />
                </div>

                <div class="form-group-inline">
                    <div class="form-group">
                        <label for="departure-date"><b>Departure Date:</b></label>
                        <input type="date" id="departure-date" name="departure-date" />
                    </div>
                    <div class="form-group">
                        <label for="departure-time"><b>Time:</b></label>
                        <input type="time" id="departure-time" name="departure-time" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="seat-no"><b>Seat No:</b></label>
                    <input type="text" id="seat-no" name="seat-no" placeholder="e.g. 10A" />
                </div>

                <div class="form-group-radio">
                    <label><b>Status:</b></label>
                    <div>
                        <label><input type="radio" name="status" value="Confirmed" /> Confirmed</label>
                        <label><input type="radio" name="status" value="Pending" /> Pending</label>
                        <label><input type="radio" name="status" value="Cancelled" /> Cancelled</label>
                    </div>
                </div>

                <div class="form-group-radio">
                    <label><b>Payment Status:</b></label>
                    <div>
                        <label><input type="radio" name="payment-status" value="Paid" /> Paid</label>
                        <label><input type="radio" name="payment-status" value="Unpaid" /> Unpaid</label>
                        <label><input type="radio" name="payment-status" value="Refunded" /> Refunded</label>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="save-booking-btn">Save Booking</button>
                    <button type="button" class="cancel-booking-btn">Cancel</button>
                </div>
            </form>
        </div>
    </div>
</body>

</html>