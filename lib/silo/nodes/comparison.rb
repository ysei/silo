require 'pry'

module Silo
  module Nodes
    class Comparison

      def self.exec(left, right, op)
        left = self.clean_side(left)
        right = self.clean_side(right)
        op = '==' if op == 'is'
        op = '!=' if op == 'isnt'
        left.send(op, right)
      end

      def self.clean_side(side)
        return Silo.variables[side] unless side.is_a?(Fixnum) || side.is_a?(String)
        side
      end

    end
  end
end
