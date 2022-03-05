require "./z3/*"

module Z3
  def Z3.distinct(args : Array(IntExpr))
    BoolExpr.new API.mk_distinct(args.map(&._expr))
  end

  def Z3.int(name)
    Z3::IntSort[name]
  end

  def Z3.bool(name)
    Z3::BoolSort[name]
  end

  def Z3.version
    LibZ3.get_version(out v0, out v1, out v2, out v3)
    [v0, v1, v2, v3].join(".")
  end
end
