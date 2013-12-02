require_relative './parser'
require 'parslet'
require 'pry'

module Silo
  class Transformer < Parslet::Transform
    rule(:int => simple(:int))            { Integer(int) }
    rule(:float => simple(:float))        { Float(float) }
    rule(:true => simple(:true))          { true }
    rule(:false => simple(:false))        { false }
    rule(:nope => simple(:nope))          { nil }

    # Assignment
    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => '=')                         { instance_variable_set("@#{left}", right) }

    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => '>')                         { left > right }

    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => '<')                         { left < right }

    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => '>=')                         { left >= right }

    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => '<=')                         { left <= right }

    # Arithmetic
    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => simple(:op))                 { left.send(op, right) }

    def noop
      return "noop"
    end
  end
end
