#!/usr/bin/ruby

iteration = 0
generator = "peg_parser_generator.rb"
# 
10.times do
  #
  new_generator = "generated/peg_parser_generator#{iteration}.rb"
  # Generate the generator again!
  system %(ruby #{generator} peg_parser_generator.peg > #{new_generator}) or
    exit $?.exitstatus
  # Stop generating if new generators become the same.
  if File.read(new_generator) == File.read(generator)
    break
  end
  #
  generator = new_generator
end