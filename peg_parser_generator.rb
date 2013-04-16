#!/usr/bin/ruby
# 
# This files is both runnable and "require"-able.
# 
require 'set'
require 'stringio'


class PEGParserGenerator
  
  # +input+ must be IO which has working IO#pos and IO#pos=().
  def call(input, output = STDOUT)
    # Initialize.
    @input = input
    @output = output
    @nonterminal_to_method_name = {}
    @id = 0
    @used_nonterminals = Set.new
    # Parse.
    (pparser and @input.eof?) or raise SyntaxError
  end
  
  class SyntaxError < Exception
  end
  
  private
  
  # ---- Syntax ----
  
  def pparser
    pinclude_delimiter = lambda { string("%%") and many { char_except "\n" } and string("\n") }
    #
    pws and
    opt {
      pinclude_delimiter.() and
      (code = capture { many { not follows(&pinclude_delimiter) and char } }) and
      pinclude_delimiter.() and
      pws and (
        @output.print code; true
      )
    } and
    pparser_body and
    opt {
      pinclude_delimiter.() and
      (code = capture { many { char } }) and (
        @output.print code; true
      )
    }
  end
  
  def pparser_body
    # 
    rules_left_parts = Set.new
    rule_is_first = true
    # 
    many1 {
      (rule = prule) and begin
        # Mark rule's left part as already used.
        raise SyntaxError, %(rule "#{rule[:left_part]}" is already defined) if rules_left_parts.include? rule[:left_part]
        rules_left_parts << rule[:left_part]
        # Print main parser method if the rule is first.
        if rule_is_first
          @output.print %(
            def yy_parse(input)
              # Initialize.
              @yy_input = input
              # Parse!
              (value = #{method_name(rule[:left_part])}) or raise SyntaxError
              # 
              return yy_from_pcv(value)
            end
          )
          rule_is_first = false
        end
        # Print the rule's method.
        @output.puts rule[:method_code]
        # 
        true
      end
    } and
    begin
      # Check that used nonterminals have their counterparts among rules.
      missing_rules_left_parts = @used_nonterminals - rules_left_parts
      raise SyntaxError, %(nonterminals #{missing_rules_left_parts.map { |x| %("#{x}") }.join(", ")} is/are used but corresponding rules are not defined) if not missing_rules_left_parts.empty?
      # Print auxiliary methods.
      @output.print %(
        def yy_char_range(from, to)
          return nil if @yy_input.eof?
          c = @yy_input.getc
          if from <= c and c <= to then
            return c
          else
            nil
          end
        end
        
        def yy_string(string)
          if ((@yy_input.read(string.bytesize) or "").force_encoding(string.encoding) == string) then string else nil end
        end
        
        # parser compatible (non-nil) value of +value+.
        def yy_to_pcv(value)
          if value.nil? then :yy_nil else value end
        end
        
        # real value of parser compatible value got by #yy_to_pcv().
        def yy_from_pcv(value)
          if value == :yy_nil then nil else value end
        end
        
        class SyntaxError < Exception
        end
      )
      true
    end
  end
  
  # returns Hash with keys +:left_part+ and +:method_code+.
  def prule
    (left_part = pnonterminal) and plexeme '<-' and (code = pexpr) and plexeme ';' and begin
      {
        left_part: left_part,
        method_code: %(
          def #{method_name(left_part)}
            value = :yy_nil
            #{code} and yy_to_pcv(value)
          end
        ).force_encoding(Encoding::default_external)
      }
    end
  end
  
  def pexpr
    pexpr50
  end
  
  def pexpr50
    # Choice (ordered)
    more_than_one_alternative = false
    stored_pos_var = new_var
    #
    (code = pexpr60) and many {
      plexeme '/' and (code1 = pexpr60) and begin
        more_than_one_alternative = true
        code = %(#{code} or (@yy_input.pos = #{stored_pos_var}; #{code1}))
      end
    } and
    if more_than_one_alternative then
      Code.new %(begin; #{stored_pos_var} = @yy_input.pos; #{code}; end), false
    else
      code
    end
  end
  
  def pexpr60
    # Sequence
    code_needs_brackets = false
    # 
    (code = pexpr70) and many {
      (code2 = pexpr70) and begin
        code_needs_brackets = true
        code = Code.new %(#{code} and #{code2}), false
      end
    } and
    if code_needs_brackets then code = Code.new %((#{code})), code.has_semantic_value?
    else code end
  end
  
  def pexpr70
    # Capture
    try {
      (var = pvar) and (try { plexeme ':' } or try { plexeme '=' }) and (code = pexpr70) and
      if code.has_semantic_value? then
        code_result_var = new_var
        Code.new %(begin; #{code_result_var} = #{code}; if #{code_result_var} then #{var} = yy_from_pcv(#{code_result_var}) end; #{code_result_var}; end), code.has_semantic_value?
      else
        start_pos_var = new_var
        end_pos_var = new_var
        code_result_var = new_var
        Code.new %(begin; #{start_pos_var} = @yy_input.pos; #{code_result_var} = #{code}; if #{code_result_var} then #{end_pos_var} = @yy_input.pos; @yy_input.pos = #{start_pos_var}; #{var} = @yy_input.read(#{end_pos_var} - #{start_pos_var}) end; #{code_result_var}; end), code.has_semantic_value?
      end
    } or
    pexpr80
  end
  
  def pexpr80
    # Predicate
    stored_pos_var = new_var
    look_ahead_code = lambda { |code|
      # Optimization: When expression under predicate fails
      # it is not needed to backtrack because outer expression
      # will do it.
      Code.new %(begin; #{stored_pos_var} = @yy_input.pos; #{code} and (@yy_input.pos = #{stored_pos_var}; true); end), false
    }
    #
    try {
      plexeme '&' and (code = pexpr80) and
      look_ahead_code.(code)
    } or
    try {
      plexeme '!' and (code = pexpr80) and
      look_ahead_code.("(not #{code})")
    } or
    pexpr90
  end
  
  def pexpr90
    # Repetition
    stored_pos_var = new_var
    repeat_code = lambda { |code|
      %(begin; while true; #{stored_pos_var} = @yy_input.pos; #{code} or (@yy_input.pos = #{stored_pos_var}; break); end; true; end)
    }
    #
    (code = pexpr95) and many {
      try {
        plexeme '*' and
        (code = Code.new repeat_code.(code), false)
      } or
      try {
        plexeme '?' and
        (code = Code.new %(begin; #{stored_pos_var} = @yy_input.pos; #{code} or (@yy_input.pos = #{stored_pos_var}); true; end), false)
      } or
      try {
        plexeme '+' and
        (code = Code.new %((#{code} and #{repeat_code.(code)})), false)
      }
    } and
    code
  end
  
  def pexpr95
    # < xxx > (text capture)
    try {
      plexeme '<' and (code = pexpr) and plexeme '>' and
      code.has_no_semantic_value
    } or
    pexpr100
  end
  
  def pexpr100
    # Brackets
    try {
      plexeme '(' and (code = pexpr) and plexeme ')' and
      code
    } or
    patomic_expr
  end
  
  def patomic_expr
    # char. range
    try {
      range = pchar_range and
      Code.new %(yy_char_range(#{to_ruby_code(range.begin)}, #{to_ruby_code(range.end)})), true
    } or
    # char.
    try {
      char = pchar and
      Code.new %(yy_string(#{to_ruby_code(char)})), true
    } or
    # string
    try {
      s = pstring and (
        body, quote = *s;
        p body.encoding
        Code.new %(yy_string(#{quote}#{body}#{quote})), true
      )
    } or
    # any char.
    try {
      pany_char and
      Code.new %(@yy_input.getc), true  # It will return either character or nil. That suits us.
    } or
    # end
    try {
      plexeme 'end' and
      Code.new %(@yy_input.eof?), false
    } or
    # nonterminal
    try {
      nonterminal = pnonterminal and (
        @used_nonterminals << nonterminal;
        Code.new %(#{method_name(nonterminal)}), true
      )
    } or
    # semantic action
    try {
      action = pcode and
      Code.new %(begin #{action}; true; end), false
    }
  end
  
  class Code
    
    def initialize(string, has_semantic_value)
      @string = string
      @has_semantic_value = has_semantic_value
    end
    
    def to_s
      @string
    end
    
    def has_semantic_value?
      @has_semantic_value
    end
    
    # returns this Code with #has_semantic_value?() set to false.
    def has_no_semantic_value
      Code.new(@string, false)
    end
    
  end
  
  # ---- Lex ----
  
  # returns body of the code block or nil.
  def pcode
    body = capture { pcode_fragment } and pws and
    body[1...-1]
  end
  
  def pcode_fragment
    char '{' and many {
      try { char_except /[\{\}]/ } or
      try { pcode_fragment }
    } and char '}'
  end
  
  # returns +str+ or nil.
  def plexeme(str)
    string(str) and pws and
    str
  end
  
  # returns variable name or nil.
  def pvar
    (name = capture { char /[a-z_]/ and many { char /[a-z_0-9]/ } }) and pws and
    name
  end
  
  # returns nonterminal name or nil.
  def pnonterminal
    (name = capture {
      try { many1 { char /[a-zA-Z0-9_\.\$\@\-]/ } } or
      try { string '`' and many { char_except '`' } and string '`' }
    }) and pws and
    name
  end
  
  # returns range or nil.
  def pchar_range
    (from = pchar_fragment) and string '...' and (to = pchar_fragment) and pws and
    (from..to)
  end
  
  # returns character or nil.
  def pchar
    (char = pchar_fragment) and pws and
    char
  end
  
  # returns character or nil.
  def pchar_fragment
    char = nil
    (
      try { string('"') and (char = char_except('"')) and string('"') } or
      try { string("'") and (char = char_except("'")) and string("'") } or
      try { string('U+') and (hex_code = capture { many { char(/[0-9A-F]/) } }) and (char = eval(%("\\u{#{hex_code}}"))) }
    ) and
    char
  end
  
  def pany_char
    string "char" and not follows { char /[a-zA-Z0-9_\.\$\@\-]/ } and pws
  end
  
  # returns +[body, quote]+ or nil.
  def pstring
    quote = nil
    body = nil
    (
      try { quote = string('"') and body = capture { many { char_except('"') } } and string('"') and pws } or
      try { quote = string("'") and body = capture { many { char_except("'") } } and string("'") and pws }
    ) and
    [body, quote]
  end
  
  def pws
    many {
      try { char(/\s/) } or
      try { string("#") and many { char_except("\n") } and char("\n") } or
      try { string("--") and many { char_except("\n") } and char("\n") }
    }
  end
  
  # ---- API ----
  
  # prints +msg+ and returns true.
  def debug(msg = "here")
    puts msg
    true
  end
  
  def many1(&parse)
    parse.() and many(&parse)
  end
  
  # always returns +true+.
  def many(&parse)
    while true
      old_pos = input.pos
      parse.() or (input.pos = old_pos; break)
    end
    return true
  end
  
  # calls +parse+. If it returns not nil and not false then this method returns
  # String from #input located between IO#pos of #input before call to this
  # method and IO#pos of #input after call to this method. Otherwise it returns
  # what +parse+ returns.
  # 
  # String#encoding of the String returned is always Encoding::default_external.
  # 
  def capture(&parse)
    start_pos = input.pos
    parse = parse.()
    if parse
      end_pos = input.pos
      capture = (input.pos = start_pos; input.read(end_pos - start_pos) or "").force_encoding(Encoding::default_external)
    else
      parse
    end
  end
  
  # calls +parse+. If it returns nil then IO#pos of +input+ is restored to
  # value before call to this method.
  # 
  # It returns what +parse+ returns.
  # 
  def try(&parse)
    original_pos = input.pos
    parse = parse.()
    if parse.nil? then input.pos = original_pos end
    return parse
  end
  
  # calls +parse. If it returns nil then IO#pos of +input is restored to
  # value before call to this method.
  # 
  # It always returns true.
  # 
  def opt(&parse)
    original_pos = input.pos
    parse = parse.()
    if parse.nil? then input.pos = original_pos end
    return true
  end
  
  # returns what +parse+ returns but IO#pos of +input+ is not changed.
  def follows(&parse)
    original_pos = input.pos
    parse = parse.()
    input.pos = original_pos
    return parse
  end
  
  attr_reader :input
  
  # If the next String in #input is +string+ then it returns +string+. Otherwise
  # it returns +nil+.
  # 
  # It always changes IO#pos of #input to IO#pos+(byte length of +string+).
  # 
  def string(string)
    if (input.read(string.bytesize) or "").force_encoding(string.encoding) == string then string else nil end
  end
  
  # If +char_range is case equal to the next character in #input then it returns
  # the character. Otherwise it returns nil.
  # 
  # It always changes IO#pos of #input to IO#pos+(byte length of the character).
  # 
  def char(char_range = ANY)
    c = input.getc()
    if char_range === c then c else nil end
  end
  
  # The same as #char() but returns the character if +char_range+ is not case
  # equal to it.
  def char_except(char_range)
    c = input.getc()
    if char_range === c then nil else c end
  end
  
  # Ruby code which value of is equivalent to
  # +char+.
  def to_ruby_code(char)
    case char
    when "'" then %("#{char}")
    when "\\" then %('\\\\')
    else %('#{char}')
    end
  end
  
  # Name of method corresponding to +nonterminal+.
  # Each nonterminal corresponds to unique name.
  # The name always starts with "yy_nonterm".
  def method_name(nonterminal)
    @nonterminal_to_method_name[nonterminal] ||= (@id += 1; "yy_nonterm#{@id.to_s(36)}")
  end
  
  # returns name for new variable. Each call returns
  # unique name. The name always starts with "yy_var".
  def new_var
    @id += 1
    "yy_var#{@id.to_s(36)}"
  end
  
  class Any
    
    def eql?(other); true; end
    alias == eql?
    def ===(other); true; end
    
  end
  
  # An object which is equal to anything.
  ANY = Any.new
  
  # Alias for ANY.
  def _
    ANY
  end
  
end


if $0 == __FILE__
  # Help
  if ARGV[0] == "-h" or ARGV[0] == "--help" or ARGV.empty?
    puts <<-HELP
Usage: ruby #{File.basename(__FILE__)} grammar_file

Prints parser corresponding to grammar written in `grammar_file' to standard
output. See `samples' directory for samples of grammars.
    HELP
    exit(0)
  end
  # Generate the parser.
  File.open(ARGV[0]) do |input|
    PEGParserGenerator.new.(input)
  end
end
