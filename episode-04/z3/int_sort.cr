module Z3
  class IntSort
    @@sort = LibZ3.mk_int_sort(API::Context)

    def self.[](expr : IntExpr)
      expr
    end

    def self.[](name : Symbol)
      IntExpr.new API.mk_const(name.to_s, @@sort)
    end

    def self.[](v : Int)
      IntExpr.new API.mk_numeral(v, @@sort)
    end
  end
end
