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

    # This is hacky as hell, we need our own printer as these are
    # just Lisp-style S-expression and won't even handle negatives in a sensible way
    # For example -4 is "(- 4)"
    def to_s(io)
      s = API.ast_to_string(@expr)
      if s =~ /\A\(- (\d+)\)\z/
        s = "-#{$1}"
      end
      io << s
    end

    def inspect(io)
      to_s(io)
    end

    protected def _expr
      @expr
    end
  end
end
