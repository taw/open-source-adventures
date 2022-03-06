require "./spec_helper"

describe Z3::BoolExpr do
  a = Z3.bool("a")
  b = Z3.bool("b")
  c = Z3.bool("c")
  x = Z3.int("x")

  it "&" do
    [a ==  true, b ==  true, c == (a & b)].should have_solution({c =>  true})
    [a ==  true, b == false, c == (a & b)].should have_solution({c => false})
    [a == false, b ==  true, c == (a & b)].should have_solution({c => false})
    [a == false, b == false, c == (a & b)].should have_solution({c => false})
  end

  it "|" do
    [a ==  true, b ==  true, c == (a | b)].should have_solution({c =>  true})
    [a ==  true, b == false, c == (a | b)].should have_solution({c =>  true})
    [a == false, b ==  true, c == (a | b)].should have_solution({c =>  true})
    [a == false, b == false, c == (a | b)].should have_solution({c => false})
  end

  it "^" do
    [a ==  true, b ==  true, c == (a ^ b)].should have_solution({c => false})
    [a ==  true, b == false, c == (a ^ b)].should have_solution({c =>  true})
    [a == false, b ==  true, c == (a ^ b)].should have_solution({c =>  true})
    [a == false, b == false, c == (a ^ b)].should have_solution({c => false})
  end

  it "!=" do
    [a ==  true, b ==  true, c == (a != b)].should have_solution({c => false})
    [a ==  true, b == false, c == (a != b)].should have_solution({c =>  true})
    [a == false, b ==  true, c == (a != b)].should have_solution({c =>  true})
    [a == false, b == false, c == (a != b)].should have_solution({c => false})
  end

  it "implies" do
    [a ==  true, b ==  true, c == a.implies(b)].should have_solution({c =>  true})
    [a ==  true, b == false, c == a.implies(b)].should have_solution({c => false})
    [a == false, b ==  true, c == a.implies(b)].should have_solution({c =>  true})
    [a == false, b == false, c == a.implies(b)].should have_solution({c =>  true})
  end

  it "iff" do
    [a ==  true, b ==  true, c == a.iff(b)].should have_solution({c =>  true})
    [a ==  true, b == false, c == a.iff(b)].should have_solution({c => false})
    [a == false, b ==  true, c == a.iff(b)].should have_solution({c => false})
    [a == false, b == false, c == a.iff(b)].should have_solution({c =>  true})
  end

  it "==" do
    [a ==  true, b ==  true, c == (a == b)].should have_solution({c =>  true})
    [a ==  true, b == false, c == (a == b)].should have_solution({c => false})
    [a == false, b ==  true, c == (a == b)].should have_solution({c => false})
    [a == false, b == false, c == (a == b)].should have_solution({c =>  true})
  end

  # ! not possible
  it "~" do
    [a ==  true, b == ~a].should have_solution({b => false})
    [a == false, b == ~a].should have_solution({b =>  true})
  end

  it "if then else" do
    [a ==  true, x == a.ite(2, 3)].should have_solution({x => 2})
    [a == false, x == a.ite(2, 3)].should have_solution({x => 3})
    [a == true,  b == a.ite(true, false)].should have_solution({b => true})
    [a == false, b == a.ite(true, false)].should have_solution({b => false})
    [a == true,  b == a.ite(false, true)].should have_solution({b => false})
    [a == false, b == a.ite(false, true)].should have_solution({b => true})
  end

  it "simplify" do
    t = Z3::BoolSort[true]
    f = Z3::BoolSort[false]
    ((t&f).to_s).should eq("(and true false)")
    ((t&f).simplify.to_s).should eq("false")
  end

  it "const?" do
    Z3::BoolSort[true].const?.should be_true
    Z3::BoolSort[false].const?.should be_true
    (Z3::BoolSort[true] | Z3::BoolSort[false]).const?.should be_false
    a.const?.should be_false
    (a | b).const?.should be_false
  end

  it "to_b" do
    Z3::BoolSort[true].to_b.should eq(true)
    Z3::BoolSort[false].to_b.should eq(false)
    (Z3::BoolSort[true] | Z3::BoolSort[false]).to_b.should eq(true)
    expect_raises(Z3::Exception) { a.to_b }
    expect_raises(Z3::Exception) { (a | b).to_b }
  end
end
