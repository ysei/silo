require "spec_helper"

describe Silo do

  context ".exec" do

    it "should parse and transform the given input" do
      input = fixture('example.silo')
      expected = false
      expect(Silo.exec(input)).to eq(expected)
    end

  end

end
