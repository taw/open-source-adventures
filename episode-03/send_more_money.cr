#!/usr/bin/env crystal

require "./z3"

# Setup library
solver = Z3::Solver.new

# Variables, all 0 to 9
vars = Hash(Symbol, Z3::IntExpr).new
%i[s e n d m o r e m o n e y].uniq.each do |name|
  var = Z3::IntSort[name]
  vars[name] = var
  solver.assert var >= Z3::IntSort[0]
  solver.assert var <= Z3::IntSort[9]
end

# m and s need to be >= 1, no leading zeroes
solver.assert vars[:m] >= Z3::IntSort[1]
solver.assert vars[:s] >= Z3::IntSort[1]

# all letters represent different digits
solver.assert Z3.distinct(vars.values)

# SEND + MORE = MONEY
send_sum = (
  vars[:s] * Z3::IntSort[1000] +
  vars[:e] * Z3::IntSort[100] +
  vars[:n] * Z3::IntSort[10] +
  vars[:d]
)

more_sum = (
  vars[:m] * Z3::IntSort[1000] +
  vars[:o] * Z3::IntSort[100] +
  vars[:r] * Z3::IntSort[10] +
  vars[:e]
)

money_sum = (
  vars[:m] * Z3::IntSort[10000] +
  vars[:o] * Z3::IntSort[1000] +
  vars[:n] * Z3::IntSort[100] +
  vars[:e] * Z3::IntSort[10] +
  vars[:y]
)

solver.assert send_sum + more_sum == money_sum

# Get the result
result_code = solver.check
puts "Result code is: #{result_code}"
puts solver.model
