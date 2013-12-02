require 'parslet'

module Silo
  class Parser < Parslet::Parser
    rule(:space) { str(' ') }
    rule(:space?) { space.maybe }
    rule(:quote) { str('"') }
    rule(:comma) { str(",") >> space? }
    rule(:lparen) { str('(') >> space? }
    rule(:rparen) { space? >> str(')') }
    rule(:lbracket) { str('[') >> space? }
    rule(:rbracket) { space? >> str(']') }
    rule(:lbrace) { str('{') >> space? }
    rule(:rbrace) { space? >> str('}') }
    rule(:period) { str('.') }
    rule(:colon) { str(':') >> space? }
    rule(:equals) { str('=') }
    rule(:minus) { str('-') }
    rule(:bang) { str('!') }

    rule(:truth) { str('true') }
    rule(:falsehood) { str('false') }
    rule(:nope) { str('nope') }
    rule(:digit) { match['0-9'] }

    rule(:integer) { digit.repeat(1) }
    rule(:float) { digit.repeat(1) >> period >> digit.repeat(1) }

    rule(:number) { integer | float }
    rule(:string) { quote >> (quote.absent? >> any).repeat >> quote }

    rule(:literal) { number | string | truth | falsehood | nope }

    rule(:identifier) { match['a-zA-Z_'] >> match('\w').repeat }

    rule(:variable) { identifier >> (period >> identifier).maybe }

    rule(:arguments) { term >> (comma >> term).repeat }
    rule(:method_call) { variable >> lparen >> arguments.maybe >> rparen }

    rule(:assignment) { variable >> space? >> equals >> space? >> term }

    rule(:hash_assignment) { identifier >> colon >> expression }
    rule(:hash) { lbrace >> (hash_assignment >> (comma >> hash_assignment).repeat).maybe >> rbrace }

    rule(:array) { lbracket >> arguments.maybe >> rbracket }

    rule(:term) { literal | method_call | variable | assignment | hash | array }

    rule(:arithmetic_operator) { match['-+*/%'] }
    rule(:comparison_operator) { match['><'] >> equals.maybe }
    rule(:equality_operator) { str('isnt') | str('is') | str('==') | str('!=') }
    rule(:compound_assignment_operator) { match['-+*/'] >> equals }
    rule(:operator) { compound_assignment_operator | arithmetic_operator | comparison_operator | equality_operator }

    rule(:unary_operation) { (minus | bang) >> term }
    rule(:binary_operation) { term >> space? >> operator >> space? >> term }
    rule(:operation) { unary_operation | binary_operation }

    rule(:expression) { term | operation }
    root :expression
  end
end
