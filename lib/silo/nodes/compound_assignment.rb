module Silo
  module Nodes
    class CompoundAssignment

      def self.exec(left, right, op)
        old = Silo.variables[left.to_s]
        right = Silo.variables[right.to_s] unless right.is_a?(Fixnum)
        Silo.variables[left.to_s].send(op, right)
      end

    end
  end
end
