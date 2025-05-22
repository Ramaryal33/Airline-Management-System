<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Add New Flight</title>
  <style>
    body { background: #f7f9fc; font-family: Arial, sans-serif; padding: 20px; }
    .form-box { max-width: 500px; margin: auto; background: #fff; padding: 20px; border-radius: 6px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
    .form-box h2 { margin-bottom: 15px; color: #2c3e50; text-align: center; }
    .form-box label { display: block; margin: 10px 0 5px; font-weight: bold; }
    .form-box input, .form-box select { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
    .form-box button { margin-top: 15px; width: 100%; padding: 10px; background: #1976d2; color: #fff; border: none; border-radius: 4px; cursor: pointer; }
    .form-box button:hover { background: #145ca8; }
  </style>
</head>
<body>
  <div class="form-box">
    <h2>Add New Flight</h2>
    <form action="${pageContext.request.contextPath}/addFlight" method="post">
      <label for="flightId">Flight ID</label>
      <input id="flightId" name="flightId" required/>

      <label for="fromCity">From City</label>
      <input id="fromCity" name="fromCity" required/>

      <label for="toCity">To City</label>
      <input id="toCity" name="toCity" required/>

      <label for="depDate">Departure Date</label>
      <input id="depDate" name="departureDate" type="date" required/>

      <label for="depTime">Departure Time</label>
      <input id="depTime" name="departureTime" type="time" required/>

      <label for="price">Price (NPR)</label>
      <input id="price" name="price" type="number" step="0.01" required/>

      <label for="travelClass">Class</label>
      <select id="travelClass" name="travelClass" required>
        <option value="">Select Class…</option>
        <option>Economy</option>
        <option>Business</option>
        <option>First</option>
      </select>

      <button type="submit">Save Flight</button>
    </form>
  </div>
</body>
</html>
