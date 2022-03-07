require "./spec_helper"

describe Z3::RealExpr do
  a = Z3.real("a")
  b = Z3.real("b")
  c = Z3.real("c")
  x = Z3.bool("x")

  it "+" do
    [a == 2, b == 4, c == a + b].should have_solution({c => 6})
    [a == BigRational.new(1,3), b == BigRational.new(3,2), c == a + b].should have_solution({c => "11/6"})
  end

  it "-" do
    [a == 2, b == 4, c == a - b].should have_solution({c => -2})
  end

  it "*" do
    [a == 2, b == 4, c == a * b].should have_solution({c => 8})
  end

  it "/" do
    [a ==  10, b ==  3, c == a / b].should have_solution({c => "10/3"})
    [a == -10, b ==  3, c == a / b].should have_solution({c => "-10/3"})
    [a ==  10, b == -3, c == a / b].should have_solution({c => "-10/3"})
    [a == -10, b == -3, c == a / b].should have_solution({c => "10/3"})
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
    [a == 81, b == 0.25, c == (a ** b)].should have_solution({c => 3})
  end

  it "unary -" do
    [a == 3, b == -a].should have_solution({b => -3})
    [a == 0, b == -a].should have_solution({b => 0})
    [a == 3.5, b == -a].should have_solution({b => "-7/2"})
    [a == BigRational.new(4, 3), b == -a].should have_solution({b => "-4/3"})
  end

  # Many expressions will not convert to a rational with .simplify
  # Then you get a complex S-expression
  # We need to add some way to extract that
  it "to_s" do
    Z3.real(7).to_s.should eq("7")
    Z3.real(-7).to_s.should eq("-7")
    (Z3.real(10) / Z3.real(3)).simplify.to_s.should eq("10/3")
    (Z3.real(-10) / Z3.real(3)).simplify.to_s.should eq("-10/3")
  end
end
