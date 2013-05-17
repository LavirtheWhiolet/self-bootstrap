#!/usr/bin/ruby
# encoding: UTF-8

# This file is both runnable and "require"-able.


# 
class PEGParserGenerator
  
  def call(input)
    # Initialize.
    @next_unique_number = 0
    # Parse grammar and generate the parser.
    yy_parse(input)
  end
  
  private
  
  HashMap = Hash
  

      
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
 end and yy_nontermf3() and while true
      yy_var8 = @yy_input.pos
      if not begin; yy_var5 = @yy_input.pos; (begin
      yy_var6 = yy_nonterm1x()
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
      yy_var7 = yy_nonterm7t()
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
      if not yy_nonterm89() then
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
      if not (yy_nonterm89() and begin
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
 end) or (@yy_input.pos = yy_vars; (yy_nonterm8j() and begin 
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
 end) or (@yy_input.pos = yy_vars; (yy_nonterm8j() and begin 
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
    end and yy_nonterm8l() and begin
      yy_vary = yy_nonterm9p()
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
begin; yy_var11 = @yy_input.pos; (yy_nonterm8z() and begin
      yy_var12 = yy_nonterm7t()
      if yy_var12 then
        c = yy_from_pcv(yy_var12)
      end
      yy_var12
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (@yy_input.pos = yy_var11; (yy_nonterm8z() and begin
      yy_var13 = yy_nonterm16()
      if yy_var13 then
        val = yy_from_pcv(yy_var13)
      end
      yy_var13
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var11; (yy_nonterm91() and begin
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
      if not begin; yy_var1b = @yy_input.pos; (yy_nonterm8t() and begin 
  val = lazy_repeat_code(val)  
 true 
 end) or (@yy_input.pos = yy_var1b; (yy_nonterm8r() and begin 
  val = repeat_many_times_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1b; (yy_nonterm8x() and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1b; (yy_nonterm8v() and begin 
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
begin; yy_var1e = @yy_input.pos; (yy_nonterm8d() and begin
      yy_var1f = yy_nontermc()
      if yy_var1f then
        val = yy_from_pcv(yy_var1f)
      end
      yy_var1f
    end and yy_nonterm8f()) or (@yy_input.pos = yy_var1e; (yy_nonterm8n() and begin
      yy_var1g = yy_nontermc()
      if yy_var1g then
        c = yy_from_pcv(yy_var1g)
      end
      yy_var1g
    end and yy_nonterm8p() and yy_nonterm8l() and begin
      yy_var1h = yy_nonterm9p()
      if yy_var1h then
        var = yy_from_pcv(yy_var1h)
      end
      yy_var1h
    end and begin 
  val = capture_text_code(var, c)  
 true 
 end)) or (@yy_input.pos = yy_var1e; begin
      yy_var1i = yy_nonterm1p()
      if yy_var1i then
        val = yy_from_pcv(yy_var1i)
      end
      yy_var1i
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1p 
val = :yy_nil 
begin; yy_var1k = @yy_input.pos; (begin
      yy_var1l = yy_nontermcr()
      if yy_var1l then
        r = yy_from_pcv(yy_var1l)
      end
      yy_var1l
    end and begin 
  val = code "yy_char_range(#{r.begin.dump}, #{r.end.dump})"  
 true 
 end) or (@yy_input.pos = yy_var1k; (begin
      yy_var1m = yy_nontermeh()
      if yy_var1m then
        s = yy_from_pcv(yy_var1m)
      end
      yy_var1m
    end and begin 
  val = code "yy_string(#{s.dump})"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (begin
      yy_var1n = yy_nontermch()
      if yy_var1n then
        n = yy_from_pcv(yy_var1n)
      end
      yy_var1n
    end and begin 
  val = UnknownMethodCall[n]  
 true 
 end)) or (@yy_input.pos = yy_var1k; (yy_nonterm97() and begin 
  val = code "@yy_input.getc"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (begin
      yy_var1o = yy_nonterm7t()
      if yy_var1o then
        a = yy_from_pcv(yy_var1o)
      end
      yy_var1o
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (yy_nonterm8b() and begin 
  val = code "@yy_input.eof?"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm1x 
val = :yy_nil 
(begin
      yy_var1r = yy_nontermch()
      if yy_var1r then
        n = yy_from_pcv(yy_var1r)
      end
      yy_var1r
    end and begin
      yy_var1v = @yy_input.pos
      if not (yy_nonterm8l() and yy_nonterm2n()) then
        @yy_input.pos = yy_var1v
      end
      true
    end and yy_nonterm85() and begin
      yy_var1w = yy_nontermc()
      if yy_var1w then
        c = yy_from_pcv(yy_var1w)
      end
      yy_var1w
    end and yy_nonterm87() and begin 
 
    method_name = new_unique_nonterminal_method_name
    val = [n, method_name, to_method_definition(c, method_name)]
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm2n 
val = :yy_nil 
((not begin
      yy_var2k = @yy_input.pos
      yy_var2l = yy_nonterm85()
      @yy_input.pos = yy_var2k
      yy_var2l
    end and @yy_input.getc) and yy_nontermf3()) and while true
      yy_var2m = @yy_input.pos
      if not ((not begin
      yy_var2k = @yy_input.pos
      yy_var2l = yy_nonterm85()
      @yy_input.pos = yy_var2k
      yy_var2l
    end and @yy_input.getc) and yy_nontermf3()) then
        @yy_input.pos = yy_var2m
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm2t 
val = :yy_nil 
(yy_string("%%") and  begin
      while true
        ###
        yy_var2r = @yy_input.pos
        ### Look ahead.
        yy_var2s = yy_nontermff()
        @yy_input.pos = yy_var2r
        break if yy_var2s
        ### Repeat one more time (if possible).
        yy_var2s = @yy_input.getc
        if not yy_var2s then
          @yy_input.pos = yy_var2r
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nonterm7t 
val = :yy_nil 
(begin; yy_var5c = @yy_input.pos; (yy_string("{") and while true
      yy_var5e = @yy_input.pos
      if not yy_nontermfd() then
        @yy_input.pos = yy_var5e
        break true
      end
    end and yy_string("...") and begin
      yy_var5q = @yy_input.pos
      if not ( begin
      while true
        ###
        yy_var5o = @yy_input.pos
        ### Look ahead.
        yy_var5p = yy_nontermff()
        @yy_input.pos = yy_var5o
        break if yy_var5p
        ### Repeat one more time (if possible).
        yy_var5p = yy_nontermfd()
        if not yy_var5p then
          @yy_input.pos = yy_var5o
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nontermff()) then
        @yy_input.pos = yy_var5q
      end
      true
    end and begin
      val = ""
      yy_var63 = @yy_input.pos
       begin
      while true
        ###
        yy_var61 = @yy_input.pos
        ### Look ahead.
        yy_var62 = (yy_string("...") and while true
      yy_var66 = @yy_input.pos
      if not yy_nontermfd() then
        @yy_input.pos = yy_var66
        break true
      end
    end and yy_string("}"))
        @yy_input.pos = yy_var61
        break if yy_var62
        ### Repeat one more time (if possible).
        yy_var62 = @yy_input.getc
        if not yy_var62 then
          @yy_input.pos = yy_var61
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var64 = @yy_input.pos
        @yy_input.pos = yy_var63
        val << @yy_input.read(yy_var64 - yy_var63).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("...") and while true
      yy_var66 = @yy_input.pos
      if not yy_nontermfd() then
        @yy_input.pos = yy_var66
        break true
      end
    end and yy_string("}")) or (@yy_input.pos = yy_var5c; (begin
      val = ""
      yy_var6b = @yy_input.pos
      yy_nonterm81() and begin
        yy_var6c = @yy_input.pos
        @yy_input.pos = yy_var6b
        val << @yy_input.read(yy_var6c - yy_var6b).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = val[1...-1]  
 true 
 end)) or (@yy_input.pos = yy_var5c; (yy_nonterm2t() and begin
      val = ""
      yy_var75 = @yy_input.pos
       begin
      while true
        ###
        yy_var73 = @yy_input.pos
        ### Look ahead.
        yy_var74 = yy_nonterm2t()
        @yy_input.pos = yy_var73
        break if yy_var74
        ### Repeat one more time (if possible).
        yy_var74 = @yy_input.getc
        if not yy_var74 then
          @yy_input.pos = yy_var73
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var76 = @yy_input.pos
        @yy_input.pos = yy_var75
        val << @yy_input.read(yy_var76 - yy_var75).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm2t())) or (@yy_input.pos = yy_var5c; (yy_nonterm2t() and begin
      val = ""
      yy_var7r = @yy_input.pos
      while true
      yy_var7q = @yy_input.pos
      if not @yy_input.getc then
        @yy_input.pos = yy_var7q
        break true
      end
    end and begin
        yy_var7s = @yy_input.pos
        @yy_input.pos = yy_var7r
        val << @yy_input.read(yy_var7s - yy_var7r).force_encoding(Encoding::UTF_8)
      end
    end and @yy_input.eof?)); end and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm81 
val = :yy_nil 
(yy_string("{") and  begin
      while true
        ###
        yy_var7z = @yy_input.pos
        ### Look ahead.
        yy_var80 = yy_string("}")
        @yy_input.pos = yy_var7z
        break if yy_var80
        ### Repeat one more time (if possible).
        yy_var80 = begin; yy_var7y = @yy_input.pos; yy_nonterm81() or (@yy_input.pos = yy_var7y; @yy_input.getc); end
        if not yy_var80 then
          @yy_input.pos = yy_var7z
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string("}")) and yy_to_pcv(val) 
end 
def yy_nonterm85 
val = :yy_nil 
(begin; yy_var84 = @yy_input.pos; yy_string("<-") or (@yy_input.pos = yy_var84; yy_string("=")) or (@yy_input.pos = yy_var84; yy_string("\u{2190}")); end and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm87 
val = :yy_nil 
(yy_string(";") and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm89 
val = :yy_nil 
(yy_string("/") and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm8b 
val = :yy_nil 
(yy_string("$") and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm8d 
val = :yy_nil 
(yy_string("(") and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm8f 
val = :yy_nil 
(yy_string(")") and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm8h 
val = :yy_nil 
(yy_string("[") and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm8j 
val = :yy_nil 
(yy_string("]") and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm8l 
val = :yy_nil 
(yy_string(":") and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm8n 
val = :yy_nil 
(yy_string("<") and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm8p 
val = :yy_nil 
(yy_string(">") and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm8r 
val = :yy_nil 
(yy_string("*") and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm8t 
val = :yy_nil 
(yy_string("*?") and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm8v 
val = :yy_nil 
(yy_string("?") and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm8x 
val = :yy_nil 
(yy_string("+") and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm8z 
val = :yy_nil 
(yy_string("&") and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm91 
val = :yy_nil 
(yy_string("!") and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm97 
val = :yy_nil 
(yy_string("char") and not begin
      yy_var95 = @yy_input.pos
      yy_var96 = yy_nontermcl()
      @yy_input.pos = yy_var95
      yy_var96
    end and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm99 
val = :yy_nil 
yy_nonterm97() and yy_to_pcv(val) 
end 
def yy_nonterm9p 
val = :yy_nil 
(begin
      val = ""
      yy_var9n = @yy_input.pos
      (yy_nonterm9r() and while true
      yy_var9m = @yy_input.pos
      if not yy_nonterm9t() then
        @yy_input.pos = yy_var9m
        break true
      end
    end) and begin
        yy_var9o = @yy_input.pos
        @yy_input.pos = yy_var9n
        val << @yy_input.read(yy_var9o - yy_var9n).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nonterm9r 
val = :yy_nil 
begin; yy_var9q = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_var9q; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nonterm9t 
val = :yy_nil 
begin; yy_var9s = @yy_input.pos; yy_nonterm9r() or (@yy_input.pos = yy_var9s; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermch 
val = :yy_nil 
(not begin
      yy_var9x = @yy_input.pos
      yy_var9y = yy_nonterm99()
      @yy_input.pos = yy_var9x
      yy_var9y
    end and begin; yy_varb8 = @yy_input.pos; (begin
      val = ""
      yy_varbl = @yy_input.pos
      (yy_nontermcj() and while true
      yy_varbk = @yy_input.pos
      if not yy_nontermcl() then
        @yy_input.pos = yy_varbk
        break true
      end
    end) and begin
        yy_varbm = @yy_input.pos
        @yy_input.pos = yy_varbl
        val << @yy_input.read(yy_varbm - yy_varbl).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermf3()) or (@yy_input.pos = yy_varb8; (begin
      val = ""
      yy_varcf = @yy_input.pos
      (yy_string("`") and while true
      yy_varce = @yy_input.pos
      if not (not begin
      yy_varcc = @yy_input.pos
      yy_varcd = yy_string("`")
      @yy_input.pos = yy_varcc
      yy_varcd
    end and @yy_input.getc) then
        @yy_input.pos = yy_varce
        break true
      end
    end and yy_string("`")) and begin
        yy_varcg = @yy_input.pos
        @yy_input.pos = yy_varcf
        val << @yy_input.read(yy_varcg - yy_varcf).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermf3())); end) and yy_to_pcv(val) 
end 
def yy_nontermcj 
val = :yy_nil 
begin; yy_varci = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varci; yy_char_range("A", "Z")) or (@yy_input.pos = yy_varci; yy_string("-")) or (@yy_input.pos = yy_varci; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermcl 
val = :yy_nil 
begin; yy_varck = @yy_input.pos; yy_nontermcj() or (@yy_input.pos = yy_varck; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermcr 
val = :yy_nil 
(begin
      yy_varcn = yy_nontermeh()
      if yy_varcn then
        from = yy_from_pcv(yy_varcn)
      end
      yy_varcn
    end and begin; yy_varcp = @yy_input.pos; yy_string("...") or (@yy_input.pos = yy_varcp; yy_string("..")) or (@yy_input.pos = yy_varcp; yy_string("\u{2026}")) or (@yy_input.pos = yy_varcp; yy_string("\u{2025}")); end and yy_nontermf3() and begin
      yy_varcq = yy_nontermeh()
      if yy_varcq then
        to = yy_from_pcv(yy_varcq)
      end
      yy_varcq
    end and yy_nontermf3() and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermeh 
val = :yy_nil 
(begin; yy_vardn = @yy_input.pos; (yy_string("'") and begin
      val = ""
      yy_vare0 = @yy_input.pos
       begin
      while true
        ###
        yy_vardy = @yy_input.pos
        ### Look ahead.
        yy_vardz = yy_string("'")
        @yy_input.pos = yy_vardy
        break if yy_vardz
        ### Repeat one more time (if possible).
        yy_vardz = @yy_input.getc
        if not yy_vardz then
          @yy_input.pos = yy_vardy
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_vare1 = @yy_input.pos
        @yy_input.pos = yy_vare0
        val << @yy_input.read(yy_vare1 - yy_vare0).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("'")) or (@yy_input.pos = yy_vardn; (yy_string("\"") and begin
      val = ""
      yy_varee = @yy_input.pos
       begin
      while true
        ###
        yy_varec = @yy_input.pos
        ### Look ahead.
        yy_vared = yy_string("\"")
        @yy_input.pos = yy_varec
        break if yy_vared
        ### Repeat one more time (if possible).
        yy_vared = @yy_input.getc
        if not yy_vared then
          @yy_input.pos = yy_varec
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varef = @yy_input.pos
        @yy_input.pos = yy_varee
        val << @yy_input.read(yy_varef - yy_varee).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("\""))) or (@yy_input.pos = yy_vardn; (begin
      yy_vareg = yy_nontermex()
      if yy_vareg then
        code = yy_from_pcv(yy_vareg)
      end
      yy_vareg
    end and begin 
  val = "" << code  
 true 
 end)); end and yy_nontermf3()) and yy_to_pcv(val) 
end 
def yy_nontermex 
val = :yy_nil 
(yy_string("U+") and begin
      code = ""
      yy_varev = @yy_input.pos
      begin; yy_varet = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_varet; yy_char_range("A", "F")); end and while true
      yy_vareu = @yy_input.pos
      if not begin; yy_varet = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_varet; yy_char_range("A", "F")); end then
        @yy_input.pos = yy_vareu
        break true
      end
    end and begin
        yy_varew = @yy_input.pos
        @yy_input.pos = yy_varev
        code << @yy_input.read(yy_varew - yy_varev).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermf3 
val = :yy_nil 
while true
      yy_varf2 = @yy_input.pos
      if not begin; yy_varf1 = @yy_input.pos; yy_nontermfd() or (@yy_input.pos = yy_varf1; yy_nontermfb()); end then
        @yy_input.pos = yy_varf2
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nontermfb 
val = :yy_nil 
(begin; yy_varf6 = @yy_input.pos; yy_string("#") or (@yy_input.pos = yy_varf6; yy_string("--")); end and  begin
      while true
        ###
        yy_varf9 = @yy_input.pos
        ### Look ahead.
        yy_varfa = yy_nontermff()
        @yy_input.pos = yy_varf9
        break if yy_varfa
        ### Repeat one more time (if possible).
        yy_varfa = @yy_input.getc
        if not yy_varfa then
          @yy_input.pos = yy_varf9
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nontermff()) and yy_to_pcv(val) 
end 
def yy_nontermfd 
val = :yy_nil 
begin; yy_varfc = @yy_input.pos; yy_char_range("\t", "\r") or (@yy_input.pos = yy_varfc; yy_string(" ")) or (@yy_input.pos = yy_varfc; yy_string("\u{85}")) or (@yy_input.pos = yy_varfc; yy_string("\u{a0}")) or (@yy_input.pos = yy_varfc; yy_string("\u{1680}")) or (@yy_input.pos = yy_varfc; yy_string("\u{180e}")) or (@yy_input.pos = yy_varfc; yy_char_range("\u{2000}", "\u{200a}")) or (@yy_input.pos = yy_varfc; yy_string("\u{2028}")) or (@yy_input.pos = yy_varfc; yy_string("\u{2029}")) or (@yy_input.pos = yy_varfc; yy_string("\u{202f}")) or (@yy_input.pos = yy_varfc; yy_string("\u{205f}")) or (@yy_input.pos = yy_varfc; yy_string("\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nontermff 
val = :yy_nil 
begin; yy_varfe = @yy_input.pos; (yy_string("\r") and yy_string("\n")) or (@yy_input.pos = yy_varfe; yy_string("\r")) or (@yy_input.pos = yy_varfe; yy_string("\n")) or (@yy_input.pos = yy_varfe; yy_string("\u{85}")) or (@yy_input.pos = yy_varfe; yy_string("\v")) or (@yy_input.pos = yy_varfe; yy_string("\f")) or (@yy_input.pos = yy_varfe; yy_string("\u{2028}")) or (@yy_input.pos = yy_varfe; yy_string("\u{2029}")); end and yy_to_pcv(val) 
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
