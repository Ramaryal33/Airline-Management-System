<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1.0" />
        <title>Your Profile Settings</title>
        <style>
            /* RESET & GLOBAL STYLES */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Open Sans', Arial, sans-serif;
            }

            body {
                display: flex;
                min-height: 100vh;
                background: #f7f9fc;
                color: #333;
                transition: all 0.3s ease;
            }

            .a {
                color: #ffffff;
            }

            /* SIDEBAR (exact from Cancel Booking) */
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
                margin-top: 300px;
            }

            .sidebar img {
                width: 100px;
                margin: 0px;
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

            /* MAIN CONTENT: center the card */
            .main {
                margin-left: 250px;
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
                transition: padding 0.3s ease;
            }

            /* PROFILE CARD */
            .profile-card {
                background: #fff;
                border-radius: 10px;
                padding: 25px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
                max-width: 500px;
                width: 100%;
            }

            .profile-card h2 {
                margin-bottom: 20px;
                color: #444;
                font-size: 1.3rem;
                font-weight: 600;
            }

            .profile-card input {
                width: 100%;
                padding: 10px;
                margin: 8px 0;
                border: 2px solid #ccc;
                border-radius: 8px;
                font-size: 1rem;
                outline: none;
            }

            .profile-card button {
                padding: 10px 20px;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                transition: background 0.3s, transform 0.3s;
                background: #1A73E8;
                color: #fff;
                margin-top: 10px;
            }

            .profile-card button:hover {
                background: #1667c1;
                transform: scale(1.03);
            }

            /* RESPONSIVE: stack on narrow */
            @media(max-width:900px) {
                .sidebar {
                    position: static;
                    width: 100%;
                    height: auto;
                    flex-direction: row;
                    flex-wrap: wrap;
                    justify-content: center;
                    padding: 10px;
                    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
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
                    font-size: .9rem;
                }

                .sidebar nav .bottom {
                    margin-top: 0;
                }

                .main {
                    margin-left: 0;
                    padding: 10px;
                }
            }
        </style>
    </head>

    <body>

        <!-- exact sidebar -->
        <div class="sidebar">
            <img src="${pageContext.request.contextPath}/plane.png" alt="Airline Logo" class="logo" />
            <nav>
                <a href="${pageContext.request.contextPath}/passengerDashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/searchFlight">Search Flights</a>
                <a href="${pageContext.request.contextPath}/payment">Payment</a>
                <a href="${pageContext.request.contextPath}/cancelBooking">Cancel Bookings</a>
                <a href="${pageContext.request.contextPath}/contact">Contact Us</a>
                <a href="#">Log out</a>
                <div class="bottom">
                    <a href="${pageContext.request.contextPath}/passengerProfile" class="active">Settings</a>
                </div>
            </nav>
        </div>

        <!-- main profile -->
        <div class="main">
            <div class="profile-card">
                <h2>Your Profile Settings</h2>
                <form method="POST">
                    <h4>Full Name:</h4>
                    <input type="text" name="fullName" value="${sessionScope.user.fullName}" required />
                    <h4>Email:</h4>
                    <input type="email" name="email" value="${sessionScope.user.email}" required />
                    <h4>Phone Number:</h4>
                    <input type="text" name="phone" value="${sessionScope.user.phone}" required />
                    <h4>New Password:</h4>
                    <input type="password" name="newPassword" placeholder="New Password" />
                    <button type="submit">Update Profile</button>
                </form>
            </div>
        </div>
    </body>

    </html>