#!/usr/bin/sh
# TODO: Delete before merging.
echo '-- peg_parser_generator.rb --' &&
ruby -EUTF-8:UTF-8 peg_parser_generator.rb peg_parser_generator.peg > generated/peg_parser_generator.rb &&
echo '-- test_parser.rb --' &&
ruby -EUTF-8:UTF-8 generated/peg_parser_generator.rb test_parser.peg
