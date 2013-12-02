module Silo
  module Nodes
    class Assignment

      def self.exec(var, val) 
        Silo.variables[var.to_s] = val
      end

    end
  end
end
