require_relative 'parser'
require 'rspec'
require 'parslet/rig/rspec'

describe Silo::Parser do

  let(:parser) { described_class.new }

  context "digit" do

    it "should consume digits" do
      parser.digit.should parse('0')
      parser.digit.should parse('4')
      parser.digit.should parse('6')
    end

  end

  context "integer" do

    it "should consume integers" do
      parser.integer.should parse('0')
      parser.integer.should parse('123')
      parser.integer.should parse('78128391')
    end

  end

  context "float" do

    it "should consume floats" do
      parser.float.should parse('0.0')
      parser.float.should parse('123.45')
      parser.float.should parse('78128391.993')
    end

  end

  context "number" do

    it "should consume integers" do
      parser.number.should parse('0')
      parser.number.should parse('123')
      parser.number.should parse('78128391')
    end

    it "should consume floats" do
      parser.number.should parse('0.0')
      parser.number.should parse('123.45')
      parser.number.should parse('78128391.993')
    end

  end

  context "quote" do

    it "should consume quotation marks" do
      parser.quote.should parse('"')
    end

  end

  context "string" do

    it "should consume empty strings" do
      parser.string.should parse('""')
    end

    it "should consume strings" do
      parser.string.should parse('"Kill all the humans"')
      parser.string.should parse('"No but seriously"')
    end

  end

  context "literal" do

    it "should consume numbers" do
      parser.literal.should parse('781287391.9912')
    end

    it "should consume strings" do
      parser.literal.should parse('"Kill all the humans"')
    end

  end

end

RSpec::Core::Runner.run []
