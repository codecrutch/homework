const Asteroid = require('./asteroid.js');

function Game(){
  this.DIM_X = 1000;
  this.DIM_Y = 1000;
  this.NUM_ASTEROIDS = 50;
  this.asteroids = [];
}

Game.prototype.addAsteroids = function(){
  for(let i = 0; i < this.NUM_ASTEROIDS; i++){
    const asteroid = new Asteroid(this.randomPosition());
    this.asteroids.push(asteroid);
  }
};

Game.prototype.randomPosition = function(){
  let width = Math.random() * this.DIM_X;
  let height = Math.random() * this.DIM_Y;
  return [width, height];
};

Game.prototype.draw = function(ctx){
  ctx.clearRect(0, 0, 1000, 1000);
  for(let i = 0; i < this.asteroids.length; i++){
    this.asteroids[i].draw(ctx);
  }
};

Game.prototype.moveObjects = function(){
  for(let i = 0; i < this.asteroids.length; i++){
    this.asteroids[i].move();
  }
};
module.exports = Game;
