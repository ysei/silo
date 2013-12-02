module Silo
  module Nodes
  end
end

Dir.glob("#{File.join(File.dirname(__FILE__), "nodes", "*.rb")}").each do |file|
  require file
end
