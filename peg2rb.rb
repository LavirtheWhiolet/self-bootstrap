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
  
  private
  
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
        
        # It is YY_SyntaxError or nil.
        attr_reader :worst_error
        
        # adds possible error to this YY_ParsingContext.
        # 
        # +error+ is YY_SyntaxError.
        # 
        def << error
          # Update worst_error.
          if worst_error.nil? or worst_error.pos < error.pos then
            @worst_error = error
          end
          # 
          return self
        end
        
      end
      
      def yy_string(context, string)
        # Read string.
        read_string = context.input.read(string.bytesize)
        # Set the string's encoding; check if it fits the argument.
        unless read_string and (read_string.force_encoding(Encoding::UTF_8)) == string then
          # 
          context << YY_SyntaxError.new(%(#{string.inspect} is expected), context.input.pos)
          # 
          return nil
        end
        # 
        return read_string
      end
      
      def yy_eof?(context)
        #
        if not context.input.eof?
          context << YY_SyntaxError.new(%(the end is expected), context.input.pos)
          return nil
        end
        #
        return true
      end
      
      def yy_char(context)
        # Read a char.
        c = context.input.getc
        # 
        unless c then
          #
          context << YY_SyntaxError.new(%(a character is expected), context.input.pos)
          #
          return nil
        end
        #
        return c
      end
      
      def yy_char_range(context, from, to)
        # Read the char.
        c = context.input.getc
        # Check if it fits the range.
        # NOTE: c has UTF-8 encoding.
        unless c and (from <= c and c <= to) then
          # 
          context << YY_SyntaxError.new(%(#{from.inspect}...#{to.inspect} is expected), context.input.pos)
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
    def yy_nonterm1(yy_context) 
val = :yy_nil 
(begin 
 
    code = code("")
    rule_is_first = true
    method_names = HashMap.new
   
 true 
 end and yy_nontermho(yy_context) and while true
      yy_vara = yy_context.input.pos
      if not begin; yy_var7 = yy_context.input.pos; (begin
      yy_var8 = yy_nonterm22(yy_context)
      if yy_var8 then
        rule = yy_from_pcv(yy_var8)
      end
      yy_var8
    end and begin 
 
        # Check that the rule is not defined twice.
        if method_names.has_key?(rule.name) then
          raise %(rule #{rule.name} is defined more than once)
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
 end) or (yy_context.input.pos = yy_var7; (begin
      yy_var9 = yy_nonterm3s(yy_context)
      if yy_var9 then
        action_code = yy_from_pcv(yy_var9)
      end
      yy_var9
    end and begin 
 
        code += code(action_code)
       
 true 
 end)); end then
        yy_context.input.pos = yy_vara
        break true
      end
    end and yy_eof?(yy_context) and begin 
 
    code = link(code, method_names)
    print code
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermb(yy_context) 
val = :yy_nil 
begin
      yy_vard = yy_nonterme(yy_context)
      if yy_vard then
        val = yy_from_pcv(yy_vard)
      end
      yy_vard
    end and yy_to_pcv(val) 
end 
def yy_nonterme(yy_context) 
val = :yy_nil 
(begin 
 
    single_expression = true
    remembered_pos_var = new_unique_variable_name
   
 true 
 end and begin
      yy_varh = yy_context.input.pos
      if not yy_nontermaa(yy_context) then
        yy_context.input.pos = yy_varh
      end
      true
    end and begin
      yy_vari = yy_nontermp(yy_context)
      if yy_vari then
        val = yy_from_pcv(yy_vari)
      end
      yy_vari
    end and while true
      yy_varo = yy_context.input.pos
      if not (yy_nontermaa(yy_context) and begin
      yy_varn = yy_nontermp(yy_context)
      if yy_varn then
        val2 = yy_from_pcv(yy_varn)
      end
      yy_varn
    end and begin 
 
      single_expression = false
      val = val + (code " or (yy_context.input.pos = #{remembered_pos_var}; ") + val2 + (code ")")
     
 true 
 end) then
        yy_context.input.pos = yy_varo
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "begin; #{remembered_pos_var} = yy_context.input.pos; ") + val + (code "; end")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermp(yy_context) 
val = :yy_nil 
(begin 
  code_parts = []  
 true 
 end and begin; yy_varu = yy_context.input.pos; (begin
      yy_varv = yy_nontermy(yy_context)
      if yy_varv then
        code_part = yy_from_pcv(yy_varv)
      end
      yy_varv
    end and begin 
  code_parts.add code_part  
 true 
 end) or (yy_context.input.pos = yy_varu; (yy_nontermam(yy_context) and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end and while true
      yy_varw = yy_context.input.pos
      if not begin; yy_varu = yy_context.input.pos; (begin
      yy_varv = yy_nontermy(yy_context)
      if yy_varv then
        code_part = yy_from_pcv(yy_varv)
      end
      yy_varv
    end and begin 
  code_parts.add code_part  
 true 
 end) or (yy_context.input.pos = yy_varu; (yy_nontermam(yy_context) and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end then
        yy_context.input.pos = yy_varw
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
  
def yy_nontermy(yy_context) 
val = :yy_nil 
begin; yy_varz = yy_context.input.pos; (begin
      yy_var10 = yy_nonterm14(yy_context)
      if yy_var10 then
        c = yy_from_pcv(yy_var10)
      end
      yy_var10
    end and begin
      yy_var11 = yy_nonterm3i(yy_context)
      if yy_var11 then
        t = yy_from_pcv(yy_var11)
      end
      yy_var11
    end and begin
      yy_var12 = yy_nonterm3e(yy_context)
      if yy_var12 then
        var = yy_from_pcv(yy_var12)
      end
      yy_var12
    end and begin 
  val = capture_semantic_value_code(var, c, t)  
 true 
 end) or (yy_context.input.pos = yy_varz; begin
      yy_var13 = yy_nonterm14(yy_context)
      if yy_var13 then
        val = yy_from_pcv(yy_var13)
      end
      yy_var13
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm14(yy_context) 
val = :yy_nil 
begin; yy_var15 = yy_context.input.pos; (yy_nontermb0(yy_context) and begin
      yy_var16 = yy_nonterm3s(yy_context)
      if yy_var16 then
        c = yy_from_pcv(yy_var16)
      end
      yy_var16
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (yy_context.input.pos = yy_var15; (yy_nontermb0(yy_context) and begin
      yy_var17 = yy_nonterm14(yy_context)
      if yy_var17 then
        val = yy_from_pcv(yy_var17)
      end
      yy_var17
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var15; (yy_nontermb2(yy_context) and begin
      yy_var18 = yy_nonterm14(yy_context)
      if yy_var18 then
        val = yy_from_pcv(yy_var18)
      end
      yy_var18
    end and begin 
  val = code(%(not )) + positive_predicate_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var15; begin
      yy_var19 = yy_nonterm1a(yy_context)
      if yy_var19 then
        val = yy_from_pcv(yy_var19)
      end
      yy_var19
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1a(yy_context) 
val = :yy_nil 
(begin
      yy_var1c = yy_nonterm1h(yy_context)
      if yy_var1c then
        val = yy_from_pcv(yy_var1c)
      end
      yy_var1c
    end and while true
      yy_var1g = yy_context.input.pos
      if not begin; yy_var1f = yy_context.input.pos; (yy_nontermau(yy_context) and begin 
  val = lazy_repeat_code(val)  
 true 
 end) or (yy_context.input.pos = yy_var1f; (yy_nontermas(yy_context) and begin 
  val = repeat_many_times_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var1f; (yy_nontermay(yy_context) and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var1f; (yy_nontermaw(yy_context) and begin 
  val = optional_code(val)  
 true 
 end)); end then
        yy_context.input.pos = yy_var1g
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm1h(yy_context) 
val = :yy_nil 
begin; yy_var1i = yy_context.input.pos; (yy_nontermag(yy_context) and begin
      yy_var1j = yy_nontermb(yy_context)
      if yy_var1j then
        val = yy_from_pcv(yy_var1j)
      end
      yy_var1j
    end and yy_nontermai(yy_context)) or (yy_context.input.pos = yy_var1i; (yy_nontermao(yy_context) and begin
      yy_var1k = yy_nontermb(yy_context)
      if yy_var1k then
        c = yy_from_pcv(yy_var1k)
      end
      yy_var1k
    end and yy_nontermaq(yy_context) and begin
      yy_var1l = yy_nonterm3i(yy_context)
      if yy_var1l then
        t = yy_from_pcv(yy_var1l)
      end
      yy_var1l
    end and begin
      yy_var1m = yy_nonterm3e(yy_context)
      if yy_var1m then
        var = yy_from_pcv(yy_var1m)
      end
      yy_var1m
    end and begin 
  val = capture_text_code(var, c, t)  
 true 
 end)) or (yy_context.input.pos = yy_var1i; begin
      yy_var1n = yy_nonterm1o(yy_context)
      if yy_var1n then
        val = yy_from_pcv(yy_var1n)
      end
      yy_var1n
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1o(yy_context) 
val = :yy_nil 
begin; yy_var1p = yy_context.input.pos; (begin
      yy_var1q = yy_nontermfc(yy_context)
      if yy_var1q then
        r = yy_from_pcv(yy_var1q)
      end
      yy_var1q
    end and begin 
  val = code "yy_char_range(yy_context, #{r.begin.to_ruby_code}, #{r.end.to_ruby_code})"  
 true 
 end) or (yy_context.input.pos = yy_var1p; (begin
      yy_var1r = yy_nontermfi(yy_context)
      if yy_var1r then
        s = yy_from_pcv(yy_var1r)
      end
      yy_var1r
    end and begin 
  val = code "yy_string(yy_context, #{s.to_ruby_code})"  
 true 
 end)) or (yy_context.input.pos = yy_var1p; (begin
      yy_var1s = yy_nontermdg(yy_context)
      if yy_var1s then
        n = yy_from_pcv(yy_var1s)
      end
      yy_var1s
    end and begin 
  val = UnknownMethodCall[n, %(yy_context)]  
 true 
 end)) or (yy_context.input.pos = yy_var1p; (yy_nontermba(yy_context) and begin 
  val = code "yy_char(yy_context)"  
 true 
 end)) or (yy_context.input.pos = yy_var1p; (begin
      yy_var1t = yy_nonterm3s(yy_context)
      if yy_var1t then
        a = yy_from_pcv(yy_var1t)
      end
      yy_var1t
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (yy_context.input.pos = yy_var1p; (yy_nontermac(yy_context) and begin 
  val = code "yy_eof?(yy_context)"  
 true 
 end)) or (yy_context.input.pos = yy_var1p; (yy_nontermae(yy_context) and begin 
  val = code "(yy_context.input.pos == 0)"  
 true 
 end)) or (yy_context.input.pos = yy_var1p; (begin; yy_var1x = yy_context.input.pos; (yy_nontermb4(yy_context) and yy_nontermb6(yy_context) and begin
      yy_var1y = yy_nontermbo(yy_context)
      if yy_var1y then
        pos_variable = yy_from_pcv(yy_var1y)
      end
      yy_var1y
    end) or (yy_context.input.pos = yy_var1x; (yy_nontermbg(yy_context) and begin
      yy_var1z = yy_nontermbo(yy_context)
      if yy_var1z then
        pos_variable = yy_from_pcv(yy_var1z)
      end
      yy_var1z
    end)); end and begin
      yy_var21 = yy_context.input.pos
      if not yy_nonterm9k(yy_context) then
        yy_context.input.pos = yy_var21
      end
      true
    end and begin 
  val = code "(yy_context.input.pos = #{pos_variable}; true)"  
 true 
 end)) or (yy_context.input.pos = yy_var1p; (yy_nontermb4(yy_context) and begin 
  val = code "yy_context.input.pos"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm22(yy_context) 
val = :yy_nil 
(begin 
  rule = val = Rule.new  
 true 
 end and begin; yy_var2b = yy_context.input.pos; (begin
      yy_var2c = yy_nontermcw(yy_context)
      if yy_var2c then
        rule_name = yy_from_pcv(yy_var2c)
      end
      yy_var2c
    end and yy_nontermag(yy_context) and begin
      yy_var2g = yy_context.input.pos
      if not begin; yy_var2f = yy_context.input.pos; yy_nontermb8(yy_context) or (yy_context.input.pos = yy_var2f; yy_nontermcc(yy_context)); end then
        yy_context.input.pos = yy_var2g
      end
      true
    end and yy_nontermai(yy_context) and begin 
  rule.need_entry_point!  
 true 
 end) or (yy_context.input.pos = yy_var2b; begin
      yy_var2h = yy_nontermdg(yy_context)
      if yy_var2h then
        rule_name = yy_from_pcv(yy_var2h)
      end
      yy_var2h
    end); end and begin 
  rule.name = rule_name  
 true 
 end and begin
      yy_var2l = yy_context.input.pos
      if not (yy_nonterm9k(yy_context) and yy_nonterm2o(yy_context)) then
        yy_context.input.pos = yy_var2l
      end
      true
    end and yy_nonterm9g(yy_context) and begin
      yy_var2m = yy_nontermb(yy_context)
      if yy_var2m then
        c = yy_from_pcv(yy_var2m)
      end
      yy_var2m
    end and yy_nonterma8(yy_context) and begin 
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

def yy_nonterm2o(yy_context) 
val = :yy_nil 
((not begin
      yy_var3b = yy_context.input.pos
      yy_var3c = yy_nonterm9g(yy_context)
      yy_context.input.pos = yy_var3b
      yy_var3c
    end and yy_char(yy_context)) and yy_nontermho(yy_context)) and while true
      yy_var3d = yy_context.input.pos
      if not ((not begin
      yy_var3b = yy_context.input.pos
      yy_var3c = yy_nonterm9g(yy_context)
      yy_context.input.pos = yy_var3b
      yy_var3c
    end and yy_char(yy_context)) and yy_nontermho(yy_context)) then
        yy_context.input.pos = yy_var3d
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm3e(yy_context) 
val = :yy_nil 
begin; yy_var3f = yy_context.input.pos; begin
      yy_var3g = yy_nontermbo(yy_context)
      if yy_var3g then
        val = yy_from_pcv(yy_var3g)
      end
      yy_var3g
    end or (yy_context.input.pos = yy_var3f; (yy_nontermag(yy_context) and begin
      yy_var3h = yy_nontermbo(yy_context)
      if yy_var3h then
        val = yy_from_pcv(yy_var3h)
      end
      yy_var3h
    end and yy_nontermai(yy_context))); end and yy_to_pcv(val) 
end 
def yy_nonterm3i(yy_context) 
val = :yy_nil 
begin; yy_var3j = yy_context.input.pos; (yy_nonterm9k(yy_context) and begin 
 val = :capture 
 true 
 end) or (yy_context.input.pos = yy_var3j; (yy_nonterma4(yy_context) and begin 
 val = :append 
 true 
 end)) or (yy_context.input.pos = yy_var3j; (yy_nonterma6(yy_context) and begin 
 val = :append 
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm3k(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "%%") and  begin
      while true
        ###
        yy_var3o = yy_context.input.pos
        ### Look ahead.
        yy_var3p = begin; yy_var3r = yy_context.input.pos; yy_nontermi6(yy_context) or (yy_context.input.pos = yy_var3r; yy_eof?(yy_context)); end
        yy_context.input.pos = yy_var3o
        break if yy_var3p
        ### Repeat one more time (if possible).
        yy_var3p = yy_char(yy_context)
        if not yy_var3p then
          yy_context.input.pos = yy_var3o
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_var3r = yy_context.input.pos; yy_nontermi6(yy_context) or (yy_context.input.pos = yy_var3r; yy_eof?(yy_context)); end) and yy_to_pcv(val) 
end 
def yy_nonterm3s(yy_context) 
val = :yy_nil 
(begin; yy_var6j = yy_context.input.pos; (yy_string(yy_context, "{") and while true
      yy_var6l = yy_context.input.pos
      if not yy_nontermi4(yy_context) then
        yy_context.input.pos = yy_var6l
        break true
      end
    end and yy_string(yy_context, "...") and begin
      yy_var6x = yy_context.input.pos
      if not ( begin
      while true
        ###
        yy_var6v = yy_context.input.pos
        ### Look ahead.
        yy_var6w = yy_nontermi6(yy_context)
        yy_context.input.pos = yy_var6v
        break if yy_var6w
        ### Repeat one more time (if possible).
        yy_var6w = yy_nontermi4(yy_context)
        if not yy_var6w then
          yy_context.input.pos = yy_var6v
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nontermi6(yy_context)) then
        yy_context.input.pos = yy_var6x
      end
      true
    end and begin
      val = ""
      yy_var7a = yy_context.input.pos
       begin
      while true
        ###
        yy_var78 = yy_context.input.pos
        ### Look ahead.
        yy_var79 = begin; yy_var7h = yy_context.input.pos; (yy_string(yy_context, "...") and while true
      yy_var7j = yy_context.input.pos
      if not yy_nontermi4(yy_context) then
        yy_context.input.pos = yy_var7j
        break true
      end
    end and yy_string(yy_context, "}")) or (yy_context.input.pos = yy_var7h; (yy_string(yy_context, "}") and while true
      yy_var7l = yy_context.input.pos
      if not yy_nontermi4(yy_context) then
        yy_context.input.pos = yy_var7l
        break true
      end
    end and yy_string(yy_context, "..."))); end
        yy_context.input.pos = yy_var78
        break if yy_var79
        ### Repeat one more time (if possible).
        yy_var79 = yy_char(yy_context)
        if not yy_var79 then
          yy_context.input.pos = yy_var78
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var7b = yy_context.input.pos
        yy_context.input.pos = yy_var7a
        val << yy_context.input.read(yy_var7b - yy_var7a).force_encoding(Encoding::UTF_8)
      end
    end and begin; yy_var7h = yy_context.input.pos; (yy_string(yy_context, "...") and while true
      yy_var7j = yy_context.input.pos
      if not yy_nontermi4(yy_context) then
        yy_context.input.pos = yy_var7j
        break true
      end
    end and yy_string(yy_context, "}")) or (yy_context.input.pos = yy_var7h; (yy_string(yy_context, "}") and while true
      yy_var7l = yy_context.input.pos
      if not yy_nontermi4(yy_context) then
        yy_context.input.pos = yy_var7l
        break true
      end
    end and yy_string(yy_context, "..."))); end) or (yy_context.input.pos = yy_var6j; (begin
      val = ""
      yy_var7q = yy_context.input.pos
      yy_nonterm98(yy_context) and begin
        yy_var7r = yy_context.input.pos
        yy_context.input.pos = yy_var7q
        val << yy_context.input.read(yy_var7r - yy_var7q).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = val[1...-1]  
 true 
 end)) or (yy_context.input.pos = yy_var6j; (yy_nonterm3k(yy_context) and begin
      val = ""
      yy_var8k = yy_context.input.pos
       begin
      while true
        ###
        yy_var8i = yy_context.input.pos
        ### Look ahead.
        yy_var8j = yy_nonterm3k(yy_context)
        yy_context.input.pos = yy_var8i
        break if yy_var8j
        ### Repeat one more time (if possible).
        yy_var8j = yy_char(yy_context)
        if not yy_var8j then
          yy_context.input.pos = yy_var8i
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var8l = yy_context.input.pos
        yy_context.input.pos = yy_var8k
        val << yy_context.input.read(yy_var8l - yy_var8k).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm3k(yy_context))) or (yy_context.input.pos = yy_var6j; (yy_nonterm3k(yy_context) and begin
      val = ""
      yy_var96 = yy_context.input.pos
      while true
      yy_var95 = yy_context.input.pos
      if not yy_char(yy_context) then
        yy_context.input.pos = yy_var95
        break true
      end
    end and begin
        yy_var97 = yy_context.input.pos
        yy_context.input.pos = yy_var96
        val << yy_context.input.read(yy_var97 - yy_var96).force_encoding(Encoding::UTF_8)
      end
    end and yy_eof?(yy_context))); end and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nonterm98(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "{") and  begin
      while true
        ###
        yy_var9e = yy_context.input.pos
        ### Look ahead.
        yy_var9f = yy_string(yy_context, "}")
        yy_context.input.pos = yy_var9e
        break if yy_var9f
        ### Repeat one more time (if possible).
        yy_var9f = begin; yy_var9d = yy_context.input.pos; yy_nonterm98(yy_context) or (yy_context.input.pos = yy_var9d; yy_char(yy_context)); end
        if not yy_var9f then
          yy_context.input.pos = yy_var9e
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string(yy_context, "}")) and yy_to_pcv(val) 
end 
def yy_nonterm9g(yy_context) 
val = :yy_nil 
(begin; yy_var9j = yy_context.input.pos; yy_string(yy_context, "<-") or (yy_context.input.pos = yy_var9j; yy_string(yy_context, "=")) or (yy_context.input.pos = yy_var9j; yy_string(yy_context, "\u{2190}")); end and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nonterm9k(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ":") and (not begin
      yy_var9y = yy_context.input.pos
      yy_var9z = yy_string(yy_context, "+")
      yy_context.input.pos = yy_var9y
      yy_var9z
    end and not begin
      yy_vara2 = yy_context.input.pos
      yy_vara3 = yy_string(yy_context, ">>")
      yy_context.input.pos = yy_vara2
      yy_vara3
    end) and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nonterma4(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ":+") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nonterma6(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ":>>") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nonterma8(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ";") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermaa(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "/") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermac(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "$") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermae(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "^") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermag(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "(") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermai(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ")") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermak(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "[") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermam(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "]") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermao(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "<") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermaq(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ">") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermas(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "*") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermau(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "*?") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermaw(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "?") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermay(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "+") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb0(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "&") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb2(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "!") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb4(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "@") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb6(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "=") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb8(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "...") and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermba(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "char") and not begin
      yy_varbe = yy_context.input.pos
      yy_varbf = yy_nontermfa(yy_context)
      yy_context.input.pos = yy_varbe
      yy_varbf
    end and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbg(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "at") and not begin
      yy_varbk = yy_context.input.pos
      yy_varbl = yy_nontermfa(yy_context)
      yy_context.input.pos = yy_varbk
      yy_varbl
    end and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbm(yy_context) 
val = :yy_nil 
begin; yy_varbn = yy_context.input.pos; yy_nontermba(yy_context) or (yy_context.input.pos = yy_varbn; yy_nontermbg(yy_context)); end and yy_to_pcv(val) 
end 
def yy_nontermbo(yy_context) 
val = :yy_nil 
(begin
      val = ""
      yy_varca = yy_context.input.pos
      (begin
      yy_varc5 = yy_context.input.pos
      if not begin; yy_varc4 = yy_context.input.pos; yy_string(yy_context, "@") or (yy_context.input.pos = yy_varc4; yy_string(yy_context, "$")); end then
        yy_context.input.pos = yy_varc5
      end
      true
    end and yy_nontermcs(yy_context) and while true
      yy_varc9 = yy_context.input.pos
      if not yy_nontermcu(yy_context) then
        yy_context.input.pos = yy_varc9
        break true
      end
    end) and begin
        yy_varcb = yy_context.input.pos
        yy_context.input.pos = yy_varca
        val << yy_context.input.read(yy_varcb - yy_varca).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermcc(yy_context) 
val = :yy_nil 
(begin
      val = ""
      yy_varcq = yy_context.input.pos
      (yy_nontermcs(yy_context) and while true
      yy_varcp = yy_context.input.pos
      if not yy_nontermcu(yy_context) then
        yy_context.input.pos = yy_varcp
        break true
      end
    end) and begin
        yy_varcr = yy_context.input.pos
        yy_context.input.pos = yy_varcq
        val << yy_context.input.read(yy_varcr - yy_varcq).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermcs(yy_context) 
val = :yy_nil 
begin; yy_varct = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_varct; yy_string(yy_context, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermcu(yy_context) 
val = :yy_nil 
begin; yy_varcv = yy_context.input.pos; yy_nontermcs(yy_context) or (yy_context.input.pos = yy_varcv; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermcw(yy_context) 
val = :yy_nil 
(begin
      val = ""
      yy_varda = yy_context.input.pos
      (yy_nontermdc(yy_context) and while true
      yy_vard9 = yy_context.input.pos
      if not yy_nontermde(yy_context) then
        yy_context.input.pos = yy_vard9
        break true
      end
    end) and begin
        yy_vardb = yy_context.input.pos
        yy_context.input.pos = yy_varda
        val << yy_context.input.read(yy_vardb - yy_varda).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermdc(yy_context) 
val = :yy_nil 
begin; yy_vardd = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_vardd; yy_string(yy_context, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermde(yy_context) 
val = :yy_nil 
begin; yy_vardf = yy_context.input.pos; yy_nontermdc(yy_context) or (yy_context.input.pos = yy_vardf; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermdg(yy_context) 
val = :yy_nil 
(not begin
      yy_vardk = yy_context.input.pos
      yy_vardl = yy_nontermbm(yy_context)
      yy_context.input.pos = yy_vardk
      yy_vardl
    end and begin; yy_varef = yy_context.input.pos; (begin
      val = ""
      yy_vares = yy_context.input.pos
      (yy_nontermf8(yy_context) and while true
      yy_varer = yy_context.input.pos
      if not yy_nontermfa(yy_context) then
        yy_context.input.pos = yy_varer
        break true
      end
    end) and begin
        yy_varet = yy_context.input.pos
        yy_context.input.pos = yy_vares
        val << yy_context.input.read(yy_varet - yy_vares).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermho(yy_context)) or (yy_context.input.pos = yy_varef; (begin
      val = ""
      yy_varf6 = yy_context.input.pos
      (yy_string(yy_context, "`") and  begin
      while true
        ###
        yy_varf4 = yy_context.input.pos
        ### Look ahead.
        yy_varf5 = yy_string(yy_context, "`")
        yy_context.input.pos = yy_varf4
        break if yy_varf5
        ### Repeat one more time (if possible).
        yy_varf5 = yy_char(yy_context)
        if not yy_varf5 then
          yy_context.input.pos = yy_varf4
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string(yy_context, "`")) and begin
        yy_varf7 = yy_context.input.pos
        yy_context.input.pos = yy_varf6
        val << yy_context.input.read(yy_varf7 - yy_varf6).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermho(yy_context))); end) and yy_to_pcv(val) 
end 
def yy_nontermf8(yy_context) 
val = :yy_nil 
begin; yy_varf9 = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_varf9; yy_char_range(yy_context, "A", "Z")) or (yy_context.input.pos = yy_varf9; yy_string(yy_context, "-")) or (yy_context.input.pos = yy_varf9; yy_string(yy_context, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermfa(yy_context) 
val = :yy_nil 
begin; yy_varfb = yy_context.input.pos; yy_nontermf8(yy_context) or (yy_context.input.pos = yy_varfb; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermfc(yy_context) 
val = :yy_nil 
(begin
      yy_varfe = yy_nontermfi(yy_context)
      if yy_varfe then
        from = yy_from_pcv(yy_varfe)
      end
      yy_varfe
    end and begin; yy_varfg = yy_context.input.pos; yy_string(yy_context, "...") or (yy_context.input.pos = yy_varfg; yy_string(yy_context, "..")) or (yy_context.input.pos = yy_varfg; yy_string(yy_context, "\u{2026}")) or (yy_context.input.pos = yy_varfg; yy_string(yy_context, "\u{2025}")); end and yy_nontermho(yy_context) and begin
      yy_varfh = yy_nontermfi(yy_context)
      if yy_varfh then
        to = yy_from_pcv(yy_varfh)
      end
      yy_varfh
    end and yy_nontermho(yy_context) and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermfi(yy_context) 
val = :yy_nil 
(begin; yy_varge = yy_context.input.pos; (yy_string(yy_context, "'") and begin
      val = ""
      yy_vargr = yy_context.input.pos
       begin
      while true
        ###
        yy_vargp = yy_context.input.pos
        ### Look ahead.
        yy_vargq = yy_string(yy_context, "'")
        yy_context.input.pos = yy_vargp
        break if yy_vargq
        ### Repeat one more time (if possible).
        yy_vargq = yy_char(yy_context)
        if not yy_vargq then
          yy_context.input.pos = yy_vargp
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_vargs = yy_context.input.pos
        yy_context.input.pos = yy_vargr
        val << yy_context.input.read(yy_vargs - yy_vargr).force_encoding(Encoding::UTF_8)
      end
    end and yy_string(yy_context, "'")) or (yy_context.input.pos = yy_varge; (yy_string(yy_context, "\"") and begin
      val = ""
      yy_varh5 = yy_context.input.pos
       begin
      while true
        ###
        yy_varh3 = yy_context.input.pos
        ### Look ahead.
        yy_varh4 = yy_string(yy_context, "\"")
        yy_context.input.pos = yy_varh3
        break if yy_varh4
        ### Repeat one more time (if possible).
        yy_varh4 = yy_char(yy_context)
        if not yy_varh4 then
          yy_context.input.pos = yy_varh3
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varh6 = yy_context.input.pos
        yy_context.input.pos = yy_varh5
        val << yy_context.input.read(yy_varh6 - yy_varh5).force_encoding(Encoding::UTF_8)
      end
    end and yy_string(yy_context, "\""))) or (yy_context.input.pos = yy_varge; (begin
      yy_varh7 = yy_nontermh8(yy_context)
      if yy_varh7 then
        code = yy_from_pcv(yy_varh7)
      end
      yy_varh7
    end and begin 
  val = "" << code  
 true 
 end)); end and yy_nontermho(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermh8(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "U+") and begin
      code = ""
      yy_varhm = yy_context.input.pos
      begin; yy_varhk = yy_context.input.pos; yy_char_range(yy_context, "0", "9") or (yy_context.input.pos = yy_varhk; yy_char_range(yy_context, "A", "F")); end and while true
      yy_varhl = yy_context.input.pos
      if not begin; yy_varhk = yy_context.input.pos; yy_char_range(yy_context, "0", "9") or (yy_context.input.pos = yy_varhk; yy_char_range(yy_context, "A", "F")); end then
        yy_context.input.pos = yy_varhl
        break true
      end
    end and begin
        yy_varhn = yy_context.input.pos
        yy_context.input.pos = yy_varhm
        code << yy_context.input.read(yy_varhn - yy_varhm).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermho(yy_context) 
val = :yy_nil 
while true
      yy_varht = yy_context.input.pos
      if not begin; yy_varhs = yy_context.input.pos; yy_nontermi4(yy_context) or (yy_context.input.pos = yy_varhs; yy_nontermhu(yy_context)); end then
        yy_context.input.pos = yy_varht
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nontermhu(yy_context) 
val = :yy_nil 
(begin; yy_varhx = yy_context.input.pos; yy_string(yy_context, "#") or (yy_context.input.pos = yy_varhx; yy_string(yy_context, "--")); end and  begin
      while true
        ###
        yy_vari0 = yy_context.input.pos
        ### Look ahead.
        yy_vari1 = begin; yy_vari3 = yy_context.input.pos; yy_nontermi6(yy_context) or (yy_context.input.pos = yy_vari3; yy_eof?(yy_context)); end
        yy_context.input.pos = yy_vari0
        break if yy_vari1
        ### Repeat one more time (if possible).
        yy_vari1 = yy_char(yy_context)
        if not yy_vari1 then
          yy_context.input.pos = yy_vari0
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_vari3 = yy_context.input.pos; yy_nontermi6(yy_context) or (yy_context.input.pos = yy_vari3; yy_eof?(yy_context)); end) and yy_to_pcv(val) 
end 
def yy_nontermi4(yy_context) 
val = :yy_nil 
begin; yy_vari5 = yy_context.input.pos; yy_char_range(yy_context, "\t", "\r") or (yy_context.input.pos = yy_vari5; yy_string(yy_context, " ")) or (yy_context.input.pos = yy_vari5; yy_string(yy_context, "\u{85}")) or (yy_context.input.pos = yy_vari5; yy_string(yy_context, "\u{a0}")) or (yy_context.input.pos = yy_vari5; yy_string(yy_context, "\u{1680}")) or (yy_context.input.pos = yy_vari5; yy_string(yy_context, "\u{180e}")) or (yy_context.input.pos = yy_vari5; yy_char_range(yy_context, "\u{2000}", "\u{200a}")) or (yy_context.input.pos = yy_vari5; yy_string(yy_context, "\u{2028}")) or (yy_context.input.pos = yy_vari5; yy_string(yy_context, "\u{2029}")) or (yy_context.input.pos = yy_vari5; yy_string(yy_context, "\u{202f}")) or (yy_context.input.pos = yy_vari5; yy_string(yy_context, "\u{205f}")) or (yy_context.input.pos = yy_vari5; yy_string(yy_context, "\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nontermi6(yy_context) 
val = :yy_nil 
begin; yy_vari7 = yy_context.input.pos; (yy_string(yy_context, "\r") and yy_string(yy_context, "\n")) or (yy_context.input.pos = yy_vari7; yy_string(yy_context, "\r")) or (yy_context.input.pos = yy_vari7; yy_string(yy_context, "\n")) or (yy_context.input.pos = yy_vari7; yy_string(yy_context, "\u{85}")) or (yy_context.input.pos = yy_vari7; yy_string(yy_context, "\v")) or (yy_context.input.pos = yy_vari7; yy_string(yy_context, "\f")) or (yy_context.input.pos = yy_vari7; yy_string(yy_context, "\u{2028}")) or (yy_context.input.pos = yy_vari7; yy_string(yy_context, "\u{2029}")); end and yy_to_pcv(val) 
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
        
        # It is YY_SyntaxError or nil.
        attr_reader :worst_error
        
        # adds possible error to this YY_ParsingContext.
        # 
        # +error+ is YY_SyntaxError.
        # 
        def << error
          # Update worst_error.
          if worst_error.nil? or worst_error.pos < error.pos then
            @worst_error = error
          end
          # 
          return self
        end
        
      end
      
      def yy_string(context, string)
        # Read string.
        read_string = context.input.read(string.bytesize)
        # Set the string's encoding; check if it fits the argument.
        unless read_string and (read_string.force_encoding(Encoding::UTF_8)) == string then
          # 
          context << YY_SyntaxError.new(%(\#{string.inspect} is expected), context.input.pos)
          # 
          return nil
        end
        # 
        return read_string
      end
      
      def yy_eof?(context)
        #
        if not context.input.eof?
          context << YY_SyntaxError.new(%(the end is expected), context.input.pos)
          return nil
        end
        #
        return true
      end
      
      def yy_char(context)
        # Read a char.
        c = context.input.getc
        # 
        unless c then
          #
          context << YY_SyntaxError.new(%(a character is expected), context.input.pos)
          #
          return nil
        end
        #
        return c
      end
      
      def yy_char_range(context, from, to)
        # Read the char.
        c = context.input.getc
        # Check if it fits the range.
        # NOTE: c has UTF-8 encoding.
        unless c and (from <= c and c <= to) then
          # 
          context << YY_SyntaxError.new(%(\#{from.inspect}\...\#{to.inspect} is expected), context.input.pos)
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
    
    def initialize(nonterminal, args_code)
      @nonterminal = nonterminal
      @args_code = args_code
    end
    
    # Nonterminal associated with this UnknownMethodCall.
    attr_reader :nonterminal
    
    # Code of arguments of this call (as String).
    attr_reader :args_code

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
      STDERR.puts %(#{e.pos}: #{e.message})
      exit 1
    end
  end
end
