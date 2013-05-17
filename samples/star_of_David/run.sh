#!/bin/sh

ruby peg_parser_generator.rb samples/star_of_David/grammar.peg > generated/parser.rb &&
ruby generated/parser.rb samples/star_of_David/data.txt &&
echo "TEXT OBREZANY"