require "parslet"
require "silo/parser"
require "silo/transform"

module Silo

  Error = Class.new StandardError
  ParseError = Class.new Error
  TransformError = Class.new Error

  attr_accessor :variables

  def self.variables
    @variables ||= {}
  end

  def self.exec(str)
    Array(Transform.new.apply(Parser.new.expressions.parse(str.chomp))).last
  rescue Parslet::ParseFailed => e
    deepest = deepest_cause e.cause
    line, column = deepest.source.line_and_column(deepest.pos)
    raise ParseError, "unexpected input at line #{line} column #{column}"
  end

  def self.deepest_cause(cause)
    if cause.children.any?
      deepest_cause(cause.children.first)
    else
      cause
    end
  end
  
end
