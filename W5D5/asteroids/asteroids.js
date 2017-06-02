// import Util from "utils.js";
// import MovingObject from "moving_object.js";
// import Game from "game.js";
// import GameView from "game_view.js";
const Util = require("./lib/utils.js");
const MovingObject = require("./lib/moving_object.js");
const Game = require("./lib/game.js");
const GameView = require("./lib/game_view.js");

document.addEventListener("DOMContentLoaded", function(){
  debugger
  var ctx = document.getElementById('game-canvas').getContext('2d');
  var view = new GameView(ctx);
  view.start();
});
