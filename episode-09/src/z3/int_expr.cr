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

    def !=(other)
      BoolExpr.new API.mk_ne(@expr, sort[other]._expr)
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

    def rem(other)
      IntExpr.new API.mk_rem(@expr, sort[other]._expr)
    end

    def mod(other)
      IntExpr.new API.mk_mod(@expr, sort[other]._expr)
    end

    def **(other)
      IntExpr.new API.mk_power(@expr, sort[other]._expr)
    end

    def -
      IntExpr.new API.mk_unary_minus(@expr)
    end

    def simplify
      IntExpr.new API.simplify(@expr)
    end

    def const?
      API.get_ast_kind(@expr) == LibZ3::AstKind::Numeral
    end

    def to_s(io)
      if const?
        io << API.get_numeral_string(@expr)
      else
        # We should use our own printer, these are just S-Expressions
        io << API.ast_to_string(@expr)
      end
    end

    def to_i
      return API.get_numeral_string(@expr).to_i if const?
      s = simplify
      return API.get_numeral_string(s._expr).to_i if s.const?
      raise Z3::Exception.new("Expr #{to_s} is not constant")
    end

    def inspect(io)
      to_s(io)
    end

    protected def _expr
      @expr
    end
  end
end
