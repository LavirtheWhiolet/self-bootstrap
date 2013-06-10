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
 end and yy_nontermfm() and while true
      yy_var8 = @yy_input.pos
      if not begin; yy_var5 = @yy_input.pos; (begin
      yy_var6 = yy_nonterm28()
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
      yy_var7 = yy_nonterm8q()
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
      if not yy_nonterm98() then
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
      if not (yy_nonterm98() and begin
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
 end) or (@yy_input.pos = yy_vars; (yy_nonterm9k() and begin 
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
 end) or (@yy_input.pos = yy_vars; (yy_nonterm9k() and begin 
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
    end and yy_nonterm9m() and begin
      yy_vary = yy_nonterm32()
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
begin; yy_var11 = @yy_input.pos; (yy_nonterma0() and begin
      yy_var12 = yy_nonterm8q()
      if yy_var12 then
        c = yy_from_pcv(yy_var12)
      end
      yy_var12
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (@yy_input.pos = yy_var11; (yy_nonterma0() and begin
      yy_var13 = yy_nonterm16()
      if yy_var13 then
        val = yy_from_pcv(yy_var13)
      end
      yy_var13
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var11; (yy_nonterma2() and begin
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
      if not begin; yy_var1b = @yy_input.pos; (yy_nonterm9u() and begin 
  val = lazy_repeat_code(val)  
 true 
 end) or (@yy_input.pos = yy_var1b; (yy_nonterm9s() and begin 
  val = repeat_many_times_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1b; (yy_nonterm9y() and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1b; (yy_nonterm9w() and begin 
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
begin; yy_var1e = @yy_input.pos; (yy_nonterm9e() and begin
      yy_var1f = yy_nontermc()
      if yy_var1f then
        val = yy_from_pcv(yy_var1f)
      end
      yy_var1f
    end and yy_nonterm9g()) or (@yy_input.pos = yy_var1e; (yy_nonterm9o() and begin
      yy_var1g = yy_nontermc()
      if yy_var1g then
        c = yy_from_pcv(yy_var1g)
      end
      yy_var1g
    end and yy_nonterm9q() and yy_nonterm9m() and begin
      yy_var1h = yy_nonterm32()
      if yy_var1h then
        var = yy_from_pcv(yy_var1h)
      end
      yy_var1h
    end and begin 
  val = capture_text_code(var, c)  
 true 
 end)) or (@yy_input.pos = yy_var1e; begin
      yy_var1i = yy_nonterm1q()
      if yy_var1i then
        val = yy_from_pcv(yy_var1i)
      end
      yy_var1i
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1q 
val = :yy_nil 
begin; yy_var1k = @yy_input.pos; (begin
      yy_var1l = yy_nontermda()
      if yy_var1l then
        r = yy_from_pcv(yy_var1l)
      end
      yy_var1l
    end and begin 
  val = code "yy_char_range(#{r.begin.dump}, #{r.end.dump})"  
 true 
 end) or (@yy_input.pos = yy_var1k; (begin
      yy_var1m = yy_nontermf0()
      if yy_var1m then
        s = yy_from_pcv(yy_var1m)
      end
      yy_var1m
    end and begin 
  val = code "yy_string(#{s.dump})"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (begin
      yy_var1n = yy_nontermd0()
      if yy_var1n then
        n = yy_from_pcv(yy_var1n)
      end
      yy_var1n
    end and begin 
  val = UnknownMethodCall[n]  
 true 
 end)) or (@yy_input.pos = yy_var1k; (yy_nontermac() and begin 
  val = code "@yy_input.getc"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (begin
      yy_var1o = yy_nonterm8q()
      if yy_var1o then
        a = yy_from_pcv(yy_var1o)
      end
      yy_var1o
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (yy_nonterm9a() and begin 
  val = code "@yy_input.eof?"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (yy_nonterm9c() and begin 
  val = code "(@yy_input.pos == 0)"  
 true 
 end)) or (@yy_input.pos = yy_var1k; begin
      yy_var1p = yy_nonterm20()
      if yy_var1p then
        val = yy_from_pcv(yy_var1p)
      end
      yy_var1p
    end) or (@yy_input.pos = yy_var1k; (yy_nonterma4() and begin 
  val = code "@yy_input.pos"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm20 
val = :yy_nil 
(begin; yy_var1v = @yy_input.pos; (yy_nonterma4() and yy_nonterma6() and begin
      yy_var1w = yy_nontermb4()
      if yy_var1w then
        pos_variable = yy_from_pcv(yy_var1w)
      end
      yy_var1w
    end) or (@yy_input.pos = yy_var1v; (yy_nontermai() and begin
      yy_var1x = yy_nontermb4()
      if yy_var1x then
        pos_variable = yy_from_pcv(yy_var1x)
      end
      yy_var1x
    end)); end and begin
      yy_var1z = @yy_input.pos
      if not yy_nonterm9m() then
        @yy_input.pos = yy_var1z
      end
      true
    end and begin 
  val = code "(@yy_input.pos = #{pos_variable}; true)"  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm28 
val = :yy_nil 
(begin
      yy_var22 = yy_nontermd0()
      if yy_var22 then
        n = yy_from_pcv(yy_var22)
      end
      yy_var22
    end and begin
      yy_var26 = @yy_input.pos
      if not (yy_nonterm9m() and yy_nonterm2y()) then
        @yy_input.pos = yy_var26
      end
      true
    end and yy_nonterm92() and begin
      yy_var27 = yy_nontermc()
      if yy_var27 then
        c = yy_from_pcv(yy_var27)
      end
      yy_var27
    end and yy_nonterm96() and begin 
 
    method_name = new_unique_nonterminal_method_name
    val = [n, method_name, to_method_definition(c, method_name)]
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm2y 
val = :yy_nil 
((not begin
      yy_var2v = @yy_input.pos
      yy_var2w = yy_nonterm92()
      @yy_input.pos = yy_var2v
      yy_var2w
    end and @yy_input.getc) and yy_nontermfm()) and while true
      yy_var2x = @yy_input.pos
      if not ((not begin
      yy_var2v = @yy_input.pos
      yy_var2w = yy_nonterm92()
      @yy_input.pos = yy_var2v
      yy_var2w
    end and @yy_input.getc) and yy_nontermfm()) then
        @yy_input.pos = yy_var2x
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm32 
val = :yy_nil 
begin; yy_var2z = @yy_input.pos; begin
      yy_var30 = yy_nontermb4()
      if yy_var30 then
        val = yy_from_pcv(yy_var30)
      end
      yy_var30
    end or (@yy_input.pos = yy_var2z; (yy_nonterm9e() and begin
      yy_var31 = yy_nontermb4()
      if yy_var31 then
        val = yy_from_pcv(yy_var31)
      end
      yy_var31
    end and yy_nonterm9g())); end and yy_to_pcv(val) 
end 
def yy_nonterm3a 
val = :yy_nil 
(yy_string("%%") and  begin
      while true
        ###
        yy_var36 = @yy_input.pos
        ### Look ahead.
        yy_var37 = begin; yy_var39 = @yy_input.pos; yy_nontermg0() or (@yy_input.pos = yy_var39; @yy_input.eof?); end
        @yy_input.pos = yy_var36
        break if yy_var37
        ### Repeat one more time (if possible).
        yy_var37 = @yy_input.getc
        if not yy_var37 then
          @yy_input.pos = yy_var36
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_var39 = @yy_input.pos; yy_nontermg0() or (@yy_input.pos = yy_var39; @yy_input.eof?); end) and yy_to_pcv(val) 
end 
def yy_nonterm8q 
val = :yy_nil 
(begin; yy_var61 = @yy_input.pos; (yy_string("{") and while true
      yy_var63 = @yy_input.pos
      if not yy_nontermfy() then
        @yy_input.pos = yy_var63
        break true
      end
    end and yy_string("...") and begin
      yy_var6f = @yy_input.pos
      if not ( begin
      while true
        ###
        yy_var6d = @yy_input.pos
        ### Look ahead.
        yy_var6e = yy_nontermg0()
        @yy_input.pos = yy_var6d
        break if yy_var6e
        ### Repeat one more time (if possible).
        yy_var6e = yy_nontermfy()
        if not yy_var6e then
          @yy_input.pos = yy_var6d
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nontermg0()) then
        @yy_input.pos = yy_var6f
      end
      true
    end and begin
      val = ""
      yy_var6s = @yy_input.pos
       begin
      while true
        ###
        yy_var6q = @yy_input.pos
        ### Look ahead.
        yy_var6r = begin; yy_var6z = @yy_input.pos; (yy_string("...") and while true
      yy_var71 = @yy_input.pos
      if not yy_nontermfy() then
        @yy_input.pos = yy_var71
        break true
      end
    end and yy_string("}")) or (@yy_input.pos = yy_var6z; (yy_string("}") and while true
      yy_var73 = @yy_input.pos
      if not yy_nontermfy() then
        @yy_input.pos = yy_var73
        break true
      end
    end and yy_string("..."))); end
        @yy_input.pos = yy_var6q
        break if yy_var6r
        ### Repeat one more time (if possible).
        yy_var6r = @yy_input.getc
        if not yy_var6r then
          @yy_input.pos = yy_var6q
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var6t = @yy_input.pos
        @yy_input.pos = yy_var6s
        val << @yy_input.read(yy_var6t - yy_var6s).force_encoding(Encoding::UTF_8)
      end
    end and begin; yy_var6z = @yy_input.pos; (yy_string("...") and while true
      yy_var71 = @yy_input.pos
      if not yy_nontermfy() then
        @yy_input.pos = yy_var71
        break true
      end
    end and yy_string("}")) or (@yy_input.pos = yy_var6z; (yy_string("}") and while true
      yy_var73 = @yy_input.pos
      if not yy_nontermfy() then
        @yy_input.pos = yy_var73
        break true
      end
    end and yy_string("..."))); end) or (@yy_input.pos = yy_var61; (begin
      val = ""
      yy_var78 = @yy_input.pos
      yy_nonterm8y() and begin
        yy_var79 = @yy_input.pos
        @yy_input.pos = yy_var78
        val << @yy_input.read(yy_var79 - yy_var78).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = val[1...-1]  
 true 
 end)) or (@yy_input.pos = yy_var61; (yy_nonterm3a() and begin
      val = ""
      yy_var82 = @yy_input.pos
       begin
      while true
        ###
        yy_var80 = @yy_input.pos
        ### Look ahead.
        yy_var81 = yy_nonterm3a()
        @yy_input.pos = yy_var80
        break if yy_var81
        ### Repeat one more time (if possible).
        yy_var81 = @yy_input.getc
        if not yy_var81 then
          @yy_input.pos = yy_var80
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var83 = @yy_input.pos
        @yy_input.pos = yy_var82
        val << @yy_input.read(yy_var83 - yy_var82).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm3a())) or (@yy_input.pos = yy_var61; (yy_nonterm3a() and begin
      val = ""
      yy_var8o = @yy_input.pos
      while true
      yy_var8n = @yy_input.pos
      if not @yy_input.getc then
        @yy_input.pos = yy_var8n
        break true
      end
    end and begin
        yy_var8p = @yy_input.pos
        @yy_input.pos = yy_var8o
        val << @yy_input.read(yy_var8p - yy_var8o).force_encoding(Encoding::UTF_8)
      end
    end and @yy_input.eof?)); end and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm8y 
val = :yy_nil 
(yy_string("{") and  begin
      while true
        ###
        yy_var8w = @yy_input.pos
        ### Look ahead.
        yy_var8x = yy_string("}")
        @yy_input.pos = yy_var8w
        break if yy_var8x
        ### Repeat one more time (if possible).
        yy_var8x = begin; yy_var8v = @yy_input.pos; yy_nonterm8y() or (@yy_input.pos = yy_var8v; @yy_input.getc); end
        if not yy_var8x then
          @yy_input.pos = yy_var8w
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string("}")) and yy_to_pcv(val) 
end 
def yy_nonterm92 
val = :yy_nil 
(begin; yy_var91 = @yy_input.pos; yy_string("<-") or (@yy_input.pos = yy_var91; yy_string("=")) or (@yy_input.pos = yy_var91; yy_string("\u{2190}")); end and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm94 
val = :yy_nil 
(yy_string(":") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm96 
val = :yy_nil 
(yy_string(";") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm98 
val = :yy_nil 
(yy_string("/") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm9a 
val = :yy_nil 
(yy_string("$") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm9c 
val = :yy_nil 
(yy_string("^") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm9e 
val = :yy_nil 
(yy_string("(") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm9g 
val = :yy_nil 
(yy_string(")") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm9i 
val = :yy_nil 
(yy_string("[") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm9k 
val = :yy_nil 
(yy_string("]") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm9m 
val = :yy_nil 
(yy_string(":") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm9o 
val = :yy_nil 
(yy_string("<") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm9q 
val = :yy_nil 
(yy_string(">") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm9s 
val = :yy_nil 
(yy_string("*") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm9u 
val = :yy_nil 
(yy_string("*?") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm9w 
val = :yy_nil 
(yy_string("?") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterm9y 
val = :yy_nil 
(yy_string("+") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterma0 
val = :yy_nil 
(yy_string("&") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterma2 
val = :yy_nil 
(yy_string("!") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterma4 
val = :yy_nil 
(yy_string("@") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nonterma6 
val = :yy_nil 
(yy_string("=") and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nontermac 
val = :yy_nil 
(yy_string("char") and not begin
      yy_varaa = @yy_input.pos
      yy_varab = yy_nontermd4()
      @yy_input.pos = yy_varaa
      yy_varab
    end and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nontermai 
val = :yy_nil 
(yy_string("at") and not begin
      yy_varag = @yy_input.pos
      yy_varah = yy_nontermd4()
      @yy_input.pos = yy_varag
      yy_varah
    end and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nontermak 
val = :yy_nil 
begin; yy_varaj = @yy_input.pos; yy_nontermac() or (@yy_input.pos = yy_varaj; yy_nontermai()); end and yy_to_pcv(val) 
end 
def yy_nontermb4 
val = :yy_nil 
(begin
      val = ""
      yy_varb2 = @yy_input.pos
      (begin
      yy_varax = @yy_input.pos
      if not yy_string("@") then
        @yy_input.pos = yy_varax
      end
      true
    end and yy_nontermb6() and while true
      yy_varb1 = @yy_input.pos
      if not yy_nontermb8() then
        @yy_input.pos = yy_varb1
        break true
      end
    end) and begin
        yy_varb3 = @yy_input.pos
        @yy_input.pos = yy_varb2
        val << @yy_input.read(yy_varb3 - yy_varb2).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nontermb6 
val = :yy_nil 
begin; yy_varb5 = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varb5; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermb8 
val = :yy_nil 
begin; yy_varb7 = @yy_input.pos; yy_nontermb6() or (@yy_input.pos = yy_varb7; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermd0 
val = :yy_nil 
(not begin
      yy_varbc = @yy_input.pos
      yy_varbd = yy_nontermak()
      @yy_input.pos = yy_varbc
      yy_varbd
    end and begin; yy_varc7 = @yy_input.pos; (begin
      val = ""
      yy_varck = @yy_input.pos
      (yy_nontermd2() and while true
      yy_varcj = @yy_input.pos
      if not yy_nontermd4() then
        @yy_input.pos = yy_varcj
        break true
      end
    end) and begin
        yy_varcl = @yy_input.pos
        @yy_input.pos = yy_varck
        val << @yy_input.read(yy_varcl - yy_varck).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermfm()) or (@yy_input.pos = yy_varc7; (begin
      val = ""
      yy_varcy = @yy_input.pos
      (yy_string("`") and  begin
      while true
        ###
        yy_varcw = @yy_input.pos
        ### Look ahead.
        yy_varcx = yy_string("`")
        @yy_input.pos = yy_varcw
        break if yy_varcx
        ### Repeat one more time (if possible).
        yy_varcx = @yy_input.getc
        if not yy_varcx then
          @yy_input.pos = yy_varcw
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string("`")) and begin
        yy_varcz = @yy_input.pos
        @yy_input.pos = yy_varcy
        val << @yy_input.read(yy_varcz - yy_varcy).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermfm())); end) and yy_to_pcv(val) 
end 
def yy_nontermd2 
val = :yy_nil 
begin; yy_vard1 = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_vard1; yy_char_range("A", "Z")) or (@yy_input.pos = yy_vard1; yy_string("-")) or (@yy_input.pos = yy_vard1; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermd4 
val = :yy_nil 
begin; yy_vard3 = @yy_input.pos; yy_nontermd2() or (@yy_input.pos = yy_vard3; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermda 
val = :yy_nil 
(begin
      yy_vard6 = yy_nontermf0()
      if yy_vard6 then
        from = yy_from_pcv(yy_vard6)
      end
      yy_vard6
    end and begin; yy_vard8 = @yy_input.pos; yy_string("...") or (@yy_input.pos = yy_vard8; yy_string("..")) or (@yy_input.pos = yy_vard8; yy_string("\u{2026}")) or (@yy_input.pos = yy_vard8; yy_string("\u{2025}")); end and yy_nontermfm() and begin
      yy_vard9 = yy_nontermf0()
      if yy_vard9 then
        to = yy_from_pcv(yy_vard9)
      end
      yy_vard9
    end and yy_nontermfm() and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermf0 
val = :yy_nil 
(begin; yy_vare6 = @yy_input.pos; (yy_string("'") and begin
      val = ""
      yy_varej = @yy_input.pos
       begin
      while true
        ###
        yy_vareh = @yy_input.pos
        ### Look ahead.
        yy_varei = yy_string("'")
        @yy_input.pos = yy_vareh
        break if yy_varei
        ### Repeat one more time (if possible).
        yy_varei = @yy_input.getc
        if not yy_varei then
          @yy_input.pos = yy_vareh
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varek = @yy_input.pos
        @yy_input.pos = yy_varej
        val << @yy_input.read(yy_varek - yy_varej).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("'")) or (@yy_input.pos = yy_vare6; (yy_string("\"") and begin
      val = ""
      yy_varex = @yy_input.pos
       begin
      while true
        ###
        yy_varev = @yy_input.pos
        ### Look ahead.
        yy_varew = yy_string("\"")
        @yy_input.pos = yy_varev
        break if yy_varew
        ### Repeat one more time (if possible).
        yy_varew = @yy_input.getc
        if not yy_varew then
          @yy_input.pos = yy_varev
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varey = @yy_input.pos
        @yy_input.pos = yy_varex
        val << @yy_input.read(yy_varey - yy_varex).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("\""))) or (@yy_input.pos = yy_vare6; (begin
      yy_varez = yy_nontermfg()
      if yy_varez then
        code = yy_from_pcv(yy_varez)
      end
      yy_varez
    end and begin 
  val = "" << code  
 true 
 end)); end and yy_nontermfm()) and yy_to_pcv(val) 
end 
def yy_nontermfg 
val = :yy_nil 
(yy_string("U+") and begin
      code = ""
      yy_varfe = @yy_input.pos
      begin; yy_varfc = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_varfc; yy_char_range("A", "F")); end and while true
      yy_varfd = @yy_input.pos
      if not begin; yy_varfc = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_varfc; yy_char_range("A", "F")); end then
        @yy_input.pos = yy_varfd
        break true
      end
    end and begin
        yy_varff = @yy_input.pos
        @yy_input.pos = yy_varfe
        code << @yy_input.read(yy_varff - yy_varfe).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermfm 
val = :yy_nil 
while true
      yy_varfl = @yy_input.pos
      if not begin; yy_varfk = @yy_input.pos; yy_nontermfy() or (@yy_input.pos = yy_varfk; yy_nontermfw()); end then
        @yy_input.pos = yy_varfl
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nontermfw 
val = :yy_nil 
(begin; yy_varfp = @yy_input.pos; yy_string("#") or (@yy_input.pos = yy_varfp; yy_string("--")); end and  begin
      while true
        ###
        yy_varfs = @yy_input.pos
        ### Look ahead.
        yy_varft = begin; yy_varfv = @yy_input.pos; yy_nontermg0() or (@yy_input.pos = yy_varfv; @yy_input.eof?); end
        @yy_input.pos = yy_varfs
        break if yy_varft
        ### Repeat one more time (if possible).
        yy_varft = @yy_input.getc
        if not yy_varft then
          @yy_input.pos = yy_varfs
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_varfv = @yy_input.pos; yy_nontermg0() or (@yy_input.pos = yy_varfv; @yy_input.eof?); end) and yy_to_pcv(val) 
end 
def yy_nontermfy 
val = :yy_nil 
begin; yy_varfx = @yy_input.pos; yy_char_range("\t", "\r") or (@yy_input.pos = yy_varfx; yy_string(" ")) or (@yy_input.pos = yy_varfx; yy_string("\u{85}")) or (@yy_input.pos = yy_varfx; yy_string("\u{a0}")) or (@yy_input.pos = yy_varfx; yy_string("\u{1680}")) or (@yy_input.pos = yy_varfx; yy_string("\u{180e}")) or (@yy_input.pos = yy_varfx; yy_char_range("\u{2000}", "\u{200a}")) or (@yy_input.pos = yy_varfx; yy_string("\u{2028}")) or (@yy_input.pos = yy_varfx; yy_string("\u{2029}")) or (@yy_input.pos = yy_varfx; yy_string("\u{202f}")) or (@yy_input.pos = yy_varfx; yy_string("\u{205f}")) or (@yy_input.pos = yy_varfx; yy_string("\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nontermg0 
val = :yy_nil 
begin; yy_varfz = @yy_input.pos; (yy_string("\r") and yy_string("\n")) or (@yy_input.pos = yy_varfz; yy_string("\r")) or (@yy_input.pos = yy_varfz; yy_string("\n")) or (@yy_input.pos = yy_varfz; yy_string("\u{85}")) or (@yy_input.pos = yy_varfz; yy_string("\v")) or (@yy_input.pos = yy_varfz; yy_string("\f")) or (@yy_input.pos = yy_varfz; yy_string("\u{2028}")) or (@yy_input.pos = yy_varfz; yy_string("\u{2029}")); end and yy_to_pcv(val) 
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
