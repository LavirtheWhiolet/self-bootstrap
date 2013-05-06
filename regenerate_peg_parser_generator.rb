#!/usr/bin/ruby

iteration = 0
generator = "peg_parser_generator.rb"
10.times do
  new_generator = "generated/peg_parser_generator#{iteration}.rb"
  system %(ruby #{generator} peg_parser_generator.peg > #{new_generator}) or
    exit $?.exitstatus
end