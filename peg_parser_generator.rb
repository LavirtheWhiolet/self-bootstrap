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
        x = yy_parse1 or raise YY_SyntaxError
      end
    
def yy_parse1 
val = :yy_nil 
yy_nontermh and yy_to_pcv(val) 
end 
def yy_nontermh 
val = :yy_nil 
(yy_nonterm5g and begin
      yy_var9 = @yy_input.pos
      if not (yy_nonterm2c and begin
      yy_var7 = @yy_input.pos
      while true
      yy_var6 = @yy_input.pos
      if not (not begin
      yy_var4 = @yy_input.pos
      yy_var5 = yy_nonterm2c
      @yy_input.pos = yy_var4
      yy_var5
    end and @yy_input.getc) then
        @yy_input.pos = yy_var6
        break true
      end
    end and begin
        yy_var8 = @yy_input.pos
        @yy_input.pos = yy_var7
        code = @yy_input.read(yy_var8 - yy_var7).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm2c and yy_nonterm5g and begin 
  print code  
 true 
 end) then
        @yy_input.pos = yy_var9
      end
      true
    end and begin
      yy_vara = yy_nonterm1t
      if yy_vara then
        r = yy_from_pcv(yy_vara)
      end
      yy_vara
    end and begin 
 
    main_method_code = code "#{r.first_value.method_name}"
    main_method_code = link(main_method_code, r)
    generate_parser_body(main_method_code)
   
 true 
 end and begin
      yy_varg = @yy_input.pos
      if not (yy_nonterm2c and begin
      yy_vare = @yy_input.pos
      while true
      yy_vard = @yy_input.pos
      if not @yy_input.getc then
        @yy_input.pos = yy_vard
        break true
      end
    end and begin
        yy_varf = @yy_input.pos
        @yy_input.pos = yy_vare
        code = @yy_input.read(yy_varf - yy_vare).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  print code  
 true 
 end) then
        @yy_input.pos = yy_varg
      end
      true
    end and @yy_input.eof?) and yy_to_pcv(val) 
end 
def yy_nontermk 
val = :yy_nil 
begin
      yy_varj = yy_nontermr
      if yy_varj then
        val = yy_from_pcv(yy_varj)
      end
      yy_varj
    end and yy_to_pcv(val) 
end 
def yy_nontermr 
val = :yy_nil 
(begin 
 
    single_expression = true
    remembered_pos_var = new_unique_variable_name
   
 true 
 end and begin
      yy_varm = @yy_input.pos
      if not yy_nonterm2v then
        @yy_input.pos = yy_varm
      end
      true
    end and begin
      yy_varn = yy_nontermx
      if yy_varn then
        val = yy_from_pcv(yy_varn)
      end
      yy_varn
    end and while true
      yy_varq = @yy_input.pos
      if not (yy_nonterm2v and begin
      yy_varp = yy_nontermx
      if yy_varp then
        val2 = yy_from_pcv(yy_varp)
      end
      yy_varp
    end and begin 
 
      single_expression = false
      val = val + (code " or (@yy_input.pos = #{remembered_pos_var}; ") + val2 + (code ")")
     
 true 
 end) then
        @yy_input.pos = yy_varq
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "begin; #{remembered_pos_var} = @yy_input.pos; ") + val + (code "; end")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermx 
val = :yy_nil 
(begin 
  single_expression = true  
 true 
 end and begin
      yy_vart = yy_nonterm12
      if yy_vart then
        val = yy_from_pcv(yy_vart)
      end
      yy_vart
    end and while true
      yy_varw = @yy_input.pos
      if not (begin
      yy_varv = yy_nonterm12
      if yy_varv then
        val2 = yy_from_pcv(yy_varv)
      end
      yy_varv
    end and begin 
 
      single_expression = false
      val = val + (code " and ") + val2
     
 true 
 end) then
        @yy_input.pos = yy_varw
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "(") + val + (code ")")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm12 
val = :yy_nil 
begin; yy_vary = @yy_input.pos; (begin
      yy_varz = yy_nonterm3u
      if yy_varz then
        var = yy_from_pcv(yy_varz)
      end
      yy_varz
    end and yy_nonterm33 and begin
      yy_var10 = yy_nonterm12
      if yy_var10 then
        c = yy_from_pcv(yy_var10)
      end
      yy_var10
    end and begin 
  val = capture_semantic_value_code(var, c)  
 true 
 end) or (@yy_input.pos = yy_vary; begin
      yy_var11 = yy_nonterm17
      if yy_var11 then
        val = yy_from_pcv(yy_var11)
      end
      yy_var11
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm17 
val = :yy_nil 
begin; yy_var13 = @yy_input.pos; (yy_nonterm3f and begin
      yy_var14 = yy_nonterm17
      if yy_var14 then
        val = yy_from_pcv(yy_var14)
      end
      yy_var14
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end) or (@yy_input.pos = yy_var13; (yy_nonterm3h and begin
      yy_var15 = yy_nonterm17
      if yy_var15 then
        val = yy_from_pcv(yy_var15)
      end
      yy_var15
    end and begin 
  val = code(%(not )) + positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var13; begin
      yy_var16 = yy_nonterm1c
      if yy_var16 then
        val = yy_from_pcv(yy_var16)
      end
      yy_var16
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1c 
val = :yy_nil 
(begin
      yy_var19 = yy_nonterm1i
      if yy_var19 then
        val = yy_from_pcv(yy_var19)
      end
      yy_var19
    end and while true
      yy_var1b = @yy_input.pos
      if not begin; yy_var1a = @yy_input.pos; (yy_nonterm39 and begin 
  val = repeat_many_times_code(val)  
 true 
 end) or (@yy_input.pos = yy_var1a; (yy_nonterm3d and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1a; (yy_nonterm3b and begin 
  val = optional_code(val)  
 true 
 end)); end then
        @yy_input.pos = yy_var1b
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm1i 
val = :yy_nil 
begin; yy_var1d = @yy_input.pos; (yy_nonterm2z and begin
      yy_var1e = yy_nontermk
      if yy_var1e then
        val = yy_from_pcv(yy_var1e)
      end
      yy_var1e
    end and yy_nonterm31) or (@yy_input.pos = yy_var1d; (begin
      yy_var1f = yy_nonterm3u
      if yy_var1f then
        var = yy_from_pcv(yy_var1f)
      end
      yy_var1f
    end and yy_nonterm33 and yy_nonterm35 and begin
      yy_var1g = yy_nontermk
      if yy_var1g then
        c = yy_from_pcv(yy_var1g)
      end
      yy_var1g
    end and yy_nonterm37 and begin 
  val = capture_text_code(var, c)  
 true 
 end)) or (@yy_input.pos = yy_var1d; begin
      yy_var1h = yy_nonterm1o
      if yy_var1h then
        val = yy_from_pcv(yy_var1h)
      end
      yy_var1h
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1o 
val = :yy_nil 
begin; yy_var1j = @yy_input.pos; (begin
      yy_var1k = yy_nonterm4o
      if yy_var1k then
        r = yy_from_pcv(yy_var1k)
      end
      yy_var1k
    end and begin 
  val = code "yy_char_range(#{r.begin.dump}, #{r.end.dump})"  
 true 
 end) or (@yy_input.pos = yy_var1j; (begin
      yy_var1l = yy_nonterm55
      if yy_var1l then
        s = yy_from_pcv(yy_var1l)
      end
      yy_var1l
    end and begin 
  val = code "yy_string(#{s.dump})"  
 true 
 end)) or (@yy_input.pos = yy_var1j; (begin
      yy_var1m = yy_nonterm4f
      if yy_var1m then
        n = yy_from_pcv(yy_var1m)
      end
      yy_var1m
    end and begin 
  val = UnknownCode[n]  
 true 
 end)) or (@yy_input.pos = yy_var1j; (yy_nonterm3l and begin 
  val = code "@yy_input.getc"  
 true 
 end)) or (@yy_input.pos = yy_var1j; (begin
      yy_var1n = yy_nonterm2h
      if yy_var1n then
        a = yy_from_pcv(yy_var1n)
      end
      yy_var1n
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (@yy_input.pos = yy_var1j; (yy_nonterm2x and begin 
  val = code "@yy_input.eof?"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm1t 
val = :yy_nil 
(begin 
  val = HashMap1.new  
 true 
 end and (begin
      yy_var1r = yy_nonterm1z
      if yy_var1r then
        r = yy_from_pcv(yy_var1r)
      end
      yy_var1r
    end and begin 
 
      nonterminal, definition = *r
      raise %(rule "#{nonterminal}" is already defined) if val.has_key? nonterminal
      val[nonterminal] = definition
     
 true 
 end) and while true
      yy_var1s = @yy_input.pos
      if not (begin
      yy_var1r = yy_nonterm1z
      if yy_var1r then
        r = yy_from_pcv(yy_var1r)
      end
      yy_var1r
    end and begin 
 
      nonterminal, definition = *r
      raise %(rule "#{nonterminal}" is already defined) if val.has_key? nonterminal
      val[nonterminal] = definition
     
 true 
 end) then
        @yy_input.pos = yy_var1s
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm1z 
val = :yy_nil 
(begin
      yy_var1v = yy_nonterm4f
      if yy_var1v then
        n = yy_from_pcv(yy_var1v)
      end
      yy_var1v
    end and begin
      yy_var1x = @yy_input.pos
      if not (yy_nonterm33 and yy_nonterm26) then
        @yy_input.pos = yy_var1x
      end
      true
    end and yy_nonterm2r and begin
      yy_var1y = yy_nontermk
      if yy_var1y then
        c = yy_from_pcv(yy_var1y)
      end
      yy_var1y
    end and yy_nonterm2t and begin 
  val = [n, to_method_definition(c, new_unique_nonterminal_method_name)]  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm26 
val = :yy_nil 
((not begin
      yy_var23 = @yy_input.pos
      yy_var24 = yy_nonterm2r
      @yy_input.pos = yy_var23
      yy_var24
    end and @yy_input.getc) and yy_nonterm5g) and while true
      yy_var25 = @yy_input.pos
      if not ((not begin
      yy_var23 = @yy_input.pos
      yy_var24 = yy_nonterm2r
      @yy_input.pos = yy_var23
      yy_var24
    end and @yy_input.getc) and yy_nonterm5g) then
        @yy_input.pos = yy_var25
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm2c 
val = :yy_nil 
(yy_string("%%") and while true
      yy_var2b = @yy_input.pos
      if not (not begin
      yy_var29 = @yy_input.pos
      yy_var2a = yy_nonterm5r
      @yy_input.pos = yy_var29
      yy_var2a
    end and @yy_input.getc) then
        @yy_input.pos = yy_var2b
        break true
      end
    end and yy_nonterm5r) and yy_to_pcv(val) 
end 
def yy_nonterm2h 
val = :yy_nil 
(begin
      yy_var2f = @yy_input.pos
      yy_nonterm2o and begin
        yy_var2g = @yy_input.pos
        @yy_input.pos = yy_var2f
        val = @yy_input.read(yy_var2g - yy_var2f).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm5g and begin 
  val = val[1...-1]  
 true 
 end and begin 
  RubyVM::InstructionSequence.compile(val)  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm2o 
val = :yy_nil 
(yy_string("{") and while true
      yy_var2n = @yy_input.pos
      if not (not begin
      yy_var2k = @yy_input.pos
      yy_var2l = yy_string("}")
      @yy_input.pos = yy_var2k
      yy_var2l
    end and begin; yy_var2m = @yy_input.pos; yy_nonterm2o or (@yy_input.pos = yy_var2m; @yy_input.getc); end) then
        @yy_input.pos = yy_var2n
        break true
      end
    end and yy_string("}")) and yy_to_pcv(val) 
end 
def yy_nonterm2r 
val = :yy_nil 
(begin; yy_var2q = @yy_input.pos; yy_string("<-") or (@yy_input.pos = yy_var2q; yy_string("=")) or (@yy_input.pos = yy_var2q; yy_string("\u{2190}")); end and yy_nonterm5g) and yy_to_pcv(val) 
end 
def yy_nonterm2t 
val = :yy_nil 
(yy_string(";") and yy_nonterm5g) and yy_to_pcv(val) 
end 
def yy_nonterm2v 
val = :yy_nil 
(yy_string("/") and yy_nonterm5g) and yy_to_pcv(val) 
end 
def yy_nonterm2x 
val = :yy_nil 
(yy_string("$") and yy_nonterm5g) and yy_to_pcv(val) 
end 
def yy_nonterm2z 
val = :yy_nil 
(yy_string("(") and yy_nonterm5g) and yy_to_pcv(val) 
end 
def yy_nonterm31 
val = :yy_nil 
(yy_string(")") and yy_nonterm5g) and yy_to_pcv(val) 
end 
def yy_nonterm33 
val = :yy_nil 
(yy_string(":") and yy_nonterm5g) and yy_to_pcv(val) 
end 
def yy_nonterm35 
val = :yy_nil 
(yy_string("<") and yy_nonterm5g) and yy_to_pcv(val) 
end 
def yy_nonterm37 
val = :yy_nil 
(yy_string(">") and yy_nonterm5g) and yy_to_pcv(val) 
end 
def yy_nonterm39 
val = :yy_nil 
(yy_string("*") and yy_nonterm5g) and yy_to_pcv(val) 
end 
def yy_nonterm3b 
val = :yy_nil 
(yy_string("?") and yy_nonterm5g) and yy_to_pcv(val) 
end 
def yy_nonterm3d 
val = :yy_nil 
(yy_string("+") and yy_nonterm5g) and yy_to_pcv(val) 
end 
def yy_nonterm3f 
val = :yy_nil 
(yy_string("&") and yy_nonterm5g) and yy_to_pcv(val) 
end 
def yy_nonterm3h 
val = :yy_nil 
(yy_string("!") and yy_nonterm5g) and yy_to_pcv(val) 
end 
def yy_nonterm3l 
val = :yy_nil 
(yy_string("char") and not begin
      yy_var3j = @yy_input.pos
      yy_var3k = yy_nonterm4j
      @yy_input.pos = yy_var3j
      yy_var3k
    end and yy_nonterm5g) and yy_to_pcv(val) 
end 
def yy_nonterm3n 
val = :yy_nil 
yy_nonterm3l and yy_to_pcv(val) 
end 
def yy_nonterm3u 
val = :yy_nil 
(begin
      yy_var3s = @yy_input.pos
      (yy_nonterm3w and while true
      yy_var3r = @yy_input.pos
      if not yy_nonterm3y then
        @yy_input.pos = yy_var3r
        break true
      end
    end) and begin
        yy_var3t = @yy_input.pos
        @yy_input.pos = yy_var3s
        val = @yy_input.read(yy_var3t - yy_var3s).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm5g) and yy_to_pcv(val) 
end 
def yy_nonterm3w 
val = :yy_nil 
begin; yy_var3v = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_var3v; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nonterm3y 
val = :yy_nil 
begin; yy_var3x = @yy_input.pos; yy_nonterm3w or (@yy_input.pos = yy_var3x; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nonterm4f 
val = :yy_nil 
(not begin
      yy_var40 = @yy_input.pos
      yy_var41 = yy_nonterm3n
      @yy_input.pos = yy_var40
      yy_var41
    end and begin; yy_var42 = @yy_input.pos; (begin
      yy_var46 = @yy_input.pos
      (yy_nonterm4h and while true
      yy_var45 = @yy_input.pos
      if not yy_nonterm4j then
        @yy_input.pos = yy_var45
        break true
      end
    end) and begin
        yy_var47 = @yy_input.pos
        @yy_input.pos = yy_var46
        val = @yy_input.read(yy_var47 - yy_var46).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm5g) or (@yy_input.pos = yy_var42; (begin
      yy_var4d = @yy_input.pos
      (yy_string("`") and while true
      yy_var4c = @yy_input.pos
      if not (not begin
      yy_var4a = @yy_input.pos
      yy_var4b = yy_string("`")
      @yy_input.pos = yy_var4a
      yy_var4b
    end and @yy_input.getc) then
        @yy_input.pos = yy_var4c
        break true
      end
    end and yy_string("`")) and begin
        yy_var4e = @yy_input.pos
        @yy_input.pos = yy_var4d
        val = @yy_input.read(yy_var4e - yy_var4d).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm5g)); end) and yy_to_pcv(val) 
end 
def yy_nonterm4h 
val = :yy_nil 
begin; yy_var4g = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_var4g; yy_char_range("A", "Z")) or (@yy_input.pos = yy_var4g; yy_string("-")) or (@yy_input.pos = yy_var4g; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nonterm4j 
val = :yy_nil 
begin; yy_var4i = @yy_input.pos; yy_nonterm4h or (@yy_input.pos = yy_var4i; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nonterm4o 
val = :yy_nil 
(begin
      yy_var4l = yy_nonterm55
      if yy_var4l then
        from = yy_from_pcv(yy_var4l)
      end
      yy_var4l
    end and begin; yy_var4m = @yy_input.pos; yy_string("...") or (@yy_input.pos = yy_var4m; yy_string("..")) or (@yy_input.pos = yy_var4m; yy_string("\u{2026}")) or (@yy_input.pos = yy_var4m; yy_string("\u{2025}")); end and begin
      yy_var4n = yy_nonterm55
      if yy_var4n then
        to = yy_from_pcv(yy_var4n)
      end
      yy_var4n
    end and yy_nonterm5g and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm55 
val = :yy_nil 
begin; yy_var4p = @yy_input.pos; (yy_string("'") and begin
      yy_var4v = @yy_input.pos
      while true
      yy_var4u = @yy_input.pos
      if not (not begin
      yy_var4s = @yy_input.pos
      yy_var4t = yy_string("'")
      @yy_input.pos = yy_var4s
      yy_var4t
    end and @yy_input.getc) then
        @yy_input.pos = yy_var4u
        break true
      end
    end and begin
        yy_var4w = @yy_input.pos
        @yy_input.pos = yy_var4v
        val = @yy_input.read(yy_var4w - yy_var4v).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("'") and yy_nonterm5g) or (@yy_input.pos = yy_var4p; (yy_string("\"") and begin
      yy_var52 = @yy_input.pos
      while true
      yy_var51 = @yy_input.pos
      if not (not begin
      yy_var4z = @yy_input.pos
      yy_var50 = yy_string("\"")
      @yy_input.pos = yy_var4z
      yy_var50
    end and @yy_input.getc) then
        @yy_input.pos = yy_var51
        break true
      end
    end and begin
        yy_var53 = @yy_input.pos
        @yy_input.pos = yy_var52
        val = @yy_input.read(yy_var53 - yy_var52).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("\"") and yy_nonterm5g)) or (@yy_input.pos = yy_var4p; (begin
      yy_var54 = yy_nonterm5c
      if yy_var54 then
        code = yy_from_pcv(yy_var54)
      end
      yy_var54
    end and yy_nonterm5g and begin 
  val = "" << code  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm5c 
val = :yy_nil 
(yy_string("U+") and begin
      yy_var5a = @yy_input.pos
      begin; yy_var58 = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_var58; yy_char_range("A", "F")); end and while true
      yy_var59 = @yy_input.pos
      if not begin; yy_var58 = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_var58; yy_char_range("A", "F")); end then
        @yy_input.pos = yy_var59
        break true
      end
    end and begin
        yy_var5b = @yy_input.pos
        @yy_input.pos = yy_var5a
        code = @yy_input.read(yy_var5b - yy_var5a).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm5g 
val = :yy_nil 
while true
      yy_var5f = @yy_input.pos
      if not begin; yy_var5e = @yy_input.pos; yy_nonterm5p or (@yy_input.pos = yy_var5e; yy_nonterm5n); end then
        @yy_input.pos = yy_var5f
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm5n 
val = :yy_nil 
(begin; yy_var5i = @yy_input.pos; yy_string("#") or (@yy_input.pos = yy_var5i; yy_string("--")); end and while true
      yy_var5m = @yy_input.pos
      if not (not begin
      yy_var5k = @yy_input.pos
      yy_var5l = yy_nonterm5r
      @yy_input.pos = yy_var5k
      yy_var5l
    end and @yy_input.getc) then
        @yy_input.pos = yy_var5m
        break true
      end
    end and yy_nonterm5r) and yy_to_pcv(val) 
end 
def yy_nonterm5p 
val = :yy_nil 
begin; yy_var5o = @yy_input.pos; yy_char_range("\t", "\r") or (@yy_input.pos = yy_var5o; yy_string(" ")) or (@yy_input.pos = yy_var5o; yy_string("\u{85}")) or (@yy_input.pos = yy_var5o; yy_string("\u{a0}")) or (@yy_input.pos = yy_var5o; yy_string("\u{1680}")) or (@yy_input.pos = yy_var5o; yy_string("\u{180e}")) or (@yy_input.pos = yy_var5o; yy_char_range("\u{2000}", "\u{200a}")) or (@yy_input.pos = yy_var5o; yy_string("\u{2028}")) or (@yy_input.pos = yy_var5o; yy_string("\u{2029}")) or (@yy_input.pos = yy_var5o; yy_string("\u{202f}")) or (@yy_input.pos = yy_var5o; yy_string("\u{205f}")) or (@yy_input.pos = yy_var5o; yy_string("\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nonterm5r 
val = :yy_nil 
begin; yy_var5q = @yy_input.pos; (yy_string("\r") and yy_string("\n")) or (@yy_input.pos = yy_var5q; yy_string("\r")) or (@yy_input.pos = yy_var5q; yy_string("\n")) or (@yy_input.pos = yy_var5q; yy_string("\u{85}")) or (@yy_input.pos = yy_var5q; yy_string("\v")) or (@yy_input.pos = yy_var5q; yy_string("\f")) or (@yy_input.pos = yy_var5q; yy_string("\u{2028}")) or (@yy_input.pos = yy_var5q; yy_string("\u{2029}")); end and yy_to_pcv(val) 
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
      #{start_pos_var} = @yy_input.pos
      )) +
      parsing_code + (code %( and begin
        #{end_pos_var} = @yy_input.pos
        @yy_input.pos = #{start_pos_var}
        #{variable_name} = @yy_input.read(#{end_pos_var} - #{start_pos_var}).force_encoding(Encoding::UTF_8)
      end
    end))
  end
  
  def generate_parser_body(code)
    
    code = to_method_definition(code, "yy_parse1")
    
    puts %(
      def yy_parse(input)
        @yy_input = input
        @yy_input.set_encoding("UTF-8", "UTF-8")
        x = yy_parse1 or raise YY_SyntaxError
      end
    )
    
    puts code.definitions_to_s
    
    puts %(
      
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
  def link(code, nonterminal_to_definition)
    # Add all definitions to the code.
    nonterminal_to_definition.values.each do |definition|
      code += definition
    end
    # Replace all unknown codes with corresponding method calls (where
    # possible).
    nonterminal_to_definition.each do |nonterminal, definition|
      code = code.replace_unknown_code(nonterminal, (code definition.method_name))
    end
    #
    return code
  end
  
  def to_method_definition(code, method_name)
    Definition[
      method_name,
      code("def #{method_name} \n") +
        code("val = :yy_nil \n") +
        code + code(" and yy_to_pcv(val) \n") +
      code("end \n")
    ]
  end
  
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
    
    def definitions_to_s
      ""
    end
    
    # 
    # returns this Code with UnknownCode-s having specified
    # UnknownCode#nonterminal (+nonterminal+) replaced with +code+.
    # 
    def replace_unknown_code(nonterminal, code)
      return self
    end
    
    # Non-overridable.
    def + other
      CodeConcatenation.new([self, other])
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
    
    def replace_unknown_code(nonterminal, code)
      CodeConcatenation.new(@parts.map { |part| part.replace_unknown_code(nonterminal, code) })
    end
    
    def to_s
      @parts.map { |part| part.to_s }.join
    end
    
    def definitions_to_s
      @parts.map { |part| part.definitions_to_s }.join
    end
    
    def + other
      # Optimization.
      CodeConcatenation.new([*@parts, other])
    end
    
    def inspect
      "#<CodeConcatenation: #{@parts.map { |p| p.inspect }.join(", ")}>"
    end
    
  end
  
  class UnknownCode < Code
    
    class << self
      
      alias [] new
      
    end
    
    def initialize(nonterminal)
      @nonterminal = nonterminal
    end
    
    # Nonterminal associated with this UnknownCode.
    attr_reader :nonterminal
    
    def replace_unknown_code(nonterminal, code)
      if self.nonterminal == nonterminal then code
      else self
      end
    end
    
    def to_s
      raise UnknownCodeEncountered, self
    end
    
    def inspect
      "#<UnknownCode: @nonterminal=#{@nonterminal.inspect}>"
    end
    
  end
  
  class UnknownCodeEncountered < Exception
    
    def initialize(code)
      super %(unknown code with nonterminal #{code.nonterminal} is encountered)
      @code = code
    end
    
    attr_reader :code
    
  end
  
  # A code which goes to "definitions" section.
  class Definition < Code
    
    class << self
      
      alias [] new
      
    end
    
    def initialize(method_name, code)
      # Fix common errors.
      code = CodeAsString[code] if code.is_a? String
      # 
      @code = code
      @method_name = method_name
    end
    
    def replace_unknown_code(nonterminal, code)
      Definition.new(@method_name, @code.replace_unknown_code(nonterminal, code))
    end
    
    def to_s
      ""
    end
    
    # Method name associated with this Definition.
    attr_reader :method_name
    
    def definitions_to_s
      @code.to_s + @code.definitions_to_s
    end
    
    def inspect
      "#<Definition: #{@code.inspect}>"
    end
    
  end
  
  class HashMap1 < HashMap
    
    def initialize(*args, &block)
      super(*args, &block)
      @first_value = nil
    end
    
    def []=(key, value)
      raise %(value can not be nil) if value.nil?
      @first_value ||= value
      super(key, value)
    end
    
    attr_reader :first_value
    
  end
  
end


if $0 == __FILE__
  File.open(ARGV[0]) do |io|
    PEGParserGenerator.new.call(io)
  end
end
