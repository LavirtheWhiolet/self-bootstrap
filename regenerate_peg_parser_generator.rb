#!/usr/bin/ruby
# encoding: UTF-8

def make_line_endings_unix_style(file)
  File.binwrite(file,
    File.binread(file).
      gsub("\r\n", "\n").
      gsub("\r", "\n")
  )
end

begin
  source_generator = "peg_parser_generator.rb"
  10.times do |iteration|
    new_generator = "generated/peg_parser_generator#{iteration}.rb"
    system %(ruby #{source_generator} peg_parser_generator.peg > #{new_generator}) or
      exit $?.exitstatus
    make_line_endings_unix_style(new_generator)
    if File.binread(new_generator) == File.binread(source_generator)
      break
    end
    source_generator = new_generator
  end
end
