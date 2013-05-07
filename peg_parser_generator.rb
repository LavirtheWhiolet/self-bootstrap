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
(yy_nonterm5h and begin
      yy_var9 = @yy_input.pos
      if not (yy_nonterm2d and begin
      yy_var7 = @yy_input.pos
      while true
      yy_var6 = @yy_input.pos
      if not (not begin
      yy_var4 = @yy_input.pos
      yy_var5 = yy_nonterm2d
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
    end and yy_nonterm2d and yy_nonterm5h and begin 
  print code  
 true 
 end) then
        @yy_input.pos = yy_var9
      end
      true
    end and begin
      yy_vara = yy_nonterm1u
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
      if not (yy_nonterm2d and begin
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
      if not yy_nonterm2w then
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
      if not (yy_nonterm2w and begin
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
      yy_varz = yy_nonterm3v
      if yy_varz then
        var = yy_from_pcv(yy_varz)
      end
      yy_varz
    end and yy_nonterm34 and begin
      yy_var10 = yy_nonterm12
      if yy_var10 then
        c = yy_from_pcv(yy_var10)
      end
      yy_var10
    end and begin 
  val = capture_semantic_value_code(var, c)  
 true 
 end) or (@yy_input.pos = yy_vary; begin
      yy_var11 = yy_nonterm18
      if yy_var11 then
        val = yy_from_pcv(yy_var11)
      end
      yy_var11
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm18 
val = :yy_nil 
begin; yy_var13 = @yy_input.pos; (yy_nonterm3g and begin
      yy_var14 = yy_nonterm2i
      if yy_var14 then
        c = yy_from_pcv(yy_var14)
      end
      yy_var14
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (@yy_input.pos = yy_var13; (yy_nonterm3g and begin
      yy_var15 = yy_nonterm18
      if yy_var15 then
        val = yy_from_pcv(yy_var15)
      end
      yy_var15
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var13; (yy_nonterm3i and begin
      yy_var16 = yy_nonterm18
      if yy_var16 then
        val = yy_from_pcv(yy_var16)
      end
      yy_var16
    end and begin 
  val = code(%(not )) + positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var13; begin
      yy_var17 = yy_nonterm1d
      if yy_var17 then
        val = yy_from_pcv(yy_var17)
      end
      yy_var17
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1d 
val = :yy_nil 
(begin
      yy_var1a = yy_nonterm1j
      if yy_var1a then
        val = yy_from_pcv(yy_var1a)
      end
      yy_var1a
    end and while true
      yy_var1c = @yy_input.pos
      if not begin; yy_var1b = @yy_input.pos; (yy_nonterm3a and begin 
  val = repeat_many_times_code(val)  
 true 
 end) or (@yy_input.pos = yy_var1b; (yy_nonterm3e and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1b; (yy_nonterm3c and begin 
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
begin; yy_var1e = @yy_input.pos; (yy_nonterm30 and begin
      yy_var1f = yy_nontermk
      if yy_var1f then
        val = yy_from_pcv(yy_var1f)
      end
      yy_var1f
    end and yy_nonterm32) or (@yy_input.pos = yy_var1e; (begin
      yy_var1g = yy_nonterm3v
      if yy_var1g then
        var = yy_from_pcv(yy_var1g)
      end
      yy_var1g
    end and yy_nonterm34 and yy_nonterm36 and begin
      yy_var1h = yy_nontermk
      if yy_var1h then
        c = yy_from_pcv(yy_var1h)
      end
      yy_var1h
    end and yy_nonterm38 and begin 
  val = capture_text_code(var, c)  
 true 
 end)) or (@yy_input.pos = yy_var1e; begin
      yy_var1i = yy_nonterm1p
      if yy_var1i then
        val = yy_from_pcv(yy_var1i)
      end
      yy_var1i
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1p 
val = :yy_nil 
begin; yy_var1k = @yy_input.pos; (begin
      yy_var1l = yy_nonterm4p
      if yy_var1l then
        r = yy_from_pcv(yy_var1l)
      end
      yy_var1l
    end and begin 
  val = code "yy_char_range(#{r.begin.dump}, #{r.end.dump})"  
 true 
 end) or (@yy_input.pos = yy_var1k; (begin
      yy_var1m = yy_nonterm56
      if yy_var1m then
        s = yy_from_pcv(yy_var1m)
      end
      yy_var1m
    end and begin 
  val = code "yy_string(#{s.dump})"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (begin
      yy_var1n = yy_nonterm4g
      if yy_var1n then
        n = yy_from_pcv(yy_var1n)
      end
      yy_var1n
    end and begin 
  val = UnknownCode[n]  
 true 
 end)) or (@yy_input.pos = yy_var1k; (yy_nonterm3m and begin 
  val = code "@yy_input.getc"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (begin
      yy_var1o = yy_nonterm2i
      if yy_var1o then
        a = yy_from_pcv(yy_var1o)
      end
      yy_var1o
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (@yy_input.pos = yy_var1k; (yy_nonterm2y and begin 
  val = code "@yy_input.eof?"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm1u 
val = :yy_nil 
(begin 
  val = HashMap1.new  
 true 
 end and (begin
      yy_var1s = yy_nonterm20
      if yy_var1s then
        r = yy_from_pcv(yy_var1s)
      end
      yy_var1s
    end and begin 
 
      nonterminal, definition = *r
      raise %(rule "#{nonterminal}" is already defined) if val.has_key? nonterminal
      val[nonterminal] = definition
     
 true 
 end) and while true
      yy_var1t = @yy_input.pos
      if not (begin
      yy_var1s = yy_nonterm20
      if yy_var1s then
        r = yy_from_pcv(yy_var1s)
      end
      yy_var1s
    end and begin 
 
      nonterminal, definition = *r
      raise %(rule "#{nonterminal}" is already defined) if val.has_key? nonterminal
      val[nonterminal] = definition
     
 true 
 end) then
        @yy_input.pos = yy_var1t
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm20 
val = :yy_nil 
(begin
      yy_var1w = yy_nonterm4g
      if yy_var1w then
        n = yy_from_pcv(yy_var1w)
      end
      yy_var1w
    end and begin
      yy_var1y = @yy_input.pos
      if not (yy_nonterm34 and yy_nonterm27) then
        @yy_input.pos = yy_var1y
      end
      true
    end and yy_nonterm2s and begin
      yy_var1z = yy_nontermk
      if yy_var1z then
        c = yy_from_pcv(yy_var1z)
      end
      yy_var1z
    end and yy_nonterm2u and begin 
  val = [n, to_method_definition(c, new_unique_nonterminal_method_name)]  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm27 
val = :yy_nil 
((not begin
      yy_var24 = @yy_input.pos
      yy_var25 = yy_nonterm2s
      @yy_input.pos = yy_var24
      yy_var25
    end and @yy_input.getc) and yy_nonterm5h) and while true
      yy_var26 = @yy_input.pos
      if not ((not begin
      yy_var24 = @yy_input.pos
      yy_var25 = yy_nonterm2s
      @yy_input.pos = yy_var24
      yy_var25
    end and @yy_input.getc) and yy_nonterm5h) then
        @yy_input.pos = yy_var26
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm2d 
val = :yy_nil 
(yy_string("%%") and while true
      yy_var2c = @yy_input.pos
      if not (not begin
      yy_var2a = @yy_input.pos
      yy_var2b = yy_nonterm5s
      @yy_input.pos = yy_var2a
      yy_var2b
    end and @yy_input.getc) then
        @yy_input.pos = yy_var2c
        break true
      end
    end and yy_nonterm5s) and yy_to_pcv(val) 
end 
def yy_nonterm2i 
val = :yy_nil 
(begin
      yy_var2g = @yy_input.pos
      yy_nonterm2p and begin
        yy_var2h = @yy_input.pos
        @yy_input.pos = yy_var2g
        val = @yy_input.read(yy_var2h - yy_var2g).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm5h and begin 
  val = val[1...-1]  
 true 
 end and begin 
  RubyVM::InstructionSequence.compile(val)  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm2p 
val = :yy_nil 
(yy_string("{") and while true
      yy_var2o = @yy_input.pos
      if not (not begin
      yy_var2l = @yy_input.pos
      yy_var2m = yy_string("}")
      @yy_input.pos = yy_var2l
      yy_var2m
    end and begin; yy_var2n = @yy_input.pos; yy_nonterm2p or (@yy_input.pos = yy_var2n; @yy_input.getc); end) then
        @yy_input.pos = yy_var2o
        break true
      end
    end and yy_string("}")) and yy_to_pcv(val) 
end 
def yy_nonterm2s 
val = :yy_nil 
(begin; yy_var2r = @yy_input.pos; yy_string("<-") or (@yy_input.pos = yy_var2r; yy_string("=")) or (@yy_input.pos = yy_var2r; yy_string("\u{2190}")); end and yy_nonterm5h) and yy_to_pcv(val) 
end 
def yy_nonterm2u 
val = :yy_nil 
(yy_string(";") and yy_nonterm5h) and yy_to_pcv(val) 
end 
def yy_nonterm2w 
val = :yy_nil 
(yy_string("/") and yy_nonterm5h) and yy_to_pcv(val) 
end 
def yy_nonterm2y 
val = :yy_nil 
(yy_string("$") and yy_nonterm5h) and yy_to_pcv(val) 
end 
def yy_nonterm30 
val = :yy_nil 
(yy_string("(") and yy_nonterm5h) and yy_to_pcv(val) 
end 
def yy_nonterm32 
val = :yy_nil 
(yy_string(")") and yy_nonterm5h) and yy_to_pcv(val) 
end 
def yy_nonterm34 
val = :yy_nil 
(yy_string(":") and yy_nonterm5h) and yy_to_pcv(val) 
end 
def yy_nonterm36 
val = :yy_nil 
(yy_string("<") and yy_nonterm5h) and yy_to_pcv(val) 
end 
def yy_nonterm38 
val = :yy_nil 
(yy_string(">") and yy_nonterm5h) and yy_to_pcv(val) 
end 
def yy_nonterm3a 
val = :yy_nil 
(yy_string("*") and yy_nonterm5h) and yy_to_pcv(val) 
end 
def yy_nonterm3c 
val = :yy_nil 
(yy_string("?") and yy_nonterm5h) and yy_to_pcv(val) 
end 
def yy_nonterm3e 
val = :yy_nil 
(yy_string("+") and yy_nonterm5h) and yy_to_pcv(val) 
end 
def yy_nonterm3g 
val = :yy_nil 
(yy_string("&") and yy_nonterm5h) and yy_to_pcv(val) 
end 
def yy_nonterm3i 
val = :yy_nil 
(yy_string("!") and yy_nonterm5h) and yy_to_pcv(val) 
end 
def yy_nonterm3m 
val = :yy_nil 
(yy_string("char") and not begin
      yy_var3k = @yy_input.pos
      yy_var3l = yy_nonterm4k
      @yy_input.pos = yy_var3k
      yy_var3l
    end and yy_nonterm5h) and yy_to_pcv(val) 
end 
def yy_nonterm3o 
val = :yy_nil 
yy_nonterm3m and yy_to_pcv(val) 
end 
def yy_nonterm3v 
val = :yy_nil 
(begin
      yy_var3t = @yy_input.pos
      (yy_nonterm3x and while true
      yy_var3s = @yy_input.pos
      if not yy_nonterm3z then
        @yy_input.pos = yy_var3s
        break true
      end
    end) and begin
        yy_var3u = @yy_input.pos
        @yy_input.pos = yy_var3t
        val = @yy_input.read(yy_var3u - yy_var3t).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm5h) and yy_to_pcv(val) 
end 
def yy_nonterm3x 
val = :yy_nil 
begin; yy_var3w = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_var3w; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nonterm3z 
val = :yy_nil 
begin; yy_var3y = @yy_input.pos; yy_nonterm3x or (@yy_input.pos = yy_var3y; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nonterm4g 
val = :yy_nil 
(not begin
      yy_var41 = @yy_input.pos
      yy_var42 = yy_nonterm3o
      @yy_input.pos = yy_var41
      yy_var42
    end and begin; yy_var43 = @yy_input.pos; (begin
      yy_var47 = @yy_input.pos
      (yy_nonterm4i and while true
      yy_var46 = @yy_input.pos
      if not yy_nonterm4k then
        @yy_input.pos = yy_var46
        break true
      end
    end) and begin
        yy_var48 = @yy_input.pos
        @yy_input.pos = yy_var47
        val = @yy_input.read(yy_var48 - yy_var47).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm5h) or (@yy_input.pos = yy_var43; (begin
      yy_var4e = @yy_input.pos
      (yy_string("`") and while true
      yy_var4d = @yy_input.pos
      if not (not begin
      yy_var4b = @yy_input.pos
      yy_var4c = yy_string("`")
      @yy_input.pos = yy_var4b
      yy_var4c
    end and @yy_input.getc) then
        @yy_input.pos = yy_var4d
        break true
      end
    end and yy_string("`")) and begin
        yy_var4f = @yy_input.pos
        @yy_input.pos = yy_var4e
        val = @yy_input.read(yy_var4f - yy_var4e).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm5h)); end) and yy_to_pcv(val) 
end 
def yy_nonterm4i 
val = :yy_nil 
begin; yy_var4h = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_var4h; yy_char_range("A", "Z")) or (@yy_input.pos = yy_var4h; yy_string("-")) or (@yy_input.pos = yy_var4h; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nonterm4k 
val = :yy_nil 
begin; yy_var4j = @yy_input.pos; yy_nonterm4i or (@yy_input.pos = yy_var4j; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nonterm4p 
val = :yy_nil 
(begin
      yy_var4m = yy_nonterm56
      if yy_var4m then
        from = yy_from_pcv(yy_var4m)
      end
      yy_var4m
    end and begin; yy_var4n = @yy_input.pos; yy_string("...") or (@yy_input.pos = yy_var4n; yy_string("..")) or (@yy_input.pos = yy_var4n; yy_string("\u{2026}")) or (@yy_input.pos = yy_var4n; yy_string("\u{2025}")); end and begin
      yy_var4o = yy_nonterm56
      if yy_var4o then
        to = yy_from_pcv(yy_var4o)
      end
      yy_var4o
    end and yy_nonterm5h and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm56 
val = :yy_nil 
begin; yy_var4q = @yy_input.pos; (yy_string("'") and begin
      yy_var4w = @yy_input.pos
      while true
      yy_var4v = @yy_input.pos
      if not (not begin
      yy_var4t = @yy_input.pos
      yy_var4u = yy_string("'")
      @yy_input.pos = yy_var4t
      yy_var4u
    end and @yy_input.getc) then
        @yy_input.pos = yy_var4v
        break true
      end
    end and begin
        yy_var4x = @yy_input.pos
        @yy_input.pos = yy_var4w
        val = @yy_input.read(yy_var4x - yy_var4w).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("'") and yy_nonterm5h) or (@yy_input.pos = yy_var4q; (yy_string("\"") and begin
      yy_var53 = @yy_input.pos
      while true
      yy_var52 = @yy_input.pos
      if not (not begin
      yy_var50 = @yy_input.pos
      yy_var51 = yy_string("\"")
      @yy_input.pos = yy_var50
      yy_var51
    end and @yy_input.getc) then
        @yy_input.pos = yy_var52
        break true
      end
    end and begin
        yy_var54 = @yy_input.pos
        @yy_input.pos = yy_var53
        val = @yy_input.read(yy_var54 - yy_var53).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("\"") and yy_nonterm5h)) or (@yy_input.pos = yy_var4q; (begin
      yy_var55 = yy_nonterm5d
      if yy_var55 then
        code = yy_from_pcv(yy_var55)
      end
      yy_var55
    end and yy_nonterm5h and begin 
  val = "" << code  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm5d 
val = :yy_nil 
(yy_string("U+") and begin
      yy_var5b = @yy_input.pos
      begin; yy_var59 = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_var59; yy_char_range("A", "F")); end and while true
      yy_var5a = @yy_input.pos
      if not begin; yy_var59 = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_var59; yy_char_range("A", "F")); end then
        @yy_input.pos = yy_var5a
        break true
      end
    end and begin
        yy_var5c = @yy_input.pos
        @yy_input.pos = yy_var5b
        code = @yy_input.read(yy_var5c - yy_var5b).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm5h 
val = :yy_nil 
while true
      yy_var5g = @yy_input.pos
      if not begin; yy_var5f = @yy_input.pos; yy_nonterm5q or (@yy_input.pos = yy_var5f; yy_nonterm5o); end then
        @yy_input.pos = yy_var5g
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm5o 
val = :yy_nil 
(begin; yy_var5j = @yy_input.pos; yy_string("#") or (@yy_input.pos = yy_var5j; yy_string("--")); end and while true
      yy_var5n = @yy_input.pos
      if not (not begin
      yy_var5l = @yy_input.pos
      yy_var5m = yy_nonterm5s
      @yy_input.pos = yy_var5l
      yy_var5m
    end and @yy_input.getc) then
        @yy_input.pos = yy_var5n
        break true
      end
    end and yy_nonterm5s) and yy_to_pcv(val) 
end 
def yy_nonterm5q 
val = :yy_nil 
begin; yy_var5p = @yy_input.pos; yy_char_range("\t", "\r") or (@yy_input.pos = yy_var5p; yy_string(" ")) or (@yy_input.pos = yy_var5p; yy_string("\u{85}")) or (@yy_input.pos = yy_var5p; yy_string("\u{a0}")) or (@yy_input.pos = yy_var5p; yy_string("\u{1680}")) or (@yy_input.pos = yy_var5p; yy_string("\u{180e}")) or (@yy_input.pos = yy_var5p; yy_char_range("\u{2000}", "\u{200a}")) or (@yy_input.pos = yy_var5p; yy_string("\u{2028}")) or (@yy_input.pos = yy_var5p; yy_string("\u{2029}")) or (@yy_input.pos = yy_var5p; yy_string("\u{202f}")) or (@yy_input.pos = yy_var5p; yy_string("\u{205f}")) or (@yy_input.pos = yy_var5p; yy_string("\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nonterm5s 
val = :yy_nil 
begin; yy_var5r = @yy_input.pos; (yy_string("\r") and yy_string("\n")) or (@yy_input.pos = yy_var5r; yy_string("\r")) or (@yy_input.pos = yy_var5r; yy_string("\n")) or (@yy_input.pos = yy_var5r; yy_string("\u{85}")) or (@yy_input.pos = yy_var5r; yy_string("\v")) or (@yy_input.pos = yy_var5r; yy_string("\f")) or (@yy_input.pos = yy_var5r; yy_string("\u{2028}")) or (@yy_input.pos = yy_var5r; yy_string("\u{2029}")); end and yy_to_pcv(val) 
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
