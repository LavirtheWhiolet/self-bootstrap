Self-bootstrap
==============

<a id="peg2rb.rb"/> peg2rb.rb
-----------------------------

A general-purpose parser generator that converts a grammar description for an extended [parsing expression grammar](http://en.wikipedia.org/wiki/Parsing_expression_grammar) into a [Ruby](http://ruby-lang.org) program to parse that grammar.

The input grammar description has its own grammar which is described in [peg2rb.peg](#peg2rb.peg) (in terms of the extended [parsing expression grammar](http://en.wikipedia.org/wiki/Parsing_expression_grammar) as well). You may also see samples of the description in [samples](#samples).

The output parser is a [Ruby](http://ruby-lang.org) script containing the following (in order of appearance):
* Content of the `{...}` block before all rules in the input grammar description (if it is present).
* `yy_parse(io)` method. It either returns a semantic value of the first rule of the grammar or raises YY_SyntaxError (see below).<br/>
  `io` is IO which supports following methods:
  * `read(...)`
  * `pos`
  * `pos=(...)`
  * `set_encoding(...)`
* YY_SyntaxError class. It is a subclass of Exception.
* Auxiliary functions and classes with names starting with `yy_` or `YY_`.
* Content of the `{...}` block after all rules in the input grammar (if it is present).

### Requirements ###

* [Ruby 1.9 or higher](http://ruby-lang.org)

### Usage ###

You may run this program with the following command of [Bourne shell](http://en.wikipedia.org/wiki/Bourne_shell) or [Command Prompt](http://en.wikipedia.org/wiki/CMD.EXE_%28Windows%29):

    ruby peg2rb.rb input-grammar > output-parser

where `input-grammar` is a file with the input grammar description and `output-parser` is a file which the output parser is to be written to.

The program exits with [status](http://en.wikipedia.org/wiki/Exit_status) 0 if the parser is generated successfully and with non-zero status otherwise.

<a id="peg2rb.peg"/> peg2rb.peg
-------------------------------

Source code for [peg2rb.rb](#peg2rb.rb). You may use [peg2rb.rb](#peg2rb.rb) on it to generate [peg2rb.rb](#peg2rb.rb) itself.

Rakefile
--------

Script for [Rake](http://rake.rubyforge.org/) for building this package.

TODO
----

Tasks planned to be done on this package.

generated
---------

All generated files—generated parsers, object files, temporary assets—are put here.

proof
-----

Formal proof of this package correctness. Not done yet.

<a id="samples"/> samples
-------------------------

Sample grammar descriptions for [peg2rb.rb](#peg2rb.rb), scripts to generate and run parsers from them and sample input data for the parsers.

How to build
------------

Install [Rake](http://rake.rubyforge.org/) and run following command in this directory:

    rake
