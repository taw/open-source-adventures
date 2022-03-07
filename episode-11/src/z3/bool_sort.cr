module Z3
  class BoolSort
    @@sort = LibZ3.mk_bool_sort(API::Context)

    def self.[](expr : BoolExpr)
      expr
    end

    def self.[](name : String)
      BoolExpr.new API.mk_const(name, @@sort)
    end

    def self.[](t : Bool)
      if t
        BoolExpr.new API.mk_true
      else
        BoolExpr.new API.mk_false
      end
    end
  end
end
