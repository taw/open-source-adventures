require "./libz3"

module Z3
  extend self

  Context = LibZ3.mk_context(LibZ3.mk_config)

  def mk_solver
    LibZ3.mk_solver(Context)
  end

  def mk_numeral(num, sort)
    LibZ3.mk_numeral(Context, num.to_s, sort)
  end

  def mk_const(name, sort)
    name_sym = LibZ3.mk_string_symbol(Context, name)
    var = LibZ3.mk_const(Context, name_sym, sort)
  end

  def mk_eq(a, b)
    LibZ3.mk_eq(Context, a, b)
  end

  def mk_ge(a, b)
    LibZ3.mk_ge(Context, a, b)
  end

  def mk_gt(a, b)
    LibZ3.mk_gt(Context, a, b)
  end

  def mk_le(a, b)
    LibZ3.mk_le(Context, a, b)
  end

  def mk_lt(a, b)
    LibZ3.mk_lt(Context, a, b)
  end

  def mk_add(asts)
    LibZ3.mk_add(Context, asts.size, asts)
  end

  def mk_mul(asts)
    LibZ3.mk_mul(Context, asts.size, asts)
  end

  def mk_distinct(asts)
    LibZ3.mk_distinct(Context, asts.size, asts)
  end

  def solver_assert(solver, ast)
    LibZ3.solver_assert(Context, solver, ast)
  end

  def solver_check(solver)
    LibZ3.solver_check(Context, solver)
  end

  def solver_get_model(solver)
    LibZ3.solver_get_model(Context, solver)
  end

  def model_to_string(model)
    String.new LibZ3.model_to_string(Context, model)
  end
end

class Z3::Solver
  def initialize
    @solver = Z3.mk_solver
  end

  def assert(expr)
    Z3.solver_assert(@solver, expr._expr)
  end

  def check
    Z3.solver_check(@solver)
  end

  def model
    Z3::Model.new(Z3.solver_get_model(@solver))
  end
end

class Z3::Model
  def initialize(model : LibZ3::Model)
    @model = model
  end

  # This needs to go eventually
  def to_s(io)
    io << Z3.model_to_string(@model).chomp
  end
end

class Z3::IntSort
  @@sort = LibZ3.mk_int_sort(Context)

  def self.[](name : Symbol)
    Z3::IntExpr.new Z3.mk_const(name.to_s, @@sort)
  end

  def self.[](v : Int32)
    Z3::IntExpr.new Z3.mk_numeral(v, @@sort)
  end
end

class Z3::BoolSort
  @@sort = LibZ3.mk_bool_sort(Context)
end

class Z3::IntExpr
  def initialize(expr : LibZ3::Ast)
    @expr = expr
  end

  def sort
    Z3::IntSort
  end

  def ==(other : Z3::IntExpr)
    Z3::BoolExpr.new Z3.mk_eq(@expr, other._expr)
  end

  def >=(other : Z3::IntExpr)
    Z3::BoolExpr.new Z3.mk_ge(@expr, other._expr)
  end

  def >(other : Z3::IntExpr)
    Z3::BoolExpr.new Z3.mk_gt(@expr, other._expr)
  end

  def <=(other : Z3::IntExpr)
    Z3::BoolExpr.new Z3.mk_le(@expr, other._expr)
  end

  def <(other : Z3::IntExpr)
    Z3::BoolExpr.new Z3.mk_lt(@expr, other._expr)
  end

  def *(other : Z3::IntExpr)
    Z3::IntExpr.new Z3.mk_mul([@expr, other._expr])
  end

  def +(other : Z3::IntExpr)
    Z3::IntExpr.new Z3.mk_add([@expr, other._expr])
  end

  def _expr
    @expr
  end
end

class Z3::BoolExpr
  def initialize(expr : LibZ3::Ast)
    @expr = expr
  end

  def sort
    Z3::BoolSort
  end

  def _expr
    @expr
  end
end

# Not sure where to put this
def Z3.distinct(args : Array(Z3::IntExpr))
  Z3::BoolExpr.new Z3.mk_distinct(args.map(&._expr))
end
