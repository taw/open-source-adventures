module Z3
  class IntExpr
    def initialize(expr : LibZ3::Ast)
      @expr = expr
    end

    def sort
      IntSort
    end

    def ==(other)
      BoolExpr.new API.mk_eq(@expr, sort[other]._expr)
    end

    def >=(other)
      BoolExpr.new API.mk_ge(@expr, sort[other]._expr)
    end

    def >(other)
      BoolExpr.new API.mk_gt(@expr, sort[other]._expr)
    end

    def <=(other)
      BoolExpr.new API.mk_le(@expr, sort[other]._expr)
    end

    def <(other)
      BoolExpr.new API.mk_lt(@expr, sort[other]._expr)
    end

    def *(other)
      IntExpr.new API.mk_mul([@expr, sort[other]._expr])
    end

    def +(other)
      IntExpr.new API.mk_add([@expr, sort[other]._expr])
    end

    def -(other)
      IntExpr.new API.mk_sub([@expr, sort[other]._expr])
    end

    def /(other)
      IntExpr.new API.mk_div(@expr, sort[other]._expr)
    end

    protected def _expr
      @expr
    end
  end
end
