@[Link("z3")]
lib LibZ3
  alias CString = UInt8*
  type Ast = Void*
  type Config = Void*
  type Context = Void*
  type Model = Void*
  type Solver = Void*
  type Sort = Void*
  type Symbol = Void*

  enum LBool
    False = -1
    Undefined = 0
    True = 1
  end

  enum AstKind
    Numeral = 0
    App = 1
    Var = 2
    Quantifier = 3
    Sort = 4
    FuncDecl = 5
    Unknown = 1000
  end

  # This is incomplete
  enum SortKind
    Bool = 1
    Int = 2
    Real = 3
    Bitvec = 4
  end

  # Just list the ones we need, there's about 700 API calls total
  fun ast_to_string = Z3_ast_to_string(ctx : Context, ast : Ast) : CString
  fun get_ast_kind = Z3_get_ast_kind(ctx : Context, ast : Ast) : AstKind
  fun get_bv_sort_size = Z3_get_bv_sort_size(ctx : Context, sort : Sort) : UInt32
  fun get_numeral_string = Z3_get_numeral_string(ctx : Context, ast : Ast) : CString
  fun get_sort = Z3_get_sort(ctx : Context, ast : Ast) : Sort
  fun get_sort_kind = Z3_get_sort_kind(ctx : Context, sort : Sort) : SortKind
  fun get_version = Z3_get_version(v0 : UInt32*, v1 : UInt32*, v2 : UInt32*, v3 : UInt32*) : Void
  fun mk_add = Z3_mk_add(ctx : Context, count : UInt32, asts : Ast*) : Ast
  fun mk_and = Z3_mk_and(ctx : Context, count : UInt32, asts : Ast*) : Ast
  fun mk_bool_sort = Z3_mk_bool_sort(ctx : Context) : Sort
  fun mk_bv_sort = Z3_mk_bv_sort(ctx : Context, size : UInt32) : Sort
  fun mk_bvadd = Z3_mk_bvadd(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvand = Z3_mk_bvand(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvashr = Z3_mk_bvashr(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvlshr = Z3_mk_bvlshr(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvmul = Z3_mk_bvmul(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvnand = Z3_mk_bvnand(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvneg = Z3_mk_bvneg(ctx : Context, a : Ast) : Ast
  fun mk_bvnor = Z3_mk_bvnor(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvnot = Z3_mk_bvnot(ctx : Context, a : Ast) : Ast
  fun mk_bvor = Z3_mk_bvor(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvsdiv = Z3_mk_bvsdiv(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvsge = Z3_mk_bvsge(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvsgt = Z3_mk_bvsgt(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvshl = Z3_mk_bvshl(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvsle = Z3_mk_bvsle(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvslt = Z3_mk_bvslt(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvsmod = Z3_mk_bvsmod(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvsrem = Z3_mk_bvsrem(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvsub = Z3_mk_bvsub(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvudiv = Z3_mk_bvudiv(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvuge = Z3_mk_bvuge(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvugt = Z3_mk_bvugt(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvule = Z3_mk_bvule(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvult = Z3_mk_bvult(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvurem = Z3_mk_bvurem(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvxnor = Z3_mk_bvxnor(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_bvxor = Z3_mk_bvxor(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_concat = Z3_mk_concat(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_config = Z3_mk_config() : Config
  fun mk_const = Z3_mk_const(ctx : Context, name : Symbol, sort : Sort) : Ast
  fun mk_context = Z3_mk_context(cfg : Config) : Context
  fun mk_distinct = Z3_mk_distinct(ctx : Context, count : UInt32, asts : Ast*) : Ast
  fun mk_div = Z3_mk_div(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_eq = Z3_mk_eq(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_extract = Z3_mk_extract(ctx : Context, high : UInt32, low : UInt32, a : Ast) : Ast
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
  fun mk_numeral = Z3_mk_numeral(ctx : Context, s : CString, sort : Sort) : Ast
  fun mk_or = Z3_mk_or(ctx : Context, count : UInt32, asts : Ast*) : Ast
  fun mk_power = Z3_mk_power(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_real_sort = Z3_mk_real_sort(ctx : Context) : Sort
  fun mk_rem = Z3_mk_rem(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_rotate_left = Z3_mk_rotate_left(ctx : Context, n : UInt32, a : Ast) : Ast
  fun mk_rotate_right = Z3_mk_rotate_right(ctx : Context, n : UInt32, a : Ast) : Ast
  fun mk_sign_ext = Z3_mk_sign_ext(ctx : Context, n : UInt32, a : Ast) : Ast
  fun mk_solver = Z3_mk_solver(ctx : Context) : Solver
  fun mk_string_symbol = Z3_mk_string_symbol(ctx : Context, s : UInt8*) : Symbol
  fun mk_sub = Z3_mk_sub(ctx : Context, count : UInt32, asts : Ast*) : Ast
  fun mk_true = Z3_mk_true(ctx : Context) : Ast
  fun mk_unary_minus = Z3_mk_unary_minus(ctx : Context, a : Ast) : Ast
  fun mk_xor = Z3_mk_xor(ctx : Context, a : Ast, b : Ast) : Ast
  fun mk_zero_ext = Z3_mk_zero_ext(ctx : Context, n : UInt32, a : Ast) : Ast
  fun model_eval = Z3_model_eval(ctx : Context, model : Model, ast : Ast, complete : Bool, result : Ast*) : Bool
  fun model_to_string = Z3_model_to_string(ctx : Context, model : Model) : CString
  fun simplify = Z3_simplify(ctx : Context, ast : Ast) : Ast
  fun solver_assert = Z3_solver_assert(ctx : Context, solver : Solver, ast : Ast) : Void
  fun solver_check = Z3_solver_check(ctx : Context, solver : Solver) : LBool
  fun solver_get_model = Z3_solver_get_model(ctx : Context, solver : Solver) : Model
end
