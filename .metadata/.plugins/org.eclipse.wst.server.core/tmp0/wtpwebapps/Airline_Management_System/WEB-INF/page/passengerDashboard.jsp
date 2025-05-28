<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Passenger Dashboard</title>
    <style>
        /* RESET & GLOBAL STYLES */
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

        /* SIDEBAR */
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
            transition: width 0.3s ease, padding 0.3s ease;
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
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
            transition: background 0.3s, transform 0.3s;
            text-align: center;
            font-weight: 600;
        }

        .sidebar nav a:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateX(5px);
        }

        /* MAIN CONTENT */
        .main {
            margin-left: 250px;
            padding: 20px;
            transition: padding 0.3s ease;
        }

        .page-header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .page-title {
            font-size: 1.5rem;
            color: #444;
        }

        /* SEARCH BAR */
        .search-bar {
            display: flex;
            margin-bottom: 20px;
            gap: 0.5rem;
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
            transition: background 0.3s, transform 0.3s;
        }

        .search-bar button:hover {
            background: #1667c1;
            transform: scale(1.03);
        }

        /* ACTIVITY SECTION */
        .activity h3 {
            margin-bottom: 10px;
            font-weight: 600;
            color: #555;
        }

        .activity-grid {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }

        .activity-item {
            flex: 1;
            min-width: 140px;
            background: #fff;
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s;
        }

        .activity-item:hover {
            transform: translateY(-3px);
        }

        /* PLANNING JOURNEY SECTION */
        .planning-journey {
            display: flex;
            gap: 20px;
            margin-top: 20px;
            flex-wrap: wrap;
        }

        .planning-form,
        .calendar {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
            flex: 1;
            min-width: 250px;
            transition: all 0.3s ease;
        }

        .planning-form h3 {
            margin-bottom: 10px;
            color: #444;
        }

        .planning-form p {
            margin-bottom: 15px;
            color: #777;
            font-size: 0.95rem;
        }

        .planning-form img {
            width: 100%;
            max-width: 500px;
            display: block;
            margin-bottom: 15px;
        }

        .planning-form label {
            display: block;
            margin-top: 10px;
            font-weight: 600;
            color: #555;
        }

        .planning-form input {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 2px solid #ccc;
            border-radius: 8px;
            outline: none;
        }

        .calendar h3 {
            margin-bottom: 10px;
            color: #444;
        }

        .calendar input {
            width: 100%;
            padding: 8px;
            border: 2px solid #ccc;
            border-radius: 8px;
            outline: none;
        }

        /* RESPONSIVE DESIGN */
        @media (max-width: 900px) {
            .sidebar {
                position: static;
                width: 100%;
                height: auto;
                flex-direction: row;
                flex-wrap: wrap;
                justify-content: center;
                padding: 10px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            .sidebar nav {
                flex-direction: row;
                flex-wrap: wrap;
                justify-content: center;
                width: 100%;
            }

            .sidebar nav a {
                margin: 5px;
                padding: 8px 10px;
                font-size: 0.9rem;
            }

            .sidebar nav .bottom {
                margin-top: 0;
            }

            .main {
                margin-left: 0;
                padding: 10px;
            }
        }

        @media (min-width: 1200px) {
            .sidebar {
                padding: 25px;
            }

            .search-bar input,
            .search-bar button {
                padding: 12px;
                font-size: 1.1rem;
            }

            .activity-item {
                padding: 20px;
                min-width: 160px;
            }

            .planning-form,
            .calendar {
                padding: 25px;
            }
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
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">Passenger Dashboard</h1>
        </div>

        <!-- Search Bar -->
        <div class="search-bar">
            <input type="text" placeholder="Search by Flight No." />
            <button>Search</button>
        </div>

        <!-- Activity Section -->
        <div class="activity">
            <h3>Activity</h3>
            <div class="activity-grid">
                <div class="activity-item">
                    <strong>Passengers</strong><br><small>Date</small>
                </div>
                <div class="activity-item">
                    <strong>Flight</strong><br><small>Date</small>
                </div>
                <div class="activity-item">
                    <strong>Waiting List</strong><br><small>Date</small>
                </div>
                <div class="activity-item">
                    <strong>Revenue</strong><br><small>Date</small>
                </div>
            </div>
        </div>

        <!-- Planning Journey Section -->
        <div class="planning-journey">
            <div class="planning-form">
                <h3>Where To?</h3>
                <p>Book a Flight</p>
                <img src="plane.png" alt="Plane Illustration" />

                <label for="from">From:</label>
                <input id="from" type="text" placeholder="From" />

                <label for="to">To:</label>
                <input id="to" type="text" placeholder="To" />

                <label for="date">Date:</label>
                <input id="date" type="date" />

                <label for="passengers">Passengers:</label>
                <input id="passengers" type="number" min="1" value="1" />
            </div>

            <div class="calendar">
                <h3>Select Date</h3>
                <input type="date" />
            </div>
        </div>
    </div>
</body>

</html>
