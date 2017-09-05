console.log("Hello from the JavaScript console!");

// Your AJAX request here
$.ajax({
  type: 'GET',
  url: 'http://api.openweathermap.org/data/2.5/weather?q=NY,NY&appid=bcb83c4b54aee8418983c2aff3073b3b',
  success: function (message) {
    console.log("Here is the weather:");
    console.log(message);
  },
  error: function (message) {
    console.error("The request failed.");
    console.log(message);
  }
});

// Add another console log here, outside your AJAX request
console.log("Here is another console log for testing purposes.");


// Make sure you can answer the following questions:
// -------------------------------------------------
// 1. When does the request get sent?
  // After the entire page has loaded, aka after everything has run including
  // the bottom console.log("Here is another...")
// 2. When does the response come back?
  // ??? It comes back after the request is made, which is after the page loads
// 3. What's the current weather in New York?
  // All the information is contained in an object
// 4. Did the page refresh?
  // No, it did not
// 5. How could we use different HTTP methods in our request?
  // By simplying changing the 'GET' method type to one of the others and using
  // the correct path/url
