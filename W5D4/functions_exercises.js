class Clock {
  constructor() {
    // 1. Create a Date object.
    // 2. Store the hours, minutes, and seconds.
    // 3. Call printTime.
    // 4. Schedule the tick at 1 second intervals.
    let origDate = new Date();  //just a variable, lose after creation
    this.hours = origDate.getHours(); // these are instance variables
    this.minutes = origDate.getMinutes();
    this.seconds = origDate.getSeconds();

    this.printTime(); // Need to call with this to call on the instance
    setInterval(this._tick.bind(this), 1000); // Bind the instance to the call
  }

  printTime() {
    // Format the time in HH:MM:SS
    // Use console.log to print it.
    if (this.seconds > 59) {
      this.seconds = 0;
      this.minutes++;
    }
    if (this.minutes > 59) {
      this.minutes = 0;
      this.hours++;
    }
    if (this.hours > 24) {
      this.hours = 0;
    }

    // could format this better to deal with padding zeros in mins/secs
    console.log(`${this.hours}:${this.minutes}:${this.seconds}`);
  }

  _tick() {
    // 1. Increment the time by one second.
    // 2. Call printTime.
    this.seconds++;
    this.printTime();
  }
}

// const clock = new Clock();

// Add Numbers
// const readline = require('readline');
// const reader = readline.createInterface( {
//   input: process.stdin,
//   output: process.stdout
// });

// function addNumbers(sum, numsLeft, compCB) {
//   if (numsLeft === 0) {
//     reader.close();
//     return compCB(sum);
//   }
//   if (numsLeft > 0) {
//     reader.question("Enter a number to add: ", (answer) => {
//       console.log(`Partial Sum: ${sum += parseInt(answer)}`);
//       addNumbers(sum, numsLeft - 1, compCB);
//     });
//   }
// }

// addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));

// Write this first.
function askIfGreaterThan(el1, el2, callback) {
  // Prompt user to tell us whether el1 > el2; pass true back to the
  // callback if true; else false.
  reader.question(`Is ${el1} greater than ${el2}? `, callback);
}

// reader.prototype.question = function (cb) {
//   answer = thingFromUser;
//   cb(answer);
// };

// Once you're done testing askIfGreaterThan with dummy arguments, write this.
function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  // Do an "async loop":
  // 1. If (i == arr.length - 1), call outerBubbleSortLoop, letting it
  const handleInput = (answer) => {
    if (answer === 'y') {
      temp = arr[i + 1];
      arr[i + 1] = arr[i];
      arr[i] = temp;
      madeAnySwaps = true;
    }
    innerBubbleSortLoop(arr, ++i, madeAnySwaps, outerBubbleSortLoop);
  };
  //    know whether any swap was made.
  // 2. Else, use `askIfGreaterThan` to compare `arr[i]` and `arr[i +
  //    1]`. Swap if necessary. Call `innerBubbleSortLoop` again to
  //    continue the inner loop. You'll want to increment i for the
  //    next call, and possibly switch madeAnySwaps if you did swap.
  if (i == arr.length - 1) {
    // reader.close(); didnt work
    return outerBubbleSortLoop(madeAnySwaps);
  } else {
    askIfGreaterThan(arr[i], arr[i + 1], handleInput);
  }
}


// Once you're done testing innerBubbleSortLoop, write outerBubbleSortLoop.
// Once you're done testing outerBubbleSortLoop, write absurdBubbleSort.

function absurdBubbleSort(arr, sortCompletionCallback) {
  function outerBubbleSortLoop(madeAnySwaps) {
    // Begin an inner loop if you made any swaps. Otherwise, call
    // `sortCompletionCallback`.
    if (madeAnySwaps === true) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
      reader.close();
    }
  }

  // Kick the first outer loop off, starting `madeAnySwaps` as true.
  outerBubbleSortLoop(true);
}

// absurdBubbleSort([3, 2, 1], function (arr) {
//   console.log("Sorted array: " + JSON.stringify(arr));
// });

// innerBubbleSortLoop([3,1,2,5], 0, false, () => console.log("we're in the outer bubble"));

Function.prototype.myBind = function(context) {
  // caller scope
  return () => this.apply(context);
};

class Lamp {
  constructor() {
    this.name = "a lamp";
  }
}

const turnOn = function() {
  //global scope
   console.log("Turning on " + this.name);
};

const lamp = new Lamp();

// turnOn(); // should not work the way we want it to

// const boundTurnOn = turnOn.bind(lamp);
const myBoundTurnOn = turnOn.myBind(lamp);

// boundTurnOn(); // should say "Turning on a lamp"
myBoundTurnOn(); // should say "Turning on a lamp"
