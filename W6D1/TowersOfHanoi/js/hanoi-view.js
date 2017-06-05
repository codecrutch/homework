class View {
  constructor(game, $board){
    this.game = game;
    this.$board = $board;
    this.startMove = null;
    this.endMove = null;
    this.setupTowers();
    // this.render();
    this.clickTower();
  }

  setupTowers() {
    for (var i = 0; i < 3; i++) {
      this.$board.append($(`<ul tower='${i}'>`));
      this.$board.append($(`<li disc='${i}'>`));
    }
    let $startingTower = $('ul').eq(0);
    let $lis = $('li');
    $startingTower.append($lis);
  }

  render(startPos, endPos) {
    // startPos and endPos should be integers
    if (this.game.isValidMove(startPos, endPos)) {
      this.game.move(startPos, endPos);
      // make the view move
      let $endTower = this.$board.children().eq(endPos);
      let $topPiece = this.$board.children().eq(startPos).children().eq(0);
      console.log($endTower);
      console.log($topPiece);
      $endTower.append($topPiece);
    } else {
      alert("You can't make that move.");
    }
    console.log(this.game.towers);
    this.startMove = null;
    this.endMove = null;
  }

  clickTower() {
    let that = this;
    this.$board.on('click', 'ul', function(e){
      // check to see what move we are on
      if (that.startMove === null) {
        that.startMove = parseInt($(e.currentTarget).attr('tower'));
      } else {
        that.endMove = parseInt($(e.target).attr('tower'));
        that.render(that.startMove, that.endMove);
      }
    });
  }
}


module.exports = View;
