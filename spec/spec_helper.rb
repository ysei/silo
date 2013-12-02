require "parslet/rig/rspec"
require "silo"

def fixture(filename)
  File.read("spec/fixtures/#{filename}")
end
