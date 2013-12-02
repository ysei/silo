require_relative './parser'
require 'parslet'
require 'pry'

module Silo
  class Transformer < Parslet::Transform
    rule(:int => simple(:int))            { Integer(int) }
    rule(:float => simple(:float))        { Float(float) }
    rule(:string => simple(:string))      { string }
    rule(:true => simple(:true))          { true }
    rule(:false => simple(:false))        { false }
    rule(:nope => simple(:nope))          { nil }

    # Arrays
    rule(:array => subtree(:a))           { a }

    # Hashes
    rule(
      :key => simple(:key),
      :value => subtree(:value))          {{ key.to_s => value }}

    # Assignment
    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => '=')                         { instance_variable_set("@#{left}", right) }

    # Comparison
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

    # Equality
    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => '==')                         { left == right }

    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => '!=')                         { left != right }

    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => 'is')                         { left == right }

    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => 'isnt')                         { left != right }

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
