describe Z3::BitvecExpr do
  a = Z3.bitvec("a", 8)
  b = Z3.bitvec("b", 8)
  c = Z3.bitvec("c", 8)
  d = Z3.bitvec("d", 12)
  e = Z3.bitvec("e", 4)
  x = Z3.bool("x")
  bv8 = Z3::BitvecSort.new(8)

  it "==" do
    [a == 2, b == -254, x == (a == b)].should have_solution({x => true})
    [a == 2, b == 2, x == (a == b)].should have_solution({x => true})
    [a == 2, b == 3, x == (a == b)].should have_solution({x => false})
  end

  it "!=" do
    [a == 2, b == -254, x == (a != b)].should have_solution({x => false})
    [a == 2, b == 2, x == (a != b)].should have_solution({x => false})
    [a == 2, b == 3, x == (a != b)].should have_solution({x => true})
  end

  it "+" do
    [a == 2, b == 40, c == (a + b)].should have_solution({c => 42})
    [a == 200, b == 40, c == (a + b)].should have_solution({c => 240})
    [a == -1, b == -1, c == (a + b)].should have_solution({c => 254})
  end

  it "-" do
    [a == 50, b == 8, c == (a - b)].should have_solution({c => 42})
    [a == 200, b == 40, c == (a - b)].should have_solution({c => 160})
    [a == 40, b == 200, c == (a - b)].should have_solution({c => 96})
  end

  it "*" do
    [a == 3, b == 40, c == (a * b)].should have_solution({c => 120})
    [a == 30, b == 42, c == (a * b)].should have_solution({c => 236})
  end

  it "/" do
    expect_raises(Z3::Exception) { a / b }
    [a == 200, b == 20, c == a.unsigned_div(b)].should have_solution({c => 10})
    [a == 200, b == 20, c == a.signed_div(b)].should have_solution({c => 254})
  end

  it "%" do
    expect_raises(Z3::Exception) { a % b }
    [a == 200, b == 20, c == a.signed_mod(b)].should have_solution({c => 4})
    [a == 200, b == 20, c == a.signed_rem(b)].should have_solution({c => 240})
    [a == 200, b == 20, c == a.unsigned_rem(b)].should have_solution({c => 0})
  end

  it "&" do
    [a == 50, b == 27, c == (a & b)].should have_solution({c => 18})
  end

  it "|" do
    [a == 50, b == 27, c == (a | b)].should have_solution({c => 59})
  end

  it "^" do
    [a == 50, b == 27, c == (a ^ b)].should have_solution({c => 41})
  end

  it "xnor" do
    [a == 50, b == 27, c == a.xnor(b)].should have_solution({c => 214})
  end

  it "nand" do
    [a == 50, b == 27, c == a.nand(b)].should have_solution({c => 237})
  end

  it "nor" do
    [a == 50, b == 27, c == a.nor(b)].should have_solution({c => 196})
  end

  it "unary -" do
    [a == 50, b == -a].should have_solution({b => 206})
  end

  # ! can't be overriden in Crystal
  it "~" do
    [a == 50, b == ~a].should have_solution({b => 205})
  end

  it ">> (sign-dependent)" do
    [a == 234, b == 2, c == a.unsigned_rshift(b)].should have_solution({c => 58})
    [a == 234, b == 2, c == a.signed_rshift(b)].should have_solution({c => 250})
    expect_raises(Z3::Exception) { a.rshift(b) }
    expect_raises(Z3::Exception) { a >> b }
  end

  # There's only one way to shift left so these are all aliases
  # but it would be confusing API to have different names for left and right shifts
  it "<< (sign-independent)" do
    [a == 234, b == 2, c == a.signed_lshift(b)].should have_solution({c => 168})
    [a == 234, b == 2, c == a.unsigned_lshift(b)].should have_solution({c => 168})
    [a == 234, b == 2, c == a.lshift(b)].should have_solution({c => 168})
    [a == 234, b == 2, c == (a << b)].should have_solution({c => 168})
  end

  it ">" do
    # expect_raises(Z3::Exception) { a > b }
    [a == 100, b ==  20, x == a.unsigned_gt(b)].should have_solution({x => true})
    [a == 100, b == 100, x == a.unsigned_gt(b)].should have_solution({x => false})
    [a == 100, b == 120, x == a.unsigned_gt(b)].should have_solution({x => false})
    [a == 100, b == 200, x == a.unsigned_gt(b)].should have_solution({x => false})
    [a == 100, b ==  20, x == a.signed_gt(b)].should have_solution({x => true})
    [a == 100, b == 100, x == a.signed_gt(b)].should have_solution({x => false})
    [a == 100, b == 120, x == a.signed_gt(b)].should have_solution({x => false})
    [a == 100, b == 200, x == a.signed_gt(b)].should have_solution({x => true})
  end

  it ">=" do
    # expect_raises(Z3::Exception) { a >= b }
    [a == 100, b ==  20, x == a.unsigned_ge(b)].should have_solution({x => true})
    [a == 100, b == 100, x == a.unsigned_ge(b)].should have_solution({x => true})
    [a == 100, b == 120, x == a.unsigned_ge(b)].should have_solution({x => false})
    [a == 100, b == 200, x == a.unsigned_ge(b)].should have_solution({x => false})
    [a == 100, b ==  20, x == a.signed_ge(b)].should have_solution({x => true})
    [a == 100, b == 100, x == a.signed_ge(b)].should have_solution({x => true})
    [a == 100, b == 120, x == a.signed_ge(b)].should have_solution({x => false})
    [a == 100, b == 200, x == a.signed_ge(b)].should have_solution({x => true})
  end

  it "<" do
    # expect_raises(Z3::Exception) { a < b }
    [a == 100, b ==  20, x == a.unsigned_lt(b)].should have_solution({x => false})
    [a == 100, b == 100, x == a.unsigned_lt(b)].should have_solution({x => false})
    [a == 100, b == 120, x == a.unsigned_lt(b)].should have_solution({x =>  true})
    [a == 100, b == 200, x == a.unsigned_lt(b)].should have_solution({x =>  true})
    [a == 100, b ==  20, x == a.signed_lt(b)].should have_solution({x => false})
    [a == 100, b == 100, x == a.signed_lt(b)].should have_solution({x => false})
    [a == 100, b == 120, x == a.signed_lt(b)].should have_solution({x =>  true})
    [a == 100, b == 200, x == a.signed_lt(b)].should have_solution({x => false})
  end

  it "<=" do
    # expect_raises(Z3::Exception) { a <= b }
    [a == 100, b ==  20, x == a.unsigned_le(b)].should have_solution({x => false})
    [a == 100, b == 100, x == a.unsigned_le(b)].should have_solution({x =>  true})
    [a == 100, b == 120, x == a.unsigned_le(b)].should have_solution({x =>  true})
    [a == 100, b == 200, x == a.unsigned_le(b)].should have_solution({x =>  true})
    [a == 100, b ==  20, x == a.signed_le(b)].should have_solution({x => false})
    [a == 100, b == 100, x == a.signed_le(b)].should have_solution({x =>  true})
    [a == 100, b == 120, x == a.signed_le(b)].should have_solution({x =>  true})
    [a == 100, b == 200, x == a.signed_le(b)].should have_solution({x => false})
  end

  it "zero_ext / sign_ext" do
    [a ==  100, d ==  a.zero_ext(4)].should have_solution({d => 100})
    [a == -100, d ==  a.zero_ext(4)].should have_solution({d => 2**8-100})
    [a ==  100, d ==  a.sign_ext(4)].should have_solution({d => 100})
    [a == -100, d ==  a.sign_ext(4)].should have_solution({d => 2**12-100})
  end

  it "rotate_left / rotate_right" do
    [a == 0b0101_0110, b == a.rotate_left(1)].should have_solution({b => 0b101_0110_0})
    [a == 0b0101_0110, b == a.rotate_left(4)].should have_solution({b => 0b0110_0101})
    [a == 0b0101_0110, b == a.rotate_right(1)].should have_solution({b => 0b0_0101_011})
    [a == 0b0101_0110, b == a.rotate_right(4)].should have_solution({b => 0b0110_0101})
  end

  # This (hi, lo) API from Z3 feels bad in Crystal
  # we should probably drop it and accept Range instead
  it "extract" do
    [a == 0b0101_0110, e == a.extract(3, 0)].should have_solution({e => 0b0110})
    [a == 0b0101_0110, e == a.extract(7, 4)].should have_solution({e => 0b0101})
    expect_raises(Z3::Exception) { a.extract(8, 4) }
    expect_raises(Z3::Exception) { a.extract(2, 3) }
    # expect_raises(Z3::Exception) { a.extract(2, -1) }
  end

  it "concat" do
    [a == 0b0101_0110, e == 0b1101, d == a.concat(e)].should have_solution({d => 0b0101_0110_1101})
    [a == 0b0101_0110, e == 0b1101, d == e.concat(a)].should have_solution({d => 0b1101_0101_0110})
  end

  it "simplify" do
    u = bv8[100]
    v = bv8[50]
    ((u+v).to_s).should eq("(bvadd #x64 #x32)")
    ((u+v).simplify.to_s).should eq("150")
  end

  it "to_s and inspect" do
    u = bv8[5]
    v = bv8[-3]
    u.to_s.should eq "5"
    v.to_s.should eq "253"
    a.to_s.should eq "a"
    u.inspect.should eq "BitvecExpr(8)<5>"
    v.inspect.should eq "BitvecExpr(8)<253>"
    a.inspect.should eq "BitvecExpr(8)<a>"
  end

  it "const?" do
    bv8[100].const?.should be_true
    bv8[-100].const?.should be_true
    (bv8[100] + bv8[50]).const?.should be_false
    a.const?.should be_false
    (a + b).const?.should be_false
  end

  it "to_i" do
    bv8[5].to_i.should eq(5)
    bv8[-10].to_i.should eq(246)
    (bv8[2] + bv8[2]).to_i.should eq(4)
    expect_raises(Z3::Exception){ a.to_i }
    expect_raises(Z3::Exception){ (a + b).to_i }
  end
end
