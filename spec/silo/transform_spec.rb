require "spec_helper"

describe Silo::Transform do

  let(:parser) { described_class.new }

  context "values" do

    it "should return an integer" do
      expect(parser.apply(int: '1')).to eq(1)
    end

    it "should return an float" do
      expect(parser.apply(float: '1.3')).to eq(1.3)
    end

    it "should return a string" do
      expect(parser.apply(string: 'foo')).to eq('foo')
    end

    it "should return false" do
      expect(parser.apply(false: 'false')).to eq(false)
    end

    it "should return true" do
      expect(parser.apply(true: 'true')).to eq(true)
    end

    it "should return nope" do
      expect(parser.apply(nope: 'nope')).to eq(nil)
    end

    it "should return a hash" do
      expect(parser.apply({key: "a key", value: "a value"})).to eq({"a key" => "a value"})
    end

  end

  context "addition" do

    it "should add some things together" do
      expect(parser.apply(left: {int: '1'}, right: {int: '3'}, op: '+')).to eq(4)
    end

  end

  context "subtraction" do

    it "should subtract some things" do
      expect(parser.apply(left: {int: '1'}, right: {int: '3'}, op: '-')).to eq(-2)
    end

  end

  context "multiplication" do

    it "should multiply some things together" do
      expect(parser.apply(left: {int: '400'}, right: {int: '200'}, op: '*')).to eq(80_000)
    end

  end

  context "division" do

    it "should divide some things" do
      expect(parser.apply(left: {int: '800'}, right: {int: '8'}, op: '/')).to eq(100)
    end

  end

  context "modulus" do

    it "should return the remainder of a division operation" do
      expect(parser.apply(left: {int: '3'}, right: {int: '2'}, op: '%')).to eq(1)
    end

  end

  context "comparison" do

    it "should return the result of the comparison" do
      expect(parser.apply(left: {int: '3'}, right: {int: '2'}, op: '<')).to eq(false)
      expect(parser.apply(left: {int: '3'}, right: {int: '2'}, op: '>')).to eq(true)
      expect(parser.apply(left: {int: '3'}, right: {int: '2'}, op: '<=')).to eq(false)
      expect(parser.apply(left: {int: '3'}, right: {int: '3'}, op: '<=')).to eq(true)
      expect(parser.apply(left: {int: '3'}, right: {int: '2'}, op: '>=')).to eq(true)
      expect(parser.apply(left: {int: '3'}, right: {int: '3'}, op: '>=')).to eq(true)
    end

  end

  context "equality" do

    it "should return the result of the comparison" do
      expect(parser.apply(left: {string: 'hey'}, right: {string: 'hey'}, op: '==')).to eq(true)
      expect(parser.apply(left: {string: 'foo'}, right: {string: 'bar'}, op: '==')).to eq(false)
      expect(parser.apply(left: {string: 'hey'}, right: {string: 'hey'}, op: '!=')).to eq(false)
      expect(parser.apply(left: {string: 'foo'}, right: {string: 'bar'}, op: '!=')).to eq(true)
      expect(parser.apply(left: {string: 'hey'}, right: {string: 'hey'}, op: 'is')).to eq(true)
      expect(parser.apply(left: {string: 'foo'}, right: {string: 'bar'}, op: 'is')).to eq(false)
      expect(parser.apply(left: {string: 'hey'}, right: {string: 'hey'}, op: 'isnt')).to eq(false)
      expect(parser.apply(left: {string: 'foo'}, right: {string: 'bar'}, op: 'isnt')).to eq(true)
    end

  end

end
