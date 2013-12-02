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

    rule(:truth) { str('true').as(:true) }
    rule(:falsehood) { str('false').as(:false) }
    rule(:nope) { str('nope').as(:nope) }
    rule(:digit) { match['0-9'] }

    rule(:integer) { digit.repeat(1).as(:int) }
    rule(:float) { (digit.repeat(1) >> period >> digit.repeat(1)).as(:float) }

    rule(:number) { float | integer }
    rule(:string) { quote >> (quote.absent? >> any).repeat.as(:string) >> quote }

    rule(:literal) { number | string | truth | falsehood | nope }

    rule(:identifier) { match['a-zA-Z_'] >> match('\w').repeat }

    rule(:variable) { identifier >> (period >> identifier).maybe }

    rule(:arguments) { term >> (comma >> term).repeat }
    rule(:method_call) { variable.as(:method) >> lparen >> arguments.maybe.as(:args) >> rparen }

    rule(:hash_assignment) { identifier.as(:key) >> colon >> term.as(:value) }
    rule(:hash) { lbrace >> (hash_assignment >> (comma >> hash_assignment).repeat).maybe >> rbrace }

    rule(:array) { lbracket >> arguments.repeat.as(:array) >> rbracket }

    rule(:term) { literal | method_call | variable | hash | array }

    rule(:assignment_operator) { str('=') }
    rule(:arithmetic_operator) { match['-+*/%'] }
    rule(:comparison_operator) { match['><'] >> equals.maybe }
    rule(:equality_operator) { str('isnt') | str('is') | str('==') | str('!=') }
    rule(:compound_assignment_operator) { match['-+*/'] >> equals }
    rule(:operator) { compound_assignment_operator | equality_operator | comparison_operator | assignment_operator | arithmetic_operator }

    rule(:unary_operation) { (minus | bang) >> term }
    rule(:binary_operation) { term.as(:left) >> space? >> operator.as(:op) >> space? >> term.as(:right) }
    rule(:operation) { unary_operation | binary_operation }

    rule(:expression) { operation | term }
    root :expression
  end
end
