abstract struct Int
  def +(other : Z3::IntExpr)
    Z3::IntSort[self] + other
  end

  def *(other : Z3::IntExpr)
    Z3::IntSort[self] * other
  end

  def /(other : Z3::IntExpr)
    Z3::IntSort[self] / other
  end

  def -(other : Z3::IntExpr)
    Z3::IntSort[self] - other
  end

  def ==(other : Z3::IntExpr)
    Z3::IntSort[self] == other
  end

  def >=(other : Z3::IntExpr)
    Z3::IntSort[self] >= other
  end

  def >(other : Z3::IntExpr)
    Z3::IntSort[self] > other
  end

  def <=(other : Z3::IntExpr)
    Z3::IntSort[self] <= other
  end

  def <(other : Z3::IntExpr)
    Z3::IntSort[self] < other
  end
end
