module Z3
  class BoolExpr
    def initialize(@expr : LibZ3::Ast)
    end

    def sort
      BoolSort
    end

    def ==(other)
      BoolExpr.new API.mk_eq(self, sort[other])
    end

    def !=(other)
      BoolExpr.new API.mk_ne(self, sort[other])
    end

    def &(other)
      BoolExpr.new API.mk_and([self, sort[other]])
    end

    def |(other)
      BoolExpr.new API.mk_or([self, sort[other]])
    end

    def ^(other)
      BoolExpr.new API.mk_xor(self, sort[other])
    end

    def implies(other)
      BoolExpr.new API.mk_implies(self, sort[other])
    end

    def iff(other)
      BoolExpr.new API.mk_iff(self, sort[other])
    end

    def ite(a : (IntExpr | Int), b : (IntExpr | Int)) : IntExpr
      IntExpr.new API.mk_ite(self, IntSort[a], IntSort[b])
    end

    def ite(a : (BoolExpr | Bool), b : (BoolExpr | Bool)) : BoolExpr
      BoolExpr.new API.mk_ite(self, BoolSort[a], BoolSort[b])
    end

    def ~
      BoolExpr.new API.mk_not(self)
    end

    def simplify
      BoolExpr.new API.simplify(self)
    end

    def to_s(io)
      io << API.ast_to_string(self)
    end

    def inspect(io)
      io << "BoolExpr<"
      to_s(io)
      io << ">"
    end

    def const?
      API.get_ast_kind(self) == LibZ3::AstKind::App && API.ast_to_string(self).in?(["true", "false"])
    end

    def to_b
      return API.ast_to_string(self) == "true" if const?
      s = simplify
      return API.ast_to_string(s) == "true" if s.const?
      raise Z3::Exception.new("Expr #{to_s} is not constant")
    end

    def to_unsafe
      @expr
    end
  end
end
