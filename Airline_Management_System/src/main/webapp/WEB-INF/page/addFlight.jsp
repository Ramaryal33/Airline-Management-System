<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Flight</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; padding: 20px; }
        .form-container { background: #fff; padding: 20px; max-width: 600px; margin: auto; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input, select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; }
        .form-actions { margin-top: 20px; display: flex; gap: 10px; }
        .btn { padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; }
        .btn-save { background: #28a745; color: white; }
        .btn-cancel { background: #6c757d; color: white; }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Add New Flight</h2>
    <form action="flightManagement" method="post">
        <input type="hidden" name="action" value="update" />

        <div class="form-group">
            <label for="flight-number">Flight Number</label>
            <input type="text" id="flight-number" name="flight-number" required />
        </div>

        <div class="form-group">
            <label for="origin">From City</label>
            <input type="text" id="origin" name="origin" required />
        </div>

        <div class="form-group">
            <label for="destination">To City</label>
            <input type="text" id="destination" name="destination" required />
        </div>

        <div class="form-group">
            <label for="departure-date">Departure Date</label>
            <input type="date" id="departure-date" name="departure-date" required />
        </div>

        <div class="form-group">
            <label for="departure-time">Departure Time</label>
            <input type="time" id="departure-time" name="departure-time" required />
        </div>

        <div class="form-group">
            <label for="arrival-date">Arrival Date</label>
            <input type="date" id="arrival-date" name="arrival-date" />
        </div>

        <div class="form-group">
            <label for="arrival-time">Arrival Time</label>
            <input type="time" id="arrival-time" name="arrival-time" />
        </div>

        <div class="form-group">
            <label for="price">Price</label>
            <input type="number" id="price" name="price" step="0.01" required />
        </div>

        <div class="form-group">
            <label for="travel-class">Travel Class</label>
            <select id="travel-class" name="travel-class">
                <option value="Economy">Economy</option>
                <option value="Business">Business</option>
                <option value="First">First</option>
            </select>
        </div>

        <div class="form-group">
            <label for="total-seats">Total Seats</label>
            <input type="number" id="total-seats" name="total-seats" required />
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-save">Add Flight</button>
            <a href="flightManagement?action=list" class="btn btn-cancel">Cancel</a>
        </div>
    </form>
</div>

</body>
</html>
