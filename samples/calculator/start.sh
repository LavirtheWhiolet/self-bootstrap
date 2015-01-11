#!/bin/sh
ruby -EUTF-8:UTF-8 peg2rb.rb samples/calculator/grammar.peg > generated/calculator.rb &&
ruby -EUTF-8:UTF-8 generated/calculator.rb

