#!/usr/bin/ruby
# encoding: UTF-8


#
class String
  
  # returns Ruby code which evaluates to this String.
  def to_ruby_code
    self.dump
  end
  
end


class UniqueNumber
  
  begin
    @@next = 0
  end

  def self.new
    @@next.tap { @@next += 1 }
  end

end


# The value starts with "yy_var" and is lowcase.
def new_unique_variable_name
  "yy_var#{UniqueNumber.new.to_s(36)}"
end


# The value starts with "yy_nonterm" and is lowcase.
def new_unique_nonterminal_method_name
  "yy_nonterm#{UniqueNumber.new.to_s(36)}"
end


HashMap = Hash
  


      # 
      # +input+ is IO. It must have working IO#pos, IO#pos= and
      # IO#set_encoding() methods.
      # 
      # It may raise YY_SyntaxError.
      # 
      def yy_parse(input)
        input.set_encoding("UTF-8", "UTF-8")
        context = YY_ParsingContext.new(input)
        yy_from_pcv(
          yy_nonterm1(context) ||
          # TODO: context.worst_error can not be nil here. Prove it.
          raise(context.worst_error)
        )
      end

      # TODO: Allow to pass String to the entry point.
    
      
      # converts value to parser-compatible value (which is always non-false and
      # non-nil).
      def yy_to_pcv(value)
        if value.nil? then :yy_nil
        elsif value == false then :yy_false
        else value
        end
      end
      
      # converts value got by #yy_to_pcv() to actual value.
      def yy_from_pcv(value)
        if value == :yy_nil then nil
        elsif value == :yy_false then false
        else value
        end
      end

      class YY_ParsingContext
        
        # +input+ is IO.
        def initialize(input)
          @input = input
          @worst_error = nil
        end
        
        attr_reader :input
        
        # It is YY_SyntaxExpectationError or nil.
        attr_accessor :worst_error
        
        # adds possible error to this YY_ParsingContext.
        # 
        # +error+ is YY_SyntaxExpectationError.
        # 
        def << error
          # Update worst_error.
          if worst_error.nil? or worst_error.pos < error.pos then
            @worst_error = error
          elsif worst_error.pos == error.pos then
            @worst_error = @worst_error.or error
          end
          # 
          return self
        end
        
      end
      
      def yy_string(context, string)
        # 
        string_start_pos = context.input.pos
        # Read string.
        read_string = context.input.read(string.bytesize)
        # Set the string's encoding; check if it fits the argument.
        unless read_string and (read_string.force_encoding(Encoding::UTF_8)) == string then
          # 
          context << YY_SyntaxExpectationError.new(yy_displayed(string), string_start_pos)
          # 
          return nil
        end
        # 
        return read_string
      end
      
      def yy_end?(context)
        #
        if not context.input.eof?
          context << YY_SyntaxExpectationError.new("the end", context.input.pos)
          return nil
        end
        #
        return true
      end
      
      def yy_begin?(context)
        #
        if not (context.input.pos == 0)
          context << YY_SyntaxExpectationError.new("the beginning", context.input.pos)
          return nil
        end
        #
        return true
      end
      
      def yy_char(context)
        # 
        char_start_pos = context.input.pos
        # Read a char.
        c = context.input.getc
        # 
        unless c then
          #
          context << YY_SyntaxExpectationError.new("a character", char_start_pos)
          #
          return nil
        end
        #
        return c
      end
      
      def yy_char_range(context, from, to)
        # 
        char_start_pos = context.input.pos
        # Read the char.
        c = context.input.getc
        # Check if it fits the range.
        # NOTE: c has UTF-8 encoding.
        unless c and (from <= c and c <= to) then
          # 
          context << YY_SyntaxExpectationError.new(%(#{yy_displayed from}...#{yy_displayed to}), char_start_pos)
          # 
          return nil
        end
        #
        return c
      end
      
      # The form of +string+ suitable for displaying in messages.
      def yy_displayed(string)
        if string.length == 1 then
          char = string[0]
          char_code = char.ord
          case char_code
          when 0x00...0x20 then %(#{yy_unicode_s char_code})
          when 0x20...0x80 then %("#{char}")
          when 0x80...Float::INFINITY then %("#{char} (#{yy_unicode_s char_code})")
          end
        else
          %("#{string}")
        end
      end
      
      # "U+XXXX" string corresponding to +char_code+.
      def yy_unicode_s(char_code)
        "U+#{"%04X" % char_code}"
      end
      
      class YY_SyntaxError < Exception
        
        def initialize(message, pos)
          super(message)
          @pos = pos
        end
        
        attr_reader :pos
        
      end
      
      class YY_SyntaxExpectationError < YY_SyntaxError
        
        # 
        # +expectations+ are String-s.
        # 
        def initialize(*expectations, pos)
          super(nil, pos)
          @expectations = expectations
        end
        
        # 
        # returns other YY_SyntaxExpectationError with #expectations combined.
        # 
        # +other+ is another YY_SyntaxExpectationError.
        # 
        # #pos of this YY_SyntaxExpectationError and +other+ must be equal.
        # 
        def or other
          raise %(can not "or" #{YY_SyntaxExpectationError}s with different pos) unless self.pos == other.pos
          YY_SyntaxExpectationError.new(*(self.expectations + other.expectations), pos)
        end
        
        def message
          expectations = self.expectations.uniq
          [expectations[0...-1].join(", "), expectations[-1]].join(" or ") + " is expected"
        end
        
        protected
        
        # Private
        attr_reader :expectations
        
      end
    def yy_nonterm1(yy_context) 
val = :yy_nil 
(begin 
 
    code = code("")
    rule_is_first = true
    method_names = HashMap.new
   
 true 
 end and yy_nontermis(yy_context) and while true
      yy_varc = yy_context.input.pos
      if not begin; yy_var8 = yy_context.input.pos; (begin
      yy_var9 = yy_context.input.pos
      if yy_var9 then
        rule_pos = yy_from_pcv(yy_var9)
      end
      yy_var9
    end and begin
      yy_vara = yy_nonterm27(yy_context)
      if yy_vara then
        rule = yy_from_pcv(yy_vara)
      end
      yy_vara
    end and begin 
 
        # Check that the rule is not defined twice.
        if method_names.has_key?(rule.name) then
          raise YY_SyntaxError.new(%(rule #{rule.name} is defined more than once), rule_pos)
        end
        # 
        if rule_is_first
          code += parser_entry_point_code("yy_parse", rule.method_name)
          code += auxiliary_parser_code
          rule_is_first = false
        end
        # 
        if rule.need_entry_point?
          code += parser_entry_point_code(rule.entry_point_method_name, rule.method_name)
        end
        #
        code += rule.method_definition
        # 
        method_names[rule.name] = rule.method_name
       
 true 
 end) or (yy_context.input.pos = yy_var8; (begin
      yy_varb = yy_nonterm4i(yy_context)
      if yy_varb then
        action_code = yy_from_pcv(yy_varb)
      end
      yy_varb
    end and begin 
 
        code += code(action_code)
       
 true 
 end)); end then
        yy_context.input.pos = yy_varc
        break true
      end
    end and yy_end?(yy_context) and begin 
 
    code = link(code, method_names)
    check_no_unresolved_code_in code
    print code
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermd(yy_context) 
val = :yy_nil 
begin
      yy_varf = yy_nontermg(yy_context)
      if yy_varf then
        val = yy_from_pcv(yy_varf)
      end
      yy_varf
    end and yy_to_pcv(val) 
end 
def yy_nontermg(yy_context) 
val = :yy_nil 
(begin 
 
    single_expression = true
    remembered_pos_var = new_unique_variable_name
   
 true 
 end and begin
      yy_varj = yy_context.input.pos
      if not yy_nontermb8(yy_context) then
        yy_context.input.pos = yy_varj
      end
      true
    end and begin
      yy_vark = yy_nontermr(yy_context)
      if yy_vark then
        val = yy_from_pcv(yy_vark)
      end
      yy_vark
    end and while true
      yy_varq = yy_context.input.pos
      if not (yy_nontermb8(yy_context) and begin
      yy_varp = yy_nontermr(yy_context)
      if yy_varp then
        val2 = yy_from_pcv(yy_varp)
      end
      yy_varp
    end and begin 
 
      single_expression = false
      val = val + (code " or (yy_context.input.pos = #{remembered_pos_var}; ") + val2 + (code ")")
     
 true 
 end) then
        yy_context.input.pos = yy_varq
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "begin; #{remembered_pos_var} = yy_context.input.pos; ") + val + (code "; end")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermr(yy_context) 
val = :yy_nil 
(begin 
  code_parts = []  
 true 
 end and begin; yy_varw = yy_context.input.pos; (begin
      yy_varx = yy_nonterm10(yy_context)
      if yy_varx then
        code_part = yy_from_pcv(yy_varx)
      end
      yy_varx
    end and begin 
  code_parts.add code_part  
 true 
 end) or (yy_context.input.pos = yy_varw; (yy_nontermbk(yy_context) and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end and while true
      yy_vary = yy_context.input.pos
      if not begin; yy_varw = yy_context.input.pos; (begin
      yy_varx = yy_nonterm10(yy_context)
      if yy_varx then
        code_part = yy_from_pcv(yy_varx)
      end
      yy_varx
    end and begin 
  code_parts.add code_part  
 true 
 end) or (yy_context.input.pos = yy_varw; (yy_nontermbk(yy_context) and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end then
        yy_context.input.pos = yy_vary
        break true
      end
    end and begin 
 val = sequence_code(code_parts) 
 true 
 end) and yy_to_pcv(val) 
end 
  
  def sequence_code(sequence_parts)
    # 
    lazy_kleene_star_part_index =
      sequence_parts.find_index { |sequence_part| sequence_part.any? { |code_part| code_part.is_a? LazyRepeat::UnknownLookAheadCode } }
    # Compile parts after "*?" part as look ahead of the "*?" part
    # (if possible).
    if lazy_kleene_star_part_index and lazy_kleene_star_part_index != (sequence_parts.size - 1)
      lazy_kleene_star_part = sequence_parts[lazy_kleene_star_part_index]
      sequence_parts_after_lazy_kleene_star_part = sequence_parts[(lazy_kleene_star_part_index+1)..-1]
      lazy_kleene_star_part = lazy_kleene_star_part.replace(
        LazyRepeat::UnknownLookAheadCode,
        sequence_code(sequence_parts_after_lazy_kleene_star_part)
      )
      sequence_parts[lazy_kleene_star_part_index] = lazy_kleene_star_part
    end
    # Compile the code parts into sequence code!
    if sequence_parts.size == 1
      sequence_parts.first
    else
      code("(") + sequence_parts.reduce { |r, sequence_part| r + code(" and ") + sequence_part } + code(")")
    end
  end
  
def yy_nonterm10(yy_context) 
val = :yy_nil 
begin; yy_var11 = yy_context.input.pos; (begin
      yy_var12 = yy_nonterm16(yy_context)
      if yy_var12 then
        c = yy_from_pcv(yy_var12)
      end
      yy_var12
    end and begin
      yy_var13 = yy_nonterm3v(yy_context)
      if yy_var13 then
        t = yy_from_pcv(yy_var13)
      end
      yy_var13
    end and begin
      yy_var14 = yy_nonterm3r(yy_context)
      if yy_var14 then
        var = yy_from_pcv(yy_var14)
      end
      yy_var14
    end and begin 
  val = capture_semantic_value_code(var, c, t)  
 true 
 end) or (yy_context.input.pos = yy_var11; begin
      yy_var15 = yy_nonterm16(yy_context)
      if yy_var15 then
        val = yy_from_pcv(yy_var15)
      end
      yy_var15
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm16(yy_context) 
val = :yy_nil 
begin; yy_var17 = yy_context.input.pos; (yy_nontermby(yy_context) and begin
      yy_var18 = yy_nonterm4i(yy_context)
      if yy_var18 then
        c = yy_from_pcv(yy_var18)
      end
      yy_var18
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (yy_context.input.pos = yy_var17; (yy_nontermby(yy_context) and begin
      yy_var19 = yy_nonterm16(yy_context)
      if yy_var19 then
        val = yy_from_pcv(yy_var19)
      end
      yy_var19
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var17; (yy_nontermc0(yy_context) and begin
      yy_var1a = yy_nonterm16(yy_context)
      if yy_var1a then
        val = yy_from_pcv(yy_var1a)
      end
      yy_var1a
    end and begin 
  val = negative_predicate_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var17; begin
      yy_var1b = yy_nonterm1c(yy_context)
      if yy_var1b then
        val = yy_from_pcv(yy_var1b)
      end
      yy_var1b
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1c(yy_context) 
val = :yy_nil 
(begin
      yy_var1e = yy_nonterm1l(yy_context)
      if yy_var1e then
        val = yy_from_pcv(yy_var1e)
      end
      yy_var1e
    end and while true
      yy_var1k = yy_context.input.pos
      if not begin; yy_var1i = yy_context.input.pos; (begin
      yy_var1j = yy_context.input.pos
      if yy_var1j then
        p = yy_from_pcv(yy_var1j)
      end
      yy_var1j
    end and yy_nontermbs(yy_context) and begin 
  val = lazy_repeat_code(val, p)  
 true 
 end) or (yy_context.input.pos = yy_var1i; (yy_nontermbq(yy_context) and begin 
  val = repeat_many_times_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var1i; (yy_nontermbw(yy_context) and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var1i; (yy_nontermbu(yy_context) and begin 
  val = optional_code(val)  
 true 
 end)); end then
        yy_context.input.pos = yy_var1k
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm1l(yy_context) 
val = :yy_nil 
begin; yy_var1m = yy_context.input.pos; (yy_nontermbe(yy_context) and begin
      yy_var1n = yy_nontermd(yy_context)
      if yy_var1n then
        val = yy_from_pcv(yy_var1n)
      end
      yy_var1n
    end and yy_nontermbg(yy_context)) or (yy_context.input.pos = yy_var1m; (yy_nontermbm(yy_context) and begin
      yy_var1o = yy_nontermd(yy_context)
      if yy_var1o then
        c = yy_from_pcv(yy_var1o)
      end
      yy_var1o
    end and yy_nontermbo(yy_context) and begin
      yy_var1p = yy_nonterm3v(yy_context)
      if yy_var1p then
        t = yy_from_pcv(yy_var1p)
      end
      yy_var1p
    end and begin
      yy_var1q = yy_nonterm3r(yy_context)
      if yy_var1q then
        var = yy_from_pcv(yy_var1q)
      end
      yy_var1q
    end and begin 
  val = capture_text_code(var, c, t)  
 true 
 end)) or (yy_context.input.pos = yy_var1m; begin
      yy_var1r = yy_nonterm1s(yy_context)
      if yy_var1r then
        val = yy_from_pcv(yy_var1r)
      end
      yy_var1r
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1s(yy_context) 
val = :yy_nil 
begin; yy_var1t = yy_context.input.pos; (begin
      yy_var1u = yy_nontermgg(yy_context)
      if yy_var1u then
        r = yy_from_pcv(yy_var1u)
      end
      yy_var1u
    end and begin 
  val = code "yy_char_range(yy_context, #{r.begin.to_ruby_code}, #{r.end.to_ruby_code})"  
 true 
 end) or (yy_context.input.pos = yy_var1t; (begin
      yy_var1v = yy_nontermgm(yy_context)
      if yy_var1v then
        s = yy_from_pcv(yy_var1v)
      end
      yy_var1v
    end and begin 
  val = code "yy_string(yy_context, #{s.to_ruby_code})"  
 true 
 end)) or (yy_context.input.pos = yy_var1t; (begin
      yy_var1w = yy_context.input.pos
      if yy_var1w then
        n_pos = yy_from_pcv(yy_var1w)
      end
      yy_var1w
    end and begin
      yy_var1x = yy_nontermei(yy_context)
      if yy_var1x then
        n = yy_from_pcv(yy_var1x)
      end
      yy_var1x
    end and begin 
  val = UnknownMethodCall[n, %(yy_context), n_pos]  
 true 
 end)) or (yy_context.input.pos = yy_var1t; (yy_nontermc8(yy_context) and begin 
  val = code "yy_char(yy_context)"  
 true 
 end)) or (yy_context.input.pos = yy_var1t; (begin
      yy_var1y = yy_nonterm4i(yy_context)
      if yy_var1y then
        a = yy_from_pcv(yy_var1y)
      end
      yy_var1y
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (yy_context.input.pos = yy_var1t; (yy_nontermba(yy_context) and begin 
  val = code "yy_end?(yy_context)"  
 true 
 end)) or (yy_context.input.pos = yy_var1t; (yy_nontermbc(yy_context) and begin 
  val = code "yy_begin?(yy_context)"  
 true 
 end)) or (yy_context.input.pos = yy_var1t; (begin; yy_var22 = yy_context.input.pos; (yy_nontermc2(yy_context) and yy_nontermc4(yy_context) and begin
      yy_var23 = yy_nontermcq(yy_context)
      if yy_var23 then
        pos_variable = yy_from_pcv(yy_var23)
      end
      yy_var23
    end) or (yy_context.input.pos = yy_var22; (yy_nontermcg(yy_context) and begin
      yy_var24 = yy_nontermcq(yy_context)
      if yy_var24 then
        pos_variable = yy_from_pcv(yy_var24)
      end
      yy_var24
    end)); end and begin
      yy_var26 = yy_context.input.pos
      if not yy_nontermaa(yy_context) then
        yy_context.input.pos = yy_var26
      end
      true
    end and begin 
  val = code "(yy_context.input.pos = #{pos_variable}; true)"  
 true 
 end)) or (yy_context.input.pos = yy_var1t; (yy_nontermc2(yy_context) and begin 
  val = code "yy_context.input.pos"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm27(yy_context) 
val = :yy_nil 
(begin 
  rule = val = Rule.new  
 true 
 end and begin; yy_var2g = yy_context.input.pos; (begin
      yy_var2h = yy_nontermdy(yy_context)
      if yy_var2h then
        rule_name = yy_from_pcv(yy_var2h)
      end
      yy_var2h
    end and yy_nontermbe(yy_context) and begin
      yy_var2l = yy_context.input.pos
      if not begin; yy_var2k = yy_context.input.pos; yy_nontermc6(yy_context) or (yy_context.input.pos = yy_var2k; yy_nontermde(yy_context)); end then
        yy_context.input.pos = yy_var2l
      end
      true
    end and yy_nontermbg(yy_context) and begin 
  rule.need_entry_point!  
 true 
 end) or (yy_context.input.pos = yy_var2g; begin
      yy_var2m = yy_nontermei(yy_context)
      if yy_var2m then
        rule_name = yy_from_pcv(yy_var2m)
      end
      yy_var2m
    end); end and begin 
  rule.name = rule_name  
 true 
 end and begin
      yy_var2q = yy_context.input.pos
      if not (yy_nontermaa(yy_context) and yy_nonterm2t(yy_context)) then
        yy_context.input.pos = yy_var2q
      end
      true
    end and yy_nonterma6(yy_context) and begin
      yy_var2r = yy_nontermd(yy_context)
      if yy_var2r then
        c = yy_from_pcv(yy_var2r)
      end
      yy_var2r
    end and yy_nontermb6(yy_context) and begin 
  rule.method_definition = to_method_definition(c, rule.method_name)  
 true 
 end) and yy_to_pcv(val) 
end 
  
  class Rule

    def initialize()
      @need_entry_point = false
      @method_name = new_unique_nonterminal_method_name
    end

    # Nonterminal
    attr_accessor :name
    
    # Definition of method implementing this Rule.
    # 
    # It is Code.
    # 
    attr_accessor :method_definition

    # MethodName
    attr_reader :method_name

    # Default is false.
    def need_entry_point?
      @need_entry_point
    end

    # sets #need_entry_point? to true.
    def need_entry_point!
      @need_entry_point = true
    end

    def entry_point_method_name
      name
    end

  end

def yy_nonterm2t(yy_context) 
val = :yy_nil 
((begin
      yy_var3n = yy_context.worst_error
      begin
        not begin
      yy_var3o = yy_context.input.pos
      yy_var3p = yy_nonterma6(yy_context)
      yy_context.input.pos = yy_var3o
      yy_var3p
    end
      ensure
        yy_context.worst_error = yy_var3n
      end
    end and yy_char(yy_context)) and yy_nontermis(yy_context)) and while true
      yy_var3q = yy_context.input.pos
      if not ((begin
      yy_var3n = yy_context.worst_error
      begin
        not begin
      yy_var3o = yy_context.input.pos
      yy_var3p = yy_nonterma6(yy_context)
      yy_context.input.pos = yy_var3o
      yy_var3p
    end
      ensure
        yy_context.worst_error = yy_var3n
      end
    end and yy_char(yy_context)) and yy_nontermis(yy_context)) then
        yy_context.input.pos = yy_var3q
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm3r(yy_context) 
val = :yy_nil 
begin; yy_var3s = yy_context.input.pos; begin
      yy_var3t = yy_nontermcq(yy_context)
      if yy_var3t then
        val = yy_from_pcv(yy_var3t)
      end
      yy_var3t
    end or (yy_context.input.pos = yy_var3s; (yy_nontermbe(yy_context) and begin
      yy_var3u = yy_nontermcq(yy_context)
      if yy_var3u then
        val = yy_from_pcv(yy_var3u)
      end
      yy_var3u
    end and yy_nontermbg(yy_context))); end and yy_to_pcv(val) 
end 
def yy_nonterm3v(yy_context) 
val = :yy_nil 
begin; yy_var3w = yy_context.input.pos; (yy_nontermaa(yy_context) and begin 
 val = :capture 
 true 
 end) or (yy_context.input.pos = yy_var3w; (yy_nontermb2(yy_context) and begin 
 val = :append 
 true 
 end)) or (yy_context.input.pos = yy_var3w; (yy_nontermb4(yy_context) and begin 
 val = :append 
 true 
 end)); end and yy_to_pcv(val) 
end 

# [line, column] corresponding to position in +io+ (+pos+).
def line_and_column(pos, io)
  @pos = pos
  io.pos = 0
  return line_and_column0(io)
end



      # 
      # +input+ is IO. It must have working IO#pos, IO#pos= and
      # IO#set_encoding() methods.
      # 
      # It may raise YY_SyntaxError.
      # 
      def line_and_column0(input)
        input.set_encoding("UTF-8", "UTF-8")
        context = YY_ParsingContext.new(input)
        yy_from_pcv(
          yy_nonterm3y(context) ||
          # TODO: context.worst_error can not be nil here. Prove it.
          raise(context.worst_error)
        )
      end

      # TODO: Allow to pass String to the entry point.
    def yy_nonterm3y(yy_context) 
val = :yy_nil 
(begin 
  current_line_and_column = [1, 1]  
 true 
 end and while true
      yy_var49 = yy_context.input.pos
      if not (begin
      yy_var46 = yy_context.input.pos
      if yy_var46 then
        current_pos = yy_from_pcv(yy_var46)
      end
      yy_var46
    end and begin 
  if current_pos == @pos then val = current_line_and_column.dup; end  
 true 
 end and begin; yy_var48 = yy_context.input.pos; (yy_nontermja(yy_context) and begin 
  current_line_and_column[0] += 1; current_line_and_column[1] = 1  
 true 
 end) or (yy_context.input.pos = yy_var48; (yy_char(yy_context) and begin 
  current_line_and_column[1] += 1  
 true 
 end)); end) then
        yy_context.input.pos = yy_var49
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm4a(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "%%") and  begin
      while true
        ###
        yy_var4e = yy_context.input.pos
        ### Look ahead.
        yy_var4f = begin; yy_var4h = yy_context.input.pos; yy_nontermja(yy_context) or (yy_context.input.pos = yy_var4h; yy_end?(yy_context)); end
        yy_context.input.pos = yy_var4e
        break if yy_var4f
        ### Repeat one more time (if possible).
        yy_var4f = yy_char(yy_context)
        if not yy_var4f then
          yy_context.input.pos = yy_var4e
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_var4h = yy_context.input.pos; yy_nontermja(yy_context) or (yy_context.input.pos = yy_var4h; yy_end?(yy_context)); end) and yy_to_pcv(val) 
end 
def yy_nonterm4i(yy_context) 
val = :yy_nil 
(begin; yy_var79 = yy_context.input.pos; (yy_string(yy_context, "{") and while true
      yy_var7b = yy_context.input.pos
      if not yy_nontermj8(yy_context) then
        yy_context.input.pos = yy_var7b
        break true
      end
    end and yy_string(yy_context, "...") and begin
      yy_var7n = yy_context.input.pos
      if not ( begin
      while true
        ###
        yy_var7l = yy_context.input.pos
        ### Look ahead.
        yy_var7m = yy_nontermja(yy_context)
        yy_context.input.pos = yy_var7l
        break if yy_var7m
        ### Repeat one more time (if possible).
        yy_var7m = yy_nontermj8(yy_context)
        if not yy_var7m then
          yy_context.input.pos = yy_var7l
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nontermja(yy_context)) then
        yy_context.input.pos = yy_var7n
      end
      true
    end and begin
      val = ""
      yy_var80 = yy_context.input.pos
       begin
      while true
        ###
        yy_var7y = yy_context.input.pos
        ### Look ahead.
        yy_var7z = begin; yy_var87 = yy_context.input.pos; (yy_string(yy_context, "...") and while true
      yy_var89 = yy_context.input.pos
      if not yy_nontermj8(yy_context) then
        yy_context.input.pos = yy_var89
        break true
      end
    end and yy_string(yy_context, "}")) or (yy_context.input.pos = yy_var87; (yy_string(yy_context, "}") and while true
      yy_var8b = yy_context.input.pos
      if not yy_nontermj8(yy_context) then
        yy_context.input.pos = yy_var8b
        break true
      end
    end and yy_string(yy_context, "..."))); end
        yy_context.input.pos = yy_var7y
        break if yy_var7z
        ### Repeat one more time (if possible).
        yy_var7z = yy_char(yy_context)
        if not yy_var7z then
          yy_context.input.pos = yy_var7y
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var81 = yy_context.input.pos
        yy_context.input.pos = yy_var80
        val << yy_context.input.read(yy_var81 - yy_var80).force_encoding(Encoding::UTF_8)
      end
    end and begin; yy_var87 = yy_context.input.pos; (yy_string(yy_context, "...") and while true
      yy_var89 = yy_context.input.pos
      if not yy_nontermj8(yy_context) then
        yy_context.input.pos = yy_var89
        break true
      end
    end and yy_string(yy_context, "}")) or (yy_context.input.pos = yy_var87; (yy_string(yy_context, "}") and while true
      yy_var8b = yy_context.input.pos
      if not yy_nontermj8(yy_context) then
        yy_context.input.pos = yy_var8b
        break true
      end
    end and yy_string(yy_context, "..."))); end) or (yy_context.input.pos = yy_var79; (begin
      val = ""
      yy_var8g = yy_context.input.pos
      yy_nonterm9y(yy_context) and begin
        yy_var8h = yy_context.input.pos
        yy_context.input.pos = yy_var8g
        val << yy_context.input.read(yy_var8h - yy_var8g).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = val[1...-1]  
 true 
 end)) or (yy_context.input.pos = yy_var79; (yy_nonterm4a(yy_context) and begin
      val = ""
      yy_var9a = yy_context.input.pos
       begin
      while true
        ###
        yy_var98 = yy_context.input.pos
        ### Look ahead.
        yy_var99 = yy_nonterm4a(yy_context)
        yy_context.input.pos = yy_var98
        break if yy_var99
        ### Repeat one more time (if possible).
        yy_var99 = yy_char(yy_context)
        if not yy_var99 then
          yy_context.input.pos = yy_var98
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var9b = yy_context.input.pos
        yy_context.input.pos = yy_var9a
        val << yy_context.input.read(yy_var9b - yy_var9a).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm4a(yy_context))) or (yy_context.input.pos = yy_var79; (yy_nonterm4a(yy_context) and begin
      val = ""
      yy_var9w = yy_context.input.pos
      while true
      yy_var9v = yy_context.input.pos
      if not yy_char(yy_context) then
        yy_context.input.pos = yy_var9v
        break true
      end
    end and begin
        yy_var9x = yy_context.input.pos
        yy_context.input.pos = yy_var9w
        val << yy_context.input.read(yy_var9x - yy_var9w).force_encoding(Encoding::UTF_8)
      end
    end and yy_end?(yy_context))); end and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nonterm9y(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "{") and  begin
      while true
        ###
        yy_vara4 = yy_context.input.pos
        ### Look ahead.
        yy_vara5 = yy_string(yy_context, "}")
        yy_context.input.pos = yy_vara4
        break if yy_vara5
        ### Repeat one more time (if possible).
        yy_vara5 = begin; yy_vara3 = yy_context.input.pos; yy_nonterm9y(yy_context) or (yy_context.input.pos = yy_vara3; yy_char(yy_context)); end
        if not yy_vara5 then
          yy_context.input.pos = yy_vara4
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string(yy_context, "}")) and yy_to_pcv(val) 
end 
def yy_nonterma6(yy_context) 
val = :yy_nil 
(begin; yy_vara9 = yy_context.input.pos; yy_string(yy_context, "<-") or (yy_context.input.pos = yy_vara9; yy_string(yy_context, "=")) or (yy_context.input.pos = yy_vara9; yy_string(yy_context, "\u{2190}")); end and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermaa(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ":") and (begin
      yy_varat = yy_context.worst_error
      begin
        not begin
      yy_varau = yy_context.input.pos
      yy_varav = yy_string(yy_context, "+")
      yy_context.input.pos = yy_varau
      yy_varav
    end
      ensure
        yy_context.worst_error = yy_varat
      end
    end and begin
      yy_varaz = yy_context.worst_error
      begin
        not begin
      yy_varb0 = yy_context.input.pos
      yy_varb1 = yy_string(yy_context, ">>")
      yy_context.input.pos = yy_varb0
      yy_varb1
    end
      ensure
        yy_context.worst_error = yy_varaz
      end
    end) and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb2(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ":+") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb4(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ":>>") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb6(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ";") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb8(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "/") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermba(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "$") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbc(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "^") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbe(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "(") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbg(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ")") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbi(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "[") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbk(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "]") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbm(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "<") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbo(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ">") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbq(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "*") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbs(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "*?") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbu(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "?") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbw(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "+") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermby(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "&") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermc0(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "!") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermc2(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "@") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermc4(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "=") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermc6(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "...") and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermc8(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "char") and begin
      yy_varcd = yy_context.worst_error
      begin
        not begin
      yy_varce = yy_context.input.pos
      yy_varcf = yy_nontermge(yy_context)
      yy_context.input.pos = yy_varce
      yy_varcf
    end
      ensure
        yy_context.worst_error = yy_varcd
      end
    end and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermcg(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "at") and begin
      yy_varcl = yy_context.worst_error
      begin
        not begin
      yy_varcm = yy_context.input.pos
      yy_varcn = yy_nontermge(yy_context)
      yy_context.input.pos = yy_varcm
      yy_varcn
    end
      ensure
        yy_context.worst_error = yy_varcl
      end
    end and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermco(yy_context) 
val = :yy_nil 
begin; yy_varcp = yy_context.input.pos; yy_nontermc8(yy_context) or (yy_context.input.pos = yy_varcp; yy_nontermcg(yy_context)); end and yy_to_pcv(val) 
end 
def yy_nontermcq(yy_context) 
val = :yy_nil 
(begin
      val = ""
      yy_vardc = yy_context.input.pos
      (begin
      yy_vard7 = yy_context.input.pos
      if not begin; yy_vard6 = yy_context.input.pos; yy_string(yy_context, "@") or (yy_context.input.pos = yy_vard6; yy_string(yy_context, "$")); end then
        yy_context.input.pos = yy_vard7
      end
      true
    end and yy_nontermdu(yy_context) and while true
      yy_vardb = yy_context.input.pos
      if not yy_nontermdw(yy_context) then
        yy_context.input.pos = yy_vardb
        break true
      end
    end) and begin
        yy_vardd = yy_context.input.pos
        yy_context.input.pos = yy_vardc
        val << yy_context.input.read(yy_vardd - yy_vardc).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermde(yy_context) 
val = :yy_nil 
(begin
      val = ""
      yy_vards = yy_context.input.pos
      (yy_nontermdu(yy_context) and while true
      yy_vardr = yy_context.input.pos
      if not yy_nontermdw(yy_context) then
        yy_context.input.pos = yy_vardr
        break true
      end
    end) and begin
        yy_vardt = yy_context.input.pos
        yy_context.input.pos = yy_vards
        val << yy_context.input.read(yy_vardt - yy_vards).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermdu(yy_context) 
val = :yy_nil 
begin; yy_vardv = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_vardv; yy_string(yy_context, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermdw(yy_context) 
val = :yy_nil 
begin; yy_vardx = yy_context.input.pos; yy_nontermdu(yy_context) or (yy_context.input.pos = yy_vardx; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermdy(yy_context) 
val = :yy_nil 
(begin
      val = ""
      yy_varec = yy_context.input.pos
      (yy_nontermee(yy_context) and while true
      yy_vareb = yy_context.input.pos
      if not yy_nontermeg(yy_context) then
        yy_context.input.pos = yy_vareb
        break true
      end
    end) and begin
        yy_vared = yy_context.input.pos
        yy_context.input.pos = yy_varec
        val << yy_context.input.read(yy_vared - yy_varec).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermee(yy_context) 
val = :yy_nil 
begin; yy_varef = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_varef; yy_string(yy_context, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermeg(yy_context) 
val = :yy_nil 
begin; yy_vareh = yy_context.input.pos; yy_nontermee(yy_context) or (yy_context.input.pos = yy_vareh; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermei(yy_context) 
val = :yy_nil 
(begin
      yy_varen = yy_context.worst_error
      begin
        not begin
      yy_vareo = yy_context.input.pos
      yy_varep = yy_nontermco(yy_context)
      yy_context.input.pos = yy_vareo
      yy_varep
    end
      ensure
        yy_context.worst_error = yy_varen
      end
    end and begin; yy_varfj = yy_context.input.pos; (begin
      val = ""
      yy_varfw = yy_context.input.pos
      (yy_nontermgc(yy_context) and while true
      yy_varfv = yy_context.input.pos
      if not yy_nontermge(yy_context) then
        yy_context.input.pos = yy_varfv
        break true
      end
    end) and begin
        yy_varfx = yy_context.input.pos
        yy_context.input.pos = yy_varfw
        val << yy_context.input.read(yy_varfx - yy_varfw).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermis(yy_context)) or (yy_context.input.pos = yy_varfj; (begin
      val = ""
      yy_varga = yy_context.input.pos
      (yy_string(yy_context, "`") and  begin
      while true
        ###
        yy_varg8 = yy_context.input.pos
        ### Look ahead.
        yy_varg9 = yy_string(yy_context, "`")
        yy_context.input.pos = yy_varg8
        break if yy_varg9
        ### Repeat one more time (if possible).
        yy_varg9 = yy_char(yy_context)
        if not yy_varg9 then
          yy_context.input.pos = yy_varg8
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string(yy_context, "`")) and begin
        yy_vargb = yy_context.input.pos
        yy_context.input.pos = yy_varga
        val << yy_context.input.read(yy_vargb - yy_varga).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermis(yy_context))); end) and yy_to_pcv(val) 
end 
def yy_nontermgc(yy_context) 
val = :yy_nil 
begin; yy_vargd = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_vargd; yy_char_range(yy_context, "A", "Z")) or (yy_context.input.pos = yy_vargd; yy_string(yy_context, "-")) or (yy_context.input.pos = yy_vargd; yy_string(yy_context, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermge(yy_context) 
val = :yy_nil 
begin; yy_vargf = yy_context.input.pos; yy_nontermgc(yy_context) or (yy_context.input.pos = yy_vargf; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermgg(yy_context) 
val = :yy_nil 
(begin
      yy_vargi = yy_nontermgm(yy_context)
      if yy_vargi then
        from = yy_from_pcv(yy_vargi)
      end
      yy_vargi
    end and begin; yy_vargk = yy_context.input.pos; yy_string(yy_context, "...") or (yy_context.input.pos = yy_vargk; yy_string(yy_context, "..")) or (yy_context.input.pos = yy_vargk; yy_string(yy_context, "\u{2026}")) or (yy_context.input.pos = yy_vargk; yy_string(yy_context, "\u{2025}")); end and yy_nontermis(yy_context) and begin
      yy_vargl = yy_nontermgm(yy_context)
      if yy_vargl then
        to = yy_from_pcv(yy_vargl)
      end
      yy_vargl
    end and yy_nontermis(yy_context) and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermgm(yy_context) 
val = :yy_nil 
(begin; yy_varhi = yy_context.input.pos; (yy_string(yy_context, "'") and begin
      val = ""
      yy_varhv = yy_context.input.pos
       begin
      while true
        ###
        yy_varht = yy_context.input.pos
        ### Look ahead.
        yy_varhu = yy_string(yy_context, "'")
        yy_context.input.pos = yy_varht
        break if yy_varhu
        ### Repeat one more time (if possible).
        yy_varhu = yy_char(yy_context)
        if not yy_varhu then
          yy_context.input.pos = yy_varht
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varhw = yy_context.input.pos
        yy_context.input.pos = yy_varhv
        val << yy_context.input.read(yy_varhw - yy_varhv).force_encoding(Encoding::UTF_8)
      end
    end and yy_string(yy_context, "'")) or (yy_context.input.pos = yy_varhi; (yy_string(yy_context, "\"") and begin
      val = ""
      yy_vari9 = yy_context.input.pos
       begin
      while true
        ###
        yy_vari7 = yy_context.input.pos
        ### Look ahead.
        yy_vari8 = yy_string(yy_context, "\"")
        yy_context.input.pos = yy_vari7
        break if yy_vari8
        ### Repeat one more time (if possible).
        yy_vari8 = yy_char(yy_context)
        if not yy_vari8 then
          yy_context.input.pos = yy_vari7
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varia = yy_context.input.pos
        yy_context.input.pos = yy_vari9
        val << yy_context.input.read(yy_varia - yy_vari9).force_encoding(Encoding::UTF_8)
      end
    end and yy_string(yy_context, "\""))) or (yy_context.input.pos = yy_varhi; (begin
      yy_varib = yy_nontermic(yy_context)
      if yy_varib then
        code = yy_from_pcv(yy_varib)
      end
      yy_varib
    end and begin 
  val = "" << code  
 true 
 end)); end and yy_nontermis(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermic(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "U+") and begin
      code = ""
      yy_variq = yy_context.input.pos
      begin; yy_vario = yy_context.input.pos; yy_char_range(yy_context, "0", "9") or (yy_context.input.pos = yy_vario; yy_char_range(yy_context, "A", "F")); end and while true
      yy_varip = yy_context.input.pos
      if not begin; yy_vario = yy_context.input.pos; yy_char_range(yy_context, "0", "9") or (yy_context.input.pos = yy_vario; yy_char_range(yy_context, "A", "F")); end then
        yy_context.input.pos = yy_varip
        break true
      end
    end and begin
        yy_varir = yy_context.input.pos
        yy_context.input.pos = yy_variq
        code << yy_context.input.read(yy_varir - yy_variq).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermis(yy_context) 
val = :yy_nil 
while true
      yy_varix = yy_context.input.pos
      if not begin; yy_variw = yy_context.input.pos; yy_nontermj8(yy_context) or (yy_context.input.pos = yy_variw; yy_nontermiy(yy_context)); end then
        yy_context.input.pos = yy_varix
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nontermiy(yy_context) 
val = :yy_nil 
(begin; yy_varj1 = yy_context.input.pos; yy_string(yy_context, "#") or (yy_context.input.pos = yy_varj1; yy_string(yy_context, "--")); end and  begin
      while true
        ###
        yy_varj4 = yy_context.input.pos
        ### Look ahead.
        yy_varj5 = begin; yy_varj7 = yy_context.input.pos; yy_nontermja(yy_context) or (yy_context.input.pos = yy_varj7; yy_end?(yy_context)); end
        yy_context.input.pos = yy_varj4
        break if yy_varj5
        ### Repeat one more time (if possible).
        yy_varj5 = yy_char(yy_context)
        if not yy_varj5 then
          yy_context.input.pos = yy_varj4
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_varj7 = yy_context.input.pos; yy_nontermja(yy_context) or (yy_context.input.pos = yy_varj7; yy_end?(yy_context)); end) and yy_to_pcv(val) 
end 
def yy_nontermj8(yy_context) 
val = :yy_nil 
begin; yy_varj9 = yy_context.input.pos; yy_char_range(yy_context, "\t", "\r") or (yy_context.input.pos = yy_varj9; yy_string(yy_context, " ")) or (yy_context.input.pos = yy_varj9; yy_string(yy_context, "\u{85}")) or (yy_context.input.pos = yy_varj9; yy_string(yy_context, "\u{a0}")) or (yy_context.input.pos = yy_varj9; yy_string(yy_context, "\u{1680}")) or (yy_context.input.pos = yy_varj9; yy_string(yy_context, "\u{180e}")) or (yy_context.input.pos = yy_varj9; yy_char_range(yy_context, "\u{2000}", "\u{200a}")) or (yy_context.input.pos = yy_varj9; yy_string(yy_context, "\u{2028}")) or (yy_context.input.pos = yy_varj9; yy_string(yy_context, "\u{2029}")) or (yy_context.input.pos = yy_varj9; yy_string(yy_context, "\u{202f}")) or (yy_context.input.pos = yy_varj9; yy_string(yy_context, "\u{205f}")) or (yy_context.input.pos = yy_varj9; yy_string(yy_context, "\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nontermja(yy_context) 
val = :yy_nil 
begin; yy_varjb = yy_context.input.pos; (yy_string(yy_context, "\r") and yy_string(yy_context, "\n")) or (yy_context.input.pos = yy_varjb; yy_string(yy_context, "\r")) or (yy_context.input.pos = yy_varjb; yy_string(yy_context, "\n")) or (yy_context.input.pos = yy_varjb; yy_string(yy_context, "\u{85}")) or (yy_context.input.pos = yy_varjb; yy_string(yy_context, "\v")) or (yy_context.input.pos = yy_varjb; yy_string(yy_context, "\f")) or (yy_context.input.pos = yy_varjb; yy_string(yy_context, "\u{2028}")) or (yy_context.input.pos = yy_varjb; yy_string(yy_context, "\u{2029}")); end and yy_to_pcv(val) 
end 
  
  # 
  # +capture_type+ may be:
  # 
  # [:capture] "Capture the semantic value to +target_var+"
  # [:append]  "Append semantic value to +target_var+ using "<<" operator".
  # 
  def capture_semantic_value_code(target_var, code, capture_type)
    parse_result_var = new_unique_variable_name
    capture_operator =
      case capture_type
      when :capture then "="
      when :append then "<<"
      else raise %(capture_type #{capture_type.inspect} is not supported)
      end
    #
    code(%(begin
      #{parse_result_var} = )) + code + code(%(
      if #{parse_result_var} then
        #{target_var} #{capture_operator} yy_from_pcv(#{parse_result_var})
      end
      #{parse_result_var}
    end))
  end
  
  def positive_predicate_with_native_code_code(native_code)
    code(%(begin \n #{native_code} \n end))  # Newlines are needed because native_code may contain comments.
  end
  
  def positive_predicate_code(code)
    stored_pos_var = new_unique_variable_name
    result_var = new_unique_variable_name
    #
    code(%(begin
      #{stored_pos_var} = yy_context.input.pos
      #{result_var} = )) + code + code(%(
      yy_context.input.pos = #{stored_pos_var}
      #{result_var}
    end))
  end
  
  def negative_predicate_code(code)
    stored_worst_error_var = new_unique_variable_name
    # 
    code(%(begin
      #{stored_worst_error_var} = yy_context.worst_error
      begin
        not )) + positive_predicate_code(code) + code(%(
      ensure
        yy_context.worst_error = #{stored_worst_error_var}
      end
    end))
  end
  
  def repeat_many_times_code(code)
    stored_pos_var = new_unique_variable_name
    #
    code(%(while true
      #{stored_pos_var} = yy_context.input.pos
      if not )) + code + code(%( then
        yy_context.input.pos = #{stored_pos_var}
        break true
      end
    end))
  end
  
  def repeat_at_least_once_code(code)
    code + code(%( and )) + repeat_many_times_code(code)
  end
  
  def optional_code(code)
    stored_pos_var = new_unique_variable_name
    #
    code(%(begin
      #{stored_pos_var} = yy_context.input.pos
      if not )) + code + code(%( then
        yy_context.input.pos = #{stored_pos_var}
      end
      true
    end))
  end
  
  # 
  # +source_pos+ is position in source code the "lazy repeat" code is compiled
  # from.
  # 
  def lazy_repeat_code(parsing_code, source_pos)
    #
    original_pos_var = new_unique_variable_name
    result_var = new_unique_variable_name
    #
    code(%[ begin
      while true
        ###
        #{original_pos_var} = yy_context.input.pos
        ### Look ahead.
        #{result_var} = ]) + LazyRepeat::UnknownLookAheadCode[source_pos] + code(%[
        yy_context.input.pos = #{original_pos_var}
        break if #{result_var}
        ### Repeat one more time (if possible).
        #{result_var} = ]) + parsing_code + code(%[
        if not #{result_var} then
          yy_context.input.pos = #{original_pos_var}
          break
        end
      end
      ### The repetition is always successful.
      true
    end ])
  end
  
  # returns code which captures text to specified variable.
  # 
  # +capture_type+ may be one of the following:
  # 
  # [:capture] "Capture the text into the variable +target_variable_name+"
  # [:append]  "Append the text to the variable +target_variable_name+"
  # 
  def capture_text_code(target_variable_name, parsing_code, capture_type)
    #
    init_target_variable_code =
      case capture_type
      when :capture then %(#{target_variable_name} = "")
      when :append then %()
      else raise %(capture_type #{capture_type.inspect} is not supported)
      end
    start_pos_var = new_unique_variable_name
    end_pos_var = new_unique_variable_name
    # 
    code(%(begin
      #{init_target_variable_code}
      #{start_pos_var} = yy_context.input.pos
      )) +
      parsing_code + code(%( and begin
        #{end_pos_var} = yy_context.input.pos
        yy_context.input.pos = #{start_pos_var}
        #{target_variable_name} << yy_context.input.read(#{end_pos_var} - #{start_pos_var}).force_encoding(Encoding::UTF_8)
      end
    end))
  end
  
  def auxiliary_parser_code
    code %(
      
      # converts value to parser-compatible value (which is always non-false and
      # non-nil).
      def yy_to_pcv(value)
        if value.nil? then :yy_nil
        elsif value == false then :yy_false
        else value
        end
      end
      
      # converts value got by #yy_to_pcv() to actual value.
      def yy_from_pcv(value)
        if value == :yy_nil then nil
        elsif value == :yy_false then false
        else value
        end
      end

      class YY_ParsingContext
        
        # +input+ is IO.
        def initialize(input)
          @input = input
          @worst_error = nil
        end
        
        attr_reader :input
        
        # It is YY_SyntaxExpectationError or nil.
        attr_accessor :worst_error
        
        # adds possible error to this YY_ParsingContext.
        # 
        # +error+ is YY_SyntaxExpectationError.
        # 
        def << error
          # Update worst_error.
          if worst_error.nil? or worst_error.pos < error.pos then
            @worst_error = error
          elsif worst_error.pos == error.pos then
            @worst_error = @worst_error.or error
          end
          # 
          return self
        end
        
      end
      
      def yy_string(context, string)
        # 
        string_start_pos = context.input.pos
        # Read string.
        read_string = context.input.read(string.bytesize)
        # Set the string's encoding; check if it fits the argument.
        unless read_string and (read_string.force_encoding(Encoding::UTF_8)) == string then
          # 
          context << YY_SyntaxExpectationError.new(yy_displayed(string), string_start_pos)
          # 
          return nil
        end
        # 
        return read_string
      end
      
      def yy_end?(context)
        #
        if not context.input.eof?
          context << YY_SyntaxExpectationError.new("the end", context.input.pos)
          return nil
        end
        #
        return true
      end
      
      def yy_begin?(context)
        #
        if not (context.input.pos == 0)
          context << YY_SyntaxExpectationError.new("the beginning", context.input.pos)
          return nil
        end
        #
        return true
      end
      
      def yy_char(context)
        # 
        char_start_pos = context.input.pos
        # Read a char.
        c = context.input.getc
        # 
        unless c then
          #
          context << YY_SyntaxExpectationError.new("a character", char_start_pos)
          #
          return nil
        end
        #
        return c
      end
      
      def yy_char_range(context, from, to)
        # 
        char_start_pos = context.input.pos
        # Read the char.
        c = context.input.getc
        # Check if it fits the range.
        # NOTE: c has UTF-8 encoding.
        unless c and (from <= c and c <= to) then
          # 
          context << YY_SyntaxExpectationError.new(%(\#{yy_displayed from}\...\#{yy_displayed to}), char_start_pos)
          # 
          return nil
        end
        #
        return c
      end
      
      # The form of +string+ suitable for displaying in messages.
      def yy_displayed(string)
        if string.length == 1 then
          char = string[0]
          char_code = char.ord
          case char_code
          when 0x00...0x20 then %(\#{yy_unicode_s char_code})
          when 0x20...0x80 then %("\#{char}")
          when 0x80...Float::INFINITY then %("\#{char} (\#{yy_unicode_s char_code})")
          end
        else
          %("\#{string}")
        end
      end
      
      # "U+XXXX" string corresponding to +char_code+.
      def yy_unicode_s(char_code)
        "U+\#{"%04X" % char_code}"
      end
      
      class YY_SyntaxError < Exception
        
        def initialize(message, pos)
          super(message)
          @pos = pos
        end
        
        attr_reader :pos
        
      end
      
      class YY_SyntaxExpectationError < YY_SyntaxError
        
        # 
        # +expectations+ are String-s.
        # 
        def initialize(*expectations, pos)
          super(nil, pos)
          @expectations = expectations
        end
        
        # 
        # returns other YY_SyntaxExpectationError with #expectations combined.
        # 
        # +other+ is another YY_SyntaxExpectationError.
        # 
        # #pos of this YY_SyntaxExpectationError and +other+ must be equal.
        # 
        def or other
          raise %(can not "or" \#{YY_SyntaxExpectationError}s with different pos) unless self.pos == other.pos
          YY_SyntaxExpectationError.new(*(self.expectations + other.expectations), pos)
        end
        
        def message
          expectations = self.expectations.uniq
          [expectations[0...-1].join(", "), expectations[-1]].join(" or ") + " is expected"
        end
        
        protected
        
        # Private
        attr_reader :expectations
        
      end
    )
  end

  def parser_entry_point_code(method_name, parsing_method_name)
    code %(

      # 
      # +input+ is IO. It must have working IO#pos, IO#pos= and
      # IO#set_encoding() methods.
      # 
      # It may raise YY_SyntaxError.
      # 
      def #{method_name}(input)
        input.set_encoding("UTF-8", "UTF-8")
        context = YY_ParsingContext.new(input)
        yy_from_pcv(
          #{parsing_method_name}(context) ||
          # TODO: context.worst_error can not be nil here. Prove it.
          raise(context.worst_error)
        )
      end

      # TODO: Allow to pass String to the entry point.
    )
  end
  
  # 
  # See source code.
  # 
  def link(code, method_names)
    code.map do |code_part|
      if code_part.is_a? UnknownMethodCall and method_names.has_key? code_part.nonterminal
        code "#{method_names[code_part.nonterminal]}(#{code_part.args_code.to_s})"
      else
        code_part
      end
    end
  end
  
  def check_no_unresolved_code_in code
    code.each do |code_part|
      case code_part
      when UnknownMethodCall
        raise YY_SyntaxError.new(%(rule #{code_part.nonterminal} is not defined), code_part.source_pos)
      when LazyRepeat::UnknownLookAheadCode
        raise YY_SyntaxError.new(%(at least one expression is expected to be in sequence with "*?" expression), code_part.source_pos)
      end
    end
  end
  
  def to_method_definition(code, method_name)
    code("def #{method_name}(yy_context) \n") +
      code("val = :yy_nil \n") +
      code + code(" and yy_to_pcv(val) \n") +
    code("end \n")
  end
  
  RubyCode = String
  
  Nonterminal = String
  
  # TODO: Replace String with Nonterminal where it is needed.
  
  class Code
    
    # defines abstract method.
    def self.abstract(method)
      define_method(method) { |*args| raise %(method `#{method}' is abstract) }
    end
    
    abstract :to_s
    
    # Not overridable.
    def + other
      CodeConcatenation.new([self, other])
    end
    
    # 
    # passes every atomic Code comprising this Code and returns this Code with
    # the atomic Code-s replaced with what +block+ returns.
    # 
    def map(&block)
      block.(self)
    end
    
    # 
    # passes every atomic Code comprising this Code to +block+.
    # 
    # It returns this Code.
    # 
    # Not overridable.
    # 
    def each(&block)
      map do |part|
        block.(part)
        part
      end
    end
    
    # 
    # The same as Enumerable#reduce(initial) <tt>{ |memo, obj| block }</tt> or
    # Enumerable#reduce <tt>{ |memo, obj| block }</tt> where +obj+ is one of
    # atomic Code-s comprising this Code.
    # 
    # Not overridable.
    # 
    def reduce(initial = nil, &block)
      # TODO: Optimize.
      result = initial
      self.map { |code_part| result = block.(result, code_part); code_part }
      return result
    end
    
    # returns true if +predicate+ returns true for any atomic Code comprising
    # this code.
    def any?(&predicate)
      self.reduce(false) { |result, part| result or predicate.(part) }
    end
    
    # 
    # replaces each atomic Code which comprises this Code and is case-equal to
    # +pattern+ with +replacement+.
    # 
    def replace(pattern, replacement)
      self.map do |code_part|
        if pattern === code_part then
          replacement
        else
          code_part
        end
      end
    end
    
  end
  
  class CodeAsString < Code
    
    class << self
      
      alias [] new
      
    end
    
    def initialize(string)
      @string = string
    end
    
    def to_s
      @string
    end
    
    def inspect
      "#<CodeAsString: #{@string.inspect}>"
    end
    
  end
  
  # returns CodeAsString.
  def code(string)
    CodeAsString.new(string)
  end
  
  class CodeConcatenation < Code
    
    def initialize(parts)
      @parts = parts
    end
    
    def to_s
      @parts.map { |part| part.to_s }.join
    end
    
    def + other
      # Optimization.
      CodeConcatenation.new([*@parts, other])
    end
    
    def map(&block)
      CodeConcatenation.new(@parts.map { |part| part.map(&block) })
    end
    
    def inspect
      "#<CodeConcatenation: #{@parts.map { |p| p.inspect }.join(", ")}>"
    end
    
  end
  
  class UnknownMethodCall < Code
    
    class << self
      
      alias [] new
      
    end
    
    def initialize(nonterminal, args_code, source_pos)
      @nonterminal = nonterminal
      @args_code = args_code
      @source_pos = source_pos
    end
    
    # Nonterminal associated with this UnknownMethodCall.
    attr_reader :nonterminal
    
    # Code of arguments of this call (as String).
    attr_reader :args_code
    
    # Position in source code of this UnknownMethodCall.
    attr_reader :source_pos

    def to_s
      raise CodeCanNotBeDetermined.new self
    end
    
    def inspect
      "#<UnknownMethodCall: @nonterminal=#{@nonterminal.inspect}>"
    end
    
  end
  
  module LazyRepeat
    
    class UnknownLookAheadCode < Code
      
      class << self
        
        alias [] new
        
      end
      
      def initialize(source_pos)
        @source_pos = source_pos
      end
      
      def to_s
        raise CodeCanNotBeDetermined.new self
      end
      
      # Position in source code associated with this UnknownLookAheadCode.
      attr_reader :source_pos
      
      def inspect
        "#<LazyRepeat::UnknownLookAheadCode>"
      end
      
    end
    
  end
  
  class CodeCanNotBeDetermined < Exception
    
    def initialize(code)
      super %(code can not be determined: #{code.inspect})
      @code = code
    end
    
    attr_reader :code
    
  end
  

  class Array
    
    alias add <<
    
  end


  begin
    grammar_file = ARGV[0] or abort %(Usage: ruby #{__FILE__} grammar-file)
    File.open(grammar_file) do |io|
      begin
        yy_parse(io)
      rescue PEGParserGenerator::YY_SyntaxError => e
        line, column = *(line_and_column(e.pos, io))
        STDERR.puts %(#{grammar_file}:#{line}:#{column}: error: #{e.message})
        exit 1
      end
    end
  end

