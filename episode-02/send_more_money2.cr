#!/usr/bin/env crystal

@[Link("z3")]
lib LibZ3
  type Ast = Void*
  type Config = Void*
  type Context = Void*
  type Model = Void*
  type Solver = Void*
  type Sort = Void*
  type Symbol = Void*

  enum LBool : Int32
    False = -1
    Undefined = 0
    True = 1
  end

  # Just list the ones we need, there's about 700 API calls total
  fun mk_add = Z3_mk_add(ctx : Context, count : UInt32, asts : Ast*) : Ast
  fun mk_const = Z3_mk_const(ctx : Context, name : Symbol, sort : Sort) : Ast
  fun mk_context = Z3_mk_context(cfg : Config) : Context
  fun mk_config = Z3_mk_config() : Config
  fun mk_eq = Z3_mk_eq(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_ge = Z3_mk_ge(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_gt = Z3_mk_gt(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_int_sort = Z3_mk_int_sort(ctx : Context) : Sort
  fun mk_le = Z3_mk_le(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_lt = Z3_mk_lt(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_distinct = Z3_mk_distinct(ctx : Context, count : UInt32, asts : Ast*) : Ast
  fun mk_mul = Z3_mk_mul(ctx : Context, count : UInt32, asts : Ast*) : Ast
  fun mk_numeral = Z3_mk_numeral(ctx : Context, s : UInt8*, sort : Sort) : Ast
  fun mk_solver = Z3_mk_solver(ctx : Context) : Solver
  fun mk_string_symbol = Z3_mk_string_symbol(ctx : Context, s : UInt8*) : Symbol
  fun model_to_string = Z3_model_to_string(ctx : Context, model : Model) : UInt8*
  fun solver_assert = Z3_solver_assert(ctx : Context, solver : Solver, ast : Ast) : Void
  fun solver_check = Z3_solver_check(ctx : Context, solver : Solver) : LBool
  fun solver_get_model = Z3_solver_get_model(ctx : Context, solver : Solver) : Model
end

module Z3
  extend self

  Context = LibZ3.mk_context(LibZ3.mk_config)
  IntSort = LibZ3.mk_int_sort(Context)

  def mk_solver
    LibZ3.mk_solver(Context)
  end

  def mk_numeral(num, sort=IntSort)
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

# Setup library
solver = Z3.mk_solver

# Integer constants
nums = Hash(Int32, LibZ3::Ast).new
[0, 1, 9, 10, 100, 1000, 10000].each do |num|
  nums[num] = Z3.mk_numeral(num)
end

# Variables, all 0 to 9
vars = Hash(String, LibZ3::Ast).new
%w[s e n d m o r e m o n e y].uniq.each do |name|
  var = Z3.mk_const(name, Z3::IntSort)
  vars[name] = var
  Z3.solver_assert(solver, Z3.mk_ge(var, nums[0]))
  Z3.solver_assert(solver, Z3.mk_le(var, nums[9]))
end

# m and s need to be >= 1, no leading zeroes
Z3.solver_assert(solver, Z3.mk_ge(vars["m"], nums[1]))
Z3.solver_assert(solver, Z3.mk_ge(vars["s"], nums[1]))

# all letters represent different digits
Z3.solver_assert(solver, Z3.mk_distinct(vars.values))

# SEND + MORE = MONEY
send_sum = Z3.mk_add([
  Z3.mk_mul([vars["s"], nums[1000]]),
  Z3.mk_mul([vars["e"], nums[100]]),
  Z3.mk_mul([vars["n"], nums[10]]),
  vars["d"],
])

more_sum = Z3.mk_add([
  Z3.mk_mul([vars["m"], nums[1000]]),
  Z3.mk_mul([vars["o"], nums[100]]),
  Z3.mk_mul([vars["r"], nums[10]]),
  vars["e"],
])

money_sum = Z3.mk_add([
  Z3.mk_mul([vars["m"], nums[10000]]),
  Z3.mk_mul([vars["o"], nums[1000]]),
  Z3.mk_mul([vars["n"], nums[100]]),
  Z3.mk_mul([vars["e"], nums[10]]),
  vars["y"],
])

equation = Z3.mk_eq(Z3.mk_add([send_sum, more_sum]), money_sum)
Z3.solver_assert(solver, equation)

# Get the result
result_code = Z3.solver_check(solver)
puts "Result code is: #{result_code}"

model = Z3.solver_get_model(solver)
puts Z3.model_to_string(model)
