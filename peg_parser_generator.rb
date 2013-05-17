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
        x = yy_nontermd or raise YY_SyntaxError
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
    def yy_nontermd 
val = :yy_nil 
(begin 
 
    code = code("")
    rule_is_first = true
    method_names = HashMap.new
   
 true 
 end and yy_nontermlj() and while true
      yy_varc = @yy_input.pos
      if not begin; yy_var7 = @yy_input.pos; (begin
      yy_var9 = yy_nonterm2v()
      if yy_var9 then
        r = yy_from_pcv(yy_var9)
      end
      yy_var9
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
 end) or (@yy_input.pos = yy_var7; (begin
      yy_varb = yy_nontermdv()
      if yy_varb then
        x = yy_from_pcv(yy_varb)
      end
      yy_varb
    end and begin 
 
        code += code(x)
       
 true 
 end)); end then
        @yy_input.pos = yy_varc
        break true
      end
    end and @yy_input.eof? and begin 
 
    code = link(code, method_names)
    print code
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermh 
val = :yy_nil 
begin
      yy_varg = yy_nontermv()
      if yy_varg then
        val = yy_from_pcv(yy_varg)
      end
      yy_varg
    end and yy_to_pcv(val) 
end 
def yy_nontermv 
val = :yy_nil 
(begin 
 
    single_expression = true
    remembered_pos_var = new_unique_variable_name
   
 true 
 end and begin
      yy_varp = @yy_input.pos
      if not yy_nontermel() then
        @yy_input.pos = yy_varp
      end
      true
    end and begin
      yy_varq = yy_nonterm11()
      if yy_varq then
        val = yy_from_pcv(yy_varq)
      end
      yy_varq
    end and while true
      yy_varu = @yy_input.pos
      if not (yy_nontermel() and begin
      yy_vart = yy_nonterm11()
      if yy_vart then
        val2 = yy_from_pcv(yy_vart)
      end
      yy_vart
    end and begin 
 
      single_expression = false
      val = val + (code " or (@yy_input.pos = #{remembered_pos_var}; ") + val2 + (code ")")
     
 true 
 end) then
        @yy_input.pos = yy_varu
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "begin; #{remembered_pos_var} = @yy_input.pos; ") + val + (code "; end")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm11 
val = :yy_nil 
begin; yy_varw = @yy_input.pos; (begin
      yy_vary = yy_nonterm1b()
      if yy_vary then
        val = yy_from_pcv(yy_vary)
      end
      yy_vary
    end and yy_nontermev()) or (@yy_input.pos = yy_varw; begin
      yy_var10 = yy_nonterm1b()
      if yy_var10 then
        val = yy_from_pcv(yy_var10)
      end
      yy_var10
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1b 
val = :yy_nil 
(begin 
  code_parts = []  
 true 
 end and (begin
      yy_var19 = yy_nonterm1j()
      if yy_var19 then
        code_part = yy_from_pcv(yy_var19)
      end
      yy_var19
    end and begin 
  code_parts.add code_part  
 true 
 end) and while true
      yy_var1a = @yy_input.pos
      if not (begin
      yy_var19 = yy_nonterm1j()
      if yy_var19 then
        code_part = yy_from_pcv(yy_var19)
      end
      yy_var19
    end and begin 
  code_parts.add code_part  
 true 
 end) then
        @yy_input.pos = yy_var1a
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
  
def yy_nonterm1j 
val = :yy_nil 
begin; yy_var1c = @yy_input.pos; (begin
      yy_var1f = yy_nontermg1()
      if yy_var1f then
        var = yy_from_pcv(yy_var1f)
      end
      yy_var1f
    end and yy_nontermex() and begin
      yy_var1g = yy_nonterm1j()
      if yy_var1g then
        c = yy_from_pcv(yy_var1g)
      end
      yy_var1g
    end and begin 
  val = capture_semantic_value_code(var, c)  
 true 
 end) or (@yy_input.pos = yy_var1c; begin
      yy_var1i = yy_nonterm1t()
      if yy_var1i then
        val = yy_from_pcv(yy_var1i)
      end
      yy_var1i
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1t 
val = :yy_nil 
begin; yy_var1k = @yy_input.pos; (yy_nontermfb() and begin
      yy_var1m = yy_nontermdv()
      if yy_var1m then
        c = yy_from_pcv(yy_var1m)
      end
      yy_var1m
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (@yy_input.pos = yy_var1k; (yy_nontermfb() and begin
      yy_var1o = yy_nonterm1t()
      if yy_var1o then
        val = yy_from_pcv(yy_var1o)
      end
      yy_var1o
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1k; (yy_nontermfd() and begin
      yy_var1q = yy_nonterm1t()
      if yy_var1q then
        val = yy_from_pcv(yy_var1q)
      end
      yy_var1q
    end and begin 
  val = code(%(not )) + positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1k; begin
      yy_var1s = yy_nonterm21()
      if yy_var1s then
        val = yy_from_pcv(yy_var1s)
      end
      yy_var1s
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm21 
val = :yy_nil 
(begin
      yy_var1y = yy_nonterm2b()
      if yy_var1y then
        val = yy_from_pcv(yy_var1y)
      end
      yy_var1y
    end and while true
      yy_var20 = @yy_input.pos
      if not begin; yy_var1z = @yy_input.pos; (yy_nontermf5() and begin 
  val = lazy_repeat_code(val)  
 true 
 end) or (@yy_input.pos = yy_var1z; (yy_nontermf3() and begin 
  val = repeat_many_times_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1z; (yy_nontermf9() and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1z; (yy_nontermf7() and begin 
  val = optional_code(val)  
 true 
 end)); end then
        @yy_input.pos = yy_var20
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm2b 
val = :yy_nil 
begin; yy_var22 = @yy_input.pos; (yy_nontermep() and begin
      yy_var24 = yy_nontermh()
      if yy_var24 then
        val = yy_from_pcv(yy_var24)
      end
      yy_var24
    end and yy_nontermer()) or (@yy_input.pos = yy_var22; (begin
      yy_var27 = yy_nontermg1()
      if yy_var27 then
        var = yy_from_pcv(yy_var27)
      end
      yy_var27
    end and yy_nontermex() and yy_nontermez() and begin
      yy_var28 = yy_nontermh()
      if yy_var28 then
        c = yy_from_pcv(yy_var28)
      end
      yy_var28
    end and yy_nontermf1() and begin 
  val = capture_text_code(var, c)  
 true 
 end)) or (@yy_input.pos = yy_var22; begin
      yy_var2a = yy_nonterm2l()
      if yy_var2a then
        val = yy_from_pcv(yy_var2a)
      end
      yy_var2a
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm2l 
val = :yy_nil 
begin; yy_var2c = @yy_input.pos; (begin
      yy_var2e = yy_nontermj5()
      if yy_var2e then
        r = yy_from_pcv(yy_var2e)
      end
      yy_var2e
    end and begin 
  val = code "yy_char_range(#{r.begin.dump}, #{r.end.dump})"  
 true 
 end) or (@yy_input.pos = yy_var2c; (begin
      yy_var2g = yy_nontermkx()
      if yy_var2g then
        s = yy_from_pcv(yy_var2g)
      end
      yy_var2g
    end and begin 
  val = code "yy_string(#{s.dump})"  
 true 
 end)) or (@yy_input.pos = yy_var2c; (begin
      yy_var2i = yy_nontermit()
      if yy_var2i then
        n = yy_from_pcv(yy_var2i)
      end
      yy_var2i
    end and begin 
  val = UnknownMethodCall[n]  
 true 
 end)) or (@yy_input.pos = yy_var2c; (yy_nontermfj() and begin 
  val = code "@yy_input.getc"  
 true 
 end)) or (@yy_input.pos = yy_var2c; (begin
      yy_var2k = yy_nontermdv()
      if yy_var2k then
        a = yy_from_pcv(yy_var2k)
      end
      yy_var2k
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (@yy_input.pos = yy_var2c; (yy_nontermen() and begin 
  val = code "@yy_input.eof?"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm2v 
val = :yy_nil 
(begin
      yy_var2r = yy_nontermit()
      if yy_var2r then
        n = yy_from_pcv(yy_var2r)
      end
      yy_var2r
    end and begin
      yy_var2t = @yy_input.pos
      if not (yy_nontermex() and yy_nonterm3l()) then
        @yy_input.pos = yy_var2t
      end
      true
    end and yy_nontermeh() and begin
      yy_var2u = yy_nontermh()
      if yy_var2u then
        c = yy_from_pcv(yy_var2u)
      end
      yy_var2u
    end and yy_nontermej() and begin 
 
    method_name = new_unique_nonterminal_method_name
    val = [n, method_name, to_method_definition(c, method_name)]
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm3l 
val = :yy_nil 
((not begin
      yy_var3i = @yy_input.pos
      yy_var3j = yy_nontermeh()
      @yy_input.pos = yy_var3i
      yy_var3j
    end and @yy_input.getc) and yy_nontermlj()) and while true
      yy_var3k = @yy_input.pos
      if not ((not begin
      yy_var3i = @yy_input.pos
      yy_var3j = yy_nontermeh()
      @yy_input.pos = yy_var3i
      yy_var3j
    end and @yy_input.getc) and yy_nontermlj()) then
        @yy_input.pos = yy_var3k
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm3z 
val = :yy_nil 
(yy_string("%%") and while true
      yy_var3y = @yy_input.pos
      if not (not begin
      yy_var3w = @yy_input.pos
      yy_var3x = yy_nontermm3()
      @yy_input.pos = yy_var3w
      yy_var3x
    end and @yy_input.getc) then
        @yy_input.pos = yy_var3y
        break true
      end
    end and yy_nontermm3()) and yy_to_pcv(val) 
end 
def yy_nontermdv 
val = :yy_nil 
(begin; yy_var8y = @yy_input.pos; (yy_string("{") and while true
      yy_vara6 = @yy_input.pos
      if not yy_nontermm1() then
        @yy_input.pos = yy_vara6
        break true
      end
    end and yy_string("...") and begin
      yy_varak = @yy_input.pos
      if not (while true
      yy_varaj = @yy_input.pos
      if not (not begin
      yy_varah = @yy_input.pos
      yy_varai = yy_nontermm3()
      @yy_input.pos = yy_varah
      yy_varai
    end and yy_nontermm1()) then
        @yy_input.pos = yy_varaj
        break true
      end
    end and yy_nontermm3()) then
        @yy_input.pos = yy_varak
      end
      true
    end and begin
      val = ""
      yy_varba = @yy_input.pos
      while true
      yy_varb9 = @yy_input.pos
      if not (not begin
      yy_varb7 = @yy_input.pos
      yy_varb8 = (yy_string("...") and while true
      yy_varb6 = @yy_input.pos
      if not yy_nontermm1() then
        @yy_input.pos = yy_varb6
        break true
      end
    end and yy_string("}"))
      @yy_input.pos = yy_varb7
      yy_varb8
    end and @yy_input.getc) then
        @yy_input.pos = yy_varb9
        break true
      end
    end and begin
        yy_varbb = @yy_input.pos
        @yy_input.pos = yy_varba
        val << @yy_input.read(yy_varbb - yy_varba).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("...") and while true
      yy_varbc = @yy_input.pos
      if not yy_nontermm1() then
        @yy_input.pos = yy_varbc
        break true
      end
    end and yy_string("}")) or (@yy_input.pos = yy_var8y; (begin
      val = ""
      yy_varbh = @yy_input.pos
      yy_nontermed() and begin
        yy_varbi = @yy_input.pos
        @yy_input.pos = yy_varbh
        val << @yy_input.read(yy_varbi - yy_varbh).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = val[1...-1]  
 true 
 end)) or (@yy_input.pos = yy_var8y; (yy_nonterm3z() and begin
      val = ""
      yy_vard7 = @yy_input.pos
      while true
      yy_vard6 = @yy_input.pos
      if not (not begin
      yy_vard4 = @yy_input.pos
      yy_vard5 = yy_nonterm3z()
      @yy_input.pos = yy_vard4
      yy_vard5
    end and @yy_input.getc) then
        @yy_input.pos = yy_vard6
        break true
      end
    end and begin
        yy_vard8 = @yy_input.pos
        @yy_input.pos = yy_vard7
        val << @yy_input.read(yy_vard8 - yy_vard7).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm3z())) or (@yy_input.pos = yy_var8y; (yy_nonterm3z() and begin
      val = ""
      yy_vardt = @yy_input.pos
      while true
      yy_vards = @yy_input.pos
      if not @yy_input.getc then
        @yy_input.pos = yy_vards
        break true
      end
    end and begin
        yy_vardu = @yy_input.pos
        @yy_input.pos = yy_vardt
        val << @yy_input.read(yy_vardu - yy_vardt).force_encoding(Encoding::UTF_8)
      end
    end and @yy_input.eof?)); end and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermed 
val = :yy_nil 
(yy_string("{") and while true
      yy_varec = @yy_input.pos
      if not (not begin
      yy_vare9 = @yy_input.pos
      yy_varea = yy_string("}")
      @yy_input.pos = yy_vare9
      yy_varea
    end and begin; yy_vareb = @yy_input.pos; yy_nontermed() or (@yy_input.pos = yy_vareb; @yy_input.getc); end) then
        @yy_input.pos = yy_varec
        break true
      end
    end and yy_string("}")) and yy_to_pcv(val) 
end 
def yy_nontermeh 
val = :yy_nil 
(begin; yy_vareg = @yy_input.pos; yy_string("<-") or (@yy_input.pos = yy_vareg; yy_string("=")) or (@yy_input.pos = yy_vareg; yy_string("\u{2190}")); end and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermej 
val = :yy_nil 
(yy_string(";") and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermel 
val = :yy_nil 
(yy_string("/") and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermen 
val = :yy_nil 
(yy_string("$") and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermep 
val = :yy_nil 
(yy_string("(") and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermer 
val = :yy_nil 
(yy_string(")") and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermet 
val = :yy_nil 
(yy_string("[") and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermev 
val = :yy_nil 
(yy_string("]") and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermex 
val = :yy_nil 
(yy_string(":") and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermez 
val = :yy_nil 
(yy_string("<") and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermf1 
val = :yy_nil 
(yy_string(">") and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermf3 
val = :yy_nil 
(yy_string("*") and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermf5 
val = :yy_nil 
(yy_string("*?") and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermf7 
val = :yy_nil 
(yy_string("?") and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermf9 
val = :yy_nil 
(yy_string("+") and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermfb 
val = :yy_nil 
(yy_string("&") and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermfd 
val = :yy_nil 
(yy_string("!") and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermfj 
val = :yy_nil 
(yy_string("char") and not begin
      yy_varfh = @yy_input.pos
      yy_varfi = yy_nontermix()
      @yy_input.pos = yy_varfh
      yy_varfi
    end and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermfl 
val = :yy_nil 
yy_nontermfj() and yy_to_pcv(val) 
end 
def yy_nontermg1 
val = :yy_nil 
(begin
      val = ""
      yy_varfz = @yy_input.pos
      (yy_nontermg3() and while true
      yy_varfy = @yy_input.pos
      if not yy_nontermg5() then
        @yy_input.pos = yy_varfy
        break true
      end
    end) and begin
        yy_varg0 = @yy_input.pos
        @yy_input.pos = yy_varfz
        val << @yy_input.read(yy_varg0 - yy_varfz).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermlj()) and yy_to_pcv(val) 
end 
def yy_nontermg3 
val = :yy_nil 
begin; yy_varg2 = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varg2; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermg5 
val = :yy_nil 
begin; yy_varg4 = @yy_input.pos; yy_nontermg3() or (@yy_input.pos = yy_varg4; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermit 
val = :yy_nil 
(not begin
      yy_varhi = @yy_input.pos
      yy_varhj = yy_nontermfl()
      @yy_input.pos = yy_varhi
      yy_varhj
    end and begin; yy_varhk = @yy_input.pos; (begin
      val = ""
      yy_varhx = @yy_input.pos
      (yy_nontermiv() and while true
      yy_varhw = @yy_input.pos
      if not yy_nontermix() then
        @yy_input.pos = yy_varhw
        break true
      end
    end) and begin
        yy_varhy = @yy_input.pos
        @yy_input.pos = yy_varhx
        val << @yy_input.read(yy_varhy - yy_varhx).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermlj()) or (@yy_input.pos = yy_varhk; (begin
      val = ""
      yy_varir = @yy_input.pos
      (yy_string("`") and while true
      yy_variq = @yy_input.pos
      if not (not begin
      yy_vario = @yy_input.pos
      yy_varip = yy_string("`")
      @yy_input.pos = yy_vario
      yy_varip
    end and @yy_input.getc) then
        @yy_input.pos = yy_variq
        break true
      end
    end and yy_string("`")) and begin
        yy_varis = @yy_input.pos
        @yy_input.pos = yy_varir
        val << @yy_input.read(yy_varis - yy_varir).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermlj())); end) and yy_to_pcv(val) 
end 
def yy_nontermiv 
val = :yy_nil 
begin; yy_variu = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_variu; yy_char_range("A", "Z")) or (@yy_input.pos = yy_variu; yy_string("-")) or (@yy_input.pos = yy_variu; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermix 
val = :yy_nil 
begin; yy_variw = @yy_input.pos; yy_nontermiv() or (@yy_input.pos = yy_variw; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermj5 
val = :yy_nil 
(begin
      yy_varj2 = yy_nontermkx()
      if yy_varj2 then
        from = yy_from_pcv(yy_varj2)
      end
      yy_varj2
    end and begin; yy_varj3 = @yy_input.pos; yy_string("...") or (@yy_input.pos = yy_varj3; yy_string("..")) or (@yy_input.pos = yy_varj3; yy_string("\u{2026}")) or (@yy_input.pos = yy_varj3; yy_string("\u{2025}")); end and yy_nontermlj() and begin
      yy_varj4 = yy_nontermkx()
      if yy_varj4 then
        to = yy_from_pcv(yy_varj4)
      end
      yy_varj4
    end and yy_nontermlj() and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermkx 
val = :yy_nil 
begin; yy_varj6 = @yy_input.pos; (yy_string("'") and begin
      val = ""
      yy_varjz = @yy_input.pos
      while true
      yy_varjy = @yy_input.pos
      if not (not begin
      yy_varjw = @yy_input.pos
      yy_varjx = yy_string("'")
      @yy_input.pos = yy_varjw
      yy_varjx
    end and @yy_input.getc) then
        @yy_input.pos = yy_varjy
        break true
      end
    end and begin
        yy_vark0 = @yy_input.pos
        @yy_input.pos = yy_varjz
        val << @yy_input.read(yy_vark0 - yy_varjz).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("'") and yy_nontermlj()) or (@yy_input.pos = yy_varj6; (yy_string("\"") and begin
      val = ""
      yy_varkt = @yy_input.pos
      while true
      yy_varks = @yy_input.pos
      if not (not begin
      yy_varkq = @yy_input.pos
      yy_varkr = yy_string("\"")
      @yy_input.pos = yy_varkq
      yy_varkr
    end and @yy_input.getc) then
        @yy_input.pos = yy_varks
        break true
      end
    end and begin
        yy_varku = @yy_input.pos
        @yy_input.pos = yy_varkt
        val << @yy_input.read(yy_varku - yy_varkt).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("\"") and yy_nontermlj())) or (@yy_input.pos = yy_varj6; (begin
      yy_varkw = yy_nontermld()
      if yy_varkw then
        code = yy_from_pcv(yy_varkw)
      end
      yy_varkw
    end and yy_nontermlj() and begin 
  val = "" << code  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nontermld 
val = :yy_nil 
(yy_string("U+") and begin
      code = ""
      yy_varlb = @yy_input.pos
      begin; yy_varl9 = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_varl9; yy_char_range("A", "F")); end and while true
      yy_varla = @yy_input.pos
      if not begin; yy_varl9 = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_varl9; yy_char_range("A", "F")); end then
        @yy_input.pos = yy_varla
        break true
      end
    end and begin
        yy_varlc = @yy_input.pos
        @yy_input.pos = yy_varlb
        code << @yy_input.read(yy_varlc - yy_varlb).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermlj 
val = :yy_nil 
while true
      yy_varli = @yy_input.pos
      if not begin; yy_varlh = @yy_input.pos; yy_nontermm1() or (@yy_input.pos = yy_varlh; yy_nontermlz()); end then
        @yy_input.pos = yy_varli
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nontermlz 
val = :yy_nil 
(begin; yy_varls = @yy_input.pos; yy_string("#") or (@yy_input.pos = yy_varls; yy_string("--")); end and while true
      yy_varly = @yy_input.pos
      if not (not begin
      yy_varlw = @yy_input.pos
      yy_varlx = yy_nontermm3()
      @yy_input.pos = yy_varlw
      yy_varlx
    end and @yy_input.getc) then
        @yy_input.pos = yy_varly
        break true
      end
    end and yy_nontermm3()) and yy_to_pcv(val) 
end 
def yy_nontermm1 
val = :yy_nil 
begin; yy_varm0 = @yy_input.pos; yy_char_range("\t", "\r") or (@yy_input.pos = yy_varm0; yy_string(" ")) or (@yy_input.pos = yy_varm0; yy_string("\u{85}")) or (@yy_input.pos = yy_varm0; yy_string("\u{a0}")) or (@yy_input.pos = yy_varm0; yy_string("\u{1680}")) or (@yy_input.pos = yy_varm0; yy_string("\u{180e}")) or (@yy_input.pos = yy_varm0; yy_char_range("\u{2000}", "\u{200a}")) or (@yy_input.pos = yy_varm0; yy_string("\u{2028}")) or (@yy_input.pos = yy_varm0; yy_string("\u{2029}")) or (@yy_input.pos = yy_varm0; yy_string("\u{202f}")) or (@yy_input.pos = yy_varm0; yy_string("\u{205f}")) or (@yy_input.pos = yy_varm0; yy_string("\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nontermm3 
val = :yy_nil 
begin; yy_varm2 = @yy_input.pos; (yy_string("\r") and yy_string("\n")) or (@yy_input.pos = yy_varm2; yy_string("\r")) or (@yy_input.pos = yy_varm2; yy_string("\n")) or (@yy_input.pos = yy_varm2; yy_string("\u{85}")) or (@yy_input.pos = yy_varm2; yy_string("\v")) or (@yy_input.pos = yy_varm2; yy_string("\f")) or (@yy_input.pos = yy_varm2; yy_string("\u{2028}")) or (@yy_input.pos = yy_varm2; yy_string("\u{2029}")); end and yy_to_pcv(val) 
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
