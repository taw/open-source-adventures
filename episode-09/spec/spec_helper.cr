require "spec"
require "../src/z3"

class SolutionExpectation(T)
  def initialize(@expected : Hash(T, String))
  end

  def setup_solver(asts)
    solver = Z3::Solver.new
    asts.each do |ast|
      solver.assert(ast)
    end
    solver
  end

  def match(asts)
    solver = setup_solver(asts)
    return false unless solver.satisfiable?
    model = solver.model
    @expected.each do |ast, expected_value|
      return false unless model[ast] == expected_value
    end
    true
  end

  def failure_message(asts)
    solver = setup_solver(asts)
    unless solver.satisfiable?
      return "Expected #{asts.inspect} to have a solution, but no solution was found"
    end
    model = solver.model
    "Solution found, but it does not match expectations:\n" +
    @expected.map do |ast, expected_value|
      "#{asts} (actual #{model[ast]}, expected #{expected_value})"
    end.join("\n")
  end
end

module Spec::Expectations
  def have_solution(solution)
    SolutionExpectation.new solution.transform_values(&.to_s)
  end
end
