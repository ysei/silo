require 'parslet'

module Silo
  class Parser < Parslet::Parser

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

    rule(:expression) { literal | variable }

    root(:expression)
  end
end
