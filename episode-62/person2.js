class Person {
  constructor(first_name, last_name) {
    this._first_name = first_name;
    this._last_name = last_name
  };

  toString() {
    return `${this._first_name} ${this._last_name}`
  }
};

let person = new Person("Alice", "Ruby");
console.log(`Hello, ${person}!`)
