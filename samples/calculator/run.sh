#!/bin/sh
ruby -EUTF-8:UTF-8 -I. peg2rb.rb samples/calculator/grammar.peg > generated/calculator.rb &&
ruby -EUTF-8:UTF-8 generated/calculator.rb samples/calculator/input.txt
