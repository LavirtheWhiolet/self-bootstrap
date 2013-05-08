#!/bin/sh

dir=samples/parser_xml_s_kwadratny_skobkamy
parser=generated/parser.rb

ruby peg_parser_generator.rb ${dir}/grammar.peg > ${parser} &&
(
  ruby ${parser} ${dir}/sample_input.txt
  ruby ${parser} ${dir}/bad_sample_input.txt
)