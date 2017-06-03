// const Util = require("./lib/utils.js");
// const MovingObject = require("./lib/moving_object.js");
// const Game = require("./lib/game.js");
const GameView = require("./lib/game_view.js");

document.addEventListener("DOMContentLoaded", function(){
  console.log("We are running, Sassy Gecko");
  var ctx = document.getElementById('game-canvas').getContext('2d');
  var view = new GameView(ctx);
  view.start();
});
