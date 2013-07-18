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

samples
-------

Sample parsers with sample input data for them and scripts to run them.
