#!/usr/bin/ruby
# encoding: UTF-8

# This file is both runnable and "require"-able.


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


# 
class PEGParserGenerator
  
  # 
  # +input+ is IO. It must have working IO#pos, IO#pos= and IO#set_encoding()
  # methods.
  # 
  def call(input)
    # Initialize.
    @next_unique_number = 0
    # Parse grammar and generate the parser.
    yy_parse(input)
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
          context << YY_SyntaxExpectationError.new(string.inspect, string_start_pos)
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
          context << YY_SyntaxExpectationError.new(%(#{from.inspect}...#{to.inspect}), char_start_pos)
          # 
          return nil
        end
        #
        return c
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
 end and yy_nontermip(yy_context) and while true
      yy_varc = yy_context.input.pos
      if not begin; yy_var8 = yy_context.input.pos; (begin
      yy_var9 = yy_context.input.pos
      if yy_var9 then
        rule_pos = yy_from_pcv(yy_var9)
      end
      yy_var9
    end and begin
      yy_vara = yy_nonterm25(yy_context)
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
      yy_varb = yy_nonterm4f(yy_context)
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
    check_no_unresolved_nonterminals(code)
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
      if not yy_nontermb5(yy_context) then
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
      if not (yy_nontermb5(yy_context) and begin
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
 end) or (yy_context.input.pos = yy_varw; (yy_nontermbh(yy_context) and begin 
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
 end) or (yy_context.input.pos = yy_varw; (yy_nontermbh(yy_context) and begin 
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
      yy_var13 = yy_nonterm3t(yy_context)
      if yy_var13 then
        t = yy_from_pcv(yy_var13)
      end
      yy_var13
    end and begin
      yy_var14 = yy_nonterm3p(yy_context)
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
begin; yy_var17 = yy_context.input.pos; (yy_nontermbv(yy_context) and begin
      yy_var18 = yy_nonterm4f(yy_context)
      if yy_var18 then
        c = yy_from_pcv(yy_var18)
      end
      yy_var18
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (yy_context.input.pos = yy_var17; (yy_nontermbv(yy_context) and begin
      yy_var19 = yy_nonterm16(yy_context)
      if yy_var19 then
        val = yy_from_pcv(yy_var19)
      end
      yy_var19
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var17; (yy_nontermbx(yy_context) and begin
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
      yy_var1e = yy_nonterm1j(yy_context)
      if yy_var1e then
        val = yy_from_pcv(yy_var1e)
      end
      yy_var1e
    end and while true
      yy_var1i = yy_context.input.pos
      if not begin; yy_var1h = yy_context.input.pos; (yy_nontermbp(yy_context) and begin 
  val = lazy_repeat_code(val)  
 true 
 end) or (yy_context.input.pos = yy_var1h; (yy_nontermbn(yy_context) and begin 
  val = repeat_many_times_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var1h; (yy_nontermbt(yy_context) and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var1h; (yy_nontermbr(yy_context) and begin 
  val = optional_code(val)  
 true 
 end)); end then
        yy_context.input.pos = yy_var1i
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm1j(yy_context) 
val = :yy_nil 
begin; yy_var1k = yy_context.input.pos; (yy_nontermbb(yy_context) and begin
      yy_var1l = yy_nontermd(yy_context)
      if yy_var1l then
        val = yy_from_pcv(yy_var1l)
      end
      yy_var1l
    end and yy_nontermbd(yy_context)) or (yy_context.input.pos = yy_var1k; (yy_nontermbj(yy_context) and begin
      yy_var1m = yy_nontermd(yy_context)
      if yy_var1m then
        c = yy_from_pcv(yy_var1m)
      end
      yy_var1m
    end and yy_nontermbl(yy_context) and begin
      yy_var1n = yy_nonterm3t(yy_context)
      if yy_var1n then
        t = yy_from_pcv(yy_var1n)
      end
      yy_var1n
    end and begin
      yy_var1o = yy_nonterm3p(yy_context)
      if yy_var1o then
        var = yy_from_pcv(yy_var1o)
      end
      yy_var1o
    end and begin 
  val = capture_text_code(var, c, t)  
 true 
 end)) or (yy_context.input.pos = yy_var1k; begin
      yy_var1p = yy_nonterm1q(yy_context)
      if yy_var1p then
        val = yy_from_pcv(yy_var1p)
      end
      yy_var1p
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1q(yy_context) 
val = :yy_nil 
begin; yy_var1r = yy_context.input.pos; (begin
      yy_var1s = yy_nontermgd(yy_context)
      if yy_var1s then
        r = yy_from_pcv(yy_var1s)
      end
      yy_var1s
    end and begin 
  val = code "yy_char_range(yy_context, #{r.begin.to_ruby_code}, #{r.end.to_ruby_code})"  
 true 
 end) or (yy_context.input.pos = yy_var1r; (begin
      yy_var1t = yy_nontermgj(yy_context)
      if yy_var1t then
        s = yy_from_pcv(yy_var1t)
      end
      yy_var1t
    end and begin 
  val = code "yy_string(yy_context, #{s.to_ruby_code})"  
 true 
 end)) or (yy_context.input.pos = yy_var1r; (begin
      yy_var1u = yy_context.input.pos
      if yy_var1u then
        n_pos = yy_from_pcv(yy_var1u)
      end
      yy_var1u
    end and begin
      yy_var1v = yy_nontermef(yy_context)
      if yy_var1v then
        n = yy_from_pcv(yy_var1v)
      end
      yy_var1v
    end and begin 
  val = UnknownMethodCall[n, %(yy_context), n_pos]  
 true 
 end)) or (yy_context.input.pos = yy_var1r; (yy_nontermc5(yy_context) and begin 
  val = code "yy_char(yy_context)"  
 true 
 end)) or (yy_context.input.pos = yy_var1r; (begin
      yy_var1w = yy_nonterm4f(yy_context)
      if yy_var1w then
        a = yy_from_pcv(yy_var1w)
      end
      yy_var1w
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (yy_context.input.pos = yy_var1r; (yy_nontermb7(yy_context) and begin 
  val = code "yy_end?(yy_context)"  
 true 
 end)) or (yy_context.input.pos = yy_var1r; (yy_nontermb9(yy_context) and begin 
  val = code "yy_begin?(yy_context)"  
 true 
 end)) or (yy_context.input.pos = yy_var1r; (begin; yy_var20 = yy_context.input.pos; (yy_nontermbz(yy_context) and yy_nontermc1(yy_context) and begin
      yy_var21 = yy_nontermcn(yy_context)
      if yy_var21 then
        pos_variable = yy_from_pcv(yy_var21)
      end
      yy_var21
    end) or (yy_context.input.pos = yy_var20; (yy_nontermcd(yy_context) and begin
      yy_var22 = yy_nontermcn(yy_context)
      if yy_var22 then
        pos_variable = yy_from_pcv(yy_var22)
      end
      yy_var22
    end)); end and begin
      yy_var24 = yy_context.input.pos
      if not yy_nonterma7(yy_context) then
        yy_context.input.pos = yy_var24
      end
      true
    end and begin 
  val = code "(yy_context.input.pos = #{pos_variable}; true)"  
 true 
 end)) or (yy_context.input.pos = yy_var1r; (yy_nontermbz(yy_context) and begin 
  val = code "yy_context.input.pos"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm25(yy_context) 
val = :yy_nil 
(begin 
  rule = val = Rule.new  
 true 
 end and begin; yy_var2e = yy_context.input.pos; (begin
      yy_var2f = yy_nontermdv(yy_context)
      if yy_var2f then
        rule_name = yy_from_pcv(yy_var2f)
      end
      yy_var2f
    end and yy_nontermbb(yy_context) and begin
      yy_var2j = yy_context.input.pos
      if not begin; yy_var2i = yy_context.input.pos; yy_nontermc3(yy_context) or (yy_context.input.pos = yy_var2i; yy_nontermdb(yy_context)); end then
        yy_context.input.pos = yy_var2j
      end
      true
    end and yy_nontermbd(yy_context) and begin 
  rule.need_entry_point!  
 true 
 end) or (yy_context.input.pos = yy_var2e; begin
      yy_var2k = yy_nontermef(yy_context)
      if yy_var2k then
        rule_name = yy_from_pcv(yy_var2k)
      end
      yy_var2k
    end); end and begin 
  rule.name = rule_name  
 true 
 end and begin
      yy_var2o = yy_context.input.pos
      if not (yy_nonterma7(yy_context) and yy_nonterm2r(yy_context)) then
        yy_context.input.pos = yy_var2o
      end
      true
    end and yy_nonterma3(yy_context) and begin
      yy_var2p = yy_nontermd(yy_context)
      if yy_var2p then
        c = yy_from_pcv(yy_var2p)
      end
      yy_var2p
    end and yy_nontermb3(yy_context) and begin 
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

def yy_nonterm2r(yy_context) 
val = :yy_nil 
((begin
      yy_var3l = yy_context.worst_error
      begin
        not begin
      yy_var3m = yy_context.input.pos
      yy_var3n = yy_nonterma3(yy_context)
      yy_context.input.pos = yy_var3m
      yy_var3n
    end
      ensure
        yy_context.worst_error = yy_var3l
      end
    end and yy_char(yy_context)) and yy_nontermip(yy_context)) and while true
      yy_var3o = yy_context.input.pos
      if not ((begin
      yy_var3l = yy_context.worst_error
      begin
        not begin
      yy_var3m = yy_context.input.pos
      yy_var3n = yy_nonterma3(yy_context)
      yy_context.input.pos = yy_var3m
      yy_var3n
    end
      ensure
        yy_context.worst_error = yy_var3l
      end
    end and yy_char(yy_context)) and yy_nontermip(yy_context)) then
        yy_context.input.pos = yy_var3o
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm3p(yy_context) 
val = :yy_nil 
begin; yy_var3q = yy_context.input.pos; begin
      yy_var3r = yy_nontermcn(yy_context)
      if yy_var3r then
        val = yy_from_pcv(yy_var3r)
      end
      yy_var3r
    end or (yy_context.input.pos = yy_var3q; (yy_nontermbb(yy_context) and begin
      yy_var3s = yy_nontermcn(yy_context)
      if yy_var3s then
        val = yy_from_pcv(yy_var3s)
      end
      yy_var3s
    end and yy_nontermbd(yy_context))); end and yy_to_pcv(val) 
end 
def yy_nonterm3t(yy_context) 
val = :yy_nil 
begin; yy_var3u = yy_context.input.pos; (yy_nonterma7(yy_context) and begin 
 val = :capture 
 true 
 end) or (yy_context.input.pos = yy_var3u; (yy_nontermaz(yy_context) and begin 
 val = :append 
 true 
 end)) or (yy_context.input.pos = yy_var3u; (yy_nontermb1(yy_context) and begin 
 val = :append 
 true 
 end)); end and yy_to_pcv(val) 
end 


      # 
      # +input+ is IO. It must have working IO#pos, IO#pos= and
      # IO#set_encoding() methods.
      # 
      # It may raise YY_SyntaxError.
      # 
      def line_and_column(input)
        input.set_encoding("UTF-8", "UTF-8")
        context = YY_ParsingContext.new(input)
        yy_from_pcv(
          yy_nonterm3v(context) ||
          # TODO: context.worst_error can not be nil here. Prove it.
          raise(context.worst_error)
        )
      end

      # TODO: Allow to pass String to the entry point.
    def yy_nonterm3v(yy_context) 
val = :yy_nil 
(begin 
  current_line_and_column = [1, 1]  
 true 
 end and while true
      yy_var46 = yy_context.input.pos
      if not (begin
      yy_var43 = yy_context.input.pos
      if yy_var43 then
        current_pos = yy_from_pcv(yy_var43)
      end
      yy_var43
    end and begin 
  if current_pos == @pos then val = current_line_and_column.dup; end  
 true 
 end and begin; yy_var45 = yy_context.input.pos; (yy_nontermj7(yy_context) and begin 
  current_line_and_column[0] += 1; current_line_and_column[1] = 1  
 true 
 end) or (yy_context.input.pos = yy_var45; (yy_char(yy_context) and begin 
  current_line_and_column[1] += 1  
 true 
 end)); end) then
        yy_context.input.pos = yy_var46
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm47(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "%%") and  begin
      while true
        ###
        yy_var4b = yy_context.input.pos
        ### Look ahead.
        yy_var4c = begin; yy_var4e = yy_context.input.pos; yy_nontermj7(yy_context) or (yy_context.input.pos = yy_var4e; yy_end?(yy_context)); end
        yy_context.input.pos = yy_var4b
        break if yy_var4c
        ### Repeat one more time (if possible).
        yy_var4c = yy_char(yy_context)
        if not yy_var4c then
          yy_context.input.pos = yy_var4b
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_var4e = yy_context.input.pos; yy_nontermj7(yy_context) or (yy_context.input.pos = yy_var4e; yy_end?(yy_context)); end) and yy_to_pcv(val) 
end 
def yy_nonterm4f(yy_context) 
val = :yy_nil 
(begin; yy_var76 = yy_context.input.pos; (yy_string(yy_context, "{") and while true
      yy_var78 = yy_context.input.pos
      if not yy_nontermj5(yy_context) then
        yy_context.input.pos = yy_var78
        break true
      end
    end and yy_string(yy_context, "...") and begin
      yy_var7k = yy_context.input.pos
      if not ( begin
      while true
        ###
        yy_var7i = yy_context.input.pos
        ### Look ahead.
        yy_var7j = yy_nontermj7(yy_context)
        yy_context.input.pos = yy_var7i
        break if yy_var7j
        ### Repeat one more time (if possible).
        yy_var7j = yy_nontermj5(yy_context)
        if not yy_var7j then
          yy_context.input.pos = yy_var7i
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nontermj7(yy_context)) then
        yy_context.input.pos = yy_var7k
      end
      true
    end and begin
      val = ""
      yy_var7x = yy_context.input.pos
       begin
      while true
        ###
        yy_var7v = yy_context.input.pos
        ### Look ahead.
        yy_var7w = begin; yy_var84 = yy_context.input.pos; (yy_string(yy_context, "...") and while true
      yy_var86 = yy_context.input.pos
      if not yy_nontermj5(yy_context) then
        yy_context.input.pos = yy_var86
        break true
      end
    end and yy_string(yy_context, "}")) or (yy_context.input.pos = yy_var84; (yy_string(yy_context, "}") and while true
      yy_var88 = yy_context.input.pos
      if not yy_nontermj5(yy_context) then
        yy_context.input.pos = yy_var88
        break true
      end
    end and yy_string(yy_context, "..."))); end
        yy_context.input.pos = yy_var7v
        break if yy_var7w
        ### Repeat one more time (if possible).
        yy_var7w = yy_char(yy_context)
        if not yy_var7w then
          yy_context.input.pos = yy_var7v
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var7y = yy_context.input.pos
        yy_context.input.pos = yy_var7x
        val << yy_context.input.read(yy_var7y - yy_var7x).force_encoding(Encoding::UTF_8)
      end
    end and begin; yy_var84 = yy_context.input.pos; (yy_string(yy_context, "...") and while true
      yy_var86 = yy_context.input.pos
      if not yy_nontermj5(yy_context) then
        yy_context.input.pos = yy_var86
        break true
      end
    end and yy_string(yy_context, "}")) or (yy_context.input.pos = yy_var84; (yy_string(yy_context, "}") and while true
      yy_var88 = yy_context.input.pos
      if not yy_nontermj5(yy_context) then
        yy_context.input.pos = yy_var88
        break true
      end
    end and yy_string(yy_context, "..."))); end) or (yy_context.input.pos = yy_var76; (begin
      val = ""
      yy_var8d = yy_context.input.pos
      yy_nonterm9v(yy_context) and begin
        yy_var8e = yy_context.input.pos
        yy_context.input.pos = yy_var8d
        val << yy_context.input.read(yy_var8e - yy_var8d).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = val[1...-1]  
 true 
 end)) or (yy_context.input.pos = yy_var76; (yy_nonterm47(yy_context) and begin
      val = ""
      yy_var97 = yy_context.input.pos
       begin
      while true
        ###
        yy_var95 = yy_context.input.pos
        ### Look ahead.
        yy_var96 = yy_nonterm47(yy_context)
        yy_context.input.pos = yy_var95
        break if yy_var96
        ### Repeat one more time (if possible).
        yy_var96 = yy_char(yy_context)
        if not yy_var96 then
          yy_context.input.pos = yy_var95
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var98 = yy_context.input.pos
        yy_context.input.pos = yy_var97
        val << yy_context.input.read(yy_var98 - yy_var97).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm47(yy_context))) or (yy_context.input.pos = yy_var76; (yy_nonterm47(yy_context) and begin
      val = ""
      yy_var9t = yy_context.input.pos
      while true
      yy_var9s = yy_context.input.pos
      if not yy_char(yy_context) then
        yy_context.input.pos = yy_var9s
        break true
      end
    end and begin
        yy_var9u = yy_context.input.pos
        yy_context.input.pos = yy_var9t
        val << yy_context.input.read(yy_var9u - yy_var9t).force_encoding(Encoding::UTF_8)
      end
    end and yy_end?(yy_context))); end and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nonterm9v(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "{") and  begin
      while true
        ###
        yy_vara1 = yy_context.input.pos
        ### Look ahead.
        yy_vara2 = yy_string(yy_context, "}")
        yy_context.input.pos = yy_vara1
        break if yy_vara2
        ### Repeat one more time (if possible).
        yy_vara2 = begin; yy_vara0 = yy_context.input.pos; yy_nonterm9v(yy_context) or (yy_context.input.pos = yy_vara0; yy_char(yy_context)); end
        if not yy_vara2 then
          yy_context.input.pos = yy_vara1
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string(yy_context, "}")) and yy_to_pcv(val) 
end 
def yy_nonterma3(yy_context) 
val = :yy_nil 
(begin; yy_vara6 = yy_context.input.pos; yy_string(yy_context, "<-") or (yy_context.input.pos = yy_vara6; yy_string(yy_context, "=")) or (yy_context.input.pos = yy_vara6; yy_string(yy_context, "\u{2190}")); end and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nonterma7(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ":") and (begin
      yy_varaq = yy_context.worst_error
      begin
        not begin
      yy_varar = yy_context.input.pos
      yy_varas = yy_string(yy_context, "+")
      yy_context.input.pos = yy_varar
      yy_varas
    end
      ensure
        yy_context.worst_error = yy_varaq
      end
    end and begin
      yy_varaw = yy_context.worst_error
      begin
        not begin
      yy_varax = yy_context.input.pos
      yy_varay = yy_string(yy_context, ">>")
      yy_context.input.pos = yy_varax
      yy_varay
    end
      ensure
        yy_context.worst_error = yy_varaw
      end
    end) and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermaz(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ":+") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb1(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ":>>") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb3(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ";") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb5(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "/") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb7(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "$") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb9(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "^") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbb(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "(") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbd(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ")") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbf(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "[") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbh(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "]") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbj(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "<") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbl(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ">") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbn(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "*") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbp(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "*?") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbr(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "?") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbt(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "+") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbv(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "&") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbx(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "!") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbz(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "@") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermc1(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "=") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermc3(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "...") and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermc5(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "char") and begin
      yy_varca = yy_context.worst_error
      begin
        not begin
      yy_varcb = yy_context.input.pos
      yy_varcc = yy_nontermgb(yy_context)
      yy_context.input.pos = yy_varcb
      yy_varcc
    end
      ensure
        yy_context.worst_error = yy_varca
      end
    end and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermcd(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "at") and begin
      yy_varci = yy_context.worst_error
      begin
        not begin
      yy_varcj = yy_context.input.pos
      yy_varck = yy_nontermgb(yy_context)
      yy_context.input.pos = yy_varcj
      yy_varck
    end
      ensure
        yy_context.worst_error = yy_varci
      end
    end and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermcl(yy_context) 
val = :yy_nil 
begin; yy_varcm = yy_context.input.pos; yy_nontermc5(yy_context) or (yy_context.input.pos = yy_varcm; yy_nontermcd(yy_context)); end and yy_to_pcv(val) 
end 
def yy_nontermcn(yy_context) 
val = :yy_nil 
(begin
      val = ""
      yy_vard9 = yy_context.input.pos
      (begin
      yy_vard4 = yy_context.input.pos
      if not begin; yy_vard3 = yy_context.input.pos; yy_string(yy_context, "@") or (yy_context.input.pos = yy_vard3; yy_string(yy_context, "$")); end then
        yy_context.input.pos = yy_vard4
      end
      true
    end and yy_nontermdr(yy_context) and while true
      yy_vard8 = yy_context.input.pos
      if not yy_nontermdt(yy_context) then
        yy_context.input.pos = yy_vard8
        break true
      end
    end) and begin
        yy_varda = yy_context.input.pos
        yy_context.input.pos = yy_vard9
        val << yy_context.input.read(yy_varda - yy_vard9).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermdb(yy_context) 
val = :yy_nil 
(begin
      val = ""
      yy_vardp = yy_context.input.pos
      (yy_nontermdr(yy_context) and while true
      yy_vardo = yy_context.input.pos
      if not yy_nontermdt(yy_context) then
        yy_context.input.pos = yy_vardo
        break true
      end
    end) and begin
        yy_vardq = yy_context.input.pos
        yy_context.input.pos = yy_vardp
        val << yy_context.input.read(yy_vardq - yy_vardp).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermdr(yy_context) 
val = :yy_nil 
begin; yy_vards = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_vards; yy_string(yy_context, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermdt(yy_context) 
val = :yy_nil 
begin; yy_vardu = yy_context.input.pos; yy_nontermdr(yy_context) or (yy_context.input.pos = yy_vardu; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermdv(yy_context) 
val = :yy_nil 
(begin
      val = ""
      yy_vare9 = yy_context.input.pos
      (yy_nontermeb(yy_context) and while true
      yy_vare8 = yy_context.input.pos
      if not yy_nontermed(yy_context) then
        yy_context.input.pos = yy_vare8
        break true
      end
    end) and begin
        yy_varea = yy_context.input.pos
        yy_context.input.pos = yy_vare9
        val << yy_context.input.read(yy_varea - yy_vare9).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermeb(yy_context) 
val = :yy_nil 
begin; yy_varec = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_varec; yy_string(yy_context, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermed(yy_context) 
val = :yy_nil 
begin; yy_varee = yy_context.input.pos; yy_nontermeb(yy_context) or (yy_context.input.pos = yy_varee; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermef(yy_context) 
val = :yy_nil 
(begin
      yy_varek = yy_context.worst_error
      begin
        not begin
      yy_varel = yy_context.input.pos
      yy_varem = yy_nontermcl(yy_context)
      yy_context.input.pos = yy_varel
      yy_varem
    end
      ensure
        yy_context.worst_error = yy_varek
      end
    end and begin; yy_varfg = yy_context.input.pos; (begin
      val = ""
      yy_varft = yy_context.input.pos
      (yy_nontermg9(yy_context) and while true
      yy_varfs = yy_context.input.pos
      if not yy_nontermgb(yy_context) then
        yy_context.input.pos = yy_varfs
        break true
      end
    end) and begin
        yy_varfu = yy_context.input.pos
        yy_context.input.pos = yy_varft
        val << yy_context.input.read(yy_varfu - yy_varft).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermip(yy_context)) or (yy_context.input.pos = yy_varfg; (begin
      val = ""
      yy_varg7 = yy_context.input.pos
      (yy_string(yy_context, "`") and  begin
      while true
        ###
        yy_varg5 = yy_context.input.pos
        ### Look ahead.
        yy_varg6 = yy_string(yy_context, "`")
        yy_context.input.pos = yy_varg5
        break if yy_varg6
        ### Repeat one more time (if possible).
        yy_varg6 = yy_char(yy_context)
        if not yy_varg6 then
          yy_context.input.pos = yy_varg5
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string(yy_context, "`")) and begin
        yy_varg8 = yy_context.input.pos
        yy_context.input.pos = yy_varg7
        val << yy_context.input.read(yy_varg8 - yy_varg7).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermip(yy_context))); end) and yy_to_pcv(val) 
end 
def yy_nontermg9(yy_context) 
val = :yy_nil 
begin; yy_varga = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_varga; yy_char_range(yy_context, "A", "Z")) or (yy_context.input.pos = yy_varga; yy_string(yy_context, "-")) or (yy_context.input.pos = yy_varga; yy_string(yy_context, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermgb(yy_context) 
val = :yy_nil 
begin; yy_vargc = yy_context.input.pos; yy_nontermg9(yy_context) or (yy_context.input.pos = yy_vargc; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermgd(yy_context) 
val = :yy_nil 
(begin
      yy_vargf = yy_nontermgj(yy_context)
      if yy_vargf then
        from = yy_from_pcv(yy_vargf)
      end
      yy_vargf
    end and begin; yy_vargh = yy_context.input.pos; yy_string(yy_context, "...") or (yy_context.input.pos = yy_vargh; yy_string(yy_context, "..")) or (yy_context.input.pos = yy_vargh; yy_string(yy_context, "\u{2026}")) or (yy_context.input.pos = yy_vargh; yy_string(yy_context, "\u{2025}")); end and yy_nontermip(yy_context) and begin
      yy_vargi = yy_nontermgj(yy_context)
      if yy_vargi then
        to = yy_from_pcv(yy_vargi)
      end
      yy_vargi
    end and yy_nontermip(yy_context) and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermgj(yy_context) 
val = :yy_nil 
(begin; yy_varhf = yy_context.input.pos; (yy_string(yy_context, "'") and begin
      val = ""
      yy_varhs = yy_context.input.pos
       begin
      while true
        ###
        yy_varhq = yy_context.input.pos
        ### Look ahead.
        yy_varhr = yy_string(yy_context, "'")
        yy_context.input.pos = yy_varhq
        break if yy_varhr
        ### Repeat one more time (if possible).
        yy_varhr = yy_char(yy_context)
        if not yy_varhr then
          yy_context.input.pos = yy_varhq
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varht = yy_context.input.pos
        yy_context.input.pos = yy_varhs
        val << yy_context.input.read(yy_varht - yy_varhs).force_encoding(Encoding::UTF_8)
      end
    end and yy_string(yy_context, "'")) or (yy_context.input.pos = yy_varhf; (yy_string(yy_context, "\"") and begin
      val = ""
      yy_vari6 = yy_context.input.pos
       begin
      while true
        ###
        yy_vari4 = yy_context.input.pos
        ### Look ahead.
        yy_vari5 = yy_string(yy_context, "\"")
        yy_context.input.pos = yy_vari4
        break if yy_vari5
        ### Repeat one more time (if possible).
        yy_vari5 = yy_char(yy_context)
        if not yy_vari5 then
          yy_context.input.pos = yy_vari4
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_vari7 = yy_context.input.pos
        yy_context.input.pos = yy_vari6
        val << yy_context.input.read(yy_vari7 - yy_vari6).force_encoding(Encoding::UTF_8)
      end
    end and yy_string(yy_context, "\""))) or (yy_context.input.pos = yy_varhf; (begin
      yy_vari8 = yy_nontermi9(yy_context)
      if yy_vari8 then
        code = yy_from_pcv(yy_vari8)
      end
      yy_vari8
    end and begin 
  val = "" << code  
 true 
 end)); end and yy_nontermip(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermi9(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "U+") and begin
      code = ""
      yy_varin = yy_context.input.pos
      begin; yy_varil = yy_context.input.pos; yy_char_range(yy_context, "0", "9") or (yy_context.input.pos = yy_varil; yy_char_range(yy_context, "A", "F")); end and while true
      yy_varim = yy_context.input.pos
      if not begin; yy_varil = yy_context.input.pos; yy_char_range(yy_context, "0", "9") or (yy_context.input.pos = yy_varil; yy_char_range(yy_context, "A", "F")); end then
        yy_context.input.pos = yy_varim
        break true
      end
    end and begin
        yy_vario = yy_context.input.pos
        yy_context.input.pos = yy_varin
        code << yy_context.input.read(yy_vario - yy_varin).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermip(yy_context) 
val = :yy_nil 
while true
      yy_variu = yy_context.input.pos
      if not begin; yy_varit = yy_context.input.pos; yy_nontermj5(yy_context) or (yy_context.input.pos = yy_varit; yy_nontermiv(yy_context)); end then
        yy_context.input.pos = yy_variu
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nontermiv(yy_context) 
val = :yy_nil 
(begin; yy_variy = yy_context.input.pos; yy_string(yy_context, "#") or (yy_context.input.pos = yy_variy; yy_string(yy_context, "--")); end and  begin
      while true
        ###
        yy_varj1 = yy_context.input.pos
        ### Look ahead.
        yy_varj2 = begin; yy_varj4 = yy_context.input.pos; yy_nontermj7(yy_context) or (yy_context.input.pos = yy_varj4; yy_end?(yy_context)); end
        yy_context.input.pos = yy_varj1
        break if yy_varj2
        ### Repeat one more time (if possible).
        yy_varj2 = yy_char(yy_context)
        if not yy_varj2 then
          yy_context.input.pos = yy_varj1
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_varj4 = yy_context.input.pos; yy_nontermj7(yy_context) or (yy_context.input.pos = yy_varj4; yy_end?(yy_context)); end) and yy_to_pcv(val) 
end 
def yy_nontermj5(yy_context) 
val = :yy_nil 
begin; yy_varj6 = yy_context.input.pos; yy_char_range(yy_context, "\t", "\r") or (yy_context.input.pos = yy_varj6; yy_string(yy_context, " ")) or (yy_context.input.pos = yy_varj6; yy_string(yy_context, "\u{85}")) or (yy_context.input.pos = yy_varj6; yy_string(yy_context, "\u{a0}")) or (yy_context.input.pos = yy_varj6; yy_string(yy_context, "\u{1680}")) or (yy_context.input.pos = yy_varj6; yy_string(yy_context, "\u{180e}")) or (yy_context.input.pos = yy_varj6; yy_char_range(yy_context, "\u{2000}", "\u{200a}")) or (yy_context.input.pos = yy_varj6; yy_string(yy_context, "\u{2028}")) or (yy_context.input.pos = yy_varj6; yy_string(yy_context, "\u{2029}")) or (yy_context.input.pos = yy_varj6; yy_string(yy_context, "\u{202f}")) or (yy_context.input.pos = yy_varj6; yy_string(yy_context, "\u{205f}")) or (yy_context.input.pos = yy_varj6; yy_string(yy_context, "\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nontermj7(yy_context) 
val = :yy_nil 
begin; yy_varj8 = yy_context.input.pos; (yy_string(yy_context, "\r") and yy_string(yy_context, "\n")) or (yy_context.input.pos = yy_varj8; yy_string(yy_context, "\r")) or (yy_context.input.pos = yy_varj8; yy_string(yy_context, "\n")) or (yy_context.input.pos = yy_varj8; yy_string(yy_context, "\u{85}")) or (yy_context.input.pos = yy_varj8; yy_string(yy_context, "\v")) or (yy_context.input.pos = yy_varj8; yy_string(yy_context, "\f")) or (yy_context.input.pos = yy_varj8; yy_string(yy_context, "\u{2028}")) or (yy_context.input.pos = yy_varj8; yy_string(yy_context, "\u{2029}")); end and yy_to_pcv(val) 
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
  
  def lazy_repeat_code(parsing_code)
    #
    original_pos_var = new_unique_variable_name
    result_var = new_unique_variable_name
    #
    code(%[ begin
      while true
        ###
        #{original_pos_var} = yy_context.input.pos
        ### Look ahead.
        #{result_var} = ]) + LazyRepeat::UnknownLookAheadCode.new + code(%[
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
          context << YY_SyntaxExpectationError.new(string.inspect, string_start_pos)
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
          context << YY_SyntaxExpectationError.new(%(\#{from.inspect}\...\#{to.inspect}), char_start_pos)
          # 
          return nil
        end
        #
        return c
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
  
  def check_no_unresolved_nonterminals(code)
    code.each do |code_part|
      if code_part.is_a? UnknownMethodCall then
        raise YY_SyntaxError.new(%(rule #{code_part.nonterminal} is not defined), code_part.source_pos)
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
      
      def to_s
        raise CodeCanNotBeDetermined.new self
      end
      
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
  
end


class Array
  
  alias add <<
  
end


if $0 == __FILE__
  File.open(ARGV[0]) do |io|
    begin
      PEGParserGenerator.new.call(io)
    rescue PEGParserGenerator::YY_SyntaxError => e
      io.pos = 0
      line, column = *(PEGParserGenerator.new.line_and_column(io))
      STDERR.puts %(error at #{line}:#{column}: #{e.message})
      exit 1
    end
  end
end
