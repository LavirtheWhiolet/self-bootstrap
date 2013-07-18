Self-bootstrap
==============

<a id="peg2rb.rb"/> peg2rb.rb
-----------------------------

Parser generator. It generates parser in [Ruby](http://ruby-lang.org) from description of grammar.
















































from grammar descriptions which are extended version of [PEG](http://en.wikipedia.org/wiki/Parsing_expression_grammar).







































Parser generator. It generates parsers from their descriptions written in extended version of [PEG]



Output parser is a Ruby script containing following definitions:

* `yy_parse(io)` function.<br/>
  It either returns semantic value of the main rule or raises `YY_SyntaxError` (see below).<br/>
  `io` is IO supporing following methods:
  * `read(...)`
  * `pos`
  * `pos=(...)`
  * `set_encoding(...)`
* `YY_SyntaxError` class.
* Auxiliary functions and classes with names starting with `yy_` or `YY_`.













































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