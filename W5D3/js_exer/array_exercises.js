// uniq

Array.prototype.uniq = function() {
  let newArr = [];
  for (var i = 0; i < this.length; i++) {
    if (newArr.includes(this[i])) {
      continue;
    } else {
      newArr.push(this[i]);
    }
  }
  return newArr;
};
// console.log([1,2,2,3,4,4].uniq());


// twoSum
Array.prototype.twoSum = function() {
  const matchingIdx = [];
  for (let i = 0; i < this.length; i++) {
    for (let j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        matchingIdx.push([i, j]);
      }
    }
  }
  return matchingIdx;
};

// console.log([-1, 0, 2, -2, 1].twoSum());

// transpose
Array.prototype.transpose = function() {
  const newArr = [];
  for (let i = 0; i < 3; i++) {
    newArr.push([]);
  }

  for (let i = 0; i < this.length; i++) {
    for (let j = 0; j < this.length; j++) {
      newArr[j][i] = this[i][j];
    }
  }

  return newArr;
};

let rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ];
// console.log(rows.transpose());
