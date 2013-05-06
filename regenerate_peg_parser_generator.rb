#!/usr/bin/ruby

generator = "peg_parser_generator.rb"
# Generate new parser generator.
10.times do |iteration|
  #
  new_generator = "generated/peg_parser_generator#{iteration}.rb"
  # Generate yet another generator!
  system %(ruby #{generator} peg_parser_generator.peg > #{new_generator}) or
    exit $?.exitstatus
  # Stop generating if new generators become the same.
  if File.read(new_generator) == File.read(generator)
    break
  end
  #
  generator = new_generator
end