require "./spec_helper"

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
    [a == 10, b == 25, c == a - b].should have_solution({c => -15})
    [a == 2, b == 10 - a].should have_solution({b => 8})
    [a == 2, b == a - 10].should have_solution({b => -8})
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

  it "simplify" do
    u = Z3::IntSort[5]
    v = Z3::IntSort[3]
    ((u+v).to_s).should eq("(+ 5 3)")
    ((u+v).simplify.to_s).should eq("8")
  end

  it "to_s and inspect" do
    u = Z3::IntSort[5]
    v = Z3::IntSort[-3]
    u.to_s.should eq "5"
    v.to_s.should eq "-3"
    a.to_s.should eq "a"
    u.inspect.should eq "IntExpr<5>"
    v.inspect.should eq "IntExpr<-3>"
    a.inspect.should eq "IntExpr<a>"
  end

  it "const?" do
    Z3::IntSort[5].const?.should be_true
    Z3::IntSort[-5].const?.should be_true
    (Z3::IntSort[5] + Z3::IntSort[5]).const?.should be_false
    a.const?.should be_false
    (a + b).const?.should be_false
  end

  it "to_i" do
    Z3::IntSort[5].to_i.should eq(5)
    Z3::IntSort[-10].to_i.should eq(-10)
    (Z3::IntSort[2] + Z3::IntSort[2]).to_i.should eq(4)
    expect_raises(Z3::Exception){ a.to_i }
    expect_raises(Z3::Exception){ (a + b).to_i }
  end
end
