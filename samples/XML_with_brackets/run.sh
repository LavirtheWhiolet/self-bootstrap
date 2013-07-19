#!/bin/sh

dir=samples/XML_with_brackets
parser=generated/bracketed_XML.rb

ruby peg2rb.rb ${dir}/grammar.peg > ${parser} &&
(
  ruby ${parser} ${dir}/input.txt
  ruby ${parser} ${dir}/bad_input.txt
)
