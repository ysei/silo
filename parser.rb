require 'parslet'

module Silo
  class Parser < Parslet::Parser

    rule(:digit) { match('[0-9]') }
    rule(:integer) { digit.repeat(1) }
    rule(:float) { digit.repeat(1) >> str('.') >> digit.repeat(1) }
    rule(:number) { integer | float }
    root(:number)

  end
end
