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

    def &(other)
      BoolExpr.new API.mk_and([@expr, sort[other]._expr])
    end

    def |(other)
      BoolExpr.new API.mk_or([@expr, sort[other]._expr])
    end

    def ^(other)
      BoolExpr.new API.mk_xor(@expr, sort[other]._expr)
    end

    def implies(other)
      BoolExpr.new API.mk_implies(@expr, sort[other]._expr)
    end

    def iff(other)
      BoolExpr.new API.mk_iff(@expr, sort[other]._expr)
    end

    def ite(a : (IntExpr | Int), b : (IntExpr | Int)) : IntExpr
      IntExpr.new API.mk_ite(@expr, IntSort[a]._expr, IntSort[b]._expr)
    end

    def ite(a : (BoolExpr | Bool), b : (BoolExpr | Bool)) : BoolExpr
      BoolExpr.new API.mk_ite(@expr, BoolSort[a]._expr, BoolSort[b]._expr)
    end

    def ~
      BoolExpr.new API.mk_not(@expr)
    end

    def simplify
      BoolExpr.new API.simplify(@expr)
    end

    def to_s(io)
      io << API.ast_to_string(@expr)
    end

    def inspect(io)
      to_s(io)
    end

    def const?
      API.get_ast_kind(@expr) == LibZ3::AstKind::App && API.ast_to_string(@expr).in?(["true", "false"])
    end

    def to_b
      return API.ast_to_string(@expr) == "true" if const?
      s = simplify
      return API.ast_to_string(s._expr) == "true" if s.const?
      raise Z3::Exception.new("Expr #{to_s} is not constant")
    end

    protected def _expr
      @expr
    end
  end
end
