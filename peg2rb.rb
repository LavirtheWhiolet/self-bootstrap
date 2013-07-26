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
        yy_nonterm1(input) or raise YY_SyntaxError
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
      
      def yy_string(input, string)
        # Read string.
        read_string = input.read(string.bytesize)
        return nil if not read_string
        read_string.force_encoding(Encoding::UTF_8)
        # 
        if read_string == string then return string
        else return nil
        end
      end
      
      def yy_char_range(input, from, to)
        # 
        c = input.getc
        return nil if not c
        # NOTE: c has UTF-8 encoding.
        # 
        if from <= c and c <= to then return c
        else return nil
        end
      end
      
      class YY_SyntaxError < Exception
      end
    def yy_nonterm1(yy_input) 
val = :yy_nil 
(begin 
 
    code = code("")
    rule_is_first = true
    method_names = HashMap.new
   
 true 
 end and yy_nontermhg(yy_input) and while true
      yy_vara = yy_input.pos
      if not begin; yy_var7 = yy_input.pos; (begin
      yy_var8 = yy_nonterm24(yy_input)
      if yy_var8 then
        rule = yy_from_pcv(yy_var8)
      end
      yy_var8
    end and begin 
 
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
 end) or (yy_input.pos = yy_var7; (begin
      yy_var9 = yy_nonterm3s(yy_input)
      if yy_var9 then
        action_code = yy_from_pcv(yy_var9)
      end
      yy_var9
    end and begin 
 
        code += code(action_code)
       
 true 
 end)); end then
        yy_input.pos = yy_vara
        break true
      end
    end and yy_input.eof? and begin 
 
    code = link(code, method_names)
    print code
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermb(yy_input) 
val = :yy_nil 
begin
      yy_vard = yy_nonterme(yy_input)
      if yy_vard then
        val = yy_from_pcv(yy_vard)
      end
      yy_vard
    end and yy_to_pcv(val) 
end 
def yy_nonterme(yy_input) 
val = :yy_nil 
(begin 
 
    single_expression = true
    remembered_pos_var = new_unique_variable_name
   
 true 
 end and begin
      yy_varh = yy_input.pos
      if not yy_nonterma0(yy_input) then
        yy_input.pos = yy_varh
      end
      true
    end and begin
      yy_vari = yy_nontermp(yy_input)
      if yy_vari then
        val = yy_from_pcv(yy_vari)
      end
      yy_vari
    end and while true
      yy_varo = yy_input.pos
      if not (yy_nonterma0(yy_input) and begin
      yy_varn = yy_nontermp(yy_input)
      if yy_varn then
        val2 = yy_from_pcv(yy_varn)
      end
      yy_varn
    end and begin 
 
      single_expression = false
      val = val + (code " or (yy_input.pos = #{remembered_pos_var}; ") + val2 + (code ")")
     
 true 
 end) then
        yy_input.pos = yy_varo
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "begin; #{remembered_pos_var} = yy_input.pos; ") + val + (code "; end")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermp(yy_input) 
val = :yy_nil 
(begin 
  code_parts = []  
 true 
 end and begin; yy_varu = yy_input.pos; (begin
      yy_varv = yy_nontermy(yy_input)
      if yy_varv then
        code_part = yy_from_pcv(yy_varv)
      end
      yy_varv
    end and begin 
  code_parts.add code_part  
 true 
 end) or (yy_input.pos = yy_varu; (yy_nontermac(yy_input) and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end and while true
      yy_varw = yy_input.pos
      if not begin; yy_varu = yy_input.pos; (begin
      yy_varv = yy_nontermy(yy_input)
      if yy_varv then
        code_part = yy_from_pcv(yy_varv)
      end
      yy_varv
    end and begin 
  code_parts.add code_part  
 true 
 end) or (yy_input.pos = yy_varu; (yy_nontermac(yy_input) and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end then
        yy_input.pos = yy_varw
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
  
def yy_nontermy(yy_input) 
val = :yy_nil 
begin; yy_varz = yy_input.pos; (begin
      yy_var10 = yy_nonterm15(yy_input)
      if yy_var10 then
        c = yy_from_pcv(yy_var10)
      end
      yy_var10
    end and begin; yy_var12 = yy_input.pos; (yy_nonterm9w(yy_input) and begin 
 t = :append 
 true 
 end) or (yy_input.pos = yy_var12; (yy_nontermae(yy_input) and begin 
 t = :capture 
 true 
 end)); end and begin
      yy_var13 = yy_nonterm3g(yy_input)
      if yy_var13 then
        var = yy_from_pcv(yy_var13)
      end
      yy_var13
    end and begin 
  val = capture_semantic_value_code(var, c, t)  
 true 
 end) or (yy_input.pos = yy_varz; begin
      yy_var14 = yy_nonterm15(yy_input)
      if yy_var14 then
        val = yy_from_pcv(yy_var14)
      end
      yy_var14
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm15(yy_input) 
val = :yy_nil 
begin; yy_var16 = yy_input.pos; (yy_nontermas(yy_input) and begin
      yy_var17 = yy_nonterm3s(yy_input)
      if yy_var17 then
        c = yy_from_pcv(yy_var17)
      end
      yy_var17
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (yy_input.pos = yy_var16; (yy_nontermas(yy_input) and begin
      yy_var18 = yy_nonterm15(yy_input)
      if yy_var18 then
        val = yy_from_pcv(yy_var18)
      end
      yy_var18
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (yy_input.pos = yy_var16; (yy_nontermau(yy_input) and begin
      yy_var19 = yy_nonterm15(yy_input)
      if yy_var19 then
        val = yy_from_pcv(yy_var19)
      end
      yy_var19
    end and begin 
  val = code(%(not )) + positive_predicate_code(val)  
 true 
 end)) or (yy_input.pos = yy_var16; begin
      yy_var1a = yy_nonterm1b(yy_input)
      if yy_var1a then
        val = yy_from_pcv(yy_var1a)
      end
      yy_var1a
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1b(yy_input) 
val = :yy_nil 
(begin
      yy_var1d = yy_nonterm1i(yy_input)
      if yy_var1d then
        val = yy_from_pcv(yy_var1d)
      end
      yy_var1d
    end and while true
      yy_var1h = yy_input.pos
      if not begin; yy_var1g = yy_input.pos; (yy_nontermam(yy_input) and begin 
  val = lazy_repeat_code(val)  
 true 
 end) or (yy_input.pos = yy_var1g; (yy_nontermak(yy_input) and begin 
  val = repeat_many_times_code(val)  
 true 
 end)) or (yy_input.pos = yy_var1g; (yy_nontermaq(yy_input) and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (yy_input.pos = yy_var1g; (yy_nontermao(yy_input) and begin 
  val = optional_code(val)  
 true 
 end)); end then
        yy_input.pos = yy_var1h
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm1i(yy_input) 
val = :yy_nil 
begin; yy_var1j = yy_input.pos; (yy_nonterma6(yy_input) and begin
      yy_var1k = yy_nontermb(yy_input)
      if yy_var1k then
        val = yy_from_pcv(yy_var1k)
      end
      yy_var1k
    end and yy_nonterma8(yy_input)) or (yy_input.pos = yy_var1j; (yy_nontermag(yy_input) and begin
      yy_var1l = yy_nontermb(yy_input)
      if yy_var1l then
        c = yy_from_pcv(yy_var1l)
      end
      yy_var1l
    end and yy_nontermai(yy_input) and begin; yy_var1n = yy_input.pos; (yy_nontermae(yy_input) and begin 
 t = :capture 
 true 
 end) or (yy_input.pos = yy_var1n; (yy_nonterm9w(yy_input) and begin 
 t = :append 
 true 
 end)); end and begin
      yy_var1o = yy_nonterm3g(yy_input)
      if yy_var1o then
        var = yy_from_pcv(yy_var1o)
      end
      yy_var1o
    end and begin 
  val = capture_text_code(var, c, t)  
 true 
 end)) or (yy_input.pos = yy_var1j; begin
      yy_var1p = yy_nonterm1q(yy_input)
      if yy_var1p then
        val = yy_from_pcv(yy_var1p)
      end
      yy_var1p
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1q(yy_input) 
val = :yy_nil 
begin; yy_var1r = yy_input.pos; (begin
      yy_var1s = yy_nontermf4(yy_input)
      if yy_var1s then
        r = yy_from_pcv(yy_var1s)
      end
      yy_var1s
    end and begin 
  val = code "yy_char_range(yy_input, #{r.begin.to_ruby_code}, #{r.end.to_ruby_code})"  
 true 
 end) or (yy_input.pos = yy_var1r; (begin
      yy_var1t = yy_nontermfa(yy_input)
      if yy_var1t then
        s = yy_from_pcv(yy_var1t)
      end
      yy_var1t
    end and begin 
  val = code "yy_string(yy_input, #{s.to_ruby_code})"  
 true 
 end)) or (yy_input.pos = yy_var1r; (begin
      yy_var1u = yy_nontermd8(yy_input)
      if yy_var1u then
        n = yy_from_pcv(yy_var1u)
      end
      yy_var1u
    end and begin 
  val = UnknownMethodCall[n, %(yy_input)]  
 true 
 end)) or (yy_input.pos = yy_var1r; (yy_nontermb2(yy_input) and begin 
  val = code "yy_input.getc"  
 true 
 end)) or (yy_input.pos = yy_var1r; (begin
      yy_var1v = yy_nonterm3s(yy_input)
      if yy_var1v then
        a = yy_from_pcv(yy_var1v)
      end
      yy_var1v
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (yy_input.pos = yy_var1r; (yy_nonterma2(yy_input) and begin 
  val = code "yy_input.eof?"  
 true 
 end)) or (yy_input.pos = yy_var1r; (yy_nonterma4(yy_input) and begin 
  val = code "(yy_input.pos == 0)"  
 true 
 end)) or (yy_input.pos = yy_var1r; (begin; yy_var1z = yy_input.pos; (yy_nontermaw(yy_input) and yy_nontermay(yy_input) and begin
      yy_var20 = yy_nontermbg(yy_input)
      if yy_var20 then
        pos_variable = yy_from_pcv(yy_var20)
      end
      yy_var20
    end) or (yy_input.pos = yy_var1z; (yy_nontermb8(yy_input) and begin
      yy_var21 = yy_nontermbg(yy_input)
      if yy_var21 then
        pos_variable = yy_from_pcv(yy_var21)
      end
      yy_var21
    end)); end and begin
      yy_var23 = yy_input.pos
      if not yy_nontermae(yy_input) then
        yy_input.pos = yy_var23
      end
      true
    end and begin 
  val = code "(yy_input.pos = #{pos_variable}; true)"  
 true 
 end)) or (yy_input.pos = yy_var1r; (yy_nontermaw(yy_input) and begin 
  val = code "yy_input.pos"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm24(yy_input) 
val = :yy_nil 
(begin 
  rule = val = Rule.new  
 true 
 end and begin; yy_var2d = yy_input.pos; (begin
      yy_var2e = yy_nontermco(yy_input)
      if yy_var2e then
        rule_name = yy_from_pcv(yy_var2e)
      end
      yy_var2e
    end and yy_nonterma6(yy_input) and begin
      yy_var2i = yy_input.pos
      if not begin; yy_var2h = yy_input.pos; yy_nontermb0(yy_input) or (yy_input.pos = yy_var2h; yy_nontermc4(yy_input)); end then
        yy_input.pos = yy_var2i
      end
      true
    end and yy_nonterma8(yy_input) and begin 
  rule.need_entry_point!  
 true 
 end) or (yy_input.pos = yy_var2d; begin
      yy_var2j = yy_nontermd8(yy_input)
      if yy_var2j then
        rule_name = yy_from_pcv(yy_var2j)
      end
      yy_var2j
    end); end and begin 
  rule.name = rule_name  
 true 
 end and begin
      yy_var2n = yy_input.pos
      if not (yy_nontermae(yy_input) and yy_nonterm2q(yy_input)) then
        yy_input.pos = yy_var2n
      end
      true
    end and yy_nonterm9g(yy_input) and begin
      yy_var2o = yy_nontermb(yy_input)
      if yy_var2o then
        c = yy_from_pcv(yy_var2o)
      end
      yy_var2o
    end and yy_nonterm9y(yy_input) and begin 
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

def yy_nonterm2q(yy_input) 
val = :yy_nil 
((not begin
      yy_var3d = yy_input.pos
      yy_var3e = yy_nonterm9g(yy_input)
      yy_input.pos = yy_var3d
      yy_var3e
    end and yy_input.getc) and yy_nontermhg(yy_input)) and while true
      yy_var3f = yy_input.pos
      if not ((not begin
      yy_var3d = yy_input.pos
      yy_var3e = yy_nonterm9g(yy_input)
      yy_input.pos = yy_var3d
      yy_var3e
    end and yy_input.getc) and yy_nontermhg(yy_input)) then
        yy_input.pos = yy_var3f
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm3g(yy_input) 
val = :yy_nil 
begin; yy_var3h = yy_input.pos; begin
      yy_var3i = yy_nontermbg(yy_input)
      if yy_var3i then
        val = yy_from_pcv(yy_var3i)
      end
      yy_var3i
    end or (yy_input.pos = yy_var3h; (yy_nonterma6(yy_input) and begin
      yy_var3j = yy_nontermbg(yy_input)
      if yy_var3j then
        val = yy_from_pcv(yy_var3j)
      end
      yy_var3j
    end and yy_nonterma8(yy_input))); end and yy_to_pcv(val) 
end 
def yy_nonterm3k(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "%%") and  begin
      while true
        ###
        yy_var3o = yy_input.pos
        ### Look ahead.
        yy_var3p = begin; yy_var3r = yy_input.pos; yy_nontermhy(yy_input) or (yy_input.pos = yy_var3r; yy_input.eof?); end
        yy_input.pos = yy_var3o
        break if yy_var3p
        ### Repeat one more time (if possible).
        yy_var3p = yy_input.getc
        if not yy_var3p then
          yy_input.pos = yy_var3o
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_var3r = yy_input.pos; yy_nontermhy(yy_input) or (yy_input.pos = yy_var3r; yy_input.eof?); end) and yy_to_pcv(val) 
end 
def yy_nonterm3s(yy_input) 
val = :yy_nil 
(begin; yy_var6j = yy_input.pos; (yy_string(yy_input, "{") and while true
      yy_var6l = yy_input.pos
      if not yy_nontermhw(yy_input) then
        yy_input.pos = yy_var6l
        break true
      end
    end and yy_string(yy_input, "...") and begin
      yy_var6x = yy_input.pos
      if not ( begin
      while true
        ###
        yy_var6v = yy_input.pos
        ### Look ahead.
        yy_var6w = yy_nontermhy(yy_input)
        yy_input.pos = yy_var6v
        break if yy_var6w
        ### Repeat one more time (if possible).
        yy_var6w = yy_nontermhw(yy_input)
        if not yy_var6w then
          yy_input.pos = yy_var6v
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nontermhy(yy_input)) then
        yy_input.pos = yy_var6x
      end
      true
    end and begin
      val = ""
      yy_var7a = yy_input.pos
       begin
      while true
        ###
        yy_var78 = yy_input.pos
        ### Look ahead.
        yy_var79 = begin; yy_var7h = yy_input.pos; (yy_string(yy_input, "...") and while true
      yy_var7j = yy_input.pos
      if not yy_nontermhw(yy_input) then
        yy_input.pos = yy_var7j
        break true
      end
    end and yy_string(yy_input, "}")) or (yy_input.pos = yy_var7h; (yy_string(yy_input, "}") and while true
      yy_var7l = yy_input.pos
      if not yy_nontermhw(yy_input) then
        yy_input.pos = yy_var7l
        break true
      end
    end and yy_string(yy_input, "..."))); end
        yy_input.pos = yy_var78
        break if yy_var79
        ### Repeat one more time (if possible).
        yy_var79 = yy_input.getc
        if not yy_var79 then
          yy_input.pos = yy_var78
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var7b = yy_input.pos
        yy_input.pos = yy_var7a
        val << yy_input.read(yy_var7b - yy_var7a).force_encoding(Encoding::UTF_8)
      end
    end and begin; yy_var7h = yy_input.pos; (yy_string(yy_input, "...") and while true
      yy_var7j = yy_input.pos
      if not yy_nontermhw(yy_input) then
        yy_input.pos = yy_var7j
        break true
      end
    end and yy_string(yy_input, "}")) or (yy_input.pos = yy_var7h; (yy_string(yy_input, "}") and while true
      yy_var7l = yy_input.pos
      if not yy_nontermhw(yy_input) then
        yy_input.pos = yy_var7l
        break true
      end
    end and yy_string(yy_input, "..."))); end) or (yy_input.pos = yy_var6j; (begin
      val = ""
      yy_var7q = yy_input.pos
      yy_nonterm98(yy_input) and begin
        yy_var7r = yy_input.pos
        yy_input.pos = yy_var7q
        val << yy_input.read(yy_var7r - yy_var7q).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = val[1...-1]  
 true 
 end)) or (yy_input.pos = yy_var6j; (yy_nonterm3k(yy_input) and begin
      val = ""
      yy_var8k = yy_input.pos
       begin
      while true
        ###
        yy_var8i = yy_input.pos
        ### Look ahead.
        yy_var8j = yy_nonterm3k(yy_input)
        yy_input.pos = yy_var8i
        break if yy_var8j
        ### Repeat one more time (if possible).
        yy_var8j = yy_input.getc
        if not yy_var8j then
          yy_input.pos = yy_var8i
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var8l = yy_input.pos
        yy_input.pos = yy_var8k
        val << yy_input.read(yy_var8l - yy_var8k).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm3k(yy_input))) or (yy_input.pos = yy_var6j; (yy_nonterm3k(yy_input) and begin
      val = ""
      yy_var96 = yy_input.pos
      while true
      yy_var95 = yy_input.pos
      if not yy_input.getc then
        yy_input.pos = yy_var95
        break true
      end
    end and begin
        yy_var97 = yy_input.pos
        yy_input.pos = yy_var96
        val << yy_input.read(yy_var97 - yy_var96).force_encoding(Encoding::UTF_8)
      end
    end and yy_input.eof?)); end and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nonterm98(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "{") and  begin
      while true
        ###
        yy_var9e = yy_input.pos
        ### Look ahead.
        yy_var9f = yy_string(yy_input, "}")
        yy_input.pos = yy_var9e
        break if yy_var9f
        ### Repeat one more time (if possible).
        yy_var9f = begin; yy_var9d = yy_input.pos; yy_nonterm98(yy_input) or (yy_input.pos = yy_var9d; yy_input.getc); end
        if not yy_var9f then
          yy_input.pos = yy_var9e
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string(yy_input, "}")) and yy_to_pcv(val) 
end 
def yy_nonterm9g(yy_input) 
val = :yy_nil 
(begin; yy_var9j = yy_input.pos; yy_string(yy_input, "<-") or (yy_input.pos = yy_var9j; yy_string(yy_input, "=")) or (yy_input.pos = yy_var9j; yy_string(yy_input, "\u{2190}")); end and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nonterm9k(yy_input) 
val = :yy_nil 
(yy_string(yy_input, ":") and not begin
      yy_var9u = yy_input.pos
      yy_var9v = yy_string(yy_input, "+")
      yy_input.pos = yy_var9u
      yy_var9v
    end and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nonterm9w(yy_input) 
val = :yy_nil 
(yy_string(yy_input, ":+") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nonterm9y(yy_input) 
val = :yy_nil 
(yy_string(yy_input, ";") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nonterma0(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "/") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nonterma2(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "$") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nonterma4(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "^") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nonterma6(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "(") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nonterma8(yy_input) 
val = :yy_nil 
(yy_string(yy_input, ")") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermaa(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "[") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermac(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "]") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermae(yy_input) 
val = :yy_nil 
(yy_string(yy_input, ":") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermag(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "<") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermai(yy_input) 
val = :yy_nil 
(yy_string(yy_input, ">") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermak(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "*") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermam(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "*?") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermao(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "?") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermaq(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "+") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermas(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "&") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermau(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "!") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermaw(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "@") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermay(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "=") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermb0(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "...") and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermb2(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "char") and not begin
      yy_varb6 = yy_input.pos
      yy_varb7 = yy_nontermf2(yy_input)
      yy_input.pos = yy_varb6
      yy_varb7
    end and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermb8(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "at") and not begin
      yy_varbc = yy_input.pos
      yy_varbd = yy_nontermf2(yy_input)
      yy_input.pos = yy_varbc
      yy_varbd
    end and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermbe(yy_input) 
val = :yy_nil 
begin; yy_varbf = yy_input.pos; yy_nontermb2(yy_input) or (yy_input.pos = yy_varbf; yy_nontermb8(yy_input)); end and yy_to_pcv(val) 
end 
def yy_nontermbg(yy_input) 
val = :yy_nil 
(begin
      val = ""
      yy_varc2 = yy_input.pos
      (begin
      yy_varbx = yy_input.pos
      if not begin; yy_varbw = yy_input.pos; yy_string(yy_input, "@") or (yy_input.pos = yy_varbw; yy_string(yy_input, "$")); end then
        yy_input.pos = yy_varbx
      end
      true
    end and yy_nontermck(yy_input) and while true
      yy_varc1 = yy_input.pos
      if not yy_nontermcm(yy_input) then
        yy_input.pos = yy_varc1
        break true
      end
    end) and begin
        yy_varc3 = yy_input.pos
        yy_input.pos = yy_varc2
        val << yy_input.read(yy_varc3 - yy_varc2).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermc4(yy_input) 
val = :yy_nil 
(begin
      val = ""
      yy_varci = yy_input.pos
      (yy_nontermck(yy_input) and while true
      yy_varch = yy_input.pos
      if not yy_nontermcm(yy_input) then
        yy_input.pos = yy_varch
        break true
      end
    end) and begin
        yy_varcj = yy_input.pos
        yy_input.pos = yy_varci
        val << yy_input.read(yy_varcj - yy_varci).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermck(yy_input) 
val = :yy_nil 
begin; yy_varcl = yy_input.pos; yy_char_range(yy_input, "a", "z") or (yy_input.pos = yy_varcl; yy_string(yy_input, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermcm(yy_input) 
val = :yy_nil 
begin; yy_varcn = yy_input.pos; yy_nontermck(yy_input) or (yy_input.pos = yy_varcn; yy_char_range(yy_input, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermco(yy_input) 
val = :yy_nil 
(begin
      val = ""
      yy_vard2 = yy_input.pos
      (yy_nontermd4(yy_input) and while true
      yy_vard1 = yy_input.pos
      if not yy_nontermd6(yy_input) then
        yy_input.pos = yy_vard1
        break true
      end
    end) and begin
        yy_vard3 = yy_input.pos
        yy_input.pos = yy_vard2
        val << yy_input.read(yy_vard3 - yy_vard2).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermd4(yy_input) 
val = :yy_nil 
begin; yy_vard5 = yy_input.pos; yy_char_range(yy_input, "a", "z") or (yy_input.pos = yy_vard5; yy_string(yy_input, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermd6(yy_input) 
val = :yy_nil 
begin; yy_vard7 = yy_input.pos; yy_nontermd4(yy_input) or (yy_input.pos = yy_vard7; yy_char_range(yy_input, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermd8(yy_input) 
val = :yy_nil 
(not begin
      yy_vardc = yy_input.pos
      yy_vardd = yy_nontermbe(yy_input)
      yy_input.pos = yy_vardc
      yy_vardd
    end and begin; yy_vare7 = yy_input.pos; (begin
      val = ""
      yy_varek = yy_input.pos
      (yy_nontermf0(yy_input) and while true
      yy_varej = yy_input.pos
      if not yy_nontermf2(yy_input) then
        yy_input.pos = yy_varej
        break true
      end
    end) and begin
        yy_varel = yy_input.pos
        yy_input.pos = yy_varek
        val << yy_input.read(yy_varel - yy_varek).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermhg(yy_input)) or (yy_input.pos = yy_vare7; (begin
      val = ""
      yy_varey = yy_input.pos
      (yy_string(yy_input, "`") and  begin
      while true
        ###
        yy_varew = yy_input.pos
        ### Look ahead.
        yy_varex = yy_string(yy_input, "`")
        yy_input.pos = yy_varew
        break if yy_varex
        ### Repeat one more time (if possible).
        yy_varex = yy_input.getc
        if not yy_varex then
          yy_input.pos = yy_varew
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string(yy_input, "`")) and begin
        yy_varez = yy_input.pos
        yy_input.pos = yy_varey
        val << yy_input.read(yy_varez - yy_varey).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermhg(yy_input))); end) and yy_to_pcv(val) 
end 
def yy_nontermf0(yy_input) 
val = :yy_nil 
begin; yy_varf1 = yy_input.pos; yy_char_range(yy_input, "a", "z") or (yy_input.pos = yy_varf1; yy_char_range(yy_input, "A", "Z")) or (yy_input.pos = yy_varf1; yy_string(yy_input, "-")) or (yy_input.pos = yy_varf1; yy_string(yy_input, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermf2(yy_input) 
val = :yy_nil 
begin; yy_varf3 = yy_input.pos; yy_nontermf0(yy_input) or (yy_input.pos = yy_varf3; yy_char_range(yy_input, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermf4(yy_input) 
val = :yy_nil 
(begin
      yy_varf6 = yy_nontermfa(yy_input)
      if yy_varf6 then
        from = yy_from_pcv(yy_varf6)
      end
      yy_varf6
    end and begin; yy_varf8 = yy_input.pos; yy_string(yy_input, "...") or (yy_input.pos = yy_varf8; yy_string(yy_input, "..")) or (yy_input.pos = yy_varf8; yy_string(yy_input, "\u{2026}")) or (yy_input.pos = yy_varf8; yy_string(yy_input, "\u{2025}")); end and yy_nontermhg(yy_input) and begin
      yy_varf9 = yy_nontermfa(yy_input)
      if yy_varf9 then
        to = yy_from_pcv(yy_varf9)
      end
      yy_varf9
    end and yy_nontermhg(yy_input) and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermfa(yy_input) 
val = :yy_nil 
(begin; yy_varg6 = yy_input.pos; (yy_string(yy_input, "'") and begin
      val = ""
      yy_vargj = yy_input.pos
       begin
      while true
        ###
        yy_vargh = yy_input.pos
        ### Look ahead.
        yy_vargi = yy_string(yy_input, "'")
        yy_input.pos = yy_vargh
        break if yy_vargi
        ### Repeat one more time (if possible).
        yy_vargi = yy_input.getc
        if not yy_vargi then
          yy_input.pos = yy_vargh
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_vargk = yy_input.pos
        yy_input.pos = yy_vargj
        val << yy_input.read(yy_vargk - yy_vargj).force_encoding(Encoding::UTF_8)
      end
    end and yy_string(yy_input, "'")) or (yy_input.pos = yy_varg6; (yy_string(yy_input, "\"") and begin
      val = ""
      yy_vargx = yy_input.pos
       begin
      while true
        ###
        yy_vargv = yy_input.pos
        ### Look ahead.
        yy_vargw = yy_string(yy_input, "\"")
        yy_input.pos = yy_vargv
        break if yy_vargw
        ### Repeat one more time (if possible).
        yy_vargw = yy_input.getc
        if not yy_vargw then
          yy_input.pos = yy_vargv
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_vargy = yy_input.pos
        yy_input.pos = yy_vargx
        val << yy_input.read(yy_vargy - yy_vargx).force_encoding(Encoding::UTF_8)
      end
    end and yy_string(yy_input, "\""))) or (yy_input.pos = yy_varg6; (begin
      yy_vargz = yy_nontermh0(yy_input)
      if yy_vargz then
        code = yy_from_pcv(yy_vargz)
      end
      yy_vargz
    end and begin 
  val = "" << code  
 true 
 end)); end and yy_nontermhg(yy_input)) and yy_to_pcv(val) 
end 
def yy_nontermh0(yy_input) 
val = :yy_nil 
(yy_string(yy_input, "U+") and begin
      code = ""
      yy_varhe = yy_input.pos
      begin; yy_varhc = yy_input.pos; yy_char_range(yy_input, "0", "9") or (yy_input.pos = yy_varhc; yy_char_range(yy_input, "A", "F")); end and while true
      yy_varhd = yy_input.pos
      if not begin; yy_varhc = yy_input.pos; yy_char_range(yy_input, "0", "9") or (yy_input.pos = yy_varhc; yy_char_range(yy_input, "A", "F")); end then
        yy_input.pos = yy_varhd
        break true
      end
    end and begin
        yy_varhf = yy_input.pos
        yy_input.pos = yy_varhe
        code << yy_input.read(yy_varhf - yy_varhe).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermhg(yy_input) 
val = :yy_nil 
while true
      yy_varhl = yy_input.pos
      if not begin; yy_varhk = yy_input.pos; yy_nontermhw(yy_input) or (yy_input.pos = yy_varhk; yy_nontermhm(yy_input)); end then
        yy_input.pos = yy_varhl
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nontermhm(yy_input) 
val = :yy_nil 
(begin; yy_varhp = yy_input.pos; yy_string(yy_input, "#") or (yy_input.pos = yy_varhp; yy_string(yy_input, "--")); end and  begin
      while true
        ###
        yy_varhs = yy_input.pos
        ### Look ahead.
        yy_varht = begin; yy_varhv = yy_input.pos; yy_nontermhy(yy_input) or (yy_input.pos = yy_varhv; yy_input.eof?); end
        yy_input.pos = yy_varhs
        break if yy_varht
        ### Repeat one more time (if possible).
        yy_varht = yy_input.getc
        if not yy_varht then
          yy_input.pos = yy_varhs
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_varhv = yy_input.pos; yy_nontermhy(yy_input) or (yy_input.pos = yy_varhv; yy_input.eof?); end) and yy_to_pcv(val) 
end 
def yy_nontermhw(yy_input) 
val = :yy_nil 
begin; yy_varhx = yy_input.pos; yy_char_range(yy_input, "\t", "\r") or (yy_input.pos = yy_varhx; yy_string(yy_input, " ")) or (yy_input.pos = yy_varhx; yy_string(yy_input, "\u{85}")) or (yy_input.pos = yy_varhx; yy_string(yy_input, "\u{a0}")) or (yy_input.pos = yy_varhx; yy_string(yy_input, "\u{1680}")) or (yy_input.pos = yy_varhx; yy_string(yy_input, "\u{180e}")) or (yy_input.pos = yy_varhx; yy_char_range(yy_input, "\u{2000}", "\u{200a}")) or (yy_input.pos = yy_varhx; yy_string(yy_input, "\u{2028}")) or (yy_input.pos = yy_varhx; yy_string(yy_input, "\u{2029}")) or (yy_input.pos = yy_varhx; yy_string(yy_input, "\u{202f}")) or (yy_input.pos = yy_varhx; yy_string(yy_input, "\u{205f}")) or (yy_input.pos = yy_varhx; yy_string(yy_input, "\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nontermhy(yy_input) 
val = :yy_nil 
begin; yy_varhz = yy_input.pos; (yy_string(yy_input, "\r") and yy_string(yy_input, "\n")) or (yy_input.pos = yy_varhz; yy_string(yy_input, "\r")) or (yy_input.pos = yy_varhz; yy_string(yy_input, "\n")) or (yy_input.pos = yy_varhz; yy_string(yy_input, "\u{85}")) or (yy_input.pos = yy_varhz; yy_string(yy_input, "\v")) or (yy_input.pos = yy_varhz; yy_string(yy_input, "\f")) or (yy_input.pos = yy_varhz; yy_string(yy_input, "\u{2028}")) or (yy_input.pos = yy_varhz; yy_string(yy_input, "\u{2029}")); end and yy_to_pcv(val) 
end 
  
  # 
  # +capture_type+ may be:
  # 
  # [:capture] "Capture the semantic value to +var+"
  # [:append]  "Append semantic value to +var+ using "<<" operator".
  # 
  def capture_semantic_value_code(var, code, capture_type)
    result_var = new_unique_variable_name
    capture_operator =
      case capture_type
      when :capture then "="
      when :append then "<<"
      else raise %(capture_type #{capture_type.inspect} is not supported)
      end
    #
    code(%(begin
      #{result_var} = )) + code + code(%(
      if #{result_var} then
        #{var} #{capture_operator} yy_from_pcv(#{result_var})
      end
      #{result_var}
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
      #{stored_pos_var} = yy_input.pos
      #{result_var} = )) + code + code(%(
      yy_input.pos = #{stored_pos_var}
      #{result_var}
    end))
  end
  
  def repeat_many_times_code(code)
    stored_pos_var = new_unique_variable_name
    #
    code(%(while true
      #{stored_pos_var} = yy_input.pos
      if not )) + code + code(%( then
        yy_input.pos = #{stored_pos_var}
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
      #{stored_pos_var} = yy_input.pos
      if not )) + code + code(%( then
        yy_input.pos = #{stored_pos_var}
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
        #{original_pos_var} = yy_input.pos
        ### Look ahead.
        #{result_var} = ]) + LazyRepeat::UnknownLookAheadCode.new + code(%[
        yy_input.pos = #{original_pos_var}
        break if #{result_var}
        ### Repeat one more time (if possible).
        #{result_var} = ]) + parsing_code + code(%[
        if not #{result_var} then
          yy_input.pos = #{original_pos_var}
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
      #{start_pos_var} = yy_input.pos
      )) +
      parsing_code + code(%( and begin
        #{end_pos_var} = yy_input.pos
        yy_input.pos = #{start_pos_var}
        #{target_variable_name} << yy_input.read(#{end_pos_var} - #{start_pos_var}).force_encoding(Encoding::UTF_8)
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
      
      def yy_string(input, string)
        # Read string.
        read_string = input.read(string.bytesize)
        return nil if not read_string
        read_string.force_encoding(Encoding::UTF_8)
        # 
        if read_string == string then return string
        else return nil
        end
      end
      
      def yy_char_range(input, from, to)
        # 
        c = input.getc
        return nil if not c
        # NOTE: c has UTF-8 encoding.
        # 
        if from <= c and c <= to then return c
        else return nil
        end
      end
      
      class YY_SyntaxError < Exception
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
        #{parsing_method_name}(input) or raise YY_SyntaxError
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
    code("def #{method_name}(yy_input) \n") +
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
    PEGParserGenerator.new.call(io)
  end
end
