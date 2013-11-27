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

  context "other literals" do

    context "truth" do

      it "should consume true" do
        parser.truth.should parse('true')
      end

    end

    context "falsehood" do

      it "should consume falsehood" do
        parser.falsehood.should parse('false')
      end

    end

    context "nope" do

      it "should consume nope" do
        parser.nope.should parse('nope')
      end

    end

  end

  context "literal" do

    it "should consume numbers" do
      parser.literal.should parse('781287391.9912')
      parser.literal.should parse('0')
    end

    it "should consume strings" do
      parser.literal.should parse('"Kill all the humans"')
      parser.literal.should parse('""')
    end

    it "should consume the other literals" do
      parser.literal.should parse('true')
      parser.literal.should parse('false')
      parser.literal.should parse('nope')
    end

  end

  context "identifier" do

    it "should consume valid identifier names" do
      parser.identifier.should parse('b')
      parser.identifier.should parse('banana')
      parser.identifier.should parse('mango')
      parser.identifier.should parse('_cherry')

      parser.identifier.should_not parse('$cherry')
      parser.identifier.should_not parse('_%')
    end

  end

  context "variable" do

    it "should consume identifiers" do
      parser.variable.should parse('b')
      parser.variable.should parse('_')
      parser.variable.should_not parse('$b')
    end

    it "shoudl also consume properties of variables" do
      parser.variable.should parse('b.banana')
      parser.variable.should parse('_._')
      parser.variable.should_not parse('b.$banana')
    end

  end

  context "expression" do

    it "should consume literals" do
      parser.expression.should parse("81923.123")
      parser.expression.should parse("1")
      parser.expression.should parse('"If you cannot do great things, do small things in a great way."')
      parser.expression.should parse('""')
      parser.expression.should parse("true")
      parser.expression.should parse("false")
      parser.expression.should parse("nope")
    end

    it "should consume variables" do
      parser.expression.should parse('_cherry')
      parser.expression.should parse('b.banana')
      parser.expression.should parse('_')
      parser.expression.should parse('Yes')
      parser.expression.should parse('Yes._no')
      parser.expression.should parse('mAybe._')
    end

  end

end

RSpec::Core::Runner.run []
