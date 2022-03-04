module Z3
  class BoolExpr
    def initialize(expr : LibZ3::Ast)
      @expr = expr
    end

    def sort
      BoolSort
    end

    protected def _expr
      @expr
    end
  end
end
