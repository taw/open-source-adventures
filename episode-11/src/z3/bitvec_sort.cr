module Z3
  class BitvecSort
    def initialize(@size : UInt32)
      @sort = LibZ3.mk_bv_sort(API::Context, @size)
    end

    def [](expr : BitvecExpr)
      raise Z3::Exception.new("Incompatible bitvector sizes #{@size} != #{expr.size}") unless @size == expr.size
      expr
    end

    def [](name : String)
      BitvecExpr.new API.mk_const(name, self), self
    end

    def [](v : Int)
      BitvecExpr.new API.mk_numeral(v, self), self
    end

    def size
      @size
    end

    def to_unsafe
      @sort
    end
  end
end
