#!/usr/bin/env crystal

require "z3"

class MosaicSolver
  @data : Array(Array(Nil | Int32))
  @ysize : Int32
  @xsize : Int32

  def initialize(path)
    @data = File.read_lines(path).map{|l| l.chars.map{|c| c.ascii_number? ? c.to_i : nil}}
    @ysize = @data.size
    @xsize = @data[0].size
    @solver = Z3::Solver.new
    @vars = {} of Tuple(Int32, Int32) => Z3::BoolExpr
  end

  def each_coord
    @ysize.times do |y|
      @xsize.times do |x|
        yield(x, y)
      end
    end
  end

  def neighbourhood(x, y)
    [
      @vars[{x, y+1}]?,
      @vars[{x, y}]?,
      @vars[{x, y-1}]?,
      @vars[{x+1, y+1}]?,
      @vars[{x+1, y}]?,
      @vars[{x+1, y-1}]?,
      @vars[{x-1, y+1}]?,
      @vars[{x-1, y}]?,
      @vars[{x-1, y-1}]?,
    ].compact
  end

  def neighbourhood_count(x, y)
    neighbourhood(x, y).map{|v| v.ite(1, 0)}.reduce{|a,b| a+b}
  end

  def call
    each_coord do |x, y|
      @vars[{x, y}] = Z3.bool("#{x},#{y}")
    end
    each_coord do |x, y|
      c = @data[y][x]
      if c
        @solver.assert neighbourhood_count(x, y) == c
      end
    end
    if @solver.check
      model = @solver.model
      @ysize.times do |y|
        @xsize.times do |x|
          v = (model[@vars[{x, y}]].to_s == "true")
          c = @data[y][x] || " "
          if v
            print "\e[30;104m"
          else
            print "\e[30;102m"
          end
          print c
        end
        print "\e[0m"
        print "\n"
      end
    else
      puts "No solution"
    end
  end
end

solver = MosaicSolver.new(ARGV[0])
solver.call
