#!/bin/sh

ruby peg2rb.rb samples/C-like_preprocessor/grammar.peg > generated/preprocessor.rb &&
ruby generated/preprocessor.rb samples/C-like_preprocessor/input.txt
