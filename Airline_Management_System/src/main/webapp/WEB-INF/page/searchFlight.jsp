<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Search Flights - Dawn Airlines</title>
  <link rel="stylesheet" href="style.css" />
</head>
<body>

  <!-- NAVIGATION BAR -->
  <header class="navbar">
    <div class="logo">Dawn Airlines</div>
    <nav>
      <ul>
        <li><a href="home.html">Home</a></li>
        <li><a href="search-flights.html" class="active">Search Flights</a></li>
        <li><a href="flight-details.html">Flight Details</a></li>
        <li><a href="contact.html">Contact</a></li>
      </ul>
    </nav>
  </header>

  <!-- BANNER IMAGE WITH TITLE -->
  <section class="banner">
    <div class="banner-overlay">
      <h1>Search Flights</h1>
    </div>
  </section>

  <!-- SEARCH FORM LAYOUT -->
  <section class="search-form-section">
    <form class="search-form">

      <!-- Trip Type Row -->
      <div class="form-group trip-type">
        <label><input type="radio" name="trip" checked> Round Trip</label>
        <label><input type="radio" name="trip"> One Way</label>
        <label><input type="radio" name="trip"> Multi City</label>
      </div>

      <!-- From and To -->
      <div class="form-group">
        <input type="text" placeholder="From" required>
        <input type="text" placeholder="To" required>
      </div>

      <!-- Departure and Return -->
      <div class="form-group">
        <input type="date" required>
        <input type="date">
      </div>

      <!-- Class and Passengers -->
      <div class="form-group">
        <select required>
          <option selected disabled>Class</option>
          <option>Economy</option>
          <option>Business</option>
          <option>First</option>
        </select>

        <select required>
          <option selected disabled>Passengers</option>
          <option>1</option>
          <option>2</option>
          <option>3+</option>
        </select>
      </div>

      <!-- Button -->
      <div class="form-group center">
        <button type="submit">Search Flights</button>
      </div>

    </form>
  </section>

</body>
</html>
