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
        @yy_input = input
        @yy_input.set_encoding("UTF-8", "UTF-8")
        yy_nonterm1 or raise YY_SyntaxError
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
      
      def yy_string(string)
        # Read string.
        read_string = @yy_input.read(string.bytesize)
        return nil if not read_string
        read_string.force_encoding(Encoding::UTF_8)
        # 
        if read_string == string then return string
        else return nil
        end
      end
      
      def yy_char_range(from, to)
        # 
        c = @yy_input.getc
        return nil if not c
        # NOTE: c has UTF-8 encoding.
        # 
        if from <= c and c <= to then return c
        else return nil
        end
      end
      
      class YY_SyntaxError < Exception
      end
    def yy_nonterm1 
val = :yy_nil 
(begin 
 
    code = code("")
    rule_is_first = true
    method_names = HashMap.new
   
 true 
 end and yy_nontermh0() and while true
      yy_vara = @yy_input.pos
      if not begin; yy_var7 = @yy_input.pos; (begin
      yy_var8 = yy_nonterm20()
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
 end) or (@yy_input.pos = yy_var7; (begin
      yy_var9 = yy_nonterm3o()
      if yy_var9 then
        action_code = yy_from_pcv(yy_var9)
      end
      yy_var9
    end and begin 
 
        code += code(action_code)
       
 true 
 end)); end then
        @yy_input.pos = yy_vara
        break true
      end
    end and @yy_input.eof? and begin 
 
    code = link(code, method_names)
    print code
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermb 
val = :yy_nil 
begin
      yy_vard = yy_nonterme()
      if yy_vard then
        val = yy_from_pcv(yy_vard)
      end
      yy_vard
    end and yy_to_pcv(val) 
end 
def yy_nonterme 
val = :yy_nil 
(begin 
 
    single_expression = true
    remembered_pos_var = new_unique_variable_name
   
 true 
 end and begin
      yy_varh = @yy_input.pos
      if not yy_nonterm9k() then
        @yy_input.pos = yy_varh
      end
      true
    end and begin
      yy_vari = yy_nontermp()
      if yy_vari then
        val = yy_from_pcv(yy_vari)
      end
      yy_vari
    end and while true
      yy_varo = @yy_input.pos
      if not (yy_nonterm9k() and begin
      yy_varn = yy_nontermp()
      if yy_varn then
        val2 = yy_from_pcv(yy_varn)
      end
      yy_varn
    end and begin 
 
      single_expression = false
      val = val + (code " or (@yy_input.pos = #{remembered_pos_var}; ") + val2 + (code ")")
     
 true 
 end) then
        @yy_input.pos = yy_varo
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "begin; #{remembered_pos_var} = @yy_input.pos; ") + val + (code "; end")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermp 
val = :yy_nil 
(begin 
  code_parts = []  
 true 
 end and begin; yy_varu = @yy_input.pos; (begin
      yy_varv = yy_nontermy()
      if yy_varv then
        code_part = yy_from_pcv(yy_varv)
      end
      yy_varv
    end and begin 
  code_parts.add code_part  
 true 
 end) or (@yy_input.pos = yy_varu; (yy_nonterm9w() and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end and while true
      yy_varw = @yy_input.pos
      if not begin; yy_varu = @yy_input.pos; (begin
      yy_varv = yy_nontermy()
      if yy_varv then
        code_part = yy_from_pcv(yy_varv)
      end
      yy_varv
    end and begin 
  code_parts.add code_part  
 true 
 end) or (@yy_input.pos = yy_varu; (yy_nonterm9w() and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end then
        @yy_input.pos = yy_varw
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
  
def yy_nontermy 
val = :yy_nil 
begin; yy_varz = @yy_input.pos; (begin
      yy_var10 = yy_nonterm13()
      if yy_var10 then
        c = yy_from_pcv(yy_var10)
      end
      yy_var10
    end and yy_nonterm9y() and begin
      yy_var11 = yy_nonterm3c()
      if yy_var11 then
        var = yy_from_pcv(yy_var11)
      end
      yy_var11
    end and begin 
  val = capture_semantic_value_code(var, c)  
 true 
 end) or (@yy_input.pos = yy_varz; begin
      yy_var12 = yy_nonterm13()
      if yy_var12 then
        val = yy_from_pcv(yy_var12)
      end
      yy_var12
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm13 
val = :yy_nil 
begin; yy_var14 = @yy_input.pos; (yy_nontermac() and begin
      yy_var15 = yy_nonterm3o()
      if yy_var15 then
        c = yy_from_pcv(yy_var15)
      end
      yy_var15
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (@yy_input.pos = yy_var14; (yy_nontermac() and begin
      yy_var16 = yy_nonterm13()
      if yy_var16 then
        val = yy_from_pcv(yy_var16)
      end
      yy_var16
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var14; (yy_nontermae() and begin
      yy_var17 = yy_nonterm13()
      if yy_var17 then
        val = yy_from_pcv(yy_var17)
      end
      yy_var17
    end and begin 
  val = code(%(not )) + positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var14; begin
      yy_var18 = yy_nonterm19()
      if yy_var18 then
        val = yy_from_pcv(yy_var18)
      end
      yy_var18
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm19 
val = :yy_nil 
(begin
      yy_var1b = yy_nonterm1g()
      if yy_var1b then
        val = yy_from_pcv(yy_var1b)
      end
      yy_var1b
    end and while true
      yy_var1f = @yy_input.pos
      if not begin; yy_var1e = @yy_input.pos; (yy_nonterma6() and begin 
  val = lazy_repeat_code(val)  
 true 
 end) or (@yy_input.pos = yy_var1e; (yy_nonterma4() and begin 
  val = repeat_many_times_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1e; (yy_nontermaa() and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1e; (yy_nonterma8() and begin 
  val = optional_code(val)  
 true 
 end)); end then
        @yy_input.pos = yy_var1f
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm1g 
val = :yy_nil 
begin; yy_var1h = @yy_input.pos; (yy_nonterm9q() and begin
      yy_var1i = yy_nontermb()
      if yy_var1i then
        val = yy_from_pcv(yy_var1i)
      end
      yy_var1i
    end and yy_nonterm9s()) or (@yy_input.pos = yy_var1h; (yy_nonterma0() and begin
      yy_var1j = yy_nontermb()
      if yy_var1j then
        c = yy_from_pcv(yy_var1j)
      end
      yy_var1j
    end and yy_nonterma2() and yy_nonterm9y() and begin
      yy_var1k = yy_nonterm3c()
      if yy_var1k then
        var = yy_from_pcv(yy_var1k)
      end
      yy_var1k
    end and begin 
  val = capture_text_code(var, c)  
 true 
 end)) or (@yy_input.pos = yy_var1h; begin
      yy_var1l = yy_nonterm1m()
      if yy_var1l then
        val = yy_from_pcv(yy_var1l)
      end
      yy_var1l
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1m 
val = :yy_nil 
begin; yy_var1n = @yy_input.pos; (begin
      yy_var1o = yy_nontermeo()
      if yy_var1o then
        r = yy_from_pcv(yy_var1o)
      end
      yy_var1o
    end and begin 
  val = code "yy_char_range(#{r.begin.to_ruby_code}, #{r.end.to_ruby_code})"  
 true 
 end) or (@yy_input.pos = yy_var1n; (begin
      yy_var1p = yy_nontermeu()
      if yy_var1p then
        s = yy_from_pcv(yy_var1p)
      end
      yy_var1p
    end and begin 
  val = code "yy_string(#{s.to_ruby_code})"  
 true 
 end)) or (@yy_input.pos = yy_var1n; (begin
      yy_var1q = yy_nontermcs()
      if yy_var1q then
        n = yy_from_pcv(yy_var1q)
      end
      yy_var1q
    end and begin 
  val = UnknownMethodCall[n]  
 true 
 end)) or (@yy_input.pos = yy_var1n; (yy_nontermam() and begin 
  val = code "@yy_input.getc"  
 true 
 end)) or (@yy_input.pos = yy_var1n; (begin
      yy_var1r = yy_nonterm3o()
      if yy_var1r then
        a = yy_from_pcv(yy_var1r)
      end
      yy_var1r
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (@yy_input.pos = yy_var1n; (yy_nonterm9m() and begin 
  val = code "@yy_input.eof?"  
 true 
 end)) or (@yy_input.pos = yy_var1n; (yy_nonterm9o() and begin 
  val = code "(@yy_input.pos == 0)"  
 true 
 end)) or (@yy_input.pos = yy_var1n; (begin; yy_var1v = @yy_input.pos; (yy_nontermag() and yy_nontermai() and begin
      yy_var1w = yy_nontermb0()
      if yy_var1w then
        pos_variable = yy_from_pcv(yy_var1w)
      end
      yy_var1w
    end) or (@yy_input.pos = yy_var1v; (yy_nontermas() and begin
      yy_var1x = yy_nontermb0()
      if yy_var1x then
        pos_variable = yy_from_pcv(yy_var1x)
      end
      yy_var1x
    end)); end and begin
      yy_var1z = @yy_input.pos
      if not yy_nonterm9y() then
        @yy_input.pos = yy_var1z
      end
      true
    end and begin 
  val = code "(@yy_input.pos = #{pos_variable}; true)"  
 true 
 end)) or (@yy_input.pos = yy_var1n; (yy_nontermag() and begin 
  val = code "@yy_input.pos"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm20 
val = :yy_nil 
(begin 
  rule = val = Rule.new  
 true 
 end and begin; yy_var29 = @yy_input.pos; (begin
      yy_var2a = yy_nontermc8()
      if yy_var2a then
        rule_name = yy_from_pcv(yy_var2a)
      end
      yy_var2a
    end and yy_nonterm9q() and begin
      yy_var2e = @yy_input.pos
      if not begin; yy_var2d = @yy_input.pos; yy_nontermak() or (@yy_input.pos = yy_var2d; yy_nontermbo()); end then
        @yy_input.pos = yy_var2e
      end
      true
    end and yy_nonterm9s() and begin 
  rule.need_entry_point!  
 true 
 end) or (@yy_input.pos = yy_var29; begin
      yy_var2f = yy_nontermcs()
      if yy_var2f then
        rule_name = yy_from_pcv(yy_var2f)
      end
      yy_var2f
    end); end and begin 
  rule.name = rule_name  
 true 
 end and begin
      yy_var2j = @yy_input.pos
      if not (yy_nonterm9y() and yy_nonterm2m()) then
        @yy_input.pos = yy_var2j
      end
      true
    end and yy_nonterm9c() and begin
      yy_var2k = yy_nontermb()
      if yy_var2k then
        c = yy_from_pcv(yy_var2k)
      end
      yy_var2k
    end and yy_nonterm9i() and begin 
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

def yy_nonterm2m 
val = :yy_nil 
((not begin
      yy_var39 = @yy_input.pos
      yy_var3a = yy_nonterm9c()
      @yy_input.pos = yy_var39
      yy_var3a
    end and @yy_input.getc) and yy_nontermh0()) and while true
      yy_var3b = @yy_input.pos
      if not ((not begin
      yy_var39 = @yy_input.pos
      yy_var3a = yy_nonterm9c()
      @yy_input.pos = yy_var39
      yy_var3a
    end and @yy_input.getc) and yy_nontermh0()) then
        @yy_input.pos = yy_var3b
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm3c 
val = :yy_nil 
begin; yy_var3d = @yy_input.pos; begin
      yy_var3e = yy_nontermb0()
      if yy_var3e then
        val = yy_from_pcv(yy_var3e)
      end
      yy_var3e
    end or (@yy_input.pos = yy_var3d; (yy_nonterm9q() and begin
      yy_var3f = yy_nontermb0()
      if yy_var3f then
        val = yy_from_pcv(yy_var3f)
      end
      yy_var3f
    end and yy_nonterm9s())); end and yy_to_pcv(val) 
end 
def yy_nonterm3g 
val = :yy_nil 
(yy_string("%%") and  begin
      while true
        ###
        yy_var3k = @yy_input.pos
        ### Look ahead.
        yy_var3l = begin; yy_var3n = @yy_input.pos; yy_nontermhi() or (@yy_input.pos = yy_var3n; @yy_input.eof?); end
        @yy_input.pos = yy_var3k
        break if yy_var3l
        ### Repeat one more time (if possible).
        yy_var3l = @yy_input.getc
        if not yy_var3l then
          @yy_input.pos = yy_var3k
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_var3n = @yy_input.pos; yy_nontermhi() or (@yy_input.pos = yy_var3n; @yy_input.eof?); end) and yy_to_pcv(val) 
end 
def yy_nonterm3o 
val = :yy_nil 
(begin; yy_var6f = @yy_input.pos; (yy_string("{") and while true
      yy_var6h = @yy_input.pos
      if not yy_nontermhg() then
        @yy_input.pos = yy_var6h
        break true
      end
    end and yy_string("...") and begin
      yy_var6t = @yy_input.pos
      if not ( begin
      while true
        ###
        yy_var6r = @yy_input.pos
        ### Look ahead.
        yy_var6s = yy_nontermhi()
        @yy_input.pos = yy_var6r
        break if yy_var6s
        ### Repeat one more time (if possible).
        yy_var6s = yy_nontermhg()
        if not yy_var6s then
          @yy_input.pos = yy_var6r
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nontermhi()) then
        @yy_input.pos = yy_var6t
      end
      true
    end and begin
      val = ""
      yy_var76 = @yy_input.pos
       begin
      while true
        ###
        yy_var74 = @yy_input.pos
        ### Look ahead.
        yy_var75 = begin; yy_var7d = @yy_input.pos; (yy_string("...") and while true
      yy_var7f = @yy_input.pos
      if not yy_nontermhg() then
        @yy_input.pos = yy_var7f
        break true
      end
    end and yy_string("}")) or (@yy_input.pos = yy_var7d; (yy_string("}") and while true
      yy_var7h = @yy_input.pos
      if not yy_nontermhg() then
        @yy_input.pos = yy_var7h
        break true
      end
    end and yy_string("..."))); end
        @yy_input.pos = yy_var74
        break if yy_var75
        ### Repeat one more time (if possible).
        yy_var75 = @yy_input.getc
        if not yy_var75 then
          @yy_input.pos = yy_var74
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var77 = @yy_input.pos
        @yy_input.pos = yy_var76
        val << @yy_input.read(yy_var77 - yy_var76).force_encoding(Encoding::UTF_8)
      end
    end and begin; yy_var7d = @yy_input.pos; (yy_string("...") and while true
      yy_var7f = @yy_input.pos
      if not yy_nontermhg() then
        @yy_input.pos = yy_var7f
        break true
      end
    end and yy_string("}")) or (@yy_input.pos = yy_var7d; (yy_string("}") and while true
      yy_var7h = @yy_input.pos
      if not yy_nontermhg() then
        @yy_input.pos = yy_var7h
        break true
      end
    end and yy_string("..."))); end) or (@yy_input.pos = yy_var6f; (begin
      val = ""
      yy_var7m = @yy_input.pos
      yy_nonterm94() and begin
        yy_var7n = @yy_input.pos
        @yy_input.pos = yy_var7m
        val << @yy_input.read(yy_var7n - yy_var7m).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = val[1...-1]  
 true 
 end)) or (@yy_input.pos = yy_var6f; (yy_nonterm3g() and begin
      val = ""
      yy_var8g = @yy_input.pos
       begin
      while true
        ###
        yy_var8e = @yy_input.pos
        ### Look ahead.
        yy_var8f = yy_nonterm3g()
        @yy_input.pos = yy_var8e
        break if yy_var8f
        ### Repeat one more time (if possible).
        yy_var8f = @yy_input.getc
        if not yy_var8f then
          @yy_input.pos = yy_var8e
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var8h = @yy_input.pos
        @yy_input.pos = yy_var8g
        val << @yy_input.read(yy_var8h - yy_var8g).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm3g())) or (@yy_input.pos = yy_var6f; (yy_nonterm3g() and begin
      val = ""
      yy_var92 = @yy_input.pos
      while true
      yy_var91 = @yy_input.pos
      if not @yy_input.getc then
        @yy_input.pos = yy_var91
        break true
      end
    end and begin
        yy_var93 = @yy_input.pos
        @yy_input.pos = yy_var92
        val << @yy_input.read(yy_var93 - yy_var92).force_encoding(Encoding::UTF_8)
      end
    end and @yy_input.eof?)); end and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nonterm94 
val = :yy_nil 
(yy_string("{") and  begin
      while true
        ###
        yy_var9a = @yy_input.pos
        ### Look ahead.
        yy_var9b = yy_string("}")
        @yy_input.pos = yy_var9a
        break if yy_var9b
        ### Repeat one more time (if possible).
        yy_var9b = begin; yy_var99 = @yy_input.pos; yy_nonterm94() or (@yy_input.pos = yy_var99; @yy_input.getc); end
        if not yy_var9b then
          @yy_input.pos = yy_var9a
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string("}")) and yy_to_pcv(val) 
end 
def yy_nonterm9c 
val = :yy_nil 
(begin; yy_var9f = @yy_input.pos; yy_string("<-") or (@yy_input.pos = yy_var9f; yy_string("=")) or (@yy_input.pos = yy_var9f; yy_string("\u{2190}")); end and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nonterm9g 
val = :yy_nil 
(yy_string(":") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nonterm9i 
val = :yy_nil 
(yy_string(";") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nonterm9k 
val = :yy_nil 
(yy_string("/") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nonterm9m 
val = :yy_nil 
(yy_string("$") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nonterm9o 
val = :yy_nil 
(yy_string("^") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nonterm9q 
val = :yy_nil 
(yy_string("(") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nonterm9s 
val = :yy_nil 
(yy_string(")") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nonterm9u 
val = :yy_nil 
(yy_string("[") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nonterm9w 
val = :yy_nil 
(yy_string("]") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nonterm9y 
val = :yy_nil 
(yy_string(":") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nonterma0 
val = :yy_nil 
(yy_string("<") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nonterma2 
val = :yy_nil 
(yy_string(">") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nonterma4 
val = :yy_nil 
(yy_string("*") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nonterma6 
val = :yy_nil 
(yy_string("*?") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nonterma8 
val = :yy_nil 
(yy_string("?") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nontermaa 
val = :yy_nil 
(yy_string("+") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nontermac 
val = :yy_nil 
(yy_string("&") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nontermae 
val = :yy_nil 
(yy_string("!") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nontermag 
val = :yy_nil 
(yy_string("@") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nontermai 
val = :yy_nil 
(yy_string("=") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nontermak 
val = :yy_nil 
(yy_string("...") and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nontermam 
val = :yy_nil 
(yy_string("char") and not begin
      yy_varaq = @yy_input.pos
      yy_varar = yy_nontermem()
      @yy_input.pos = yy_varaq
      yy_varar
    end and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nontermas 
val = :yy_nil 
(yy_string("at") and not begin
      yy_varaw = @yy_input.pos
      yy_varax = yy_nontermem()
      @yy_input.pos = yy_varaw
      yy_varax
    end and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nontermay 
val = :yy_nil 
begin; yy_varaz = @yy_input.pos; yy_nontermam() or (@yy_input.pos = yy_varaz; yy_nontermas()); end and yy_to_pcv(val) 
end 
def yy_nontermb0 
val = :yy_nil 
(begin
      val = ""
      yy_varbm = @yy_input.pos
      (begin
      yy_varbh = @yy_input.pos
      if not begin; yy_varbg = @yy_input.pos; yy_string("@") or (@yy_input.pos = yy_varbg; yy_string("$")); end then
        @yy_input.pos = yy_varbh
      end
      true
    end and yy_nontermc4() and while true
      yy_varbl = @yy_input.pos
      if not yy_nontermc6() then
        @yy_input.pos = yy_varbl
        break true
      end
    end) and begin
        yy_varbn = @yy_input.pos
        @yy_input.pos = yy_varbm
        val << @yy_input.read(yy_varbn - yy_varbm).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nontermbo 
val = :yy_nil 
(begin
      val = ""
      yy_varc2 = @yy_input.pos
      (yy_nontermc4() and while true
      yy_varc1 = @yy_input.pos
      if not yy_nontermc6() then
        @yy_input.pos = yy_varc1
        break true
      end
    end) and begin
        yy_varc3 = @yy_input.pos
        @yy_input.pos = yy_varc2
        val << @yy_input.read(yy_varc3 - yy_varc2).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nontermc4 
val = :yy_nil 
begin; yy_varc5 = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varc5; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermc6 
val = :yy_nil 
begin; yy_varc7 = @yy_input.pos; yy_nontermc4() or (@yy_input.pos = yy_varc7; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermc8 
val = :yy_nil 
(begin
      val = ""
      yy_varcm = @yy_input.pos
      (yy_nontermco() and while true
      yy_varcl = @yy_input.pos
      if not yy_nontermcq() then
        @yy_input.pos = yy_varcl
        break true
      end
    end) and begin
        yy_varcn = @yy_input.pos
        @yy_input.pos = yy_varcm
        val << @yy_input.read(yy_varcn - yy_varcm).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nontermco 
val = :yy_nil 
begin; yy_varcp = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varcp; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermcq 
val = :yy_nil 
begin; yy_varcr = @yy_input.pos; yy_nontermco() or (@yy_input.pos = yy_varcr; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermcs 
val = :yy_nil 
(not begin
      yy_varcw = @yy_input.pos
      yy_varcx = yy_nontermay()
      @yy_input.pos = yy_varcw
      yy_varcx
    end and begin; yy_vardr = @yy_input.pos; (begin
      val = ""
      yy_vare4 = @yy_input.pos
      (yy_nontermek() and while true
      yy_vare3 = @yy_input.pos
      if not yy_nontermem() then
        @yy_input.pos = yy_vare3
        break true
      end
    end) and begin
        yy_vare5 = @yy_input.pos
        @yy_input.pos = yy_vare4
        val << @yy_input.read(yy_vare5 - yy_vare4).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermh0()) or (@yy_input.pos = yy_vardr; (begin
      val = ""
      yy_varei = @yy_input.pos
      (yy_string("`") and  begin
      while true
        ###
        yy_vareg = @yy_input.pos
        ### Look ahead.
        yy_vareh = yy_string("`")
        @yy_input.pos = yy_vareg
        break if yy_vareh
        ### Repeat one more time (if possible).
        yy_vareh = @yy_input.getc
        if not yy_vareh then
          @yy_input.pos = yy_vareg
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string("`")) and begin
        yy_varej = @yy_input.pos
        @yy_input.pos = yy_varei
        val << @yy_input.read(yy_varej - yy_varei).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermh0())); end) and yy_to_pcv(val) 
end 
def yy_nontermek 
val = :yy_nil 
begin; yy_varel = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varel; yy_char_range("A", "Z")) or (@yy_input.pos = yy_varel; yy_string("-")) or (@yy_input.pos = yy_varel; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermem 
val = :yy_nil 
begin; yy_varen = @yy_input.pos; yy_nontermek() or (@yy_input.pos = yy_varen; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermeo 
val = :yy_nil 
(begin
      yy_vareq = yy_nontermeu()
      if yy_vareq then
        from = yy_from_pcv(yy_vareq)
      end
      yy_vareq
    end and begin; yy_vares = @yy_input.pos; yy_string("...") or (@yy_input.pos = yy_vares; yy_string("..")) or (@yy_input.pos = yy_vares; yy_string("\u{2026}")) or (@yy_input.pos = yy_vares; yy_string("\u{2025}")); end and yy_nontermh0() and begin
      yy_varet = yy_nontermeu()
      if yy_varet then
        to = yy_from_pcv(yy_varet)
      end
      yy_varet
    end and yy_nontermh0() and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermeu 
val = :yy_nil 
(begin; yy_varfq = @yy_input.pos; (yy_string("'") and begin
      val = ""
      yy_varg3 = @yy_input.pos
       begin
      while true
        ###
        yy_varg1 = @yy_input.pos
        ### Look ahead.
        yy_varg2 = yy_string("'")
        @yy_input.pos = yy_varg1
        break if yy_varg2
        ### Repeat one more time (if possible).
        yy_varg2 = @yy_input.getc
        if not yy_varg2 then
          @yy_input.pos = yy_varg1
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varg4 = @yy_input.pos
        @yy_input.pos = yy_varg3
        val << @yy_input.read(yy_varg4 - yy_varg3).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("'")) or (@yy_input.pos = yy_varfq; (yy_string("\"") and begin
      val = ""
      yy_vargh = @yy_input.pos
       begin
      while true
        ###
        yy_vargf = @yy_input.pos
        ### Look ahead.
        yy_vargg = yy_string("\"")
        @yy_input.pos = yy_vargf
        break if yy_vargg
        ### Repeat one more time (if possible).
        yy_vargg = @yy_input.getc
        if not yy_vargg then
          @yy_input.pos = yy_vargf
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_vargi = @yy_input.pos
        @yy_input.pos = yy_vargh
        val << @yy_input.read(yy_vargi - yy_vargh).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("\""))) or (@yy_input.pos = yy_varfq; (begin
      yy_vargj = yy_nontermgk()
      if yy_vargj then
        code = yy_from_pcv(yy_vargj)
      end
      yy_vargj
    end and begin 
  val = "" << code  
 true 
 end)); end and yy_nontermh0()) and yy_to_pcv(val) 
end 
def yy_nontermgk 
val = :yy_nil 
(yy_string("U+") and begin
      code = ""
      yy_vargy = @yy_input.pos
      begin; yy_vargw = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_vargw; yy_char_range("A", "F")); end and while true
      yy_vargx = @yy_input.pos
      if not begin; yy_vargw = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_vargw; yy_char_range("A", "F")); end then
        @yy_input.pos = yy_vargx
        break true
      end
    end and begin
        yy_vargz = @yy_input.pos
        @yy_input.pos = yy_vargy
        code << @yy_input.read(yy_vargz - yy_vargy).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermh0 
val = :yy_nil 
while true
      yy_varh5 = @yy_input.pos
      if not begin; yy_varh4 = @yy_input.pos; yy_nontermhg() or (@yy_input.pos = yy_varh4; yy_nontermh6()); end then
        @yy_input.pos = yy_varh5
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nontermh6 
val = :yy_nil 
(begin; yy_varh9 = @yy_input.pos; yy_string("#") or (@yy_input.pos = yy_varh9; yy_string("--")); end and  begin
      while true
        ###
        yy_varhc = @yy_input.pos
        ### Look ahead.
        yy_varhd = begin; yy_varhf = @yy_input.pos; yy_nontermhi() or (@yy_input.pos = yy_varhf; @yy_input.eof?); end
        @yy_input.pos = yy_varhc
        break if yy_varhd
        ### Repeat one more time (if possible).
        yy_varhd = @yy_input.getc
        if not yy_varhd then
          @yy_input.pos = yy_varhc
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_varhf = @yy_input.pos; yy_nontermhi() or (@yy_input.pos = yy_varhf; @yy_input.eof?); end) and yy_to_pcv(val) 
end 
def yy_nontermhg 
val = :yy_nil 
begin; yy_varhh = @yy_input.pos; yy_char_range("\t", "\r") or (@yy_input.pos = yy_varhh; yy_string(" ")) or (@yy_input.pos = yy_varhh; yy_string("\u{85}")) or (@yy_input.pos = yy_varhh; yy_string("\u{a0}")) or (@yy_input.pos = yy_varhh; yy_string("\u{1680}")) or (@yy_input.pos = yy_varhh; yy_string("\u{180e}")) or (@yy_input.pos = yy_varhh; yy_char_range("\u{2000}", "\u{200a}")) or (@yy_input.pos = yy_varhh; yy_string("\u{2028}")) or (@yy_input.pos = yy_varhh; yy_string("\u{2029}")) or (@yy_input.pos = yy_varhh; yy_string("\u{202f}")) or (@yy_input.pos = yy_varhh; yy_string("\u{205f}")) or (@yy_input.pos = yy_varhh; yy_string("\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nontermhi 
val = :yy_nil 
begin; yy_varhj = @yy_input.pos; (yy_string("\r") and yy_string("\n")) or (@yy_input.pos = yy_varhj; yy_string("\r")) or (@yy_input.pos = yy_varhj; yy_string("\n")) or (@yy_input.pos = yy_varhj; yy_string("\u{85}")) or (@yy_input.pos = yy_varhj; yy_string("\v")) or (@yy_input.pos = yy_varhj; yy_string("\f")) or (@yy_input.pos = yy_varhj; yy_string("\u{2028}")) or (@yy_input.pos = yy_varhj; yy_string("\u{2029}")); end and yy_to_pcv(val) 
end 
  
  def capture_semantic_value_code(var, code)
    result_var = new_unique_variable_name
    #
    code(%(begin
      #{result_var} = )) + code + code(%(
      if #{result_var} then
        #{var} = yy_from_pcv(#{result_var})
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
      #{stored_pos_var} = @yy_input.pos
      #{result_var} = )) + code + code(%(
      @yy_input.pos = #{stored_pos_var}
      #{result_var}
    end))
  end
  
  def repeat_many_times_code(code)
    stored_pos_var = new_unique_variable_name
    #
    code(%(while true
      #{stored_pos_var} = @yy_input.pos
      if not )) + code + code(%( then
        @yy_input.pos = #{stored_pos_var}
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
      #{stored_pos_var} = @yy_input.pos
      if not )) + code + code(%( then
        @yy_input.pos = #{stored_pos_var}
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
        #{original_pos_var} = @yy_input.pos
        ### Look ahead.
        #{result_var} = ]) + LazyRepeat::UnknownLookAheadCode.new + code(%[
        @yy_input.pos = #{original_pos_var}
        break if #{result_var}
        ### Repeat one more time (if possible).
        #{result_var} = ]) + parsing_code + code(%[
        if not #{result_var} then
          @yy_input.pos = #{original_pos_var}
          break
        end
      end
      ### The repetition is always successful.
      true
    end ])
  end
  
  # returns code which captures text to specified variable.
  def capture_text_code(variable_name, parsing_code)
    #
    start_pos_var = new_unique_variable_name
    end_pos_var = new_unique_variable_name
    # 
    code(%(begin
      #{variable_name} = ""
      #{start_pos_var} = @yy_input.pos
      )) +
      parsing_code + code(%( and begin
        #{end_pos_var} = @yy_input.pos
        @yy_input.pos = #{start_pos_var}
        #{variable_name} << @yy_input.read(#{end_pos_var} - #{start_pos_var}).force_encoding(Encoding::UTF_8)
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
      
      def yy_string(string)
        # Read string.
        read_string = @yy_input.read(string.bytesize)
        return nil if not read_string
        read_string.force_encoding(Encoding::UTF_8)
        # 
        if read_string == string then return string
        else return nil
        end
      end
      
      def yy_char_range(from, to)
        # 
        c = @yy_input.getc
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
        @yy_input = input
        @yy_input.set_encoding("UTF-8", "UTF-8")
        #{parsing_method_name} or raise YY_SyntaxError
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
        code "#{method_names[code_part.nonterminal]}()"
      else
        code_part
      end
    end
  end
  
  def to_method_definition(code, method_name)
    code("def #{method_name} \n") +
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
    
    def initialize(nonterminal)
      @nonterminal = nonterminal
    end
    
    # Nonterminal associated with this UnknownMethodCall.
    attr_reader :nonterminal
    
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
