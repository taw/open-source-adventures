#!/usr/bin/env crystal

require "../src/z3"

# Setup library
solver = Z3::Solver.new

# Variables, all 0 to 9
vars = Hash(String, Z3::IntExpr).new
%w[s e n d m o r e m o n e y].uniq.each do |name|
  var = Z3::IntSort[name]
  vars[name] = var
  solver.assert 0 <= var
  solver.assert 9 >= var
end

# m and s need to be >= 1, no leading zeroes
solver.assert vars["m"] >= 1
solver.assert vars["s"] >= 1

# all letters represent different digits
solver.assert Z3.distinct(vars.values)

# SEND + MORE = MONEY
send_sum = (
  vars["s"] * 1000 +
  vars["e"] * 100 +
  vars["n"] * 10 +
  vars["d"]
)

more_sum = (
  vars["m"] * 1000 +
  vars["o"] * 100 +
  vars["r"] * 10 +
  vars["e"]
)

money_sum = (
  10000 * vars["m"] +
  1000 * vars["o"] +
  100 * vars["n"]+
  10 * vars["e"]+
  vars["y"]
)

solver.assert send_sum + more_sum == money_sum

# Get the result
puts solver.model
