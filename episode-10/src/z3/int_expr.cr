module Z3
  class IntExpr
    def initialize(@expr : LibZ3::Ast)
    end

    def sort
      IntSort
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
      IntExpr.new API.mk_mul([self, sort[other]])
    end

    def +(other)
      IntExpr.new API.mk_add([self, sort[other]])
    end

    def -(other)
      IntExpr.new API.mk_sub([self, sort[other]])
    end

    def /(other)
      IntExpr.new API.mk_div(self, sort[other])
    end

    def rem(other)
      IntExpr.new API.mk_rem(self, sort[other])
    end

    def mod(other)
      IntExpr.new API.mk_mod(self, sort[other])
    end

    def **(other)
      IntExpr.new API.mk_power(self, sort[other])
    end

    def -
      IntExpr.new API.mk_unary_minus(self)
    end

    def simplify
      IntExpr.new API.simplify(self)
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

    def to_i
      return API.get_numeral_string(self).to_i if const?
      s = simplify
      return API.get_numeral_string(s).to_i if s.const?
      raise Z3::Exception.new("Expr #{to_s} is not constant")
    end

    def inspect(io)
      to_s(io)
    end

    def to_unsafe
      @expr
    end
  end
end
