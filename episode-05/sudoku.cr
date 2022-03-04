#!/usr/bin/env crystal

require "./z3"

class SudokuSolver
  def initialize(path)
    @data = Array(Array(Int32 | Nil)).new
    @cells = Array(Array(Z3::IntExpr)).new
    @data = read_data(path)
    @solver = Z3::Solver.new
  end

  def call
    @cells = (0..8).map do |j|
      (0..8).map do |i|
        cell_var(@data[j][i], i, j)
      end
    end

    @cells.each do |row|
      @solver.assert Z3.distinct(row)
    end

    @cells.transpose.each do |column|
      @solver.assert Z3.distinct(column)
    end

    @cells.each_slice(3) do |rows|
      rows.transpose.each_slice(3) do |square|
        @solver.assert Z3.distinct(square.flatten)
      end
    end

    if @solver.satisfiable?
      print_answer
    else
      puts "failed to solve"
    end
  end

  def read_data(path)
    File.read_lines(path).map do |line|
      line.split.map{|c| c == "_" ? nil : c.to_i}
    end
  end

  def cell_var(cell, i, j)
    v = Z3::IntSort["cell[#{i+1},#{j+1}]"]
    @solver.assert v >= 1
    @solver.assert v <= 9
    @solver.assert v == cell if cell
    v
  end

  def print_answer
    model = @solver.model
    @cells.each do |row|
      puts row.map{|v| model[v]}.join(" ")
    end
  end
end

path = ARGV[0]? || "./sudoku-1.txt"
SudokuSolver.new(path).call
