Self-bootstrap
==============

<a id="peg2rb.rb"/> peg2rb.rb
-----------------------------

Parser generator. It generates parser written in [Ruby](http://ruby-lang.org) from grammar which is extended version of [PEG](http://en.wikipedia.org/wiki/Parsing_expression_grammar).

Input grammar is described in [peg2rb.peg](#peg2rb.peg) in terms of [peg2rb.rb](#peg2rb.rb)'s input grammar itself.

Output parser is a [Ruby](http://ruby-lang.org) script containing the following (in order):
* Content of `{...}` block before all rules in input grammar (if it is present).
* `yy_parse(io)` method. It either returns semantic value of the first rule of the grammar or raises YY_SyntaxError (see below).<br/>
  `io` is IO which supports following methods:
  * `read(...)`
  * `pos`
  * `pos=(...)`
  * `set_encoding(...)`
* YY_SyntaxError class. It is subclass of Exception.
* Auxiliary functions and classes with names starting with `yy_` or `YY_`.
* Content of `{...}` block after all rules in input grammar (if it is present).

NOTE. The first and the last `{...}` blocks allow you to wrap parsing methods into a class or a module.

### Requirements ###

* [Ruby 1.9 or higher](http://ruby-lang.org)

### Usage ###

You may run this program with the following command of [Bourne shell](http://en.wikipedia.org/wiki/Bourne_shell) or [Command Prompt](http://en.wikipedia.org/wiki/CMD.EXE_%28Windows%29):

    ruby peg2rb.rb input-grammar > output-parser

where `input-grammar` is a file with input grammar description and `output-parser` is a file which output parser is to be written to.

The program exits with [status](http://en.wikipedia.org/wiki/Exit_status) 0 if the parser is generated successfully and with non-zero status otherwise.

<a id="peg2rb.peg"/> peg2rb.peg
-------------------------------

Source code for [peg2rb.rb](#peg2rb.rb). You may use [peg2rb.rb](#peg2rb.rb) on it to generate [peg2rb.rb](#peg2rb.rb) itself.







































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