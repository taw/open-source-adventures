module Z3
  class RealSort
    @@sort = LibZ3.mk_real_sort(API::Context)

    def self.[](expr : RealExpr)
      expr
    end

    def self.[](name : String)
      RealExpr.new API.mk_const(name, @@sort)
    end

    def self.[](num : Int | BigRational)
      RealExpr.new API.mk_numeral(num, @@sort)
    end

    def self.[](num : Float64)
      raise Z3::Exception.new("Can't convert non-finite float to Z3 Real") unless num.finite?
      RealExpr.new API.mk_numeral(num, @@sort)
    end
  end
end
