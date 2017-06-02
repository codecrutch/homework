// WITH ARGUMENTS
function sum(){
  let allNums = Array.from(arguments);
  let sum = allNums.reduce((a, b) => a + b, 0 );
  console.log(sum);
}

// WITH REST OPERATORS
function sum(...nums){
  let sum = nums.reduce((a, b) => a + b, 0 );
  console.log(sum);
}

//BIND
Function.prototype.myBind = function(ctx, bindArgs){
  return () => this.call(ctx, ...Array.prototype.slice.call(arguments).slice(1));
};

class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}

const markov = new Cat("Markov");
const breakfast = new Cat("Breakfast");

markov.says("meow", "Ned");

markov.says.myBind(breakfast, "meow", "Kush")();

// CURRIEDSUM
function curriedSum(numArgs) {
  const numbers = [];
  const _adder = (num) => {
    numbers.push(num);
    if (numbers.length === numArgs) {
      return numbers.reduce((a,b) => a + b, 0);
    } else {
      return _adder;
    }
  };
  return _adder;
}

function curriedSum(numArgs) {
  const numbers = [];
  return function _adder(num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      return numbers.reduce((a,b) => a + b, 0);
    } else {
      return _adder;
    }
  };
}

Function.prototype.curry = function(numArgs) {
  const args = [];
  let that = this;
  const _argAcc = function (){
    args.push(arguments[0]);
    if(args.length === numArgs){
      return that(...args);
    } else {
      return _argAcc;
    }
  };
  return _argAcc;
};

const add = function(...nums){
  return nums.reduce((a,b) => a + b, 0);
};
