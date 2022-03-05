module Z3
  module API
    extend self

    Context = LibZ3.mk_context(LibZ3.mk_config)

    {% for name in %w[
      mk_div
      mk_eq
      mk_false
      mk_ge
      mk_gt
      mk_iff
      mk_implies
      mk_ite
      mk_le
      mk_lt
      mk_mod
      mk_not
      mk_power
      mk_rem
      mk_solver
      mk_true
      mk_unary_minus
      mk_xor
      simplify
      solver_assert
      solver_check
      solver_get_model
    ] %}
      def {{name.id}}(*args)
        LibZ3.{{name.id}}(Context, *args)
      end
    {% end %}

    {% for name in %w[
      mk_add
      mk_and
      mk_distinct
      mk_mul
      mk_or
      mk_sub
    ] %}
      def {{name.id}}(asts)
        LibZ3.{{name.id}}(Context, asts.size, asts)
      end
    {% end %}

    def mk_numeral(num : Int, sort)
      LibZ3.mk_numeral(Context, num.to_s, sort)
    end

    def mk_const(name, sort)
      name_sym = LibZ3.mk_string_symbol(Context, name)
      var = LibZ3.mk_const(Context, name_sym, sort)
    end

    # Not a real Z3 function
    def mk_ne(a, b)
      LibZ3.mk_distinct(Context, 2, [a, b])
    end

    def model_to_string(model)
      String.new LibZ3.model_to_string(Context, model)
    end

    def ast_to_string(ast)
      String.new LibZ3.ast_to_string(Context, ast)
    end

    def model_eval(model, ast, complete)
      result = LibZ3.model_eval(Context, model, ast, complete, out result_ast)
      raise "Cannot evaluate" unless result == true
      # Full conversion is complicated, this is a good start
      s = ast_to_string result_ast
      if s =~ /\A\(- (\d+)\)\z/
        s = "-#{$1}"
      end
      s
    end
  end
end
