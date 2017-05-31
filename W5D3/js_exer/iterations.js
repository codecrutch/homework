// BUBBLESORT
Array.prototype.bubbleSort = function() {
  let swapped = true;

  while (swapped) {
    swapped = false;

    for (let i = 0; i < this.length && i + 1 < this.length; i++) {
      if (this[i] > this[i + 1]) {
        let origFirst = this[i];
        let origSecond = this[i + 1];
        this[i] = origSecond;
        this[i + 1] = origFirst;
        swapped = true;
      }
    }
  }

  return this;
};

// console.log([5,1,3,17,4,9,2].bubbleSort());

// SUBSTRINGS
String.prototype.substrings = function() {
  const newArr = [];

  for (let i = 0; i < this.length; i++) {
    for (var j = i + 1; j <= this.length && j > i; j++) {
      newArr.push(this.slice(i,j));
    }
  }
  return newArr;
  // j cant be less than i
};

// console.log("cat".substrings());
