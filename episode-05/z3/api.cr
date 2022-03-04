module Z3
  module API
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

    def mk_div(a, b)
      LibZ3.mk_div(Context, a, b)
    end

    def mk_add(asts)
      LibZ3.mk_add(Context, asts.size, asts)
    end

    def mk_mul(asts)
      LibZ3.mk_mul(Context, asts.size, asts)
    end

    def mk_sub(asts)
      LibZ3.mk_add(Context, asts.size, asts)
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

    def ast_to_string(ast)
      String.new LibZ3.ast_to_string(Context, ast)
    end

    def model_eval(model, ast, complete)
      result_ptr = Pointer(LibZ3::Ast).malloc
      result = LibZ3.model_eval(Context, model, ast, complete, result_ptr)
      raise "Cannot evaluate" unless result == true
      # Full conversion is complicated, this is a good start
      ast_to_string result_ptr[0]
    end
  end
end
