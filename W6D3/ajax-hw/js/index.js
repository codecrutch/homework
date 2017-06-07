console.log("Hello from the JavaScript console!");

// Your AJAX request here
$.ajax({
  type: 'POST',
  url: "http://api.openweathermap.org/data/2.5/weather?q=NY,NY&appid=bcb83c4b54aee8418983c2aff3073b3b",
  success(data) {
    console.log("We have your weather!");
    console.log(data.weather[0].description);
    console.log(data);
  },

  error() {
    console.error("An error occured.");
  },
});
// Add another console log here, outside your AJAX request
console.log("AJAX Request Sent");
