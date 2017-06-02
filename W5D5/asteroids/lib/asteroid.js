const MovingObject = require("./moving_object.js");
const Util = require("./utils.js");

function Asteroid(pos){
  this.COLOR = "#0f0";
  this.RADIUS = 4;
  MovingObject.call(pos, Util.randomeVec(Math.floor(Math.random() * 11)), this.RADIUS, this.COLOR);

  // Return a randomly oriented vector with the given length.

}


Util.inherits(Asteroid, MovingObject);
