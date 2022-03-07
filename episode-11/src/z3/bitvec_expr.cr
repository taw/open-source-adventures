module Z3
  class BitvecExpr
    def initialize(@expr : LibZ3::Ast, @sort : BitvecSort)
    end

    def size
      @sort.size
    end

    def sort
      @sort
    end

    def ==(other)
      BoolExpr.new API.mk_eq(self, sort[other])
    end

    def !=(other)
      BoolExpr.new API.mk_ne(self, sort[other])
    end

    def +(other)
      BitvecExpr.new API.mk_bvadd(self, sort[other]), sort
    end

    def -(other)
      BitvecExpr.new API.mk_bvsub(self, sort[other]), sort
    end

    def *(other)
      BitvecExpr.new API.mk_bvmul(self, sort[other]), sort
    end

    def /(other)
      raise Z3::Exception.new("Use signed_div or unsigned_div")
    end

    def signed_div(other)
      BitvecExpr.new API.mk_bvsdiv(self, sort[other]), sort
    end

    def unsigned_div(other)
      BitvecExpr.new API.mk_bvudiv(self, sort[other]), sort
    end

    def signed_mod(other)
      BitvecExpr.new API.mk_bvsmod(self, sort[other]), sort
    end

    def signed_rem(other)
      BitvecExpr.new API.mk_bvsrem(self, sort[other]), sort
    end

    def unsigned_rem(other)
      BitvecExpr.new API.mk_bvurem(self, sort[other]), sort
    end

    def %(other)
      raise Z3::Exception.new("Use signed_mod or signed_rem or unsigned_rem")
    end

    def &(other)
      BitvecExpr.new API.mk_bvand(self, sort[other]), sort
    end

    def |(other)
      BitvecExpr.new API.mk_bvor(self, sort[other]), sort
    end

    def ^(other)
      BitvecExpr.new API.mk_bvxor(self, sort[other]), sort
    end

    def nand(other)
      BitvecExpr.new API.mk_bvnand(self, sort[other]), sort
    end

    def nor(other)
      BitvecExpr.new API.mk_bvnor(self, sort[other]), sort
    end

    def xnor(other)
      BitvecExpr.new API.mk_bvxnor(self, sort[other]), sort
    end

    def signed_lt(other)
      BoolExpr.new API.mk_bvslt(self, sort[other])
    end

    def signed_le(other)
      BoolExpr.new API.mk_bvsle(self, sort[other])
    end

    def signed_gt(other)
      BoolExpr.new API.mk_bvsgt(self, sort[other])
    end

    def signed_ge(other)
      BoolExpr.new API.mk_bvsge(self, sort[other])
    end

    def unsigned_lt(other)
      BoolExpr.new API.mk_bvult(self, sort[other])
    end

    def unsigned_le(other)
      BoolExpr.new API.mk_bvule(self, sort[other])
    end

    def unsigned_gt(other)
      BoolExpr.new API.mk_bvugt(self, sort[other])
    end

    def unsigned_ge(other)
      BoolExpr.new API.mk_bvuge(self, sort[other])
    end

    def >>(other)
      raise Z3::Exception.new("Use #signed_rshift or #unsigned_rshift for Bitvec, not >>")
    end

    def signed_rshift(other)
      BitvecExpr.new API.mk_bvashr(self, sort[other]), sort
    end

    def unsigned_rshift(other)
      BitvecExpr.new API.mk_bvlshr(self, sort[other]), sort
    end

    def rshift(other)
      raise Z3::Exception.new("Use #signed_rshift or #unsigned_rshift for Bitvec, not #rshift")
    end

    def <<(other)
      BitvecExpr.new API.mk_bvshl(self, sort[other]), sort
    end

    def signed_lshift(other)
      BitvecExpr.new API.mk_bvshl(self, sort[other]), sort
    end

    def unsigned_lshift(other)
      BitvecExpr.new API.mk_bvshl(self, sort[other]), sort
    end

    def lshift(other)
      BitvecExpr.new API.mk_bvshl(self, sort[other]), sort
    end

    def rotate_left(n : Int)
      BitvecExpr.new API.mk_rotate_left(n, self), sort
    end

    def rotate_right(n : Int)
      BitvecExpr.new API.mk_rotate_right(n, self), sort
    end

    def zero_ext(n : Int)
      BitvecExpr.new API.mk_zero_ext(n, self), BitvecSort.new(size + n)
    end

    def sign_ext(n : Int)
      BitvecExpr.new API.mk_sign_ext(n, self), BitvecSort.new(size + n)
    end

    def -
      BitvecExpr.new API.mk_bvneg(self), sort
    end

    def ~
      BitvecExpr.new API.mk_bvnot(self), sort
    end

    def extract(hi : UInt32, lo : UInt32)
      raise Z3::Exception.new("Trying to extract bits out of range") unless size > hi && hi >= lo && lo >= 0
      BitvecExpr.new API.mk_extract(hi, lo, self), BitvecSort.new(hi - lo + 1)
    end

    def concat(other : BitvecExpr)
      BitvecExpr.new API.mk_concat(self, other), BitvecSort.new(size + other.size)
    end

    def simplify
      BitvecExpr.new API.simplify(self), sort
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
      io << "BitvecExpr(#{size})<"
      to_s(io)
      io << ">"
    end

    def to_unsafe
      @expr
    end
  end
end
