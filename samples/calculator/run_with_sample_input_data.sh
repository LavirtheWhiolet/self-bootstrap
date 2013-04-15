#!/bin/sh
mkdir -p generated
ruby -EUTF-8:UTF-8 -I. peg_parser_generator.rb samples/calculator/grammar.peg > generated/calculator.rb &&
ruby -EUTF-8:UTF-8 generated/calculator.rb samples/calculator/sample_input_data.txt
