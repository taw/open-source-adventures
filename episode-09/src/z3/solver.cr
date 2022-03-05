module Z3
  class Solver
    def initialize
      @solver = API.mk_solver
      @model = nil
      @check = nil
    end

    def assert(expr)
      @model = nil
      @check = nil
      API.solver_assert(@solver, expr._expr)
    end

    def check
      @check = API.solver_check(@solver)
    end

    def model
      @model ||= begin
        check unless @check
        raise Z3::Exception.new("Model not satisfiable") unless @check == LibZ3::LBool::True
        Model.new(API.solver_get_model(@solver))
      end
    end

    def satisfiable?
      case check
      when LibZ3::LBool::True
        true
      when LibZ3::LBool::False
        false
      else
        raise Z3::Exception.new("Unknown result")
      end
    end
  end
end
