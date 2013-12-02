module Silo
  module Nodes
    class Arithmetic

      def self.exec(left, right, op)
        return Silo.variables[left.to_s].send(op, right) unless left.is_a?(Fixnum)
        left.send(op, right)
      end

    end
  end
end
