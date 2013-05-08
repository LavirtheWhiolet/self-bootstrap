#!/bin/sh
ruby peg_parser_generator.rb samples/parser_xml_s_kwadratny_skobkamy/grammar.peg > generated/parser.rb &&
ruby generated/parser.rb samples/parser_xml_s_kwadratny_skobkamy/sample_input.txt