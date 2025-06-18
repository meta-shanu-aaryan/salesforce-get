function findMin(...args) {
  if (args.length === 0) {
    return undefined; // Or throw an error, depending on desired behavior
  }
  return Math.min(...args);
}

// Define the Animal constructor (Animal class)
function Animal(name) {
  this.name = name;
}

// Define the Dog constructor (Dog class)
function Dog(name) {
  // Call the Animal constructor to set the name property
  Animal.call(this, name);
}

// Set up prototype-based inheritance: Dog inherits from Animal
Dog.prototype = Object.create(Animal.prototype);
Dog.prototype.constructor = Dog; // Important: Reset constructor

// Add the bark method to the Dog prototype
Dog.prototype.bark = function() {
  console.log(this.name + " says Woof!");
};


function multiplyByEight(num){
    const multiplier = 8;
    return function(n){
        return num*multiplier;
    }
}

function waitAndReturn(){
    return new Promise((res, rej)=>{
        setTimeout(() => {
            res("Resolved");
        }, 5000);
    })
}

async function print(){
    str = await waitAndReturn();

    console.log(str);
}

const removeElementFromArray = (arr, removeElementArr)=>{
  return arr.filter((el)=>(!removeElementArr.includes(el)??el));
}

console.log(removeElementFromArray([1,2,3,4,5,6,7,8], [4,5,6]));