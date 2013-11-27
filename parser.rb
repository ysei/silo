require 'parslet'

module Silo
  class Parser < Parslet::Parser

    rule(:space) { match(' ') }
    rule(:space?) { space.maybe }

    rule(:digit) { match('[0-9]') }
    rule(:integer) { digit.repeat(1) }
    rule(:float) { digit.repeat(1) >> str('.') >> digit.repeat(1) }
    rule(:number) { integer | float }

    rule(:quote) { str('"') }
    rule(:string) { quote >> (quote.absent? >> any).repeat >> quote }

    rule(:truth) { str('true') }
    rule(:falsehood) { str('false') }
    rule(:nope) { str('nope') }

    rule(:literal) { number | string | truth | falsehood | nope }

    rule(:identifier) { match('[a-zA-Z_]') >> match('\w').repeat }
    rule(:variable) { identifier >> (str('.') >> identifier).maybe }

    rule(:argument_delimiter) { str(",") >> space? }
    rule(:arguments) { expression >> (argument_delimiter >> expression).repeat }

    rule(:method_call) { variable >> str('(') >> arguments.maybe >> str(')') }

    rule(:assignment) { variable >> space? >> str('=') >> space? >> expression }

    rule(:expression) { literal | method_call | variable | assignment }

    rule(:body) { expression.repeat }
    root(:body)
  end
end
