#!/usr/bin/ruby
# encoding: UTF-8

# This file is both runnable and "require"-able.


# 
class PEGParserGenerator
  
  def call(input)
    # Initialize.
    @next_unique_number = 0
    # Parse grammar and generate the parser.
    code = yy_parse(input)
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
yy_nontermlt and yy_to_pcv(val) 
end 
def yy_nontermlt 
val = :yy_nil 
(yy_nonterm10l and begin
      yy_varlc = @yy_input.pos
      if not (yy_nontermpx and begin
      yy_varla = @yy_input.pos
      while true
      yy_varl9 = @yy_input.pos
      if not (not begin
      yy_varl7 = @yy_input.pos
      yy_varl8 = yy_nontermpx
      @yy_input.pos = yy_varl7
      yy_varl8
    end and @yy_input.getc) then
        @yy_input.pos = yy_varl9
        break true
      end
    end and begin
        yy_varlb = @yy_input.pos
        @yy_input.pos = yy_varla
        code = @yy_input.read(yy_varlb - yy_varla).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermpx and yy_nonterm10l and begin 
  print code  
 true 
 end) then
        @yy_input.pos = yy_varlc
      end
      true
    end and begin
      yy_varld = yy_nontermom
      if yy_varld then
        r = yy_from_pcv(yy_varld)
      end
      yy_varld
    end and begin 
 
    main_method_code = code "#{r.first_value.method_name}"
    main_method_code = link(main_method_code, r)
    generate_parser_body(main_method_code)
   
 true 
 end and begin
      yy_varls = @yy_input.pos
      if not (yy_nontermpx and begin
      yy_varlq = @yy_input.pos
      while true
      yy_varlp = @yy_input.pos
      if not @yy_input.getc then
        @yy_input.pos = yy_varlp
        break true
      end
    end and begin
        yy_varlr = @yy_input.pos
        @yy_input.pos = yy_varlq
        code = @yy_input.read(yy_varlr - yy_varlq).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  print code  
 true 
 end) then
        @yy_input.pos = yy_varls
      end
      true
    end and @yy_input.eof?) and yy_to_pcv(val) 
end 
def yy_nontermly 
val = :yy_nil 
begin
      yy_varlx = yy_nontermmf
      if yy_varlx then
        val = yy_from_pcv(yy_varlx)
      end
      yy_varlx
    end and yy_to_pcv(val) 
end 
def yy_nontermmf 
val = :yy_nil 
(begin 
 
    single_expression = true
    remembered_pos_var = new_unique_variable_name
   
 true 
 end and begin
      yy_varm8 = @yy_input.pos
      if not yy_nontermra then
        @yy_input.pos = yy_varm8
      end
      true
    end and begin
      yy_varm9 = yy_nontermmu
      if yy_varm9 then
        val = yy_from_pcv(yy_varm9)
      end
      yy_varm9
    end and while true
      yy_varme = @yy_input.pos
      if not (yy_nontermra and begin
      yy_varmd = yy_nontermmu
      if yy_varmd then
        val2 = yy_from_pcv(yy_varmd)
      end
      yy_varmd
    end and begin 
 
      single_expression = false
      val = val + (code " or (@yy_input.pos = #{remembered_pos_var}; ") + val2 + (code ")")
     
 true 
 end) then
        @yy_input.pos = yy_varme
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "begin; #{remembered_pos_var} = @yy_input.pos; ") + val + (code "; end")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermmu 
val = :yy_nil 
(begin 
  single_expression = true  
 true 
 end and begin
      yy_varmo = yy_nontermn3
      if yy_varmo then
        val = yy_from_pcv(yy_varmo)
      end
      yy_varmo
    end and while true
      yy_varmt = @yy_input.pos
      if not (begin
      yy_varms = yy_nontermn3
      if yy_varms then
        val2 = yy_from_pcv(yy_varms)
      end
      yy_varms
    end and begin 
 
      single_expression = false
      val = val + (code " and ") + val2
     
 true 
 end) then
        @yy_input.pos = yy_varmt
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "(") + val + (code ")")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermn3 
val = :yy_nil 
begin; yy_varmz = @yy_input.pos; (begin
      yy_varn0 = yy_nontermti
      if yy_varn0 then
        var = yy_from_pcv(yy_varn0)
      end
      yy_varn0
    end and yy_nontermrm and begin
      yy_varn1 = yy_nontermn3
      if yy_varn1 then
        c = yy_from_pcv(yy_varn1)
      end
      yy_varn1
    end and begin 
  val = capture_semantic_value_code(var, c)  
 true 
 end) or (@yy_input.pos = yy_varmz; begin
      yy_varn2 = yy_nontermnc
      if yy_varn2 then
        val = yy_from_pcv(yy_varn2)
      end
      yy_varn2
    end); end and yy_to_pcv(val) 
end 
def yy_nontermnc 
val = :yy_nil 
begin; yy_varn8 = @yy_input.pos; (yy_nonterms4 and begin
      yy_varn9 = yy_nontermnc
      if yy_varn9 then
        val = yy_from_pcv(yy_varn9)
      end
      yy_varn9
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end) or (@yy_input.pos = yy_varn8; (yy_nonterms7 and begin
      yy_varna = yy_nontermnc
      if yy_varna then
        val = yy_from_pcv(yy_varna)
      end
      yy_varna
    end and begin 
  val = code(%(not )) + positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_varn8; begin
      yy_varnb = yy_nontermnn
      if yy_varnb then
        val = yy_from_pcv(yy_varnb)
      end
      yy_varnb
    end); end and yy_to_pcv(val) 
end 
def yy_nontermnn 
val = :yy_nil 
(begin
      yy_varnj = yy_nontermny
      if yy_varnj then
        val = yy_from_pcv(yy_varnj)
      end
      yy_varnj
    end and while true
      yy_varnm = @yy_input.pos
      if not begin; yy_varnl = @yy_input.pos; (yy_nontermrv and begin 
  val = repeat_many_times_code(val)  
 true 
 end) or (@yy_input.pos = yy_varnl; (yy_nonterms1 and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (@yy_input.pos = yy_varnl; (yy_nontermry and begin 
  val = optional_code(val)  
 true 
 end)); end then
        @yy_input.pos = yy_varnm
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nontermny 
val = :yy_nil 
begin; yy_varnt = @yy_input.pos; (yy_nontermrg and begin
      yy_varnu = yy_nontermly
      if yy_varnu then
        val = yy_from_pcv(yy_varnu)
      end
      yy_varnu
    end and yy_nontermrj) or (@yy_input.pos = yy_varnt; (begin
      yy_varnv = yy_nontermti
      if yy_varnv then
        var = yy_from_pcv(yy_varnv)
      end
      yy_varnv
    end and yy_nontermrm and yy_nontermrp and begin
      yy_varnw = yy_nontermly
      if yy_varnw then
        c = yy_from_pcv(yy_varnw)
      end
      yy_varnw
    end and yy_nontermrs and begin 
  val = capture_text_code(var, c)  
 true 
 end)) or (@yy_input.pos = yy_varnt; begin
      yy_varnx = yy_nontermo9
      if yy_varnx then
        val = yy_from_pcv(yy_varnx)
      end
      yy_varnx
    end); end and yy_to_pcv(val) 
end 
def yy_nontermo9 
val = :yy_nil 
begin; yy_varo4 = @yy_input.pos; (begin
      yy_varo5 = yy_nontermxk
      if yy_varo5 then
        r = yy_from_pcv(yy_varo5)
      end
      yy_varo5
    end and begin 
  val = code "yy_char_range(#{r.begin.dump}, #{r.end.dump})"  
 true 
 end) or (@yy_input.pos = yy_varo4; (begin
      yy_varo6 = yy_nontermzp
      if yy_varo6 then
        s = yy_from_pcv(yy_varo6)
      end
      yy_varo6
    end and begin 
  val = code "yy_string(#{s.dump})"  
 true 
 end)) or (@yy_input.pos = yy_varo4; (begin
      yy_varo7 = yy_nontermx3
      if yy_varo7 then
        n = yy_from_pcv(yy_varo7)
      end
      yy_varo7
    end and begin 
  val = UnknownCode[n]  
 true 
 end)) or (@yy_input.pos = yy_varo4; (yy_nontermse and begin 
  val = code "@yy_input.getc"  
 true 
 end)) or (@yy_input.pos = yy_varo4; (begin
      yy_varo8 = yy_nontermq8
      if yy_varo8 then
        a = yy_from_pcv(yy_varo8)
      end
      yy_varo8
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (@yy_input.pos = yy_varo4; (yy_nontermrd and begin 
  val = code "@yy_input.eof?"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nontermom 
val = :yy_nil 
(begin 
  val = HashMap1.new  
 true 
 end and (begin
      yy_varok = yy_nontermoz
      if yy_varok then
        r = yy_from_pcv(yy_varok)
      end
      yy_varok
    end and begin 
 
      nonterminal, definition = *r
      raise %(rule "#{nonterminal}" is already defined) if val.has_key? nonterminal
      val[nonterminal] = definition
     
 true 
 end) and while true
      yy_varol = @yy_input.pos
      if not (begin
      yy_varok = yy_nontermoz
      if yy_varok then
        r = yy_from_pcv(yy_varok)
      end
      yy_varok
    end and begin 
 
      nonterminal, definition = *r
      raise %(rule "#{nonterminal}" is already defined) if val.has_key? nonterminal
      val[nonterminal] = definition
     
 true 
 end) then
        @yy_input.pos = yy_varol
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nontermoz 
val = :yy_nil 
(begin
      yy_varou = yy_nontermx3
      if yy_varou then
        n = yy_from_pcv(yy_varou)
      end
      yy_varou
    end and begin
      yy_varox = @yy_input.pos
      if not (yy_nontermrm and yy_nontermpg) then
        @yy_input.pos = yy_varox
      end
      true
    end and yy_nontermr4 and begin
      yy_varoy = yy_nontermly
      if yy_varoy then
        c = yy_from_pcv(yy_varoy)
      end
      yy_varoy
    end and yy_nontermr7 and begin 
  val = [n, to_method_definition(c, new_unique_nonterminal_method_name)]  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermpg 
val = :yy_nil 
(not begin
      yy_varpd = @yy_input.pos
      yy_varpe = yy_nontermr4
      @yy_input.pos = yy_varpd
      yy_varpe
    end and @yy_input.getc) and while true
      yy_varpf = @yy_input.pos
      if not (not begin
      yy_varpd = @yy_input.pos
      yy_varpe = yy_nontermr4
      @yy_input.pos = yy_varpd
      yy_varpe
    end and @yy_input.getc) then
        @yy_input.pos = yy_varpf
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nontermpx 
val = :yy_nil 
(yy_string("%%") and while true
      yy_varpw = @yy_input.pos
      if not (not begin
      yy_varpu = @yy_input.pos
      yy_varpv = yy_nonterm11c
      @yy_input.pos = yy_varpu
      yy_varpv
    end and @yy_input.getc) then
        @yy_input.pos = yy_varpw
        break true
      end
    end and yy_nonterm11c) and yy_to_pcv(val) 
end 
def yy_nontermq8 
val = :yy_nil 
(begin
      yy_varq6 = @yy_input.pos
      yy_nontermqx and begin
        yy_varq7 = @yy_input.pos
        @yy_input.pos = yy_varq6
        val = @yy_input.read(yy_varq7 - yy_varq6).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm10l and begin 
  val = val[1...-1]  
 true 
 end and begin 
  RubyVM::InstructionSequence.compile(val)  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermqx 
val = :yy_nil 
(yy_string("{") and while true
      yy_varqw = @yy_input.pos
      if not (not begin
      yy_varqs = @yy_input.pos
      yy_varqt = yy_string("}")
      @yy_input.pos = yy_varqs
      yy_varqt
    end and begin; yy_varqv = @yy_input.pos; yy_nontermqx or (@yy_input.pos = yy_varqv; @yy_input.getc); end) then
        @yy_input.pos = yy_varqw
        break true
      end
    end and yy_string("}")) and yy_to_pcv(val) 
end 
def yy_nontermr4 
val = :yy_nil 
(begin; yy_varr3 = @yy_input.pos; yy_string("<-") or (@yy_input.pos = yy_varr3; yy_string("=")) or (@yy_input.pos = yy_varr3; yy_string("\u{2190}")); end and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nontermr7 
val = :yy_nil 
(yy_string(";") and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nontermra 
val = :yy_nil 
(yy_string("/") and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nontermrd 
val = :yy_nil 
(yy_string("$") and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nontermrg 
val = :yy_nil 
(yy_string("(") and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nontermrj 
val = :yy_nil 
(yy_string(")") and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nontermrm 
val = :yy_nil 
(yy_string(":") and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nontermrp 
val = :yy_nil 
(yy_string("<") and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nontermrs 
val = :yy_nil 
(yy_string(">") and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nontermrv 
val = :yy_nil 
(yy_string("*") and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nontermry 
val = :yy_nil 
(yy_string("?") and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nonterms1 
val = :yy_nil 
(yy_string("+") and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nonterms4 
val = :yy_nil 
(yy_string("&") and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nonterms7 
val = :yy_nil 
(yy_string("!") and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nontermse 
val = :yy_nil 
(yy_string("char") and not begin
      yy_varsc = @yy_input.pos
      yy_varsd = yy_nontermx9
      @yy_input.pos = yy_varsc
      yy_varsd
    end and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nontermsl 
val = :yy_nil 
(yy_string("where") and not begin
      yy_varsj = @yy_input.pos
      yy_varsk = yy_nontermx9
      @yy_input.pos = yy_varsj
      yy_varsk
    end and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nontermss 
val = :yy_nil 
(yy_string("in") and not begin
      yy_varsq = @yy_input.pos
      yy_varsr = yy_nontermx9
      @yy_input.pos = yy_varsq
      yy_varsr
    end and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nontermsv 
val = :yy_nil 
begin; yy_varsu = @yy_input.pos; yy_nontermsl or (@yy_input.pos = yy_varsu; yy_nontermss) or (@yy_input.pos = yy_varsu; yy_nontermse); end and yy_to_pcv(val) 
end 
def yy_nontermti 
val = :yy_nil 
(begin
      yy_vartg = @yy_input.pos
      (yy_nontermtl and while true
      yy_vartf = @yy_input.pos
      if not yy_nontermto then
        @yy_input.pos = yy_vartf
        break true
      end
    end) and begin
        yy_varth = @yy_input.pos
        @yy_input.pos = yy_vartg
        val = @yy_input.read(yy_varth - yy_vartg).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm10l) and yy_to_pcv(val) 
end 
def yy_nontermtl 
val = :yy_nil 
begin; yy_vartk = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_vartk; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermto 
val = :yy_nil 
begin; yy_vartn = @yy_input.pos; yy_nontermtl or (@yy_input.pos = yy_vartn; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermx3 
val = :yy_nil 
(not begin
      yy_varvf = @yy_input.pos
      yy_varvg = yy_nontermsv
      @yy_input.pos = yy_varvf
      yy_varvg
    end and begin; yy_varwa = @yy_input.pos; (begin
      yy_varwj = @yy_input.pos
      (yy_nontermx6 and while true
      yy_varwi = @yy_input.pos
      if not yy_nontermx9 then
        @yy_input.pos = yy_varwi
        break true
      end
    end) and begin
        yy_varwk = @yy_input.pos
        @yy_input.pos = yy_varwj
        val = @yy_input.read(yy_varwk - yy_varwj).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm10l) or (@yy_input.pos = yy_varwa; (begin
      yy_varx1 = @yy_input.pos
      (yy_string("`") and while true
      yy_varx0 = @yy_input.pos
      if not (not begin
      yy_varwy = @yy_input.pos
      yy_varwz = yy_string("`")
      @yy_input.pos = yy_varwy
      yy_varwz
    end and @yy_input.getc) then
        @yy_input.pos = yy_varx0
        break true
      end
    end and yy_string("`")) and begin
        yy_varx2 = @yy_input.pos
        @yy_input.pos = yy_varx1
        val = @yy_input.read(yy_varx2 - yy_varx1).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm10l)); end) and yy_to_pcv(val) 
end 
def yy_nontermx6 
val = :yy_nil 
begin; yy_varx5 = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varx5; yy_char_range("A", "Z")) or (@yy_input.pos = yy_varx5; yy_string("-")) or (@yy_input.pos = yy_varx5; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermx9 
val = :yy_nil 
begin; yy_varx8 = @yy_input.pos; yy_nontermx6 or (@yy_input.pos = yy_varx8; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermxk 
val = :yy_nil 
(begin
      yy_varxg = yy_nontermzp
      if yy_varxg then
        from = yy_from_pcv(yy_varxg)
      end
      yy_varxg
    end and begin; yy_varxi = @yy_input.pos; yy_string("...") or (@yy_input.pos = yy_varxi; yy_string("..")) or (@yy_input.pos = yy_varxi; yy_string("\u{2026}")) or (@yy_input.pos = yy_varxi; yy_string("\u{2025}")); end and begin
      yy_varxj = yy_nontermzp
      if yy_varxj then
        to = yy_from_pcv(yy_varxj)
      end
      yy_varxj
    end and yy_nonterm10l and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermzp 
val = :yy_nil 
begin; yy_varyn = @yy_input.pos; (yy_string("'") and begin
      yy_varz4 = @yy_input.pos
      while true
      yy_varz3 = @yy_input.pos
      if not (not begin
      yy_varz1 = @yy_input.pos
      yy_varz2 = yy_string("'")
      @yy_input.pos = yy_varz1
      yy_varz2
    end and @yy_input.getc) then
        @yy_input.pos = yy_varz3
        break true
      end
    end and begin
        yy_varz5 = @yy_input.pos
        @yy_input.pos = yy_varz4
        val = @yy_input.read(yy_varz5 - yy_varz4).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("'") and yy_nonterm10l) or (@yy_input.pos = yy_varyn; (yy_string("\"") and begin
      yy_varzm = @yy_input.pos
      while true
      yy_varzl = @yy_input.pos
      if not (not begin
      yy_varzj = @yy_input.pos
      yy_varzk = yy_string("\"")
      @yy_input.pos = yy_varzj
      yy_varzk
    end and @yy_input.getc) then
        @yy_input.pos = yy_varzl
        break true
      end
    end and begin
        yy_varzn = @yy_input.pos
        @yy_input.pos = yy_varzm
        val = @yy_input.read(yy_varzn - yy_varzm).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("\"") and yy_nonterm10l)) or (@yy_input.pos = yy_varyn; (begin
      yy_varzo = yy_nonterm10c
      if yy_varzo then
        code = yy_from_pcv(yy_varzo)
      end
      yy_varzo
    end and yy_nonterm10l and begin 
  val = "" << code  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm10c 
val = :yy_nil 
(yy_string("U+") and begin
      yy_var10a = @yy_input.pos
      begin; yy_var108 = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_var108; yy_char_range("A", "F")); end and while true
      yy_var109 = @yy_input.pos
      if not begin; yy_var108 = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_var108; yy_char_range("A", "F")); end then
        @yy_input.pos = yy_var109
        break true
      end
    end and begin
        yy_var10b = @yy_input.pos
        @yy_input.pos = yy_var10a
        code = @yy_input.read(yy_var10b - yy_var10a).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = code.to_i(16)  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm10l 
val = :yy_nil 
while true
      yy_var10k = @yy_input.pos
      if not begin; yy_var10j = @yy_input.pos; yy_nonterm119 or (@yy_input.pos = yy_var10j; yy_nonterm116); end then
        @yy_input.pos = yy_var10k
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm116 
val = :yy_nil 
(begin; yy_var10y = @yy_input.pos; yy_string("#") or (@yy_input.pos = yy_var10y; yy_string("--")); end and while true
      yy_var115 = @yy_input.pos
      if not (not begin
      yy_var113 = @yy_input.pos
      yy_var114 = yy_nonterm11c
      @yy_input.pos = yy_var113
      yy_var114
    end and @yy_input.getc) then
        @yy_input.pos = yy_var115
        break true
      end
    end and yy_nonterm11c) and yy_to_pcv(val) 
end 
def yy_nonterm119 
val = :yy_nil 
begin; yy_var118 = @yy_input.pos; yy_char_range("\t", "\r") or (@yy_input.pos = yy_var118; yy_string(" ")) or (@yy_input.pos = yy_var118; yy_string("\u{85}")) or (@yy_input.pos = yy_var118; yy_string("\u{a0}")) or (@yy_input.pos = yy_var118; yy_string("\u{1680}")) or (@yy_input.pos = yy_var118; yy_string("\u{180e}")) or (@yy_input.pos = yy_var118; yy_char_range("\u{2000}", "\u{200a}")) or (@yy_input.pos = yy_var118; yy_string("\u{2028}")) or (@yy_input.pos = yy_var118; yy_string("\u{2029}")) or (@yy_input.pos = yy_var118; yy_string("\u{202f}")) or (@yy_input.pos = yy_var118; yy_string("\u{205f}")) or (@yy_input.pos = yy_var118; yy_string("\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nonterm11c 
val = :yy_nil 
begin; yy_var11b = @yy_input.pos; (yy_string("\r") and yy_string("\n")) or (@yy_input.pos = yy_var11b; yy_string("\r")) or (@yy_input.pos = yy_var11b; yy_string("\n")) or (@yy_input.pos = yy_var11b; yy_string("\u{85}")) or (@yy_input.pos = yy_var11b; yy_string("\v")) or (@yy_input.pos = yy_var11b; yy_string("\f")) or (@yy_input.pos = yy_var11b; yy_string("\u{2028}")) or (@yy_input.pos = yy_var11b; yy_string("\u{2029}")); end and yy_to_pcv(val) 
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
