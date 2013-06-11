#!/bin/sh

ruby peg_parser_generator.rb samples/C-like_preprocessor/grammar.peg > generated/preprocessor.rb &&
ruby generated/preprocessor.rb samples/C-like_preprocessor/input.txt
