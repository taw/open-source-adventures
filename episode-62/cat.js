class Person {
  constructor(first_name, last_name) {
    this._first_name = first_name;
    this._last_name = last_name
  };

  toString() {
    return `${this._first_name} ${this._last_name}`
  }
};

class Cat extends Person {
  toString() {
    return `Your Majesty, Princess ${super.toString()}`
  }
};

let cat = new Cat("Catherine", "Whiskers");
console.log(`Hello, ${cat}!`)
