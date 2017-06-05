class View {
  constructor(game, $el) {
    this.game = game;
    this.$grid = $el;
    this.setupBoard();
    this.bindEvents();
  }

  bindEvents() {
    let that = this;
    this.$grid.on('click', 'li', function(e){
      that.makeMove($(e.target));
    });
  }

  makeMove($square) {
    let pos = $square.attr('coords');
    let posarray = pos.split(',').map(el => parseInt(el));
    console.log(posarray, typeof posarray);
    this.game.playMove(posarray);

    if (this.game.currentPlayer === 'x') {
      $square.addClass('o');
    } else {
      $square.addClass('x');
    }


    if (this.game.isOver()) {
      if (this.game.winner()) {
        alert(`Game over man! ${this.game.winner()} wins!`);
      } else {
        alert('You guys tied! Good Game.');
      }

    }
  }

  setupBoard() {
    let $ul = $('<ul>');
    for (var x = 0; x < 3; x++) {
      for (var y = 0; y < 3; y++) {
        $ul.append($(`<li coords='${x},${y}'>`));
      }
    }
    this.$grid.append($ul);
  }
}

module.exports = View;
