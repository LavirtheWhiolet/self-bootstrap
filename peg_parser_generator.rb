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
        x = yy_nonterm5 or raise YY_SyntaxError
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
    def yy_nonterm5 
val = :yy_nil 
(begin 
 
    code = code("")
    rule_is_first = true
    method_names = HashMap.new
   
 true 
 end and yy_nonterm5l() and while true
      yy_var4 = @yy_input.pos
      if not begin; yy_var1 = @yy_input.pos; (begin
      yy_var2 = yy_nonterm1i()
      if yy_var2 then
        r = yy_from_pcv(yy_var2)
      end
      yy_var2
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
 end) or (@yy_input.pos = yy_var1; (begin
      yy_var3 = yy_nonterm2l()
      if yy_var3 then
        x = yy_from_pcv(yy_var3)
      end
      yy_var3
    end and begin 
 
        code += code(x)
       
 true 
 end)); end then
        @yy_input.pos = yy_var4
        break true
      end
    end and @yy_input.eof? and begin 
 
    code = link(code, method_names)
    print code
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm8 
val = :yy_nil 
begin
      yy_var7 = yy_nontermf()
      if yy_var7 then
        val = yy_from_pcv(yy_var7)
      end
      yy_var7
    end and yy_to_pcv(val) 
end 
def yy_nontermf 
val = :yy_nil 
(begin 
 
    single_expression = true
    remembered_pos_var = new_unique_variable_name
   
 true 
 end and begin
      yy_vara = @yy_input.pos
      if not yy_nonterm2x() then
        @yy_input.pos = yy_vara
      end
      true
    end and begin
      yy_varb = yy_nontermk()
      if yy_varb then
        val = yy_from_pcv(yy_varb)
      end
      yy_varb
    end and while true
      yy_vare = @yy_input.pos
      if not (yy_nonterm2x() and begin
      yy_vard = yy_nontermk()
      if yy_vard then
        val2 = yy_from_pcv(yy_vard)
      end
      yy_vard
    end and begin 
 
      single_expression = false
      val = val + (code " or (@yy_input.pos = #{remembered_pos_var}; ") + val2 + (code ")")
     
 true 
 end) then
        @yy_input.pos = yy_vare
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "begin; #{remembered_pos_var} = @yy_input.pos; ") + val + (code "; end")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermk 
val = :yy_nil 
(begin 
  code_parts = []  
 true 
 end and begin; yy_varh = @yy_input.pos; (begin
      yy_vari = yy_nontermp()
      if yy_vari then
        code_part = yy_from_pcv(yy_vari)
      end
      yy_vari
    end and begin 
  code_parts.add code_part  
 true 
 end) or (@yy_input.pos = yy_varh; (yy_nonterm37() and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end and while true
      yy_varj = @yy_input.pos
      if not begin; yy_varh = @yy_input.pos; (begin
      yy_vari = yy_nontermp()
      if yy_vari then
        code_part = yy_from_pcv(yy_vari)
      end
      yy_vari
    end and begin 
  code_parts.add code_part  
 true 
 end) or (@yy_input.pos = yy_varh; (yy_nonterm37() and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end then
        @yy_input.pos = yy_varj
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
  
def yy_nontermp 
val = :yy_nil 
begin; yy_varl = @yy_input.pos; (begin
      yy_varm = yy_nonterm42()
      if yy_varm then
        var = yy_from_pcv(yy_varm)
      end
      yy_varm
    end and yy_nonterm39() and begin
      yy_varn = yy_nontermp()
      if yy_varn then
        c = yy_from_pcv(yy_varn)
      end
      yy_varn
    end and begin 
  val = capture_semantic_value_code(var, c)  
 true 
 end) or (@yy_input.pos = yy_varl; begin
      yy_varo = yy_nontermv()
      if yy_varo then
        val = yy_from_pcv(yy_varo)
      end
      yy_varo
    end); end and yy_to_pcv(val) 
end 
def yy_nontermv 
val = :yy_nil 
begin; yy_varq = @yy_input.pos; (yy_nonterm3n() and begin
      yy_varr = yy_nonterm2l()
      if yy_varr then
        c = yy_from_pcv(yy_varr)
      end
      yy_varr
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (@yy_input.pos = yy_varq; (yy_nonterm3n() and begin
      yy_vars = yy_nontermv()
      if yy_vars then
        val = yy_from_pcv(yy_vars)
      end
      yy_vars
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_varq; (yy_nonterm3p() and begin
      yy_vart = yy_nontermv()
      if yy_vart then
        val = yy_from_pcv(yy_vart)
      end
      yy_vart
    end and begin 
  val = code(%(not )) + positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_varq; begin
      yy_varu = yy_nonterm10()
      if yy_varu then
        val = yy_from_pcv(yy_varu)
      end
      yy_varu
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm10 
val = :yy_nil 
(begin
      yy_varx = yy_nonterm16()
      if yy_varx then
        val = yy_from_pcv(yy_varx)
      end
      yy_varx
    end and while true
      yy_varz = @yy_input.pos
      if not begin; yy_vary = @yy_input.pos; (yy_nonterm3h() and begin 
  val = lazy_repeat_code(val)  
 true 
 end) or (@yy_input.pos = yy_vary; (yy_nonterm3f() and begin 
  val = repeat_many_times_code(val)  
 true 
 end)) or (@yy_input.pos = yy_vary; (yy_nonterm3l() and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (@yy_input.pos = yy_vary; (yy_nonterm3j() and begin 
  val = optional_code(val)  
 true 
 end)); end then
        @yy_input.pos = yy_varz
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm16 
val = :yy_nil 
begin; yy_var11 = @yy_input.pos; (yy_nonterm31() and begin
      yy_var12 = yy_nonterm8()
      if yy_var12 then
        val = yy_from_pcv(yy_var12)
      end
      yy_var12
    end and yy_nonterm33()) or (@yy_input.pos = yy_var11; (begin
      yy_var13 = yy_nonterm42()
      if yy_var13 then
        var = yy_from_pcv(yy_var13)
      end
      yy_var13
    end and yy_nonterm39() and yy_nonterm3b() and begin
      yy_var14 = yy_nonterm8()
      if yy_var14 then
        c = yy_from_pcv(yy_var14)
      end
      yy_var14
    end and yy_nonterm3d() and begin 
  val = capture_text_code(var, c)  
 true 
 end)) or (@yy_input.pos = yy_var11; begin
      yy_var15 = yy_nonterm1c()
      if yy_var15 then
        val = yy_from_pcv(yy_var15)
      end
      yy_var15
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1c 
val = :yy_nil 
begin; yy_var17 = @yy_input.pos; (begin
      yy_var18 = yy_nonterm4w()
      if yy_var18 then
        r = yy_from_pcv(yy_var18)
      end
      yy_var18
    end and begin 
  val = code "yy_char_range(#{r.begin.dump}, #{r.end.dump})"  
 true 
 end) or (@yy_input.pos = yy_var17; (begin
      yy_var19 = yy_nonterm5a()
      if yy_var19 then
        s = yy_from_pcv(yy_var19)
      end
      yy_var19
    end and begin 
  val = code "yy_string(#{s.dump})"  
 true 
 end)) or (@yy_input.pos = yy_var17; (begin
      yy_var1a = yy_nonterm4n()
      if yy_var1a then
        n = yy_from_pcv(yy_var1a)
      end
      yy_var1a
    end and begin 
  val = UnknownMethodCall[n]  
 true 
 end)) or (@yy_input.pos = yy_var17; (yy_nonterm3t() and begin 
  val = code "@yy_input.getc"  
 true 
 end)) or (@yy_input.pos = yy_var17; (begin
      yy_var1b = yy_nonterm2l()
      if yy_var1b then
        a = yy_from_pcv(yy_var1b)
      end
      yy_var1b
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (@yy_input.pos = yy_var17; (yy_nonterm2z() and begin 
  val = code "@yy_input.eof?"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm1i 
val = :yy_nil 
(begin
      yy_var1e = yy_nonterm4n()
      if yy_var1e then
        n = yy_from_pcv(yy_var1e)
      end
      yy_var1e
    end and begin
      yy_var1g = @yy_input.pos
      if not (yy_nonterm39() and yy_nonterm1p()) then
        @yy_input.pos = yy_var1g
      end
      true
    end and yy_nonterm2t() and begin
      yy_var1h = yy_nonterm8()
      if yy_var1h then
        c = yy_from_pcv(yy_var1h)
      end
      yy_var1h
    end and yy_nonterm2v() and begin 
 
    method_name = new_unique_nonterminal_method_name
    val = [n, method_name, to_method_definition(c, method_name)]
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm1p 
val = :yy_nil 
((not begin
      yy_var1m = @yy_input.pos
      yy_var1n = yy_nonterm2t()
      @yy_input.pos = yy_var1m
      yy_var1n
    end and @yy_input.getc) and yy_nonterm5l()) and while true
      yy_var1o = @yy_input.pos
      if not ((not begin
      yy_var1m = @yy_input.pos
      yy_var1n = yy_nonterm2t()
      @yy_input.pos = yy_var1m
      yy_var1n
    end and @yy_input.getc) and yy_nonterm5l()) then
        @yy_input.pos = yy_var1o
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm1t 
val = :yy_nil 
(yy_string("%%") and  begin
      while true
        ###
        yy_var1r = @yy_input.pos
        ### Look ahead.
        yy_var1s = yy_nonterm5u()
        @yy_input.pos = yy_var1r
        break if yy_var1s
        ### Repeat one more time (if possible).
        yy_var1s = @yy_input.getc
        if not yy_var1s then
          @yy_input.pos = yy_var1r
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nonterm5u()) and yy_to_pcv(val) 
end 
def yy_nonterm2l 
val = :yy_nil 
(begin; yy_var1v = @yy_input.pos; (yy_string("{") and while true
      yy_var1w = @yy_input.pos
      if not yy_nonterm5s() then
        @yy_input.pos = yy_var1w
        break true
      end
    end and yy_string("...") and begin
      yy_var20 = @yy_input.pos
      if not ( begin
      while true
        ###
        yy_var1y = @yy_input.pos
        ### Look ahead.
        yy_var1z = yy_nonterm5u()
        @yy_input.pos = yy_var1y
        break if yy_var1z
        ### Repeat one more time (if possible).
        yy_var1z = yy_nonterm5s()
        if not yy_var1z then
          @yy_input.pos = yy_var1y
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nonterm5u()) then
        @yy_input.pos = yy_var20
      end
      true
    end and begin
      val = ""
      yy_var24 = @yy_input.pos
       begin
      while true
        ###
        yy_var22 = @yy_input.pos
        ### Look ahead.
        yy_var23 = (yy_string("...") and while true
      yy_var26 = @yy_input.pos
      if not yy_nonterm5s() then
        @yy_input.pos = yy_var26
        break true
      end
    end and yy_string("}"))
        @yy_input.pos = yy_var22
        break if yy_var23
        ### Repeat one more time (if possible).
        yy_var23 = @yy_input.getc
        if not yy_var23 then
          @yy_input.pos = yy_var22
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var25 = @yy_input.pos
        @yy_input.pos = yy_var24
        val << @yy_input.read(yy_var25 - yy_var24).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("...") and while true
      yy_var26 = @yy_input.pos
      if not yy_nonterm5s() then
        @yy_input.pos = yy_var26
        break true
      end
    end and yy_string("}")) or (@yy_input.pos = yy_var1v; (begin
      val = ""
      yy_var28 = @yy_input.pos
      yy_nonterm2q() and begin
        yy_var29 = @yy_input.pos
        @yy_input.pos = yy_var28
        val << @yy_input.read(yy_var29 - yy_var28).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = val[1...-1]  
 true 
 end)) or (@yy_input.pos = yy_var1v; (yy_nonterm1t() and begin
      val = ""
      yy_var2e = @yy_input.pos
       begin
      while true
        ###
        yy_var2c = @yy_input.pos
        ### Look ahead.
        yy_var2d = yy_nonterm1t()
        @yy_input.pos = yy_var2c
        break if yy_var2d
        ### Repeat one more time (if possible).
        yy_var2d = @yy_input.getc
        if not yy_var2d then
          @yy_input.pos = yy_var2c
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var2f = @yy_input.pos
        @yy_input.pos = yy_var2e
        val << @yy_input.read(yy_var2f - yy_var2e).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm1t())) or (@yy_input.pos = yy_var1v; (yy_nonterm1t() and begin
      val = ""
      yy_var2j = @yy_input.pos
      while true
      yy_var2i = @yy_input.pos
      if not @yy_input.getc then
        @yy_input.pos = yy_var2i
        break true
      end
    end and begin
        yy_var2k = @yy_input.pos
        @yy_input.pos = yy_var2j
        val << @yy_input.read(yy_var2k - yy_var2j).force_encoding(Encoding::UTF_8)
      end
    end and @yy_input.eof?)); end and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm2q 
val = :yy_nil 
(yy_string("{") and  begin
      while true
        ###
        yy_var2o = @yy_input.pos
        ### Look ahead.
        yy_var2p = yy_string("}")
        @yy_input.pos = yy_var2o
        break if yy_var2p
        ### Repeat one more time (if possible).
        yy_var2p = begin; yy_var2n = @yy_input.pos; yy_nonterm2q() or (@yy_input.pos = yy_var2n; @yy_input.getc); end
        if not yy_var2p then
          @yy_input.pos = yy_var2o
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string("}")) and yy_to_pcv(val) 
end 
def yy_nonterm2t 
val = :yy_nil 
(begin; yy_var2s = @yy_input.pos; yy_string("<-") or (@yy_input.pos = yy_var2s; yy_string("=")) or (@yy_input.pos = yy_var2s; yy_string("\u{2190}")); end and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm2v 
val = :yy_nil 
(yy_string(";") and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm2x 
val = :yy_nil 
(yy_string("/") and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm2z 
val = :yy_nil 
(yy_string("$") and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm31 
val = :yy_nil 
(yy_string("(") and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm33 
val = :yy_nil 
(yy_string(")") and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm35 
val = :yy_nil 
(yy_string("[") and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm37 
val = :yy_nil 
(yy_string("]") and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm39 
val = :yy_nil 
(yy_string(":") and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm3b 
val = :yy_nil 
(yy_string("<") and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm3d 
val = :yy_nil 
(yy_string(">") and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm3f 
val = :yy_nil 
(yy_string("*") and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm3h 
val = :yy_nil 
(yy_string("*?") and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm3j 
val = :yy_nil 
(yy_string("?") and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm3l 
val = :yy_nil 
(yy_string("+") and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm3n 
val = :yy_nil 
(yy_string("&") and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm3p 
val = :yy_nil 
(yy_string("!") and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm3t 
val = :yy_nil 
(yy_string("char") and not begin
      yy_var3r = @yy_input.pos
      yy_var3s = yy_nonterm4r()
      @yy_input.pos = yy_var3r
      yy_var3s
    end and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm3v 
val = :yy_nil 
yy_nonterm3t() and yy_to_pcv(val) 
end 
def yy_nonterm42 
val = :yy_nil 
(begin
      val = ""
      yy_var40 = @yy_input.pos
      (yy_nonterm44() and while true
      yy_var3z = @yy_input.pos
      if not yy_nonterm46() then
        @yy_input.pos = yy_var3z
        break true
      end
    end) and begin
        yy_var41 = @yy_input.pos
        @yy_input.pos = yy_var40
        val << @yy_input.read(yy_var41 - yy_var40).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm44 
val = :yy_nil 
begin; yy_var43 = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_var43; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nonterm46 
val = :yy_nil 
begin; yy_var45 = @yy_input.pos; yy_nonterm44() or (@yy_input.pos = yy_var45; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nonterm4n 
val = :yy_nil 
(not begin
      yy_var48 = @yy_input.pos
      yy_var49 = yy_nonterm3v()
      @yy_input.pos = yy_var48
      yy_var49
    end and begin; yy_var4a = @yy_input.pos; (begin
      val = ""
      yy_var4e = @yy_input.pos
      (yy_nonterm4p() and while true
      yy_var4d = @yy_input.pos
      if not yy_nonterm4r() then
        @yy_input.pos = yy_var4d
        break true
      end
    end) and begin
        yy_var4f = @yy_input.pos
        @yy_input.pos = yy_var4e
        val << @yy_input.read(yy_var4f - yy_var4e).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm5l()) or (@yy_input.pos = yy_var4a; (begin
      val = ""
      yy_var4l = @yy_input.pos
      (yy_string("`") and while true
      yy_var4k = @yy_input.pos
      if not (not begin
      yy_var4i = @yy_input.pos
      yy_var4j = yy_string("`")
      @yy_input.pos = yy_var4i
      yy_var4j
    end and @yy_input.getc) then
        @yy_input.pos = yy_var4k
        break true
      end
    end and yy_string("`")) and begin
        yy_var4m = @yy_input.pos
        @yy_input.pos = yy_var4l
        val << @yy_input.read(yy_var4m - yy_var4l).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm5l())); end) and yy_to_pcv(val) 
end 
def yy_nonterm4p 
val = :yy_nil 
begin; yy_var4o = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_var4o; yy_char_range("A", "Z")) or (@yy_input.pos = yy_var4o; yy_string("-")) or (@yy_input.pos = yy_var4o; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nonterm4r 
val = :yy_nil 
begin; yy_var4q = @yy_input.pos; yy_nonterm4p() or (@yy_input.pos = yy_var4q; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nonterm4w 
val = :yy_nil 
(begin
      yy_var4t = yy_nonterm5a()
      if yy_var4t then
        from = yy_from_pcv(yy_var4t)
      end
      yy_var4t
    end and begin; yy_var4u = @yy_input.pos; yy_string("...") or (@yy_input.pos = yy_var4u; yy_string("..")) or (@yy_input.pos = yy_var4u; yy_string("\u{2026}")) or (@yy_input.pos = yy_var4u; yy_string("\u{2025}")); end and yy_nonterm5l() and begin
      yy_var4v = yy_nonterm5a()
      if yy_var4v then
        to = yy_from_pcv(yy_var4v)
      end
      yy_var4v
    end and yy_nonterm5l() and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm5a 
val = :yy_nil 
(begin; yy_var4y = @yy_input.pos; (yy_string("'") and begin
      val = ""
      yy_var52 = @yy_input.pos
       begin
      while true
        ###
        yy_var50 = @yy_input.pos
        ### Look ahead.
        yy_var51 = yy_string("'")
        @yy_input.pos = yy_var50
        break if yy_var51
        ### Repeat one more time (if possible).
        yy_var51 = @yy_input.getc
        if not yy_var51 then
          @yy_input.pos = yy_var50
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var53 = @yy_input.pos
        @yy_input.pos = yy_var52
        val << @yy_input.read(yy_var53 - yy_var52).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("'")) or (@yy_input.pos = yy_var4y; (yy_string("\"") and begin
      val = ""
      yy_var57 = @yy_input.pos
       begin
      while true
        ###
        yy_var55 = @yy_input.pos
        ### Look ahead.
        yy_var56 = yy_string("\"")
        @yy_input.pos = yy_var55
        break if yy_var56
        ### Repeat one more time (if possible).
        yy_var56 = @yy_input.getc
        if not yy_var56 then
          @yy_input.pos = yy_var55
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var58 = @yy_input.pos
        @yy_input.pos = yy_var57
        val << @yy_input.read(yy_var58 - yy_var57).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("\""))) or (@yy_input.pos = yy_var4y; (begin
      yy_var59 = yy_nonterm5h()
      if yy_var59 then
        code = yy_from_pcv(yy_var59)
      end
      yy_var59
    end and begin 
  val = "" << code  
 true 
 end)); end and yy_nonterm5l()) and yy_to_pcv(val) 
end 
def yy_nonterm5h 
val = :yy_nil 
(yy_string("U+") and begin
      code = ""
      yy_var5f = @yy_input.pos
      begin; yy_var5d = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_var5d; yy_char_range("A", "F")); end and while true
      yy_var5e = @yy_input.pos
      if not begin; yy_var5d = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_var5d; yy_char_range("A", "F")); end then
        @yy_input.pos = yy_var5e
        break true
      end
    end and begin
        yy_var5g = @yy_input.pos
        @yy_input.pos = yy_var5f
        code << @yy_input.read(yy_var5g - yy_var5f).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm5l 
val = :yy_nil 
while true
      yy_var5k = @yy_input.pos
      if not begin; yy_var5j = @yy_input.pos; yy_nonterm5s() or (@yy_input.pos = yy_var5j; yy_nonterm5q()); end then
        @yy_input.pos = yy_var5k
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm5q 
val = :yy_nil 
(begin; yy_var5n = @yy_input.pos; yy_string("#") or (@yy_input.pos = yy_var5n; yy_string("--")); end and  begin
      while true
        ###
        yy_var5o = @yy_input.pos
        ### Look ahead.
        yy_var5p = yy_nonterm5u()
        @yy_input.pos = yy_var5o
        break if yy_var5p
        ### Repeat one more time (if possible).
        yy_var5p = @yy_input.getc
        if not yy_var5p then
          @yy_input.pos = yy_var5o
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nonterm5u()) and yy_to_pcv(val) 
end 
def yy_nonterm5s 
val = :yy_nil 
begin; yy_var5r = @yy_input.pos; yy_char_range("\t", "\r") or (@yy_input.pos = yy_var5r; yy_string(" ")) or (@yy_input.pos = yy_var5r; yy_string("\u{85}")) or (@yy_input.pos = yy_var5r; yy_string("\u{a0}")) or (@yy_input.pos = yy_var5r; yy_string("\u{1680}")) or (@yy_input.pos = yy_var5r; yy_string("\u{180e}")) or (@yy_input.pos = yy_var5r; yy_char_range("\u{2000}", "\u{200a}")) or (@yy_input.pos = yy_var5r; yy_string("\u{2028}")) or (@yy_input.pos = yy_var5r; yy_string("\u{2029}")) or (@yy_input.pos = yy_var5r; yy_string("\u{202f}")) or (@yy_input.pos = yy_var5r; yy_string("\u{205f}")) or (@yy_input.pos = yy_var5r; yy_string("\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nonterm5u 
val = :yy_nil 
begin; yy_var5t = @yy_input.pos; (yy_string("\r") and yy_string("\n")) or (@yy_input.pos = yy_var5t; yy_string("\r")) or (@yy_input.pos = yy_var5t; yy_string("\n")) or (@yy_input.pos = yy_var5t; yy_string("\u{85}")) or (@yy_input.pos = yy_var5t; yy_string("\v")) or (@yy_input.pos = yy_var5t; yy_string("\f")) or (@yy_input.pos = yy_var5t; yy_string("\u{2028}")) or (@yy_input.pos = yy_var5t; yy_string("\u{2029}")); end and yy_to_pcv(val) 
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
