import React from 'react';

class Clock extends React.Component {
  constructor(props) {
    super(props);

    this.state = { time: new Date()};
    this.tick = this.tick.bind(this);
  }

  tick() {
    this.setState({time: new Date()});
  }

  componentDidMount() {
    let tickId = setInterval(this.tick, 1000);
    this.tickInterval = tickId;
  }

  componentWillUnmount() {

  }



  render() {
    let time = this.state.time;
    let formatTime = (time.getHours() + ":" + time.getMinutes() + ":" + time.getSeconds());
    let formatDate = (time.getMonth() + "/" + time.getDay() + "/" + time.getFullYear());

    return (
      <div className="widget clock">
        <h1>Clock</h1>
        <div>
        <p>
          <span>Time:</span>
          <span>{formatTime}</span>
        </p>
        <p>
          <span>Date:</span>
          <span>{formatDate}</span>
        </p>

        </div>
      </div>
    );
  }
}

export default Clock;
