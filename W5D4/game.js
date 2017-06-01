const readline = require('readline');
const reader = readline.createInterface( {
  input: process.stdin,
  output: process.stdout
});

class Game {
  run() {
    // make an array of 3 towers
    // put 3 discs in the first tower
    // get a move from the player
    // move the disc if it is a valid move
    // if it's not a valid move ask them to make another move
    // game is over when all three discs are stacked on tower 2 or 3
  }

  constructor() {
    this.stacks = [[1, 2, 3], [], []];
  }

  validMoves(array) {
    let startStack = this.stacks[array[0]];
    let endStack = this.stacks[array[1]];

    return startStack[0] < endStack[0] || endStack.length === 0;
  }

  move(start, end) {
    let towers = this.stacks;

    towers[end].unshift(towers[start].shift());
  }

  print() {
  }

  promptMove() {
    printStacks();
    const getDiscMoves = (moves) => {
      let movesArr = moves.split('');
      movesArr = movesArr.map(el => parseInt(el));
      if (validMoves(movesArr)) {
        move(movesArr[0], movesArr[1]);
      } else {
        promptMove();
      }
    };
    read.question("Where do you want to move the disc?", getDiscMoves);
  }
}
