Self-bootstrap
==============

<a id="peg2rb.rb"/> peg2rb.rb
-----------------------------

A general-purpose parser generator that converts a grammar description for an extended [PEG](http://en.wikipedia.org/wiki/Parsing_expression_grammar) into a [Ruby](http://ruby-lang.org) program to parse that grammar.

See <a href="peg2rb - User Guide.html">peg2rb - User Guide.html</a> ([view online](http://htmlpreview.github.io/?https://raw.github.com/LavirtheWhiolet/self-bootstrap/master/peg2rb%20-%20User%20Guide.html)) for details on the input grammar description and the output parser. You may also see samples of the grammar descriptions in [samples](#samples).

The input grammar description has its own grammar too. It is described in [peg2rb.peg](#peg2rb.peg).

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

Tasks planned to be done for this package.

generated
---------

All generated files—generated parsers, object files, temporary assets—are put into this directory.

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
