require "./z3/*"

module Z3
  def Z3.distinct(args : Array(IntExpr))
    BoolExpr.new API.mk_distinct(args.map(&._expr))
  end
end
