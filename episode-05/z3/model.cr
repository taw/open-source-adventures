module Z3
  class Model
    def initialize(model : LibZ3::Model)
      @model = model
    end

    def eval(expr, complete=false)
      API.model_eval(@model, expr._expr, complete)
    end

    def [](expr)
      eval(expr)
    end

    # This needs to go eventually
    def to_s(io)
      io << API.model_to_string(@model).chomp
    end
  end
end
