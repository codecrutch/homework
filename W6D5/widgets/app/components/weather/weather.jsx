import React from 'react';

class Weather extends React.Component {
  constructor(props) {
    super(props);

    this.state = { city: "", temp: "" };
    this.success = this.success.bind(this);
    this.setState = this.setState.bind(this);
  }

  componentWillMount() {
    let getLocation = navigator.geolocation.getCurrentPosition(this.success, this.error);
  }

  fetchWeather({coords}) {
    var request = new XMLHttpRequest();

    request.open('GET', `http://api.openweathermap.org/data/2.5/weather?lat=${coords.latitude}&lon=${coords.longitude}&appid=bcb83c4b54aee8418983c2aff3073b3b`, true);

    request.onload = () => {
      if (request.status >= 200 && request.status < 400) {
        // Success!
        let parsedWeather = JSON.parse(request.responseText);
        let temp = Math.floor((9/5) * (parsedWeather.main.temp - 273) + 32);
        this.setState({city: parsedWeather.name, temp: temp });
        // debugger
      } else {
        // We reached our target server, but it returned an error
        this.error(request);
      }
    };

    request.onerror = () => {
      // There was a connection error of some sort
    };

    request.send();
  }

  success(response) {
    console.log(response);
    this.fetchWeather(response);
    // var crd = pos.coords;
  }

  error(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
  }

  render(){
    return (
      <div className='widget weather'>
        <h1>Weather</h1>
        <p><span>{this.state.city}</span><span>{this.state.temp}</span></p>
      </div>
    );
  }
}

export default Weather;
