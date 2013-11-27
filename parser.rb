require 'parslet'

module Silo
  class Parser < Parslet::Parser

    rule(:digit) { match('[0-9]') }
    rule(:integer) { digit.repeat(1) }
    rule(:float) { digit.repeat(1) >> str('.') >> digit.repeat(1) }
    rule(:number) { integer | float }

    rule(:quote) { str('"') }
    rule(:string) { quote >> (quote.absent? >> any).repeat >> quote }

    rule(:literal) { number | string }

    root(:literal)

  end
end
