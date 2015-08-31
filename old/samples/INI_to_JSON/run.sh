#!/bin/sh

ruby peg2rb.rb samples/INI_to_JSON/grammar.peg > generated/INI_to_JSON.rb
ruby generated/INI_to_JSON.rb samples/INI_to_JSON/input_data.ini