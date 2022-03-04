module Z3
  class BoolExpr
    def initialize(expr : LibZ3::Ast)
      @expr = expr
    end

    def sort
      BoolSort
    end

    def ==(other)
      BoolExpr.new API.mk_eq(@expr, sort[other]._expr)
    end

    def !=(other)
      BoolExpr.new API.mk_ne(@expr, sort[other]._expr)
    end

    def to_s(io)
      io << API.ast_to_string(@expr)
    end

    def inspect(io)
      to_s(io)
    end

    protected def _expr
      @expr
    end
  end
end
