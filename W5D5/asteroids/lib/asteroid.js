const MovingObject = require("./moving_object.js");
const Util = require("./utils.js");

function Asteroid(pos){
  this.color = "#0f0";
  this.radius = 4;
  this.pos = pos;
  this.vel = Util.randomVec(Math.floor(Math.random() * 11));
  MovingObject.call(pos, this.vel, this.radius, this.color);
}
  Util.inherits(Asteroid, MovingObject);



module.exports = Asteroid;
