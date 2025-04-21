<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Passenger Dashboard</title>
    <!-- Link to CSS file -->
    <link rel="stylesheet" href="style.css" />
</head>

<body>
    <!-- Sidebar Section -->
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
                <nav>
                    <a href="#">Settings</a>
                </nav>
            </div>
        </nav>
    </div>

    <!-- Main Content Section -->
    <div class="main">
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
                    <strong>Passengers</strong>
                    <br>
                    <small>Date</small>
                </div>
                <div class="activity-item">
                    <strong>Flight</strong>
                    <br>
                    <small>Date</small>
                </div>
                <div class="activity-item">
                    <strong>Waiting List</strong>
                    <br>
                    <small>Date</small>
                </div>
                <div class="activity-item">
                    <strong>Revenue</strong>
                    <br>
                    <small>Date</small>
                </div>
            </div>
        </div>

        <!-- Planning Journey Section -->
        <div class="planning-journey">
            <!-- Left: Booking Form -->
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

            <!-- Right: Calendar (or Additional Info) -->
            <div class="calendar">
                <h3>Select Date</h3>
                <input type="date" />
            </div>
        </div>
    </div>


</body>

</html>