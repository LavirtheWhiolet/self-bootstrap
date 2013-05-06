#!/usr/bin/ruby

generator = "peg_parser_generator.rb"
10.times do |iteration|
  new_generator = "generated/peg_parser_generator#{iteration}.rb"
  system %(ruby #{generator} peg_parser_generator.peg > #{new_generator}) or
    exit $?.exitstatus
  break if File.read(new_generator) == File.read(generator)
  generator = new_generator
end