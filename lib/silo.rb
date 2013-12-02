require "parslet"
require "silo/parser"
require "silo/transform"

module Silo

  Error = Class.new StandardError
  ParseError = Class.new Error
  TransformError = Class.new Error

  def self.exec(str)
    Transform.new.apply(Parser.new.expression.parse(str))
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
