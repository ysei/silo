require 'silo/nodes'

module Silo

  class Transform < Parslet::Transform
    include Silo::Nodes
    rule(:int => simple(:int))            { Integer(int) }
    rule(:float => simple(:float))        { Float(float) }
    rule(:string => simple(:string))      { string.to_s }
    rule(:true => simple(:true))          { true }
    rule(:false => simple(:false))        { false }
    rule(:nope => simple(:nope))          { nil }

    # Arrays
    rule(:array => simple(:a))            { [] }
    rule(:array => subtree(:a))           { a }

    # Hashes
    rule(
      :key => simple(:key),
      :value => subtree(:value))          {{ key.to_s => value }}

    # Assignment
    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => '=')                         { Assignment.exec(left, right) }

    # Compound assignment
    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => '-=')                        { CompoundAssignment.exec(left, right, '-')}

    # Comparison
    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => '>')                         { Comparison.exec(left, right, '>') }

    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => '<')                         { Comparison.exec(left, right, '<') }

    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => '>=')                         { Comparison.exec(left, right, '>=') }

    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => '<=')                         { Comparison.exec(left, right, '<=') }

    # Equality
    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => '==')                         { Comparison.exec(left, right, '==') }

    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => '!=')                         { Comparison.exec(left, right, '!=') }

    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => 'is')                         { Comparison.exec(left, right, 'is') }

    rule(
      :left => simple(:left),
      :right => simple(:right),
      :op => 'isnt')                       { Comparison.exec(left, right, 'isnt') }

    # Arithmetic
    rule(
      :left => subtree(:left),
      :right => subtree(:right),
      :op => simple(:op))                   { Arithmetic.exec(left, right, op) }

  end

end
