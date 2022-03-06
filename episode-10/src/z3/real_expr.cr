module Z3
  class RealExpr
    def initialize(@expr : LibZ3::Ast)
    end

    def sort
      RealSort
    end

    def ==(other)
      BoolExpr.new API.mk_eq(self, sort[other])
    end

    def !=(other)
      BoolExpr.new API.mk_ne(self, sort[other])
    end

    def >=(other)
      BoolExpr.new API.mk_ge(self, sort[other])
    end

    def >(other)
      BoolExpr.new API.mk_gt(self, sort[other])
    end

    def <=(other)
      BoolExpr.new API.mk_le(self, sort[other])
    end

    def <(other)
      BoolExpr.new API.mk_lt(self, sort[other])
    end

    def *(other)
      RealExpr.new API.mk_mul([self, sort[other]])
    end

    def +(other)
      RealExpr.new API.mk_add([self, sort[other]])
    end

    def -(other)
      RealExpr.new API.mk_sub([self, sort[other]])
    end

    def /(other)
      RealExpr.new API.mk_div(self, sort[other])
    end

    def **(other)
      RealExpr.new API.mk_power(self, sort[other])
    end

    def -
      RealExpr.new API.mk_unary_minus(self)
    end

    def simplify
      RealExpr.new API.simplify(self)
    end

    def const?
      API.get_ast_kind(self) == LibZ3::AstKind::Numeral
    end

    def to_s(io)
      if const?
        io << API.get_numeral_string(self)
      else
        # We should use our own printer, these are just S-Expressions
        io << API.ast_to_string(self)
      end
    end

    # def to_rat
    # end

    # def to_f
    # end

    def inspect(io)
      to_s(io)
    end

    def to_unsafe
      @expr
    end
  end
end
