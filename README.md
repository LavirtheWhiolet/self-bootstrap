Self-bootstrap
==============

<a id="peg2rb.rb"/> peg2rb.rb
-----------------------------

















































Parser generator. It generates [parser](#output-parser) based on a [grammar description](#input-grammar) (which is extended version of [PEG](http://en.wikipedia.org/wiki/Parsing_expression_grammar)).

### Requirements ###

* [Ruby 1.9 or higher](http://ruby-lang.org)

### Usage ###

You may run this program with the following command of [Bourne shell](http://en.wikipedia.org/wiki/Bourne_shell) or [Command Prompt](http://en.wikipedia.org/wiki/CMD.EXE_%28Windows%29):

    ruby peg2rb.rb input-grammar > output-parser

where `input-grammar` is a file with [input grammar description](#input-grammar) and `output-parser` is a file with [parser](#output-parser) based on the grammar.

The program exits with [status](http://en.wikipedia.org/wiki/Exit_status) 0 if the parser is generated successfully and with non-zero status otherwise.

### <a id="input-grammar"/> Input grammars ###

Input grammars are described in extended version of [PEG](http://en.wikipedia.org/wiki/Parsing_expression_grammar). Grammar of the extended PEG is described in [peg2rb.peg](#peg2rb.peg) in terms of the extended PEG itself.