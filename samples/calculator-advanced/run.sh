#!/bin/sh
ruby -EUTF-8:UTF-8 -I. peg2rb.rb samples/calculator-advanced/grammar.peg > generated/calculator-advanced.rb &&
ruby -EUTF-8:UTF-8 generated/calculator-advanced.rb samples/calculator-advanced/input.txt
