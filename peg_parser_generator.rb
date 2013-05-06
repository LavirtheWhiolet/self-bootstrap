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
yy_nontermmr and yy_to_pcv(val) 
end 
def yy_nontermmr 
val = :yy_nil 
(yy_nonterm12h and begin
      yy_varma = @yy_input.pos
      if not (yy_nontermrt and begin
      yy_varm8 = @yy_input.pos
      while true
      yy_varm7 = @yy_input.pos
      if not (not begin
      yy_varm5 = @yy_input.pos
      yy_varm6 = yy_nontermrt
      @yy_input.pos = yy_varm5
      yy_varm6
    end and @yy_input.getc) then
        @yy_input.pos = yy_varm7
        break true
      end
    end and begin
        yy_varm9 = @yy_input.pos
        @yy_input.pos = yy_varm8
        code = @yy_input.read(yy_varm9 - yy_varm8).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermrt and yy_nonterm12h and begin 
  print code  
 true 
 end) then
        @yy_input.pos = yy_varma
      end
      true
    end and begin
      yy_varmb = yy_nontermmw
      if yy_varmb then
        val = yy_from_pcv(yy_varmb)
      end
      yy_varmb
    end and begin 
  generate_parser_body(val)  
 true 
 end and begin
      yy_varmq = @yy_input.pos
      if not (yy_nontermrt and begin
      yy_varmo = @yy_input.pos
      while true
      yy_varmn = @yy_input.pos
      if not @yy_input.getc then
        @yy_input.pos = yy_varmn
        break true
      end
    end and begin
        yy_varmp = @yy_input.pos
        @yy_input.pos = yy_varmo
        code = @yy_input.read(yy_varmp - yy_varmo).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  print code  
 true 
 end) then
        @yy_input.pos = yy_varmq
      end
      true
    end and @yy_input.eof?) and yy_to_pcv(val) 
end 
def yy_nontermmw 
val = :yy_nil 
begin
      yy_varmv = yy_nontermoh
      if yy_varmv then
        val = yy_from_pcv(yy_varmv)
      end
      yy_varmv
    end and yy_to_pcv(val) 
end 
def yy_nontermoh 
val = :yy_nil 
begin; yy_varnp = @yy_input.pos; (begin; yy_varoa = @yy_input.pos; (begin
      yy_varob = yy_nontermr5
      if yy_varob then
        r = yy_from_pcv(yy_varob)
      end
      yy_varob
    end and yy_nontermuo and begin
      yy_varoc = yy_nontermoh
      if yy_varoc then
        c = yy_from_pcv(yy_varoc)
      end
      yy_varoc
    end) or (@yy_input.pos = yy_varoa; (begin
      yy_varod = yy_nontermoy
      if yy_varod then
        c = yy_from_pcv(yy_varod)
      end
      yy_varod
    end and yy_nontermuh and begin
      yy_varoe = yy_nontermr5
      if yy_varoe then
        r = yy_from_pcv(yy_varoe)
      end
      yy_varoe
    end)) or (@yy_input.pos = yy_varoa; (begin
      yy_varof = yy_nontermr5
      if yy_varof then
        r = yy_from_pcv(yy_varof)
      end
      yy_varof
    end and begin 
  c = code "#{r.first_value.method_name}"  
 true 
 end)); end and begin 
  val = link(c, r)  
 true 
 end) or (@yy_input.pos = yy_varnp; begin
      yy_varog = yy_nontermoy
      if yy_varog then
        val = yy_from_pcv(yy_varog)
      end
      yy_varog
    end); end and yy_to_pcv(val) 
end 
def yy_nontermoy 
val = :yy_nil 
(begin 
 
    single_expression = true
    remembered_pos_var = new_unique_variable_name
   
 true 
 end and begin
      yy_varor = @yy_input.pos
      if not yy_nontermt6 then
        @yy_input.pos = yy_varor
      end
      true
    end and begin
      yy_varos = yy_nontermpd
      if yy_varos then
        val = yy_from_pcv(yy_varos)
      end
      yy_varos
    end and while true
      yy_varox = @yy_input.pos
      if not (yy_nontermt6 and begin
      yy_varow = yy_nontermpd
      if yy_varow then
        val2 = yy_from_pcv(yy_varow)
      end
      yy_varow
    end and begin 
 
      single_expression = false
      val = val + (code " or (@yy_input.pos = #{remembered_pos_var}; ") + val2 + (code ")")
     
 true 
 end) then
        @yy_input.pos = yy_varox
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "begin; #{remembered_pos_var} = @yy_input.pos; ") + val + (code "; end")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermpd 
val = :yy_nil 
(begin 
  single_expression = true  
 true 
 end and begin
      yy_varp7 = yy_nontermpm
      if yy_varp7 then
        val = yy_from_pcv(yy_varp7)
      end
      yy_varp7
    end and while true
      yy_varpc = @yy_input.pos
      if not (begin
      yy_varpb = yy_nontermpm
      if yy_varpb then
        val2 = yy_from_pcv(yy_varpb)
      end
      yy_varpb
    end and begin 
 
      single_expression = false
      val = val + (code " and ") + val2
     
 true 
 end) then
        @yy_input.pos = yy_varpc
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "(") + val + (code ")")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermpm 
val = :yy_nil 
begin; yy_varpi = @yy_input.pos; (begin
      yy_varpj = yy_nontermve
      if yy_varpj then
        var = yy_from_pcv(yy_varpj)
      end
      yy_varpj
    end and yy_nontermti and begin
      yy_varpk = yy_nontermpm
      if yy_varpk then
        c = yy_from_pcv(yy_varpk)
      end
      yy_varpk
    end and begin 
  val = capture_semantic_value_code(var, c)  
 true 
 end) or (@yy_input.pos = yy_varpi; begin
      yy_varpl = yy_nontermpv
      if yy_varpl then
        val = yy_from_pcv(yy_varpl)
      end
      yy_varpl
    end); end and yy_to_pcv(val) 
end 
def yy_nontermpv 
val = :yy_nil 
begin; yy_varpr = @yy_input.pos; (yy_nontermu0 and begin
      yy_varps = yy_nontermpv
      if yy_varps then
        val = yy_from_pcv(yy_varps)
      end
      yy_varps
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end) or (@yy_input.pos = yy_varpr; (yy_nontermu3 and begin
      yy_varpt = yy_nontermpv
      if yy_varpt then
        val = yy_from_pcv(yy_varpt)
      end
      yy_varpt
    end and begin 
  val = code(%(not )) + positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_varpr; begin
      yy_varpu = yy_nontermq6
      if yy_varpu then
        val = yy_from_pcv(yy_varpu)
      end
      yy_varpu
    end); end and yy_to_pcv(val) 
end 
def yy_nontermq6 
val = :yy_nil 
(begin
      yy_varq2 = yy_nontermqh
      if yy_varq2 then
        val = yy_from_pcv(yy_varq2)
      end
      yy_varq2
    end and while true
      yy_varq5 = @yy_input.pos
      if not begin; yy_varq4 = @yy_input.pos; (yy_nontermtr and begin 
  val = repeat_many_times_code(val)  
 true 
 end) or (@yy_input.pos = yy_varq4; (yy_nontermtx and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (@yy_input.pos = yy_varq4; (yy_nontermtu and begin 
  val = optional_code(val)  
 true 
 end)); end then
        @yy_input.pos = yy_varq5
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nontermqh 
val = :yy_nil 
begin; yy_varqc = @yy_input.pos; (yy_nontermtc and begin
      yy_varqd = yy_nontermmw
      if yy_varqd then
        val = yy_from_pcv(yy_varqd)
      end
      yy_varqd
    end and yy_nontermtf) or (@yy_input.pos = yy_varqc; (begin
      yy_varqe = yy_nontermve
      if yy_varqe then
        var = yy_from_pcv(yy_varqe)
      end
      yy_varqe
    end and yy_nontermti and yy_nontermtl and begin
      yy_varqf = yy_nontermmw
      if yy_varqf then
        c = yy_from_pcv(yy_varqf)
      end
      yy_varqf
    end and yy_nontermto and begin 
  val = capture_text_code(var, c)  
 true 
 end)) or (@yy_input.pos = yy_varqc; begin
      yy_varqg = yy_nontermqs
      if yy_varqg then
        val = yy_from_pcv(yy_varqg)
      end
      yy_varqg
    end); end and yy_to_pcv(val) 
end 
def yy_nontermqs 
val = :yy_nil 
begin; yy_varqn = @yy_input.pos; (begin
      yy_varqo = yy_nontermzg
      if yy_varqo then
        r = yy_from_pcv(yy_varqo)
      end
      yy_varqo
    end and begin 
  val = code "yy_char_range(#{r.begin.dump}, #{r.end.dump})"  
 true 
 end) or (@yy_input.pos = yy_varqn; (begin
      yy_varqp = yy_nonterm11l
      if yy_varqp then
        s = yy_from_pcv(yy_varqp)
      end
      yy_varqp
    end and begin 
  val = code "yy_string(#{s.dump})"  
 true 
 end)) or (@yy_input.pos = yy_varqn; (begin
      yy_varqq = yy_nontermyz
      if yy_varqq then
        n = yy_from_pcv(yy_varqq)
      end
      yy_varqq
    end and begin 
  val = UnknownCode[n]  
 true 
 end)) or (@yy_input.pos = yy_varqn; (yy_nontermua and begin 
  val = code "@yy_input.getc"  
 true 
 end)) or (@yy_input.pos = yy_varqn; (begin
      yy_varqr = yy_nonterms4
      if yy_varqr then
        a = yy_from_pcv(yy_varqr)
      end
      yy_varqr
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (@yy_input.pos = yy_varqn; (yy_nontermt9 and begin 
  val = code "@yy_input.eof?"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nontermr5 
val = :yy_nil 
(begin 
  val = HashMap1.new  
 true 
 end and (begin
      yy_varr3 = yy_nontermrc
      if yy_varr3 then
        r = yy_from_pcv(yy_varr3)
      end
      yy_varr3
    end and begin 
 
      nonterminal, definition = *r
      raise %(rule "#{nonterminal}" is already defined) if val.has_key? nonterminal
      val[nonterminal] = definition
     
 true 
 end) and while true
      yy_varr4 = @yy_input.pos
      if not (begin
      yy_varr3 = yy_nontermrc
      if yy_varr3 then
        r = yy_from_pcv(yy_varr3)
      end
      yy_varr3
    end and begin 
 
      nonterminal, definition = *r
      raise %(rule "#{nonterminal}" is already defined) if val.has_key? nonterminal
      val[nonterminal] = definition
     
 true 
 end) then
        @yy_input.pos = yy_varr4
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nontermrc 
val = :yy_nil 
(begin
      yy_varra = yy_nontermyz
      if yy_varra then
        n = yy_from_pcv(yy_varra)
      end
      yy_varra
    end and yy_nontermt0 and begin
      yy_varrb = yy_nontermmw
      if yy_varrb then
        c = yy_from_pcv(yy_varrb)
      end
      yy_varrb
    end and yy_nontermt3 and begin 
  val = [n, to_method_definition(c, new_unique_nonterminal_method_name)]  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermrt 
val = :yy_nil 
(yy_string("%%") and while true
      yy_varrs = @yy_input.pos
      if not (not begin
      yy_varrq = @yy_input.pos
      yy_varrr = yy_nonterm138
      @yy_input.pos = yy_varrq
      yy_varrr
    end and @yy_input.getc) then
        @yy_input.pos = yy_varrs
        break true
      end
    end and yy_nonterm138) and yy_to_pcv(val) 
end 
def yy_nonterms4 
val = :yy_nil 
(begin
      yy_vars2 = @yy_input.pos
      yy_nontermst and begin
        yy_vars3 = @yy_input.pos
        @yy_input.pos = yy_vars2
        val = @yy_input.read(yy_vars3 - yy_vars2).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm12h and begin 
  val = val[1...-1]  
 true 
 end and begin 
  RubyVM::InstructionSequence.compile(val)  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermst 
val = :yy_nil 
(yy_string("{") and while true
      yy_varss = @yy_input.pos
      if not (not begin
      yy_varso = @yy_input.pos
      yy_varsp = yy_string("}")
      @yy_input.pos = yy_varso
      yy_varsp
    end and begin; yy_varsr = @yy_input.pos; yy_nontermst or (@yy_input.pos = yy_varsr; @yy_input.getc); end) then
        @yy_input.pos = yy_varss
        break true
      end
    end and yy_string("}")) and yy_to_pcv(val) 
end 
def yy_nontermt0 
val = :yy_nil 
(begin; yy_varsz = @yy_input.pos; yy_string("<-") or (@yy_input.pos = yy_varsz; yy_string("=")) or (@yy_input.pos = yy_varsz; yy_string("\u{2190}")); end and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermt3 
val = :yy_nil 
(yy_string(";") and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermt6 
val = :yy_nil 
(yy_string("/") and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermt9 
val = :yy_nil 
(yy_string("$") and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermtc 
val = :yy_nil 
(yy_string("(") and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermtf 
val = :yy_nil 
(yy_string(")") and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermti 
val = :yy_nil 
(yy_string(":") and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermtl 
val = :yy_nil 
(yy_string("<") and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermto 
val = :yy_nil 
(yy_string(">") and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermtr 
val = :yy_nil 
(yy_string("*") and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermtu 
val = :yy_nil 
(yy_string("?") and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermtx 
val = :yy_nil 
(yy_string("+") and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermu0 
val = :yy_nil 
(yy_string("&") and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermu3 
val = :yy_nil 
(yy_string("!") and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermua 
val = :yy_nil 
(yy_string("char") and not begin
      yy_varu8 = @yy_input.pos
      yy_varu9 = yy_nontermz5
      @yy_input.pos = yy_varu8
      yy_varu9
    end and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermuh 
val = :yy_nil 
(yy_string("where") and not begin
      yy_varuf = @yy_input.pos
      yy_varug = yy_nontermz5
      @yy_input.pos = yy_varuf
      yy_varug
    end and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermuo 
val = :yy_nil 
(yy_string("in") and not begin
      yy_varum = @yy_input.pos
      yy_varun = yy_nontermz5
      @yy_input.pos = yy_varum
      yy_varun
    end and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermur 
val = :yy_nil 
begin; yy_varuq = @yy_input.pos; yy_nontermuh or (@yy_input.pos = yy_varuq; yy_nontermuo) or (@yy_input.pos = yy_varuq; yy_nontermua); end and yy_to_pcv(val) 
end 
def yy_nontermve 
val = :yy_nil 
(begin
      yy_varvc = @yy_input.pos
      (yy_nontermvh and while true
      yy_varvb = @yy_input.pos
      if not yy_nontermvk then
        @yy_input.pos = yy_varvb
        break true
      end
    end) and begin
        yy_varvd = @yy_input.pos
        @yy_input.pos = yy_varvc
        val = @yy_input.read(yy_varvd - yy_varvc).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm12h) and yy_to_pcv(val) 
end 
def yy_nontermvh 
val = :yy_nil 
begin; yy_varvg = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varvg; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermvk 
val = :yy_nil 
begin; yy_varvj = @yy_input.pos; yy_nontermvh or (@yy_input.pos = yy_varvj; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermyz 
val = :yy_nil 
(not begin
      yy_varxb = @yy_input.pos
      yy_varxc = yy_nontermur
      @yy_input.pos = yy_varxb
      yy_varxc
    end and begin; yy_vary6 = @yy_input.pos; (begin
      yy_varyf = @yy_input.pos
      (yy_nontermz2 and while true
      yy_varye = @yy_input.pos
      if not yy_nontermz5 then
        @yy_input.pos = yy_varye
        break true
      end
    end) and begin
        yy_varyg = @yy_input.pos
        @yy_input.pos = yy_varyf
        val = @yy_input.read(yy_varyg - yy_varyf).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm12h) or (@yy_input.pos = yy_vary6; (begin
      yy_varyx = @yy_input.pos
      (yy_string("`") and while true
      yy_varyw = @yy_input.pos
      if not (not begin
      yy_varyu = @yy_input.pos
      yy_varyv = yy_string("`")
      @yy_input.pos = yy_varyu
      yy_varyv
    end and @yy_input.getc) then
        @yy_input.pos = yy_varyw
        break true
      end
    end and yy_string("`")) and begin
        yy_varyy = @yy_input.pos
        @yy_input.pos = yy_varyx
        val = @yy_input.read(yy_varyy - yy_varyx).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm12h)); end) and yy_to_pcv(val) 
end 
def yy_nontermz2 
val = :yy_nil 
begin; yy_varz1 = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varz1; yy_char_range("A", "Z")) or (@yy_input.pos = yy_varz1; yy_string("-")) or (@yy_input.pos = yy_varz1; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermz5 
val = :yy_nil 
begin; yy_varz4 = @yy_input.pos; yy_nontermz2 or (@yy_input.pos = yy_varz4; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermzg 
val = :yy_nil 
(begin
      yy_varzc = yy_nonterm11l
      if yy_varzc then
        from = yy_from_pcv(yy_varzc)
      end
      yy_varzc
    end and begin; yy_varze = @yy_input.pos; yy_string("...") or (@yy_input.pos = yy_varze; yy_string("..")) or (@yy_input.pos = yy_varze; yy_string("\u{2026}")) or (@yy_input.pos = yy_varze; yy_string("\u{2025}")); end and begin
      yy_varzf = yy_nonterm11l
      if yy_varzf then
        to = yy_from_pcv(yy_varzf)
      end
      yy_varzf
    end and yy_nonterm12h and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm11l 
val = :yy_nil 
begin; yy_var10j = @yy_input.pos; (yy_string("'") and begin
      yy_var110 = @yy_input.pos
      while true
      yy_var10z = @yy_input.pos
      if not (not begin
      yy_var10x = @yy_input.pos
      yy_var10y = yy_string("'")
      @yy_input.pos = yy_var10x
      yy_var10y
    end and @yy_input.getc) then
        @yy_input.pos = yy_var10z
        break true
      end
    end and begin
        yy_var111 = @yy_input.pos
        @yy_input.pos = yy_var110
        val = @yy_input.read(yy_var111 - yy_var110).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("'") and yy_nonterm12h) or (@yy_input.pos = yy_var10j; (yy_string("\"") and begin
      yy_var11i = @yy_input.pos
      while true
      yy_var11h = @yy_input.pos
      if not (not begin
      yy_var11f = @yy_input.pos
      yy_var11g = yy_string("\"")
      @yy_input.pos = yy_var11f
      yy_var11g
    end and @yy_input.getc) then
        @yy_input.pos = yy_var11h
        break true
      end
    end and begin
        yy_var11j = @yy_input.pos
        @yy_input.pos = yy_var11i
        val = @yy_input.read(yy_var11j - yy_var11i).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("\"") and yy_nonterm12h)) or (@yy_input.pos = yy_var10j; (begin
      yy_var11k = yy_nonterm128
      if yy_var11k then
        code = yy_from_pcv(yy_var11k)
      end
      yy_var11k
    end and yy_nonterm12h and begin 
  val = "" << code  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm128 
val = :yy_nil 
(yy_string("U+") and begin
      yy_var126 = @yy_input.pos
      begin; yy_var124 = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_var124; yy_char_range("A", "F")); end and while true
      yy_var125 = @yy_input.pos
      if not begin; yy_var124 = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_var124; yy_char_range("A", "F")); end then
        @yy_input.pos = yy_var125
        break true
      end
    end and begin
        yy_var127 = @yy_input.pos
        @yy_input.pos = yy_var126
        code = @yy_input.read(yy_var127 - yy_var126).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = code.to_i(16)  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm12h 
val = :yy_nil 
while true
      yy_var12g = @yy_input.pos
      if not begin; yy_var12f = @yy_input.pos; yy_nonterm135 or (@yy_input.pos = yy_var12f; yy_nonterm132); end then
        @yy_input.pos = yy_var12g
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm132 
val = :yy_nil 
(begin; yy_var12u = @yy_input.pos; yy_string("#") or (@yy_input.pos = yy_var12u; yy_string("--")); end and while true
      yy_var131 = @yy_input.pos
      if not (not begin
      yy_var12z = @yy_input.pos
      yy_var130 = yy_nonterm138
      @yy_input.pos = yy_var12z
      yy_var130
    end and @yy_input.getc) then
        @yy_input.pos = yy_var131
        break true
      end
    end and yy_nonterm138) and yy_to_pcv(val) 
end 
def yy_nonterm135 
val = :yy_nil 
begin; yy_var134 = @yy_input.pos; yy_char_range("\t", "\r") or (@yy_input.pos = yy_var134; yy_string(" ")) or (@yy_input.pos = yy_var134; yy_string("\u{85}")) or (@yy_input.pos = yy_var134; yy_string("\u{a0}")) or (@yy_input.pos = yy_var134; yy_string("\u{1680}")) or (@yy_input.pos = yy_var134; yy_string("\u{180e}")) or (@yy_input.pos = yy_var134; yy_char_range("\u{2000}", "\u{200a}")) or (@yy_input.pos = yy_var134; yy_string("\u{2028}")) or (@yy_input.pos = yy_var134; yy_string("\u{2029}")) or (@yy_input.pos = yy_var134; yy_string("\u{202f}")) or (@yy_input.pos = yy_var134; yy_string("\u{205f}")) or (@yy_input.pos = yy_var134; yy_string("\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nonterm138 
val = :yy_nil 
begin; yy_var137 = @yy_input.pos; (yy_string("\r") and yy_string("\n")) or (@yy_input.pos = yy_var137; yy_string("\r")) or (@yy_input.pos = yy_var137; yy_string("\n")) or (@yy_input.pos = yy_var137; yy_string("\u{85}")) or (@yy_input.pos = yy_var137; yy_string("\v")) or (@yy_input.pos = yy_var137; yy_string("\f")) or (@yy_input.pos = yy_var137; yy_string("\u{2028}")) or (@yy_input.pos = yy_var137; yy_string("\u{2029}")); end and yy_to_pcv(val) 
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
