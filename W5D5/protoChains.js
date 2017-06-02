function BabyMomma(){
  this.mom = false;
}

function Surrogate(){

}

function Baby(){
  this.gas = true;
}

BabyMomma.prototype.isMomma = function(){
  if(this.mom === false){
    console.log("I was adopted.");
  } else {
    console.log("I have a mom.");
  }
};

Surrogate.prototype = Object.create(BabyMomma.prototype);
Baby.prototype = Surrogate.prototype;
Surrogate.prototype.constructor = Baby;

let chuckie = new Baby();
let melinda = new BabyMomma();

Baby.prototype.hasBottle = function(){
  console.log("Got Milk?");
};
