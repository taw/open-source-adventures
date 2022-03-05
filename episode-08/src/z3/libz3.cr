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
  fun ast_to_string = Z3_ast_to_string(ctx : Context, ast : Ast) : UInt8*
  fun mk_add = Z3_mk_add(ctx : Context, count : UInt32, asts : Ast*) : Ast
  fun mk_and = Z3_mk_and(ctx : Context, count : UInt32, asts : Ast*) : Ast
  fun mk_bool_sort = Z3_mk_bool_sort(ctx : Context) : Sort
  fun mk_config = Z3_mk_config() : Config
  fun mk_const = Z3_mk_const(ctx : Context, name : Symbol, sort : Sort) : Ast
  fun mk_context = Z3_mk_context(cfg : Config) : Context
  fun mk_distinct = Z3_mk_distinct(ctx : Context, count : UInt32, asts : Ast*) : Ast
  fun mk_div = Z3_mk_div(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_eq = Z3_mk_eq(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_false = Z3_mk_false(ctx : Context) : Ast
  fun mk_ge = Z3_mk_ge(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_gt = Z3_mk_gt(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_iff = Z3_mk_iff(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_implies = Z3_mk_implies(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_int_sort = Z3_mk_int_sort(ctx : Context) : Sort
  fun mk_ite = Z3_mk_ite(ctx : Context, a : Ast, b : Ast, c : Ast) : Ast
  fun mk_le = Z3_mk_le(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_lt = Z3_mk_lt(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_mod = Z3_mk_mod(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_mul = Z3_mk_mul(ctx : Context, count : UInt32, asts : Ast*) : Ast
  fun mk_not = Z3_mk_not(ctx : Context, a : Ast) : Ast
  fun mk_numeral = Z3_mk_numeral(ctx : Context, s : UInt8*, sort : Sort) : Ast
  fun mk_or = Z3_mk_or(ctx : Context, count : UInt32, asts : Ast*) : Ast
  fun mk_power = Z3_mk_power(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_rem = Z3_mk_rem(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_solver = Z3_mk_solver(ctx : Context) : Solver
  fun mk_string_symbol = Z3_mk_string_symbol(ctx : Context, s : UInt8*) : Symbol
  fun mk_sub = Z3_mk_add(ctx : Context, count : UInt32, asts : Ast*) : Ast
  fun mk_true = Z3_mk_true(ctx : Context) : Ast
  fun mk_unary_minus = Z3_mk_unary_minus(ctx : Context, a : Ast) : Ast
  fun mk_xor = Z3_mk_xor(ctx : Context, a : Ast, b : Ast) : Ast
  fun model_eval = Z3_model_eval(ctx : Context, model : Model, ast : Ast, complete : Bool, result : Ast*) : Bool
  fun model_to_string = Z3_model_to_string(ctx : Context, model : Model) : UInt8*
  fun simplify = Z3_simplify(ctx : Context, ast : Ast) : Ast
  fun solver_assert = Z3_solver_assert(ctx : Context, solver : Solver, ast : Ast) : Void
  fun solver_check = Z3_solver_check(ctx : Context, solver : Solver) : LBool
  fun solver_get_model = Z3_solver_get_model(ctx : Context, solver : Solver) : Model
end
