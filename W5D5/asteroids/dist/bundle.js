/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 4);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const Asteroid = __webpack_require__(5);

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


/***/ }),
/* 1 */
/***/ (function(module, exports) {

function MovingObject(pos, vel, rad, color){
  this.pos = pos;
  this.vel = vel;
  this.radius = rad;
  this.color = color;
}

MovingObject.prototype.draw = function (ctx) {
  ctx.fillStyle = this.color;

  ctx.beginPath();
  ctx.arc(
    this.pos[0], this.pos[1], this.radius, 0, 2 * Math.PI, true
  );
  ctx.fill();
};

MovingObject.prototype.move = function (){
  this.pos[0] += this.vel[0];
  this.pos[1] += this.vel[1];
};

module.exports = MovingObject;


/***/ }),
/* 2 */
/***/ (function(module, exports) {

const Util = {
  inherits (childClass, parentClass){
    function Surrogate(){}
    Surrogate.prototype = Object.create(parentClass.prototype);
    Surrogate.prototype.constructor = childClass;
    childClass.prototype = Surrogate.prototype;
  },
  randomVec (length) {
    const deg = 2 * Math.PI * Math.random();
    return Util.scale([Math.sin(deg), Math.cos(deg)], length);
  },
  // Scale the length of a vector by the given amount.
  scale (vec, m) {
    return [vec[0] * m, vec[1] * m];
  }
};

module.exports = Util;


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const Game = __webpack_require__(0);

function GameView(ctx){
  this.ctx = ctx;
  this.game = new Game();
  this.game.addAsteroids();
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


/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

// const Util = require("./lib/utils.js");
// const MovingObject = require("./lib/moving_object.js");
// const Game = require("./lib/game.js");
const GameView = __webpack_require__(3);

document.addEventListener("DOMContentLoaded", function(){
  console.log("We are running, Sassy Gecko");
  var ctx = document.getElementById('game-canvas').getContext('2d');
  var view = new GameView(ctx);
  view.start();
});


/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

const MovingObject = __webpack_require__(1);
const Util = __webpack_require__(2);

function Asteroid(pos){
  this.color = "#0f0";
  this.radius = 4;
  this.pos = pos;
  this.vel = Util.randomVec(Math.floor(Math.random() * 11));
  MovingObject.call(pos, this.vel, this.radius, this.color);
}
  Util.inherits(Asteroid, MovingObject);



module.exports = Asteroid;


/***/ })
/******/ ]);