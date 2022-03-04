#!/usr/bin/env crystal

@[Link("z3")]
lib Z3
  type Ast = Void*
  type Config = Void*
  type Context = Void*
  type Model = Void*
  type Solver = Void*
  type Sort = Void*
  type Symbol = Void*

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
  fun solver_check = Z3_solver_check(ctx : Context, solver : Solver) : Int32
  fun solver_get_model = Z3_solver_get_model(ctx : Context, solver : Solver) : Model
end

# Setup library
cfg = Z3.mk_config()
ctx = Z3.mk_context(cfg)
solver = Z3.mk_solver(ctx)
int_sort = Z3.mk_int_sort(ctx)

# Integer constants
nums = Hash(Int32, Z3::Ast).new
[0, 1, 9, 10, 100, 1000, 10000].each do |num|
  nums[num] = Z3.mk_numeral(ctx, num.to_s, int_sort)
end

# Variables, all 0 to 9
vars = Hash(String, Z3::Ast).new
%w[s e n d m o r e m o n e y].uniq.each do |name|
  name_sym = Z3.mk_string_symbol(ctx, name)
  var = Z3.mk_const(ctx, name_sym, int_sort)
  vars[name] = var
  Z3.solver_assert(ctx, solver, Z3.mk_ge(ctx, var, nums[0]))
  Z3.solver_assert(ctx, solver, Z3.mk_le(ctx, var, nums[9]))
end

# m and s need to be >= 1, no leading zeroes
Z3.solver_assert(ctx, solver, Z3.mk_ge(ctx, vars["m"], nums[1]))
Z3.solver_assert(ctx, solver, Z3.mk_ge(ctx, vars["s"], nums[1]))

# all letters represent different digits
all_distinct = Z3.mk_distinct(ctx, vars.size, vars.values)
Z3.solver_assert(ctx, solver, all_distinct)

# SEND + MORE = MONEY
send_vars = [
  Z3.mk_mul(ctx, 2, [vars["s"], nums[1000]]),
  Z3.mk_mul(ctx, 2, [vars["e"], nums[100]]),
  Z3.mk_mul(ctx, 2, [vars["n"], nums[10]]),
  vars["d"],
]

more_vars = [
  Z3.mk_mul(ctx, 2, [vars["m"], nums[1000]]),
  Z3.mk_mul(ctx, 2, [vars["o"], nums[100]]),
  Z3.mk_mul(ctx, 2, [vars["r"], nums[10]]),
  vars["e"],
]

money_vars = [
  Z3.mk_mul(ctx, 2, [vars["m"], nums[10000]]),
  Z3.mk_mul(ctx, 2, [vars["o"], nums[1000]]),
  Z3.mk_mul(ctx, 2, [vars["n"], nums[100]]),
  Z3.mk_mul(ctx, 2, [vars["e"], nums[10]]),
  vars["y"],
]

send_sum = Z3.mk_add(ctx, send_vars.size, send_vars)
more_sum = Z3.mk_add(ctx, more_vars.size, more_vars)
money_sum = Z3.mk_add(ctx, money_vars.size, money_vars)
send_more_sum = Z3.mk_add(ctx, 2, [send_sum, more_sum])
equation = Z3.mk_eq(ctx, send_more_sum, money_sum)
Z3.solver_assert(ctx, solver, equation)

# Get the result

result_code = Z3.solver_check(ctx, solver)
puts "Result code is: #{result_code}"

model = Z3.solver_get_model(ctx, solver)
s = Z3.model_to_string(ctx, model)
puts String.new(s)
