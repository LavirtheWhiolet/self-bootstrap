#!/bin/sh

dir=samples/XML_with_brackets
parser=generated/parser.rb

ruby peg_parser_generator.rb ${dir}/grammar.peg > ${parser} &&
(
  ruby ${parser} ${dir}/input.txt
  ruby ${parser} ${dir}/bad_input.txt
)