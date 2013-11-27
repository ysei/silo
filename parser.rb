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

    rule(:assignment_operator) { space? >> str('=') >> space? }
    rule(:assignment) { variable >> assignment_operator >> expression }

    rule(:hash_assignment_operator) { str(':') >> space? }
    rule(:hash_assignment) { identifier >> hash_assignment_operator >> expression}
    rule(:hash) { str('{') >> (hash_assignment >> (argument_delimiter >> hash_assignment).repeat).maybe >> str('}') }

    rule(:array) { str('[') >> arguments.maybe >> str(']') }

    rule(:expression) { literal | method_call | variable | assignment | hash | array }

    rule(:body) { expression.repeat }
    root(:body)
  end
end
