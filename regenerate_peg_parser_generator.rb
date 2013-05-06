#!/usr/bin/ruby

def make_line_endings_unix_style(file)
  content = File.read(file).gsub("\r\n", "\n").gsub("\r", "\n")
end

begin
  source_generator = "peg_parser_generator.rb"
  10.times do |iteration|
    new_generator = "generated/peg_parser_generator#{iteration}.rb"
    system %(ruby #{source_generator} peg_parser_generator.peg > #{new_generator}) or
      exit $?.exitstatus
    make_line_endings_unix_style(new_generator)
    break if File.read(new_generator) == File.read(source_generator)
    source_generator = new_generator
  end
end
