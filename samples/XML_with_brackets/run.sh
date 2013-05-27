#!/bin/sh

dir=samples/XML_with_brackets
parser=generated/parser.rb

ruby peg_parser_generator.rb ${dir}/grammar.peg > ${parser} &&
(
  file=${dir}/sample_input.txt
  echo "${file}: " && ruby ${parser} ${file}
  file=${dir}/bad_sample_input.txt
  echo "${file}: " && ruby ${parser} ${file}
)