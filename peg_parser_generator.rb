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
 end and yy_nonterm5v() and while true
      yy_var4 = @yy_input.pos
      if not begin; yy_var1 = @yy_input.pos; (begin
      yy_var2 = yy_nonterm1j()
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
      yy_var3 = yy_nonterm2w()
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
      if not yy_nonterm3a() then
        @yy_input.pos = yy_vara
      end
      true
    end and begin
      yy_varb = yy_nonterml()
      if yy_varb then
        val = yy_from_pcv(yy_varb)
      end
      yy_varb
    end and while true
      yy_vare = @yy_input.pos
      if not (yy_nonterm3a() and begin
      yy_vard = yy_nonterml()
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
def yy_nonterml 
val = :yy_nil 
(begin 
  single_expression = true  
 true 
 end and begin
      yy_varh = yy_nontermq()
      if yy_varh then
        val = yy_from_pcv(yy_varh)
      end
      yy_varh
    end and while true
      yy_vark = @yy_input.pos
      if not (begin
      yy_varj = yy_nontermq()
      if yy_varj then
        val2 = yy_from_pcv(yy_varj)
      end
      yy_varj
    end and begin 
 
      single_expression = false
      val = val + (code " and ") + val2
     
 true 
 end) then
        @yy_input.pos = yy_vark
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "(") + val + (code ")")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermq 
val = :yy_nil 
begin; yy_varm = @yy_input.pos; (begin
      yy_varn = yy_nonterm49()
      if yy_varn then
        var = yy_from_pcv(yy_varn)
      end
      yy_varn
    end and yy_nonterm3i() and begin
      yy_varo = yy_nontermq()
      if yy_varo then
        c = yy_from_pcv(yy_varo)
      end
      yy_varo
    end and begin 
  val = capture_semantic_value_code(var, c)  
 true 
 end) or (@yy_input.pos = yy_varm; begin
      yy_varp = yy_nontermw()
      if yy_varp then
        val = yy_from_pcv(yy_varp)
      end
      yy_varp
    end); end and yy_to_pcv(val) 
end 
def yy_nontermw 
val = :yy_nil 
begin; yy_varr = @yy_input.pos; (yy_nonterm3u() and begin
      yy_vars = yy_nonterm2w()
      if yy_vars then
        c = yy_from_pcv(yy_vars)
      end
      yy_vars
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (@yy_input.pos = yy_varr; (yy_nonterm3u() and begin
      yy_vart = yy_nontermw()
      if yy_vart then
        val = yy_from_pcv(yy_vart)
      end
      yy_vart
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_varr; (yy_nonterm3w() and begin
      yy_varu = yy_nontermw()
      if yy_varu then
        val = yy_from_pcv(yy_varu)
      end
      yy_varu
    end and begin 
  val = code(%(not )) + positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_varr; begin
      yy_varv = yy_nonterm11()
      if yy_varv then
        val = yy_from_pcv(yy_varv)
      end
      yy_varv
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm11 
val = :yy_nil 
(begin
      yy_vary = yy_nonterm17()
      if yy_vary then
        val = yy_from_pcv(yy_vary)
      end
      yy_vary
    end and while true
      yy_var10 = @yy_input.pos
      if not begin; yy_varz = @yy_input.pos; (yy_nonterm3o() and begin 
  val = repeat_many_times_code(val)  
 true 
 end) or (@yy_input.pos = yy_varz; (yy_nonterm3s() and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (@yy_input.pos = yy_varz; (yy_nonterm3q() and begin 
  val = optional_code(val)  
 true 
 end)); end then
        @yy_input.pos = yy_var10
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm17 
val = :yy_nil 
begin; yy_var12 = @yy_input.pos; (yy_nonterm3e() and begin
      yy_var13 = yy_nonterm8()
      if yy_var13 then
        val = yy_from_pcv(yy_var13)
      end
      yy_var13
    end and yy_nonterm3g()) or (@yy_input.pos = yy_var12; (begin
      yy_var14 = yy_nonterm49()
      if yy_var14 then
        var = yy_from_pcv(yy_var14)
      end
      yy_var14
    end and yy_nonterm3i() and yy_nonterm3k() and begin
      yy_var15 = yy_nonterm8()
      if yy_var15 then
        c = yy_from_pcv(yy_var15)
      end
      yy_var15
    end and yy_nonterm3m() and begin 
  val = capture_text_code(var, c)  
 true 
 end)) or (@yy_input.pos = yy_var12; begin
      yy_var16 = yy_nonterm1d()
      if yy_var16 then
        val = yy_from_pcv(yy_var16)
      end
      yy_var16
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1d 
val = :yy_nil 
begin; yy_var18 = @yy_input.pos; (begin
      yy_var19 = yy_nonterm53()
      if yy_var19 then
        r = yy_from_pcv(yy_var19)
      end
      yy_var19
    end and begin 
  val = code "yy_char_range(#{r.begin.dump}, #{r.end.dump})"  
 true 
 end) or (@yy_input.pos = yy_var18; (begin
      yy_var1a = yy_nonterm5k()
      if yy_var1a then
        s = yy_from_pcv(yy_var1a)
      end
      yy_var1a
    end and begin 
  val = code "yy_string(#{s.dump})"  
 true 
 end)) or (@yy_input.pos = yy_var18; (begin
      yy_var1b = yy_nonterm4u()
      if yy_var1b then
        n = yy_from_pcv(yy_var1b)
      end
      yy_var1b
    end and begin 
  val = UnknownMethodCall[n]  
 true 
 end)) or (@yy_input.pos = yy_var18; (yy_nonterm40() and begin 
  val = code "@yy_input.getc"  
 true 
 end)) or (@yy_input.pos = yy_var18; (begin
      yy_var1c = yy_nonterm2w()
      if yy_var1c then
        a = yy_from_pcv(yy_var1c)
      end
      yy_var1c
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (@yy_input.pos = yy_var18; (yy_nonterm3c() and begin 
  val = code "@yy_input.eof?"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm1j 
val = :yy_nil 
(begin
      yy_var1f = yy_nonterm4u()
      if yy_var1f then
        n = yy_from_pcv(yy_var1f)
      end
      yy_var1f
    end and begin
      yy_var1h = @yy_input.pos
      if not (yy_nonterm3i() and yy_nonterm1q()) then
        @yy_input.pos = yy_var1h
      end
      true
    end and yy_nonterm36() and begin
      yy_var1i = yy_nonterm8()
      if yy_var1i then
        c = yy_from_pcv(yy_var1i)
      end
      yy_var1i
    end and yy_nonterm38() and begin 
 
    method_name = new_unique_nonterminal_method_name
    val = [n, method_name, to_method_definition(c, method_name)]
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm1q 
val = :yy_nil 
((not begin
      yy_var1n = @yy_input.pos
      yy_var1o = yy_nonterm36()
      @yy_input.pos = yy_var1n
      yy_var1o
    end and @yy_input.getc) and yy_nonterm5v()) and while true
      yy_var1p = @yy_input.pos
      if not ((not begin
      yy_var1n = @yy_input.pos
      yy_var1o = yy_nonterm36()
      @yy_input.pos = yy_var1n
      yy_var1o
    end and @yy_input.getc) and yy_nonterm5v()) then
        @yy_input.pos = yy_var1p
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm1w 
val = :yy_nil 
(yy_string("%%") and while true
      yy_var1v = @yy_input.pos
      if not (not begin
      yy_var1t = @yy_input.pos
      yy_var1u = yy_nonterm66()
      @yy_input.pos = yy_var1t
      yy_var1u
    end and @yy_input.getc) then
        @yy_input.pos = yy_var1v
        break true
      end
    end and yy_nonterm66()) and yy_to_pcv(val) 
end 
def yy_nonterm2w 
val = :yy_nil 
(begin; yy_var1y = @yy_input.pos; (yy_string("{") and while true
      yy_var1z = @yy_input.pos
      if not yy_nonterm64() then
        @yy_input.pos = yy_var1z
        break true
      end
    end and yy_string("...") and begin
      yy_var25 = @yy_input.pos
      if not (while true
      yy_var24 = @yy_input.pos
      if not (not begin
      yy_var22 = @yy_input.pos
      yy_var23 = yy_nonterm66()
      @yy_input.pos = yy_var22
      yy_var23
    end and yy_nonterm64()) then
        @yy_input.pos = yy_var24
        break true
      end
    end and yy_nonterm66()) then
        @yy_input.pos = yy_var25
      end
      true
    end and begin
      val = ""
      yy_var2d = @yy_input.pos
      while true
      yy_var2c = @yy_input.pos
      if not (not begin
      yy_var2a = @yy_input.pos
      yy_var2b = (yy_string("...") and while true
      yy_var29 = @yy_input.pos
      if not yy_nonterm64() then
        @yy_input.pos = yy_var29
        break true
      end
    end and yy_string("}"))
      @yy_input.pos = yy_var2a
      yy_var2b
    end and @yy_input.getc) then
        @yy_input.pos = yy_var2c
        break true
      end
    end and begin
        yy_var2e = @yy_input.pos
        @yy_input.pos = yy_var2d
        val << @yy_input.read(yy_var2e - yy_var2d).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("...") and while true
      yy_var2f = @yy_input.pos
      if not yy_nonterm64() then
        @yy_input.pos = yy_var2f
        break true
      end
    end and yy_string("}")) or (@yy_input.pos = yy_var1y; (begin
      val = ""
      yy_var2h = @yy_input.pos
      yy_nonterm33() and begin
        yy_var2i = @yy_input.pos
        @yy_input.pos = yy_var2h
        val << @yy_input.read(yy_var2i - yy_var2h).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = val[1...-1]  
 true 
 end)) or (@yy_input.pos = yy_var1y; (yy_nonterm1w() and begin
      val = ""
      yy_var2p = @yy_input.pos
      while true
      yy_var2o = @yy_input.pos
      if not (not begin
      yy_var2m = @yy_input.pos
      yy_var2n = yy_nonterm1w()
      @yy_input.pos = yy_var2m
      yy_var2n
    end and @yy_input.getc) then
        @yy_input.pos = yy_var2o
        break true
      end
    end and begin
        yy_var2q = @yy_input.pos
        @yy_input.pos = yy_var2p
        val << @yy_input.read(yy_var2q - yy_var2p).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm1w())) or (@yy_input.pos = yy_var1y; (yy_nonterm1w() and begin
      val = ""
      yy_var2u = @yy_input.pos
      while true
      yy_var2t = @yy_input.pos
      if not @yy_input.getc then
        @yy_input.pos = yy_var2t
        break true
      end
    end and begin
        yy_var2v = @yy_input.pos
        @yy_input.pos = yy_var2u
        val << @yy_input.read(yy_var2v - yy_var2u).force_encoding(Encoding::UTF_8)
      end
    end and @yy_input.eof?)); end and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm33 
val = :yy_nil 
(yy_string("{") and while true
      yy_var32 = @yy_input.pos
      if not (not begin
      yy_var2z = @yy_input.pos
      yy_var30 = yy_string("}")
      @yy_input.pos = yy_var2z
      yy_var30
    end and begin; yy_var31 = @yy_input.pos; yy_nonterm33() or (@yy_input.pos = yy_var31; @yy_input.getc); end) then
        @yy_input.pos = yy_var32
        break true
      end
    end and yy_string("}")) and yy_to_pcv(val) 
end 
def yy_nonterm36 
val = :yy_nil 
(begin; yy_var35 = @yy_input.pos; yy_string("<-") or (@yy_input.pos = yy_var35; yy_string("=")) or (@yy_input.pos = yy_var35; yy_string("\u{2190}")); end and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm38 
val = :yy_nil 
(yy_string(";") and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm3a 
val = :yy_nil 
(yy_string("/") and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm3c 
val = :yy_nil 
(yy_string("$") and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm3e 
val = :yy_nil 
(yy_string("(") and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm3g 
val = :yy_nil 
(yy_string(")") and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm3i 
val = :yy_nil 
(yy_string(":") and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm3k 
val = :yy_nil 
(yy_string("<") and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm3m 
val = :yy_nil 
(yy_string(">") and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm3o 
val = :yy_nil 
(yy_string("*") and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm3q 
val = :yy_nil 
(yy_string("?") and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm3s 
val = :yy_nil 
(yy_string("+") and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm3u 
val = :yy_nil 
(yy_string("&") and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm3w 
val = :yy_nil 
(yy_string("!") and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm40 
val = :yy_nil 
(yy_string("char") and not begin
      yy_var3y = @yy_input.pos
      yy_var3z = yy_nonterm4y()
      @yy_input.pos = yy_var3y
      yy_var3z
    end and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm42 
val = :yy_nil 
yy_nonterm40() and yy_to_pcv(val) 
end 
def yy_nonterm49 
val = :yy_nil 
(begin
      val = ""
      yy_var47 = @yy_input.pos
      (yy_nonterm4b() and while true
      yy_var46 = @yy_input.pos
      if not yy_nonterm4d() then
        @yy_input.pos = yy_var46
        break true
      end
    end) and begin
        yy_var48 = @yy_input.pos
        @yy_input.pos = yy_var47
        val << @yy_input.read(yy_var48 - yy_var47).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm5v()) and yy_to_pcv(val) 
end 
def yy_nonterm4b 
val = :yy_nil 
begin; yy_var4a = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_var4a; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nonterm4d 
val = :yy_nil 
begin; yy_var4c = @yy_input.pos; yy_nonterm4b() or (@yy_input.pos = yy_var4c; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nonterm4u 
val = :yy_nil 
(not begin
      yy_var4f = @yy_input.pos
      yy_var4g = yy_nonterm42()
      @yy_input.pos = yy_var4f
      yy_var4g
    end and begin; yy_var4h = @yy_input.pos; (begin
      val = ""
      yy_var4l = @yy_input.pos
      (yy_nonterm4w() and while true
      yy_var4k = @yy_input.pos
      if not yy_nonterm4y() then
        @yy_input.pos = yy_var4k
        break true
      end
    end) and begin
        yy_var4m = @yy_input.pos
        @yy_input.pos = yy_var4l
        val << @yy_input.read(yy_var4m - yy_var4l).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm5v()) or (@yy_input.pos = yy_var4h; (begin
      val = ""
      yy_var4s = @yy_input.pos
      (yy_string("`") and while true
      yy_var4r = @yy_input.pos
      if not (not begin
      yy_var4p = @yy_input.pos
      yy_var4q = yy_string("`")
      @yy_input.pos = yy_var4p
      yy_var4q
    end and @yy_input.getc) then
        @yy_input.pos = yy_var4r
        break true
      end
    end and yy_string("`")) and begin
        yy_var4t = @yy_input.pos
        @yy_input.pos = yy_var4s
        val << @yy_input.read(yy_var4t - yy_var4s).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm5v())); end) and yy_to_pcv(val) 
end 
def yy_nonterm4w 
val = :yy_nil 
begin; yy_var4v = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_var4v; yy_char_range("A", "Z")) or (@yy_input.pos = yy_var4v; yy_string("-")) or (@yy_input.pos = yy_var4v; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nonterm4y 
val = :yy_nil 
begin; yy_var4x = @yy_input.pos; yy_nonterm4w() or (@yy_input.pos = yy_var4x; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nonterm53 
val = :yy_nil 
(begin
      yy_var50 = yy_nonterm5k()
      if yy_var50 then
        from = yy_from_pcv(yy_var50)
      end
      yy_var50
    end and begin; yy_var51 = @yy_input.pos; yy_string("...") or (@yy_input.pos = yy_var51; yy_string("..")) or (@yy_input.pos = yy_var51; yy_string("\u{2026}")) or (@yy_input.pos = yy_var51; yy_string("\u{2025}")); end and yy_nonterm5v() and begin
      yy_var52 = yy_nonterm5k()
      if yy_var52 then
        to = yy_from_pcv(yy_var52)
      end
      yy_var52
    end and yy_nonterm5v() and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm5k 
val = :yy_nil 
begin; yy_var54 = @yy_input.pos; (yy_string("'") and begin
      val = ""
      yy_var5a = @yy_input.pos
      while true
      yy_var59 = @yy_input.pos
      if not (not begin
      yy_var57 = @yy_input.pos
      yy_var58 = yy_string("'")
      @yy_input.pos = yy_var57
      yy_var58
    end and @yy_input.getc) then
        @yy_input.pos = yy_var59
        break true
      end
    end and begin
        yy_var5b = @yy_input.pos
        @yy_input.pos = yy_var5a
        val << @yy_input.read(yy_var5b - yy_var5a).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("'") and yy_nonterm5v()) or (@yy_input.pos = yy_var54; (yy_string("\"") and begin
      val = ""
      yy_var5h = @yy_input.pos
      while true
      yy_var5g = @yy_input.pos
      if not (not begin
      yy_var5e = @yy_input.pos
      yy_var5f = yy_string("\"")
      @yy_input.pos = yy_var5e
      yy_var5f
    end and @yy_input.getc) then
        @yy_input.pos = yy_var5g
        break true
      end
    end and begin
        yy_var5i = @yy_input.pos
        @yy_input.pos = yy_var5h
        val << @yy_input.read(yy_var5i - yy_var5h).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("\"") and yy_nonterm5v())) or (@yy_input.pos = yy_var54; (begin
      yy_var5j = yy_nonterm5r()
      if yy_var5j then
        code = yy_from_pcv(yy_var5j)
      end
      yy_var5j
    end and yy_nonterm5v() and begin 
  val = "" << code  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm5r 
val = :yy_nil 
(yy_string("U+") and begin
      code = ""
      yy_var5p = @yy_input.pos
      begin; yy_var5n = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_var5n; yy_char_range("A", "F")); end and while true
      yy_var5o = @yy_input.pos
      if not begin; yy_var5n = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_var5n; yy_char_range("A", "F")); end then
        @yy_input.pos = yy_var5o
        break true
      end
    end and begin
        yy_var5q = @yy_input.pos
        @yy_input.pos = yy_var5p
        code << @yy_input.read(yy_var5q - yy_var5p).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm5v 
val = :yy_nil 
while true
      yy_var5u = @yy_input.pos
      if not begin; yy_var5t = @yy_input.pos; yy_nonterm64() or (@yy_input.pos = yy_var5t; yy_nonterm62()); end then
        @yy_input.pos = yy_var5u
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm62 
val = :yy_nil 
(begin; yy_var5x = @yy_input.pos; yy_string("#") or (@yy_input.pos = yy_var5x; yy_string("--")); end and while true
      yy_var61 = @yy_input.pos
      if not (not begin
      yy_var5z = @yy_input.pos
      yy_var60 = yy_nonterm66()
      @yy_input.pos = yy_var5z
      yy_var60
    end and @yy_input.getc) then
        @yy_input.pos = yy_var61
        break true
      end
    end and yy_nonterm66()) and yy_to_pcv(val) 
end 
def yy_nonterm64 
val = :yy_nil 
begin; yy_var63 = @yy_input.pos; yy_char_range("\t", "\r") or (@yy_input.pos = yy_var63; yy_string(" ")) or (@yy_input.pos = yy_var63; yy_string("\u{85}")) or (@yy_input.pos = yy_var63; yy_string("\u{a0}")) or (@yy_input.pos = yy_var63; yy_string("\u{1680}")) or (@yy_input.pos = yy_var63; yy_string("\u{180e}")) or (@yy_input.pos = yy_var63; yy_char_range("\u{2000}", "\u{200a}")) or (@yy_input.pos = yy_var63; yy_string("\u{2028}")) or (@yy_input.pos = yy_var63; yy_string("\u{2029}")) or (@yy_input.pos = yy_var63; yy_string("\u{202f}")) or (@yy_input.pos = yy_var63; yy_string("\u{205f}")) or (@yy_input.pos = yy_var63; yy_string("\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nonterm66 
val = :yy_nil 
begin; yy_var65 = @yy_input.pos; (yy_string("\r") and yy_string("\n")) or (@yy_input.pos = yy_var65; yy_string("\r")) or (@yy_input.pos = yy_var65; yy_string("\n")) or (@yy_input.pos = yy_var65; yy_string("\u{85}")) or (@yy_input.pos = yy_var65; yy_string("\v")) or (@yy_input.pos = yy_var65; yy_string("\f")) or (@yy_input.pos = yy_var65; yy_string("\u{2028}")) or (@yy_input.pos = yy_var65; yy_string("\u{2029}")); end and yy_to_pcv(val) 
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
  
  # returns code which captures text to specified variable.
  def capture_text_code(variable_name, parsing_code)
    #
    start_pos_var = new_unique_variable_name
    end_pos_var = new_unique_variable_name
    # 
    (code %(begin
      #{variable_name} = ""
      #{start_pos_var} = @yy_input.pos
      )) +
      parsing_code + (code %( and begin
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
  
  # 
  # The Code consists of 2 parts: the code as such (which can be got with #to_s)
  # and code of definitions (which can be got with #definitions_to_s).
  # 
  # Abstract.
  # 
  class Code
    
    # defines abstract method.
    def self.abstract(method)
      define_method(method) { |*args| raise %(method `#{method}' is abstract) }
    end
    
    abstract :to_s
    
    # Non-overridable.
    def + other
      CodeConcatenation.new([self, other])
    end
    
    # +block+ is passed with every Code this Code comprises.
    def map(&block)
      block.(self)
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
      raise UnknownMethodCallEncountered, self
    end
    
    def inspect
      "#<UnknownMethodCall: @nonterminal=#{@nonterminal.inspect}>"
    end
    
  end
  
  class UnknownMethodCallEncountered < Exception
    
    def initialize(method_call)
      super %(unknown method call with associated nonterminal #{code.nonterminal} is encountered)
      @method_call = method_call
    end
    
    attr_reader :method_call
    
  end
  
end


if $0 == __FILE__
  File.open(ARGV[0]) do |io|
    PEGParserGenerator.new.call(io)
  end
end
