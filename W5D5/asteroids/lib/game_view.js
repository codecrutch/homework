const Game = require('./game.js');

function GameView(ctx){
  this.ctx = ctx;
  this.game = new Game();
  // this.ship =
}

GameView.prototype.start = function(){
  let that = this;
  const moveAndDraw = function(){
    that.game.moveObjects();
    that.game.draw(that.ctx);
  };
  setInterval(moveAndDraw, 20);
};

module.exports = GameView;
