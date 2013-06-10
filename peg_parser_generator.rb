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
 end and yy_nontermff() and while true
      yy_var8 = @yy_input.pos
      if not begin; yy_var5 = @yy_input.pos; (begin
      yy_var6 = yy_nonterm23()
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
      yy_var7 = yy_nonterm8l()
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
      if not yy_nonterm91() then
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
      if not (yy_nonterm91() and begin
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
 end) or (@yy_input.pos = yy_vars; (yy_nonterm9d() and begin 
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
 end) or (@yy_input.pos = yy_vars; (yy_nonterm9d() and begin 
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
    end and yy_nonterm9f() and begin
      yy_vary = yy_nonterm2x()
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
begin; yy_var11 = @yy_input.pos; (yy_nonterm9t() and begin
      yy_var12 = yy_nonterm8l()
      if yy_var12 then
        c = yy_from_pcv(yy_var12)
      end
      yy_var12
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (@yy_input.pos = yy_var11; (yy_nonterm9t() and begin
      yy_var13 = yy_nonterm16()
      if yy_var13 then
        val = yy_from_pcv(yy_var13)
      end
      yy_var13
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var11; (yy_nonterm9v() and begin
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
      if not begin; yy_var1b = @yy_input.pos; (yy_nonterm9n() and begin 
  val = lazy_repeat_code(val)  
 true 
 end) or (@yy_input.pos = yy_var1b; (yy_nonterm9l() and begin 
  val = repeat_many_times_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1b; (yy_nonterm9r() and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1b; (yy_nonterm9p() and begin 
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
begin; yy_var1e = @yy_input.pos; (yy_nonterm97() and begin
      yy_var1f = yy_nontermc()
      if yy_var1f then
        val = yy_from_pcv(yy_var1f)
      end
      yy_var1f
    end and yy_nonterm99()) or (@yy_input.pos = yy_var1e; (yy_nonterm9h() and begin
      yy_var1g = yy_nontermc()
      if yy_var1g then
        c = yy_from_pcv(yy_var1g)
      end
      yy_var1g
    end and yy_nonterm9j() and yy_nonterm9f() and begin
      yy_var1h = yy_nonterm2x()
      if yy_var1h then
        var = yy_from_pcv(yy_var1h)
      end
      yy_var1h
    end and begin 
  val = capture_text_code(var, c)  
 true 
 end)) or (@yy_input.pos = yy_var1e; begin
      yy_var1i = yy_nonterm1v()
      if yy_var1i then
        val = yy_from_pcv(yy_var1i)
      end
      yy_var1i
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1v 
val = :yy_nil 
begin; yy_var1k = @yy_input.pos; (begin
      yy_var1l = yy_nontermd3()
      if yy_var1l then
        r = yy_from_pcv(yy_var1l)
      end
      yy_var1l
    end and begin 
  val = code "yy_char_range(#{r.begin.dump}, #{r.end.dump})"  
 true 
 end) or (@yy_input.pos = yy_var1k; (begin
      yy_var1m = yy_nontermet()
      if yy_var1m then
        s = yy_from_pcv(yy_var1m)
      end
      yy_var1m
    end and begin 
  val = code "yy_string(#{s.dump})"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (begin
      yy_var1n = yy_nontermct()
      if yy_var1n then
        n = yy_from_pcv(yy_var1n)
      end
      yy_var1n
    end and begin 
  val = UnknownMethodCall[n]  
 true 
 end)) or (@yy_input.pos = yy_var1k; (yy_nonterma5() and begin 
  val = code "@yy_input.getc"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (begin
      yy_var1o = yy_nonterm8l()
      if yy_var1o then
        a = yy_from_pcv(yy_var1o)
      end
      yy_var1o
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (yy_nonterm93() and begin 
  val = code "@yy_input.eof?"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (yy_nonterm95() and begin 
  val = code "(@yy_input.pos == 0)"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (begin; yy_var1s = @yy_input.pos; (yy_nonterm9x() and yy_nonterm9z() and begin
      yy_var1t = yy_nontermax()
      if yy_var1t then
        pos_variable = yy_from_pcv(yy_var1t)
      end
      yy_var1t
    end) or (@yy_input.pos = yy_var1s; (yy_nontermab() and begin
      yy_var1u = yy_nontermax()
      if yy_var1u then
        pos_variable = yy_from_pcv(yy_var1u)
      end
      yy_var1u
    end)); end and begin 
  val = code "(@yy_input.pos = #{pos_variable}; true)"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (yy_nonterm9x() and begin 
  val = code "@yy_input.pos"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm23 
val = :yy_nil 
(begin
      yy_var1x = yy_nontermct()
      if yy_var1x then
        n = yy_from_pcv(yy_var1x)
      end
      yy_var1x
    end and begin
      yy_var21 = @yy_input.pos
      if not (yy_nonterm9f() and yy_nonterm2t()) then
        @yy_input.pos = yy_var21
      end
      true
    end and yy_nonterm8x() and begin
      yy_var22 = yy_nontermc()
      if yy_var22 then
        c = yy_from_pcv(yy_var22)
      end
      yy_var22
    end and yy_nonterm8z() and begin 
 
    method_name = new_unique_nonterminal_method_name
    val = [n, method_name, to_method_definition(c, method_name)]
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm2t 
val = :yy_nil 
((not begin
      yy_var2q = @yy_input.pos
      yy_var2r = yy_nonterm8x()
      @yy_input.pos = yy_var2q
      yy_var2r
    end and @yy_input.getc) and yy_nontermff()) and while true
      yy_var2s = @yy_input.pos
      if not ((not begin
      yy_var2q = @yy_input.pos
      yy_var2r = yy_nonterm8x()
      @yy_input.pos = yy_var2q
      yy_var2r
    end and @yy_input.getc) and yy_nontermff()) then
        @yy_input.pos = yy_var2s
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm2x 
val = :yy_nil 
begin; yy_var2u = @yy_input.pos; begin
      yy_var2v = yy_nontermax()
      if yy_var2v then
        val = yy_from_pcv(yy_var2v)
      end
      yy_var2v
    end or (@yy_input.pos = yy_var2u; (yy_nonterm97() and begin
      yy_var2w = yy_nontermax()
      if yy_var2w then
        val = yy_from_pcv(yy_var2w)
      end
      yy_var2w
    end and yy_nonterm99())); end and yy_to_pcv(val) 
end 
def yy_nonterm35 
val = :yy_nil 
(yy_string("%%") and  begin
      while true
        ###
        yy_var31 = @yy_input.pos
        ### Look ahead.
        yy_var32 = begin; yy_var34 = @yy_input.pos; yy_nontermft() or (@yy_input.pos = yy_var34; @yy_input.eof?); end
        @yy_input.pos = yy_var31
        break if yy_var32
        ### Repeat one more time (if possible).
        yy_var32 = @yy_input.getc
        if not yy_var32 then
          @yy_input.pos = yy_var31
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_var34 = @yy_input.pos; yy_nontermft() or (@yy_input.pos = yy_var34; @yy_input.eof?); end) and yy_to_pcv(val) 
end 
def yy_nonterm8l 
val = :yy_nil 
(begin; yy_var5w = @yy_input.pos; (yy_string("{") and while true
      yy_var5y = @yy_input.pos
      if not yy_nontermfr() then
        @yy_input.pos = yy_var5y
        break true
      end
    end and yy_string("...") and begin
      yy_var6a = @yy_input.pos
      if not ( begin
      while true
        ###
        yy_var68 = @yy_input.pos
        ### Look ahead.
        yy_var69 = yy_nontermft()
        @yy_input.pos = yy_var68
        break if yy_var69
        ### Repeat one more time (if possible).
        yy_var69 = yy_nontermfr()
        if not yy_var69 then
          @yy_input.pos = yy_var68
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nontermft()) then
        @yy_input.pos = yy_var6a
      end
      true
    end and begin
      val = ""
      yy_var6n = @yy_input.pos
       begin
      while true
        ###
        yy_var6l = @yy_input.pos
        ### Look ahead.
        yy_var6m = begin; yy_var6u = @yy_input.pos; (yy_string("...") and while true
      yy_var6w = @yy_input.pos
      if not yy_nontermfr() then
        @yy_input.pos = yy_var6w
        break true
      end
    end and yy_string("}")) or (@yy_input.pos = yy_var6u; (yy_string("}") and while true
      yy_var6y = @yy_input.pos
      if not yy_nontermfr() then
        @yy_input.pos = yy_var6y
        break true
      end
    end and yy_string("..."))); end
        @yy_input.pos = yy_var6l
        break if yy_var6m
        ### Repeat one more time (if possible).
        yy_var6m = @yy_input.getc
        if not yy_var6m then
          @yy_input.pos = yy_var6l
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var6o = @yy_input.pos
        @yy_input.pos = yy_var6n
        val << @yy_input.read(yy_var6o - yy_var6n).force_encoding(Encoding::UTF_8)
      end
    end and begin; yy_var6u = @yy_input.pos; (yy_string("...") and while true
      yy_var6w = @yy_input.pos
      if not yy_nontermfr() then
        @yy_input.pos = yy_var6w
        break true
      end
    end and yy_string("}")) or (@yy_input.pos = yy_var6u; (yy_string("}") and while true
      yy_var6y = @yy_input.pos
      if not yy_nontermfr() then
        @yy_input.pos = yy_var6y
        break true
      end
    end and yy_string("..."))); end) or (@yy_input.pos = yy_var5w; (begin
      val = ""
      yy_var73 = @yy_input.pos
      yy_nonterm8t() and begin
        yy_var74 = @yy_input.pos
        @yy_input.pos = yy_var73
        val << @yy_input.read(yy_var74 - yy_var73).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = val[1...-1]  
 true 
 end)) or (@yy_input.pos = yy_var5w; (yy_nonterm35() and begin
      val = ""
      yy_var7x = @yy_input.pos
       begin
      while true
        ###
        yy_var7v = @yy_input.pos
        ### Look ahead.
        yy_var7w = yy_nonterm35()
        @yy_input.pos = yy_var7v
        break if yy_var7w
        ### Repeat one more time (if possible).
        yy_var7w = @yy_input.getc
        if not yy_var7w then
          @yy_input.pos = yy_var7v
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var7y = @yy_input.pos
        @yy_input.pos = yy_var7x
        val << @yy_input.read(yy_var7y - yy_var7x).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm35())) or (@yy_input.pos = yy_var5w; (yy_nonterm35() and begin
      val = ""
      yy_var8j = @yy_input.pos
      while true
      yy_var8i = @yy_input.pos
      if not @yy_input.getc then
        @yy_input.pos = yy_var8i
        break true
      end
    end and begin
        yy_var8k = @yy_input.pos
        @yy_input.pos = yy_var8j
        val << @yy_input.read(yy_var8k - yy_var8j).force_encoding(Encoding::UTF_8)
      end
    end and @yy_input.eof?)); end and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm8t 
val = :yy_nil 
(yy_string("{") and  begin
      while true
        ###
        yy_var8r = @yy_input.pos
        ### Look ahead.
        yy_var8s = yy_string("}")
        @yy_input.pos = yy_var8r
        break if yy_var8s
        ### Repeat one more time (if possible).
        yy_var8s = begin; yy_var8q = @yy_input.pos; yy_nonterm8t() or (@yy_input.pos = yy_var8q; @yy_input.getc); end
        if not yy_var8s then
          @yy_input.pos = yy_var8r
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string("}")) and yy_to_pcv(val) 
end 
def yy_nonterm8x 
val = :yy_nil 
(begin; yy_var8w = @yy_input.pos; yy_string("<-") or (@yy_input.pos = yy_var8w; yy_string("=")) or (@yy_input.pos = yy_var8w; yy_string("\u{2190}")); end and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm8z 
val = :yy_nil 
(yy_string(";") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm91 
val = :yy_nil 
(yy_string("/") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm93 
val = :yy_nil 
(yy_string("$") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm95 
val = :yy_nil 
(yy_string("^") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm97 
val = :yy_nil 
(yy_string("(") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm99 
val = :yy_nil 
(yy_string(")") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm9b 
val = :yy_nil 
(yy_string("[") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm9d 
val = :yy_nil 
(yy_string("]") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm9f 
val = :yy_nil 
(yy_string(":") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm9h 
val = :yy_nil 
(yy_string("<") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm9j 
val = :yy_nil 
(yy_string(">") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm9l 
val = :yy_nil 
(yy_string("*") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm9n 
val = :yy_nil 
(yy_string("*?") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm9p 
val = :yy_nil 
(yy_string("?") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm9r 
val = :yy_nil 
(yy_string("+") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm9t 
val = :yy_nil 
(yy_string("&") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm9v 
val = :yy_nil 
(yy_string("!") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm9x 
val = :yy_nil 
(yy_string("@") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm9z 
val = :yy_nil 
(yy_string("=") and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterma5 
val = :yy_nil 
(yy_string("char") and not begin
      yy_vara3 = @yy_input.pos
      yy_vara4 = yy_nontermcx()
      @yy_input.pos = yy_vara3
      yy_vara4
    end and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nontermab 
val = :yy_nil 
(yy_string("at") and not begin
      yy_vara9 = @yy_input.pos
      yy_varaa = yy_nontermcx()
      @yy_input.pos = yy_vara9
      yy_varaa
    end and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nontermad 
val = :yy_nil 
begin; yy_varac = @yy_input.pos; yy_nonterma5() or (@yy_input.pos = yy_varac; yy_nontermab()); end and yy_to_pcv(val) 
end 
def yy_nontermax 
val = :yy_nil 
(begin
      val = ""
      yy_varav = @yy_input.pos
      (begin
      yy_varaq = @yy_input.pos
      if not yy_string("@") then
        @yy_input.pos = yy_varaq
      end
      true
    end and yy_nontermaz() and while true
      yy_varau = @yy_input.pos
      if not yy_nontermb1() then
        @yy_input.pos = yy_varau
        break true
      end
    end) and begin
        yy_varaw = @yy_input.pos
        @yy_input.pos = yy_varav
        val << @yy_input.read(yy_varaw - yy_varav).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nontermaz 
val = :yy_nil 
begin; yy_varay = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varay; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermb1 
val = :yy_nil 
begin; yy_varb0 = @yy_input.pos; yy_nontermaz() or (@yy_input.pos = yy_varb0; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermct 
val = :yy_nil 
(not begin
      yy_varb5 = @yy_input.pos
      yy_varb6 = yy_nontermad()
      @yy_input.pos = yy_varb5
      yy_varb6
    end and begin; yy_varc0 = @yy_input.pos; (begin
      val = ""
      yy_varcd = @yy_input.pos
      (yy_nontermcv() and while true
      yy_varcc = @yy_input.pos
      if not yy_nontermcx() then
        @yy_input.pos = yy_varcc
        break true
      end
    end) and begin
        yy_varce = @yy_input.pos
        @yy_input.pos = yy_varcd
        val << @yy_input.read(yy_varce - yy_varcd).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermff()) or (@yy_input.pos = yy_varc0; (begin
      val = ""
      yy_varcr = @yy_input.pos
      (yy_string("`") and  begin
      while true
        ###
        yy_varcp = @yy_input.pos
        ### Look ahead.
        yy_varcq = yy_string("`")
        @yy_input.pos = yy_varcp
        break if yy_varcq
        ### Repeat one more time (if possible).
        yy_varcq = @yy_input.getc
        if not yy_varcq then
          @yy_input.pos = yy_varcp
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string("`")) and begin
        yy_varcs = @yy_input.pos
        @yy_input.pos = yy_varcr
        val << @yy_input.read(yy_varcs - yy_varcr).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermff())); end) and yy_to_pcv(val) 
end 
def yy_nontermcv 
val = :yy_nil 
begin; yy_varcu = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varcu; yy_char_range("A", "Z")) or (@yy_input.pos = yy_varcu; yy_string("-")) or (@yy_input.pos = yy_varcu; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermcx 
val = :yy_nil 
begin; yy_varcw = @yy_input.pos; yy_nontermcv() or (@yy_input.pos = yy_varcw; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermd3 
val = :yy_nil 
(begin
      yy_varcz = yy_nontermet()
      if yy_varcz then
        from = yy_from_pcv(yy_varcz)
      end
      yy_varcz
    end and begin; yy_vard1 = @yy_input.pos; yy_string("...") or (@yy_input.pos = yy_vard1; yy_string("..")) or (@yy_input.pos = yy_vard1; yy_string("\u{2026}")) or (@yy_input.pos = yy_vard1; yy_string("\u{2025}")); end and yy_nontermff() and begin
      yy_vard2 = yy_nontermet()
      if yy_vard2 then
        to = yy_from_pcv(yy_vard2)
      end
      yy_vard2
    end and yy_nontermff() and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermet 
val = :yy_nil 
(begin; yy_vardz = @yy_input.pos; (yy_string("'") and begin
      val = ""
      yy_varec = @yy_input.pos
       begin
      while true
        ###
        yy_varea = @yy_input.pos
        ### Look ahead.
        yy_vareb = yy_string("'")
        @yy_input.pos = yy_varea
        break if yy_vareb
        ### Repeat one more time (if possible).
        yy_vareb = @yy_input.getc
        if not yy_vareb then
          @yy_input.pos = yy_varea
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_vared = @yy_input.pos
        @yy_input.pos = yy_varec
        val << @yy_input.read(yy_vared - yy_varec).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("'")) or (@yy_input.pos = yy_vardz; (yy_string("\"") and begin
      val = ""
      yy_vareq = @yy_input.pos
       begin
      while true
        ###
        yy_vareo = @yy_input.pos
        ### Look ahead.
        yy_varep = yy_string("\"")
        @yy_input.pos = yy_vareo
        break if yy_varep
        ### Repeat one more time (if possible).
        yy_varep = @yy_input.getc
        if not yy_varep then
          @yy_input.pos = yy_vareo
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varer = @yy_input.pos
        @yy_input.pos = yy_vareq
        val << @yy_input.read(yy_varer - yy_vareq).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("\""))) or (@yy_input.pos = yy_vardz; (begin
      yy_vares = yy_nontermf9()
      if yy_vares then
        code = yy_from_pcv(yy_vares)
      end
      yy_vares
    end and begin 
  val = "" << code  
 true 
 end)); end and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nontermf9 
val = :yy_nil 
(yy_string("U+") and begin
      code = ""
      yy_varf7 = @yy_input.pos
      begin; yy_varf5 = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_varf5; yy_char_range("A", "F")); end and while true
      yy_varf6 = @yy_input.pos
      if not begin; yy_varf5 = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_varf5; yy_char_range("A", "F")); end then
        @yy_input.pos = yy_varf6
        break true
      end
    end and begin
        yy_varf8 = @yy_input.pos
        @yy_input.pos = yy_varf7
        code << @yy_input.read(yy_varf8 - yy_varf7).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermff 
val = :yy_nil 
while true
      yy_varfe = @yy_input.pos
      if not begin; yy_varfd = @yy_input.pos; yy_nontermfr() or (@yy_input.pos = yy_varfd; yy_nontermfp()); end then
        @yy_input.pos = yy_varfe
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nontermfp 
val = :yy_nil 
(begin; yy_varfi = @yy_input.pos; yy_string("#") or (@yy_input.pos = yy_varfi; yy_string("--")); end and  begin
      while true
        ###
        yy_varfl = @yy_input.pos
        ### Look ahead.
        yy_varfm = begin; yy_varfo = @yy_input.pos; yy_nontermft() or (@yy_input.pos = yy_varfo; @yy_input.eof?); end
        @yy_input.pos = yy_varfl
        break if yy_varfm
        ### Repeat one more time (if possible).
        yy_varfm = @yy_input.getc
        if not yy_varfm then
          @yy_input.pos = yy_varfl
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_varfo = @yy_input.pos; yy_nontermft() or (@yy_input.pos = yy_varfo; @yy_input.eof?); end) and yy_to_pcv(val) 
end 
def yy_nontermfr 
val = :yy_nil 
begin; yy_varfq = @yy_input.pos; yy_char_range("\t", "\r") or (@yy_input.pos = yy_varfq; yy_string(" ")) or (@yy_input.pos = yy_varfq; yy_string("\u{85}")) or (@yy_input.pos = yy_varfq; yy_string("\u{a0}")) or (@yy_input.pos = yy_varfq; yy_string("\u{1680}")) or (@yy_input.pos = yy_varfq; yy_string("\u{180e}")) or (@yy_input.pos = yy_varfq; yy_char_range("\u{2000}", "\u{200a}")) or (@yy_input.pos = yy_varfq; yy_string("\u{2028}")) or (@yy_input.pos = yy_varfq; yy_string("\u{2029}")) or (@yy_input.pos = yy_varfq; yy_string("\u{202f}")) or (@yy_input.pos = yy_varfq; yy_string("\u{205f}")) or (@yy_input.pos = yy_varfq; yy_string("\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nontermft 
val = :yy_nil 
begin; yy_varfs = @yy_input.pos; (yy_string("\r") and yy_string("\n")) or (@yy_input.pos = yy_varfs; yy_string("\r")) or (@yy_input.pos = yy_varfs; yy_string("\n")) or (@yy_input.pos = yy_varfs; yy_string("\u{85}")) or (@yy_input.pos = yy_varfs; yy_string("\v")) or (@yy_input.pos = yy_varfs; yy_string("\f")) or (@yy_input.pos = yy_varfs; yy_string("\u{2028}")) or (@yy_input.pos = yy_varfs; yy_string("\u{2029}")); end and yy_to_pcv(val) 
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
