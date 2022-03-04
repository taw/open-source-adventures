require "./spec_helper"
require "../src/z3"

describe Z3::IntExpr do
  a = Z3.int("a")
  b = Z3.int("b")
  c = Z3.int("c")
  x = Z3.bool("x")

  it "+" do
    [a == 10, b == 20, c == a + b].should have_solution({c => 30})
    [a == 2, b == 10 + a].should have_solution({b => 12})
    [a == 2, b == a + 10].should have_solution({b => 12})
  end

  it "*" do
    [a == 10, b == 20, c == a * b].should have_solution({c => 200})
    [a == 2, b == 10 * a].should have_solution({b => 20})
    [a == 2, b == a * 10].should have_solution({b => 20})
  end

  it "-" do
    [a == 10, b == 20, c == a - b].should have_solution({c => 30})
    [a == 2, b == 10 - a].should have_solution({b => 12})
    [a == 2, b == a - 10].should have_solution({b => 12})
  end

  it "/" do
    [a ==  10, b ==  3, c == a / b].should have_solution({c =>  3})
    [a == -10, b ==  3, c == a / b].should have_solution({c => -4})
    [a ==  10, b == -3, c == a / b].should have_solution({c => -3})
    [a == -10, b == -3, c == a / b].should have_solution({c =>  4})
  end

  # Can't say these make much sense, but let's document what Z3 actually does
  it "rem" do
    [a ==  10, b ==  3, c == a.rem(b)].should have_solution({c => 10 -  3 *  3})
    [a == -10, b ==  3, c == a.rem(b)].should have_solution({c =>-10 -  3 * -4})
    [a ==  10, b == -3, c == a.rem(b)].should have_solution({c =>-( 10 - -3 * -3)})
    [a == -10, b == -3, c == a.rem(b)].should have_solution({c =>-(-10 - -3 *  4)})
  end

  it "mod" do
    [a ==  10, b ==  3, c == a.mod(b)].should have_solution({c => 1})
    [a ==  10, b == -3, c == a.mod(b)].should have_solution({c => 1})
    [a == -10, b ==  3, c == a.mod(b)].should have_solution({c => 2})
    [a == -10, b == -3, c == a.mod(b)].should have_solution({c => 2})
  end

  it "==" do
    [a == 2, b == 2, x == (a == b)].should have_solution({x => true})
    [a == 2, b == 3, x == (a == b)].should have_solution({x => false})
  end

  it "!=" do
    [a == 2, b == 2, x == (a != b)].should have_solution({x => false})
    [a == 2, b == 3, x == (a != b)].should have_solution({x => true})
  end

  it ">" do
    [a == 3, b == 2, x == (a > b)].should have_solution({x => true})
    [a == 2, b == 2, x == (a > b)].should have_solution({x => false})
    [a == 1, b == 2, x == (a > b)].should have_solution({x => false})
  end

  it ">=" do
    [a == 3, b == 2, x == (a >= b)].should have_solution({x => true})
    [a == 2, b == 2, x == (a >= b)].should have_solution({x => true})
    [a == 1, b == 2, x == (a >= b)].should have_solution({x => false})
  end

  it "<" do
    [a == 3, b == 2, x == (a < b)].should have_solution({x => false})
    [a == 2, b == 2, x == (a < b)].should have_solution({x => false})
    [a == 1, b == 2, x == (a < b)].should have_solution({x => true})
  end

  it "<=" do
    [a == 3, b == 2, x == (a <= b)].should have_solution({x => false})
    [a == 2, b == 2, x == (a <= b)].should have_solution({x => true})
    [a == 1, b == 2, x == (a <= b)].should have_solution({x => true})
  end

  it "**" do
    [a == 3, b == 4, c == (a ** b)].should have_solution({c => 81})
  end

  it "unary -" do
    [a == 3, b == -a].should have_solution({b => -3})
  end
end
