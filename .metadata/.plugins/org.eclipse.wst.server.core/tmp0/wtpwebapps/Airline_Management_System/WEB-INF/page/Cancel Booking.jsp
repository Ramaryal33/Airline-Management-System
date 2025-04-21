<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Cancel Booking</title>
  <link rel="stylesheet" href="cancel.css" />
</head>
<body>
  <div class="container">
    <h1>Cancel Booking - Flight from KTM to China</h1>
    <div class="details-grid">
      <div>
        <p><strong>Passenger:</strong> John Doe</p>
        <p><strong>Refund Amount:</strong> $120</p>
      </div>
      <div>
        <p><strong>Booking Ref:</strong> ABC1234</p>
        <p><strong>Cancellation Fee:</strong> $30</p>
      </div>
    </div>

    <label for="reason">Select reason for cancellation</label>
    <select id="reason">
      <option>Schedule issues</option>
      <option>Fare Change</option>
      <option>Changed plan</option>
      <option>Other</option>
    </select>

    <div class="confirm-box">
      <input type="checkbox" id="confirm" />
      <label for="confirm">Are you sure you want to cancel this flight?</label>
    </div>

    <div class="button-group">
      <button class="cancel">Cancel Booking</button>
      <button>Go Back</button>
    </div>
  </div>
</body>
</html>
