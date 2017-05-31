//RANGE - Iterative
function range(start, end) {
  if (start > end) {
    return [];
  }

  const rangeNums = [];
  while (start <= end) {
    rangeNums.push(start);
    start++;
  }

  return rangeNums;
}

//RANGE - Recursive
function range(start, end) {
  if (start > end) {
    return [];
  }
  var rangeNums = range(start + 1, end);
  rangeNums.unshift(start);
  return rangeNums;
}

// console.log(range(1, 5));

// SUM - Recursive
Array.prototype.sum = function() {
  if (this.length === 0) {
    return 0;
  }

  var total = this.slice(1, this.length).sum();
  total += this[0];
  return total;
};

// console.log([10,20,30,7].sum());


function expRecOne(num, n) {
  if (n === 0){
    return 1;
  }

  var nextExp = expRecOne(num, n - 1);
  nextExp = nextExp * num;
  return nextExp;
}

// console.log(expRecOne(2,2));

function fibrec(n) {
  if (n === 1) {
    return [0];
  } else if (n === 2) {
    return [0,1];
  }

  var fibs = fibrec(n - 1);
  fibs.push(fibs[fibs.length - 1] + fibs[fibs.length - 2]);
  return fibs;
}

// console.log(fibrec(20));

function bsearch(array, target) {
  // console.log(array);
  if (array.length === 1 && array[0] === target) {
    return 0;
  } else if (array.length === 1 && array[0] !== target) {
    return null;
  }

  var mid = Math.floor(array.length / 2);

  if (array[mid] === target) {
    return mid;
  }

  if (array[mid] > target) {
    return bsearch(array.slice(0, mid),target);
  } else if (array[mid] < target) {
    return mid + 1 + bsearch(array.slice(mid + 1), target);
  }
}

// console.log(bsearch([1,2,3,4,5,6,7,8,9,10], 3));

// Failed to Make Change
function makeChange(amt, coins) {
  if (coins.length === 0) {
    return [];
  }
  let options = [];

  if (coins[0] === amt) {
    return options.push(coins[0]);
  }

  if (coins[0] > amt) {
    makeChange(amt, coins.slice(1));
  } else {
    options.push(coins[0]);
    let bigRemainder = amt - coins[0];

    makeChange(bigRemainder, coins);
  }
}


// Almost Completed MERGE_SORT
function spo(ob1, ob2) {
  if (ob1 > ob2) {
    return 1;
  } else if (ob1 < ob2) {
    return -1;
  } else {
    return 0;
  }
}

function mergeSort(array) {
  if (array.length === 1) {
    return array;
  }

  let mid = Math.floor(array.length / 2);

  let left = mergeSort(array.slice(0, mid));
  let right = mergeSort(array.slice(mid));

  merge(left, right);
}

function merge(left, right) {
  const sorted = [];
  while (left.length > 0 || right.length > 0) {

    switch(spo(left[0], right[0])) {
      case -1:
        sorted.push(left.shift);
        break;
      case 1:
        sorted.push(right.shift);
        break;
      case 0:
        sorted.push(left.shift);
        break;
    }
  }

}
