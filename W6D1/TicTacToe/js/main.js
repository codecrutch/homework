const View = require('./ttt-view.js');
const Game = require('./sol/game.js');

$( () => {
  const game = new Game();
  const view = new View(game, $('.ttt'));

});
