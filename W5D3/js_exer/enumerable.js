// MYEACH
Array.prototype.myEach = function(cBack) {
  for (let i = 0; i < this.length; i++) {
    cBack(this[i]);
  }
};

// [1,2,3,4].myEach(el => console.log(el));

// MYMAP
Array.prototype.myMap = function(cBack) {
  const newArr = [];
  this.myEach(function(el) {
    newArr.push(cBack(el));
  });
  console.log(newArr);
};

// [1,2,3,4].myMap(el => el * 10);

// MYINJECT
Array.prototype.myInject = function() {
  let total = this[0];
  this.slice(1, this.length).myEach(function(el) {
    total += el;
  });
  return total;
};

console.log([1,2,3,4].myInject());
