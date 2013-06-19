#!/usr/bin/ruby
# encoding: UTF-8

# This file is both runnable and "require"-able.


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
        x = yy_nonterm9 or raise YY_SyntaxError
      end
      
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
    def yy_nonterm9 
val = :yy_nil 
(begin 
 
    code = code("")
    rule_is_first = true
    method_names = HashMap.new
   
 true 
 end and yy_nontermfn() and while true
      yy_var8 = @yy_input.pos
      if not begin; yy_var5 = @yy_input.pos; (begin
      yy_var6 = yy_nonterm25()
      if yy_var6 then
        r = yy_from_pcv(yy_var6)
      end
      yy_var6
    end and begin 
 
        # 
        nonterminal, method_name, method_code = *r
        # 
        if rule_is_first
          code += auxiliary_parser_code(method_name)
          rule_is_first = false
        end
        # 
        method_names[nonterminal] = method_name
        code += method_code
       
 true 
 end) or (@yy_input.pos = yy_var5; (begin
      yy_var7 = yy_nonterm8n()
      if yy_var7 then
        x = yy_from_pcv(yy_var7)
      end
      yy_var7
    end and begin 
 
        code += code(x)
       
 true 
 end)); end then
        @yy_input.pos = yy_var8
        break true
      end
    end and @yy_input.eof? and begin 
 
    code = link(code, method_names)
    print code
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermc 
val = :yy_nil 
begin
      yy_varb = yy_nontermn()
      if yy_varb then
        val = yy_from_pcv(yy_varb)
      end
      yy_varb
    end and yy_to_pcv(val) 
end 
def yy_nontermn 
val = :yy_nil 
(begin 
 
    single_expression = true
    remembered_pos_var = new_unique_variable_name
   
 true 
 end and begin
      yy_varf = @yy_input.pos
      if not yy_nonterm95() then
        @yy_input.pos = yy_varf
      end
      true
    end and begin
      yy_varg = yy_nontermv()
      if yy_varg then
        val = yy_from_pcv(yy_varg)
      end
      yy_varg
    end and while true
      yy_varm = @yy_input.pos
      if not (yy_nonterm95() and begin
      yy_varl = yy_nontermv()
      if yy_varl then
        val2 = yy_from_pcv(yy_varl)
      end
      yy_varl
    end and begin 
 
      single_expression = false
      val = val + (code " or (@yy_input.pos = #{remembered_pos_var}; ") + val2 + (code ")")
     
 true 
 end) then
        @yy_input.pos = yy_varm
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "begin; #{remembered_pos_var} = @yy_input.pos; ") + val + (code "; end")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermv 
val = :yy_nil 
(begin 
  code_parts = []  
 true 
 end and begin; yy_vars = @yy_input.pos; (begin
      yy_vart = yy_nonterm10()
      if yy_vart then
        code_part = yy_from_pcv(yy_vart)
      end
      yy_vart
    end and begin 
  code_parts.add code_part  
 true 
 end) or (@yy_input.pos = yy_vars; (yy_nonterm9h() and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end and while true
      yy_varu = @yy_input.pos
      if not begin; yy_vars = @yy_input.pos; (begin
      yy_vart = yy_nonterm10()
      if yy_vart then
        code_part = yy_from_pcv(yy_vart)
      end
      yy_vart
    end and begin 
  code_parts.add code_part  
 true 
 end) or (@yy_input.pos = yy_vars; (yy_nonterm9h() and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end then
        @yy_input.pos = yy_varu
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
  
def yy_nonterm10 
val = :yy_nil 
begin; yy_varw = @yy_input.pos; (begin
      yy_varx = yy_nonterm16()
      if yy_varx then
        c = yy_from_pcv(yy_varx)
      end
      yy_varx
    end and yy_nonterm9j() and begin
      yy_vary = yy_nonterm2z()
      if yy_vary then
        var = yy_from_pcv(yy_vary)
      end
      yy_vary
    end and begin 
  val = capture_semantic_value_code(var, c)  
 true 
 end) or (@yy_input.pos = yy_varw; begin
      yy_varz = yy_nonterm16()
      if yy_varz then
        val = yy_from_pcv(yy_varz)
      end
      yy_varz
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm16 
val = :yy_nil 
begin; yy_var11 = @yy_input.pos; (yy_nonterm9x() and begin
      yy_var12 = yy_nonterm8n()
      if yy_var12 then
        c = yy_from_pcv(yy_var12)
      end
      yy_var12
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (@yy_input.pos = yy_var11; (yy_nonterm9x() and begin
      yy_var13 = yy_nonterm16()
      if yy_var13 then
        val = yy_from_pcv(yy_var13)
      end
      yy_var13
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var11; (yy_nonterm9z() and begin
      yy_var14 = yy_nonterm16()
      if yy_var14 then
        val = yy_from_pcv(yy_var14)
      end
      yy_var14
    end and begin 
  val = code(%(not )) + positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var11; begin
      yy_var15 = yy_nonterm1d()
      if yy_var15 then
        val = yy_from_pcv(yy_var15)
      end
      yy_var15
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1d 
val = :yy_nil 
(begin
      yy_var18 = yy_nonterm1j()
      if yy_var18 then
        val = yy_from_pcv(yy_var18)
      end
      yy_var18
    end and while true
      yy_var1c = @yy_input.pos
      if not begin; yy_var1b = @yy_input.pos; (yy_nonterm9r() and begin 
  val = lazy_repeat_code(val)  
 true 
 end) or (@yy_input.pos = yy_var1b; (yy_nonterm9p() and begin 
  val = repeat_many_times_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1b; (yy_nonterm9v() and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1b; (yy_nonterm9t() and begin 
  val = optional_code(val)  
 true 
 end)); end then
        @yy_input.pos = yy_var1c
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm1j 
val = :yy_nil 
begin; yy_var1e = @yy_input.pos; (yy_nonterm9b() and begin
      yy_var1f = yy_nontermc()
      if yy_var1f then
        val = yy_from_pcv(yy_var1f)
      end
      yy_var1f
    end and yy_nonterm9d()) or (@yy_input.pos = yy_var1e; (yy_nonterm9l() and begin
      yy_var1g = yy_nontermc()
      if yy_var1g then
        c = yy_from_pcv(yy_var1g)
      end
      yy_var1g
    end and yy_nonterm9n() and yy_nonterm9j() and begin
      yy_var1h = yy_nonterm2z()
      if yy_var1h then
        var = yy_from_pcv(yy_var1h)
      end
      yy_var1h
    end and begin 
  val = capture_text_code(var, c)  
 true 
 end)) or (@yy_input.pos = yy_var1e; begin
      yy_var1i = yy_nonterm1x()
      if yy_var1i then
        val = yy_from_pcv(yy_var1i)
      end
      yy_var1i
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1x 
val = :yy_nil 
begin; yy_var1k = @yy_input.pos; (begin
      yy_var1l = yy_nontermdb()
      if yy_var1l then
        r = yy_from_pcv(yy_var1l)
      end
      yy_var1l
    end and begin 
  val = code "yy_char_range(#{r.begin.dump}, #{r.end.dump})"  
 true 
 end) or (@yy_input.pos = yy_var1k; (begin
      yy_var1m = yy_nontermf1()
      if yy_var1m then
        s = yy_from_pcv(yy_var1m)
      end
      yy_var1m
    end and begin 
  val = code "yy_string(#{s.dump})"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (begin
      yy_var1n = yy_nontermd1()
      if yy_var1n then
        n = yy_from_pcv(yy_var1n)
      end
      yy_var1n
    end and begin 
  val = UnknownMethodCall[n]  
 true 
 end)) or (@yy_input.pos = yy_var1k; (yy_nonterma9() and begin 
  val = code "@yy_input.getc"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (begin
      yy_var1o = yy_nonterm8n()
      if yy_var1o then
        a = yy_from_pcv(yy_var1o)
      end
      yy_var1o
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (yy_nonterm97() and begin 
  val = code "@yy_input.eof?"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (yy_nonterm99() and begin 
  val = code "(@yy_input.pos == 0)"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (begin; yy_var1s = @yy_input.pos; (yy_nonterma1() and yy_nonterma3() and begin
      yy_var1t = yy_nontermb5()
      if yy_var1t then
        pos_variable = yy_from_pcv(yy_var1t)
      end
      yy_var1t
    end) or (@yy_input.pos = yy_var1s; (yy_nontermaf() and begin
      yy_var1u = yy_nontermb5()
      if yy_var1u then
        pos_variable = yy_from_pcv(yy_var1u)
      end
      yy_var1u
    end)); end and begin
      yy_var1w = @yy_input.pos
      if not yy_nonterm9j() then
        @yy_input.pos = yy_var1w
      end
      true
    end and begin 
  val = code "(@yy_input.pos = #{pos_variable}; true)"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (yy_nonterma1() and begin 
  val = code "@yy_input.pos"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm25 
val = :yy_nil 
(begin
      yy_var1z = yy_nontermd1()
      if yy_var1z then
        n = yy_from_pcv(yy_var1z)
      end
      yy_var1z
    end and begin
      yy_var23 = @yy_input.pos
      if not (yy_nonterm9j() and yy_nonterm2v()) then
        @yy_input.pos = yy_var23
      end
      true
    end and yy_nonterm8z() and begin
      yy_var24 = yy_nontermc()
      if yy_var24 then
        c = yy_from_pcv(yy_var24)
      end
      yy_var24
    end and yy_nonterm93() and begin 
 
    method_name = new_unique_nonterminal_method_name
    val = [n, method_name, to_method_definition(c, method_name)]
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm2v 
val = :yy_nil 
((not begin
      yy_var2s = @yy_input.pos
      yy_var2t = yy_nonterm8z()
      @yy_input.pos = yy_var2s
      yy_var2t
    end and @yy_input.getc) and yy_nontermfn()) and while true
      yy_var2u = @yy_input.pos
      if not ((not begin
      yy_var2s = @yy_input.pos
      yy_var2t = yy_nonterm8z()
      @yy_input.pos = yy_var2s
      yy_var2t
    end and @yy_input.getc) and yy_nontermfn()) then
        @yy_input.pos = yy_var2u
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm2z 
val = :yy_nil 
begin; yy_var2w = @yy_input.pos; begin
      yy_var2x = yy_nontermb5()
      if yy_var2x then
        val = yy_from_pcv(yy_var2x)
      end
      yy_var2x
    end or (@yy_input.pos = yy_var2w; (yy_nonterm9b() and begin
      yy_var2y = yy_nontermb5()
      if yy_var2y then
        val = yy_from_pcv(yy_var2y)
      end
      yy_var2y
    end and yy_nonterm9d())); end and yy_to_pcv(val) 
end 
def yy_nonterm37 
val = :yy_nil 
(yy_string("%%") and  begin
      while true
        ###
        yy_var33 = @yy_input.pos
        ### Look ahead.
        yy_var34 = begin; yy_var36 = @yy_input.pos; yy_nontermg1() or (@yy_input.pos = yy_var36; @yy_input.eof?); end
        @yy_input.pos = yy_var33
        break if yy_var34
        ### Repeat one more time (if possible).
        yy_var34 = @yy_input.getc
        if not yy_var34 then
          @yy_input.pos = yy_var33
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_var36 = @yy_input.pos; yy_nontermg1() or (@yy_input.pos = yy_var36; @yy_input.eof?); end) and yy_to_pcv(val) 
end 
def yy_nonterm8n 
val = :yy_nil 
(begin; yy_var5y = @yy_input.pos; (yy_string("{") and while true
      yy_var60 = @yy_input.pos
      if not yy_nontermfz() then
        @yy_input.pos = yy_var60
        break true
      end
    end and yy_string("...") and begin
      yy_var6c = @yy_input.pos
      if not ( begin
      while true
        ###
        yy_var6a = @yy_input.pos
        ### Look ahead.
        yy_var6b = yy_nontermg1()
        @yy_input.pos = yy_var6a
        break if yy_var6b
        ### Repeat one more time (if possible).
        yy_var6b = yy_nontermfz()
        if not yy_var6b then
          @yy_input.pos = yy_var6a
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nontermg1()) then
        @yy_input.pos = yy_var6c
      end
      true
    end and begin
      val = ""
      yy_var6p = @yy_input.pos
       begin
      while true
        ###
        yy_var6n = @yy_input.pos
        ### Look ahead.
        yy_var6o = begin; yy_var6w = @yy_input.pos; (yy_string("...") and while true
      yy_var6y = @yy_input.pos
      if not yy_nontermfz() then
        @yy_input.pos = yy_var6y
        break true
      end
    end and yy_string("}")) or (@yy_input.pos = yy_var6w; (yy_string("}") and while true
      yy_var70 = @yy_input.pos
      if not yy_nontermfz() then
        @yy_input.pos = yy_var70
        break true
      end
    end and yy_string("..."))); end
        @yy_input.pos = yy_var6n
        break if yy_var6o
        ### Repeat one more time (if possible).
        yy_var6o = @yy_input.getc
        if not yy_var6o then
          @yy_input.pos = yy_var6n
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var6q = @yy_input.pos
        @yy_input.pos = yy_var6p
        val << @yy_input.read(yy_var6q - yy_var6p).force_encoding(Encoding::UTF_8)
      end
    end and begin; yy_var6w = @yy_input.pos; (yy_string("...") and while true
      yy_var6y = @yy_input.pos
      if not yy_nontermfz() then
        @yy_input.pos = yy_var6y
        break true
      end
    end and yy_string("}")) or (@yy_input.pos = yy_var6w; (yy_string("}") and while true
      yy_var70 = @yy_input.pos
      if not yy_nontermfz() then
        @yy_input.pos = yy_var70
        break true
      end
    end and yy_string("..."))); end) or (@yy_input.pos = yy_var5y; (begin
      val = ""
      yy_var75 = @yy_input.pos
      yy_nonterm8v() and begin
        yy_var76 = @yy_input.pos
        @yy_input.pos = yy_var75
        val << @yy_input.read(yy_var76 - yy_var75).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = val[1...-1]  
 true 
 end)) or (@yy_input.pos = yy_var5y; (yy_nonterm37() and begin
      val = ""
      yy_var7z = @yy_input.pos
       begin
      while true
        ###
        yy_var7x = @yy_input.pos
        ### Look ahead.
        yy_var7y = yy_nonterm37()
        @yy_input.pos = yy_var7x
        break if yy_var7y
        ### Repeat one more time (if possible).
        yy_var7y = @yy_input.getc
        if not yy_var7y then
          @yy_input.pos = yy_var7x
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var80 = @yy_input.pos
        @yy_input.pos = yy_var7z
        val << @yy_input.read(yy_var80 - yy_var7z).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm37())) or (@yy_input.pos = yy_var5y; (yy_nonterm37() and begin
      val = ""
      yy_var8l = @yy_input.pos
      while true
      yy_var8k = @yy_input.pos
      if not @yy_input.getc then
        @yy_input.pos = yy_var8k
        break true
      end
    end and begin
        yy_var8m = @yy_input.pos
        @yy_input.pos = yy_var8l
        val << @yy_input.read(yy_var8m - yy_var8l).force_encoding(Encoding::UTF_8)
      end
    end and @yy_input.eof?)); end and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm8v 
val = :yy_nil 
(yy_string("{") and  begin
      while true
        ###
        yy_var8t = @yy_input.pos
        ### Look ahead.
        yy_var8u = yy_string("}")
        @yy_input.pos = yy_var8t
        break if yy_var8u
        ### Repeat one more time (if possible).
        yy_var8u = begin; yy_var8s = @yy_input.pos; yy_nonterm8v() or (@yy_input.pos = yy_var8s; @yy_input.getc); end
        if not yy_var8u then
          @yy_input.pos = yy_var8t
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string("}")) and yy_to_pcv(val) 
end 
def yy_nonterm8z 
val = :yy_nil 
(begin; yy_var8y = @yy_input.pos; yy_string("<-") or (@yy_input.pos = yy_var8y; yy_string("=")) or (@yy_input.pos = yy_var8y; yy_string("\u{2190}")); end and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm91 
val = :yy_nil 
(yy_string(":") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm93 
val = :yy_nil 
(yy_string(";") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm95 
val = :yy_nil 
(yy_string("/") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm97 
val = :yy_nil 
(yy_string("$") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm99 
val = :yy_nil 
(yy_string("^") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm9b 
val = :yy_nil 
(yy_string("(") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm9d 
val = :yy_nil 
(yy_string(")") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm9f 
val = :yy_nil 
(yy_string("[") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm9h 
val = :yy_nil 
(yy_string("]") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm9j 
val = :yy_nil 
(yy_string(":") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm9l 
val = :yy_nil 
(yy_string("<") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm9n 
val = :yy_nil 
(yy_string(">") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm9p 
val = :yy_nil 
(yy_string("*") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm9r 
val = :yy_nil 
(yy_string("*?") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm9t 
val = :yy_nil 
(yy_string("?") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm9v 
val = :yy_nil 
(yy_string("+") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm9x 
val = :yy_nil 
(yy_string("&") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterm9z 
val = :yy_nil 
(yy_string("!") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterma1 
val = :yy_nil 
(yy_string("@") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterma3 
val = :yy_nil 
(yy_string("=") and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nonterma9 
val = :yy_nil 
(yy_string("char") and not begin
      yy_vara7 = @yy_input.pos
      yy_vara8 = yy_nontermd5()
      @yy_input.pos = yy_vara7
      yy_vara8
    end and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nontermaf 
val = :yy_nil 
(yy_string("at") and not begin
      yy_varad = @yy_input.pos
      yy_varae = yy_nontermd5()
      @yy_input.pos = yy_varad
      yy_varae
    end and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nontermah 
val = :yy_nil 
begin; yy_varag = @yy_input.pos; yy_nonterma9() or (@yy_input.pos = yy_varag; yy_nontermaf()); end and yy_to_pcv(val) 
end 
def yy_nontermb5 
val = :yy_nil 
(begin
      val = ""
      yy_varb3 = @yy_input.pos
      (begin
      yy_varay = @yy_input.pos
      if not begin; yy_varax = @yy_input.pos; yy_string("@") or (@yy_input.pos = yy_varax; yy_string("$")); end then
        @yy_input.pos = yy_varay
      end
      true
    end and yy_nontermb7() and while true
      yy_varb2 = @yy_input.pos
      if not yy_nontermb9() then
        @yy_input.pos = yy_varb2
        break true
      end
    end) and begin
        yy_varb4 = @yy_input.pos
        @yy_input.pos = yy_varb3
        val << @yy_input.read(yy_varb4 - yy_varb3).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nontermb7 
val = :yy_nil 
begin; yy_varb6 = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varb6; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermb9 
val = :yy_nil 
begin; yy_varb8 = @yy_input.pos; yy_nontermb7() or (@yy_input.pos = yy_varb8; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermd1 
val = :yy_nil 
(not begin
      yy_varbd = @yy_input.pos
      yy_varbe = yy_nontermah()
      @yy_input.pos = yy_varbd
      yy_varbe
    end and begin; yy_varc8 = @yy_input.pos; (begin
      val = ""
      yy_varcl = @yy_input.pos
      (yy_nontermd3() and while true
      yy_varck = @yy_input.pos
      if not yy_nontermd5() then
        @yy_input.pos = yy_varck
        break true
      end
    end) and begin
        yy_varcm = @yy_input.pos
        @yy_input.pos = yy_varcl
        val << @yy_input.read(yy_varcm - yy_varcl).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermfn()) or (@yy_input.pos = yy_varc8; (begin
      val = ""
      yy_varcz = @yy_input.pos
      (yy_string("`") and  begin
      while true
        ###
        yy_varcx = @yy_input.pos
        ### Look ahead.
        yy_varcy = yy_string("`")
        @yy_input.pos = yy_varcx
        break if yy_varcy
        ### Repeat one more time (if possible).
        yy_varcy = @yy_input.getc
        if not yy_varcy then
          @yy_input.pos = yy_varcx
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string("`")) and begin
        yy_vard0 = @yy_input.pos
        @yy_input.pos = yy_varcz
        val << @yy_input.read(yy_vard0 - yy_varcz).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermfn())); end) and yy_to_pcv(val) 
end 
def yy_nontermd3 
val = :yy_nil 
begin; yy_vard2 = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_vard2; yy_char_range("A", "Z")) or (@yy_input.pos = yy_vard2; yy_string("-")) or (@yy_input.pos = yy_vard2; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermd5 
val = :yy_nil 
begin; yy_vard4 = @yy_input.pos; yy_nontermd3() or (@yy_input.pos = yy_vard4; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermdb 
val = :yy_nil 
(begin
      yy_vard7 = yy_nontermf1()
      if yy_vard7 then
        from = yy_from_pcv(yy_vard7)
      end
      yy_vard7
    end and begin; yy_vard9 = @yy_input.pos; yy_string("...") or (@yy_input.pos = yy_vard9; yy_string("..")) or (@yy_input.pos = yy_vard9; yy_string("\u{2026}")) or (@yy_input.pos = yy_vard9; yy_string("\u{2025}")); end and yy_nontermfn() and begin
      yy_varda = yy_nontermf1()
      if yy_varda then
        to = yy_from_pcv(yy_varda)
      end
      yy_varda
    end and yy_nontermfn() and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermf1 
val = :yy_nil 
(begin; yy_vare7 = @yy_input.pos; (yy_string("'") and begin
      val = ""
      yy_varek = @yy_input.pos
       begin
      while true
        ###
        yy_varei = @yy_input.pos
        ### Look ahead.
        yy_varej = yy_string("'")
        @yy_input.pos = yy_varei
        break if yy_varej
        ### Repeat one more time (if possible).
        yy_varej = @yy_input.getc
        if not yy_varej then
          @yy_input.pos = yy_varei
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varel = @yy_input.pos
        @yy_input.pos = yy_varek
        val << @yy_input.read(yy_varel - yy_varek).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("'")) or (@yy_input.pos = yy_vare7; (yy_string("\"") and begin
      val = ""
      yy_varey = @yy_input.pos
       begin
      while true
        ###
        yy_varew = @yy_input.pos
        ### Look ahead.
        yy_varex = yy_string("\"")
        @yy_input.pos = yy_varew
        break if yy_varex
        ### Repeat one more time (if possible).
        yy_varex = @yy_input.getc
        if not yy_varex then
          @yy_input.pos = yy_varew
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varez = @yy_input.pos
        @yy_input.pos = yy_varey
        val << @yy_input.read(yy_varez - yy_varey).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("\""))) or (@yy_input.pos = yy_vare7; (begin
      yy_varf0 = yy_nontermfh()
      if yy_varf0 then
        code = yy_from_pcv(yy_varf0)
      end
      yy_varf0
    end and begin 
  val = "" << code  
 true 
 end)); end and yy_nontermfn()) and yy_to_pcv(val) 
end 
def yy_nontermfh 
val = :yy_nil 
(yy_string("U+") and begin
      code = ""
      yy_varff = @yy_input.pos
      begin; yy_varfd = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_varfd; yy_char_range("A", "F")); end and while true
      yy_varfe = @yy_input.pos
      if not begin; yy_varfd = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_varfd; yy_char_range("A", "F")); end then
        @yy_input.pos = yy_varfe
        break true
      end
    end and begin
        yy_varfg = @yy_input.pos
        @yy_input.pos = yy_varff
        code << @yy_input.read(yy_varfg - yy_varff).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermfn 
val = :yy_nil 
while true
      yy_varfm = @yy_input.pos
      if not begin; yy_varfl = @yy_input.pos; yy_nontermfz() or (@yy_input.pos = yy_varfl; yy_nontermfx()); end then
        @yy_input.pos = yy_varfm
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nontermfx 
val = :yy_nil 
(begin; yy_varfq = @yy_input.pos; yy_string("#") or (@yy_input.pos = yy_varfq; yy_string("--")); end and  begin
      while true
        ###
        yy_varft = @yy_input.pos
        ### Look ahead.
        yy_varfu = begin; yy_varfw = @yy_input.pos; yy_nontermg1() or (@yy_input.pos = yy_varfw; @yy_input.eof?); end
        @yy_input.pos = yy_varft
        break if yy_varfu
        ### Repeat one more time (if possible).
        yy_varfu = @yy_input.getc
        if not yy_varfu then
          @yy_input.pos = yy_varft
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_varfw = @yy_input.pos; yy_nontermg1() or (@yy_input.pos = yy_varfw; @yy_input.eof?); end) and yy_to_pcv(val) 
end 
def yy_nontermfz 
val = :yy_nil 
begin; yy_varfy = @yy_input.pos; yy_char_range("\t", "\r") or (@yy_input.pos = yy_varfy; yy_string(" ")) or (@yy_input.pos = yy_varfy; yy_string("\u{85}")) or (@yy_input.pos = yy_varfy; yy_string("\u{a0}")) or (@yy_input.pos = yy_varfy; yy_string("\u{1680}")) or (@yy_input.pos = yy_varfy; yy_string("\u{180e}")) or (@yy_input.pos = yy_varfy; yy_char_range("\u{2000}", "\u{200a}")) or (@yy_input.pos = yy_varfy; yy_string("\u{2028}")) or (@yy_input.pos = yy_varfy; yy_string("\u{2029}")) or (@yy_input.pos = yy_varfy; yy_string("\u{202f}")) or (@yy_input.pos = yy_varfy; yy_string("\u{205f}")) or (@yy_input.pos = yy_varfy; yy_string("\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nontermg1 
val = :yy_nil 
begin; yy_varg0 = @yy_input.pos; (yy_string("\r") and yy_string("\n")) or (@yy_input.pos = yy_varg0; yy_string("\r")) or (@yy_input.pos = yy_varg0; yy_string("\n")) or (@yy_input.pos = yy_varg0; yy_string("\u{85}")) or (@yy_input.pos = yy_varg0; yy_string("\v")) or (@yy_input.pos = yy_varg0; yy_string("\f")) or (@yy_input.pos = yy_varg0; yy_string("\u{2028}")) or (@yy_input.pos = yy_varg0; yy_string("\u{2029}")); end and yy_to_pcv(val) 
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
  
  def auxiliary_parser_code(main_parsing_method_name)
    code %(
      
      # 
      # +input+ is IO. It must have working IO#pos, IO#pos= and
      # IO#set_encoding() methods.
      # 
      # It may raise YY_SyntaxError.
      # 
      def yy_parse(input)
        @yy_input = input
        @yy_input.set_encoding("UTF-8", "UTF-8")
        x = #{main_parsing_method_name} or raise YY_SyntaxError
      end
      
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
  
  # returns unique value on each call. The value starts with "yy_nonterm" and is
  # lowcase.
  def new_unique_nonterminal_method_name
    "yy_nonterm#{new_unique_number.to_s(36)}"
  end
  
  # returns unique number on each call.
  def new_unique_number
    result = @next_unique_number
    @next_unique_number += 1
    return result
  end
  
  # returns unique value on each call. The value starts with "yy_var" and is
  # lowcase.
  def new_unique_variable_name
    "yy_var#{new_unique_number.to_s(36)}"
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
