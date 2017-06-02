function MovingObject(pos, vel, rad, color){
  this.pos  = pos;
  this.vel = vel;
  this.radius = rad;
  this.color = color;
}

MovingObject.prototype.draw = function (ctx) {
  debugger
  ctx.radius = Math.PI * 2 * this.radius;
  ctx.moveTo(this.pos[0], this.pos[1]);
  ctx.fillStyle = this.color;
};

MovingObject.prototype.move  = function (){
  this.pos[0] += this.vel[0];
  this.pos[1] += this.vel[1];
};

module.exports = MovingObject;
