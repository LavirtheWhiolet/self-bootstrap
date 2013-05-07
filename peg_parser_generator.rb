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
yy_nontermmt and yy_to_pcv(val) 
end 
def yy_nontermmt 
val = :yy_nil 
(yy_nonterm12l and begin
      yy_varmc = @yy_input.pos
      if not (yy_nontermrx and begin
      yy_varma = @yy_input.pos
      while true
      yy_varm9 = @yy_input.pos
      if not (not begin
      yy_varm7 = @yy_input.pos
      yy_varm8 = yy_nontermrx
      @yy_input.pos = yy_varm7
      yy_varm8
    end and @yy_input.getc) then
        @yy_input.pos = yy_varm9
        break true
      end
    end and begin
        yy_varmb = @yy_input.pos
        @yy_input.pos = yy_varma
        code = @yy_input.read(yy_varmb - yy_varma).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermrx and yy_nonterm12l and begin 
  print code  
 true 
 end) then
        @yy_input.pos = yy_varmc
      end
      true
    end and begin
      yy_varmd = yy_nontermmy
      if yy_varmd then
        val = yy_from_pcv(yy_varmd)
      end
      yy_varmd
    end and begin 
  generate_parser_body(val)  
 true 
 end and begin
      yy_varms = @yy_input.pos
      if not (yy_nontermrx and begin
      yy_varmq = @yy_input.pos
      while true
      yy_varmp = @yy_input.pos
      if not @yy_input.getc then
        @yy_input.pos = yy_varmp
        break true
      end
    end and begin
        yy_varmr = @yy_input.pos
        @yy_input.pos = yy_varmq
        code = @yy_input.read(yy_varmr - yy_varmq).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  print code  
 true 
 end) then
        @yy_input.pos = yy_varms
      end
      true
    end and @yy_input.eof?) and yy_to_pcv(val) 
end 
def yy_nontermmy 
val = :yy_nil 
begin
      yy_varmx = yy_nontermoj
      if yy_varmx then
        val = yy_from_pcv(yy_varmx)
      end
      yy_varmx
    end and yy_to_pcv(val) 
end 
def yy_nontermoj 
val = :yy_nil 
begin; yy_varnr = @yy_input.pos; (begin; yy_varoc = @yy_input.pos; (begin
      yy_varod = yy_nontermr9
      if yy_varod then
        r = yy_from_pcv(yy_varod)
      end
      yy_varod
    end and yy_nontermus and begin
      yy_varoe = yy_nontermoj
      if yy_varoe then
        c = yy_from_pcv(yy_varoe)
      end
      yy_varoe
    end) or (@yy_input.pos = yy_varoc; (begin
      yy_varof = yy_nontermp0
      if yy_varof then
        c = yy_from_pcv(yy_varof)
      end
      yy_varof
    end and yy_nontermul and begin
      yy_varog = yy_nontermr9
      if yy_varog then
        r = yy_from_pcv(yy_varog)
      end
      yy_varog
    end)) or (@yy_input.pos = yy_varoc; (begin
      yy_varoh = yy_nontermr9
      if yy_varoh then
        r = yy_from_pcv(yy_varoh)
      end
      yy_varoh
    end and begin 
  c = code "#{r.first_value.method_name}"  
 true 
 end)); end and begin 
  val = link(c, r)  
 true 
 end) or (@yy_input.pos = yy_varnr; begin
      yy_varoi = yy_nontermp0
      if yy_varoi then
        val = yy_from_pcv(yy_varoi)
      end
      yy_varoi
    end); end and yy_to_pcv(val) 
end 
def yy_nontermp0 
val = :yy_nil 
(begin 
 
    single_expression = true
    remembered_pos_var = new_unique_variable_name
   
 true 
 end and begin
      yy_varot = @yy_input.pos
      if not yy_nontermta then
        @yy_input.pos = yy_varot
      end
      true
    end and begin
      yy_varou = yy_nontermpf
      if yy_varou then
        val = yy_from_pcv(yy_varou)
      end
      yy_varou
    end and while true
      yy_varoz = @yy_input.pos
      if not (yy_nontermta and begin
      yy_varoy = yy_nontermpf
      if yy_varoy then
        val2 = yy_from_pcv(yy_varoy)
      end
      yy_varoy
    end and begin 
 
      single_expression = false
      val = val + (code " or (@yy_input.pos = #{remembered_pos_var}; ") + val2 + (code ")")
     
 true 
 end) then
        @yy_input.pos = yy_varoz
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "begin; #{remembered_pos_var} = @yy_input.pos; ") + val + (code "; end")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermpf 
val = :yy_nil 
(begin 
  single_expression = true  
 true 
 end and begin
      yy_varp9 = yy_nontermpo
      if yy_varp9 then
        val = yy_from_pcv(yy_varp9)
      end
      yy_varp9
    end and while true
      yy_varpe = @yy_input.pos
      if not (begin
      yy_varpd = yy_nontermpo
      if yy_varpd then
        val2 = yy_from_pcv(yy_varpd)
      end
      yy_varpd
    end and begin 
 
      single_expression = false
      val = val + (code " and ") + val2
     
 true 
 end) then
        @yy_input.pos = yy_varpe
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "(") + val + (code ")")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermpo 
val = :yy_nil 
begin; yy_varpk = @yy_input.pos; (begin
      yy_varpl = yy_nontermvi
      if yy_varpl then
        var = yy_from_pcv(yy_varpl)
      end
      yy_varpl
    end and yy_nontermtm and begin
      yy_varpm = yy_nontermpo
      if yy_varpm then
        c = yy_from_pcv(yy_varpm)
      end
      yy_varpm
    end and begin 
  val = capture_semantic_value_code(var, c)  
 true 
 end) or (@yy_input.pos = yy_varpk; begin
      yy_varpn = yy_nontermpz
      if yy_varpn then
        val = yy_from_pcv(yy_varpn)
      end
      yy_varpn
    end); end and yy_to_pcv(val) 
end 
def yy_nontermpz 
val = :yy_nil 
begin; yy_varpu = @yy_input.pos; (yy_nontermu4 and begin
      yy_varpv = yy_nonterms8
      if yy_varpv then
        c = yy_from_pcv(yy_varpv)
      end
      yy_varpv
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (@yy_input.pos = yy_varpu; (yy_nontermu4 and begin
      yy_varpw = yy_nontermpz
      if yy_varpw then
        val = yy_from_pcv(yy_varpw)
      end
      yy_varpw
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_varpu; (yy_nontermu7 and begin
      yy_varpx = yy_nontermpz
      if yy_varpx then
        val = yy_from_pcv(yy_varpx)
      end
      yy_varpx
    end and begin 
  val = code(%(not )) + positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_varpu; begin
      yy_varpy = yy_nontermqa
      if yy_varpy then
        val = yy_from_pcv(yy_varpy)
      end
      yy_varpy
    end); end and yy_to_pcv(val) 
end 
def yy_nontermqa 
val = :yy_nil 
(begin
      yy_varq6 = yy_nontermql
      if yy_varq6 then
        val = yy_from_pcv(yy_varq6)
      end
      yy_varq6
    end and while true
      yy_varq9 = @yy_input.pos
      if not begin; yy_varq8 = @yy_input.pos; (yy_nontermtv and begin 
  val = repeat_many_times_code(val)  
 true 
 end) or (@yy_input.pos = yy_varq8; (yy_nontermu1 and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (@yy_input.pos = yy_varq8; (yy_nontermty and begin 
  val = optional_code(val)  
 true 
 end)); end then
        @yy_input.pos = yy_varq9
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nontermql 
val = :yy_nil 
begin; yy_varqg = @yy_input.pos; (yy_nontermtg and begin
      yy_varqh = yy_nontermmy
      if yy_varqh then
        val = yy_from_pcv(yy_varqh)
      end
      yy_varqh
    end and yy_nontermtj) or (@yy_input.pos = yy_varqg; (begin
      yy_varqi = yy_nontermvi
      if yy_varqi then
        var = yy_from_pcv(yy_varqi)
      end
      yy_varqi
    end and yy_nontermtm and yy_nontermtp and begin
      yy_varqj = yy_nontermmy
      if yy_varqj then
        c = yy_from_pcv(yy_varqj)
      end
      yy_varqj
    end and yy_nontermts and begin 
  val = capture_text_code(var, c)  
 true 
 end)) or (@yy_input.pos = yy_varqg; begin
      yy_varqk = yy_nontermqw
      if yy_varqk then
        val = yy_from_pcv(yy_varqk)
      end
      yy_varqk
    end); end and yy_to_pcv(val) 
end 
def yy_nontermqw 
val = :yy_nil 
begin; yy_varqr = @yy_input.pos; (begin
      yy_varqs = yy_nontermzk
      if yy_varqs then
        r = yy_from_pcv(yy_varqs)
      end
      yy_varqs
    end and begin 
  val = code "yy_char_range(#{r.begin.dump}, #{r.end.dump})"  
 true 
 end) or (@yy_input.pos = yy_varqr; (begin
      yy_varqt = yy_nonterm11p
      if yy_varqt then
        s = yy_from_pcv(yy_varqt)
      end
      yy_varqt
    end and begin 
  val = code "yy_string(#{s.dump})"  
 true 
 end)) or (@yy_input.pos = yy_varqr; (begin
      yy_varqu = yy_nontermz3
      if yy_varqu then
        n = yy_from_pcv(yy_varqu)
      end
      yy_varqu
    end and begin 
  val = UnknownCode[n]  
 true 
 end)) or (@yy_input.pos = yy_varqr; (yy_nontermue and begin 
  val = code "@yy_input.getc"  
 true 
 end)) or (@yy_input.pos = yy_varqr; (begin
      yy_varqv = yy_nonterms8
      if yy_varqv then
        a = yy_from_pcv(yy_varqv)
      end
      yy_varqv
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (@yy_input.pos = yy_varqr; (yy_nontermtd and begin 
  val = code "@yy_input.eof?"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nontermr9 
val = :yy_nil 
(begin 
  val = HashMap1.new  
 true 
 end and (begin
      yy_varr7 = yy_nontermrg
      if yy_varr7 then
        r = yy_from_pcv(yy_varr7)
      end
      yy_varr7
    end and begin 
 
      nonterminal, definition = *r
      raise %(rule "#{nonterminal}" is already defined) if val.has_key? nonterminal
      val[nonterminal] = definition
     
 true 
 end) and while true
      yy_varr8 = @yy_input.pos
      if not (begin
      yy_varr7 = yy_nontermrg
      if yy_varr7 then
        r = yy_from_pcv(yy_varr7)
      end
      yy_varr7
    end and begin 
 
      nonterminal, definition = *r
      raise %(rule "#{nonterminal}" is already defined) if val.has_key? nonterminal
      val[nonterminal] = definition
     
 true 
 end) then
        @yy_input.pos = yy_varr8
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nontermrg 
val = :yy_nil 
(begin
      yy_varre = yy_nontermz3
      if yy_varre then
        n = yy_from_pcv(yy_varre)
      end
      yy_varre
    end and yy_nontermt4 and begin
      yy_varrf = yy_nontermmy
      if yy_varrf then
        c = yy_from_pcv(yy_varrf)
      end
      yy_varrf
    end and yy_nontermt7 and begin 
  val = [n, to_method_definition(c, new_unique_nonterminal_method_name)]  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermrx 
val = :yy_nil 
(yy_string("%%") and while true
      yy_varrw = @yy_input.pos
      if not (not begin
      yy_varru = @yy_input.pos
      yy_varrv = yy_nonterm13c
      @yy_input.pos = yy_varru
      yy_varrv
    end and @yy_input.getc) then
        @yy_input.pos = yy_varrw
        break true
      end
    end and yy_nonterm13c) and yy_to_pcv(val) 
end 
def yy_nonterms8 
val = :yy_nil 
(begin
      yy_vars6 = @yy_input.pos
      yy_nontermsx and begin
        yy_vars7 = @yy_input.pos
        @yy_input.pos = yy_vars6
        val = @yy_input.read(yy_vars7 - yy_vars6).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm12l and begin 
  val = val[1...-1]  
 true 
 end and begin 
  RubyVM::InstructionSequence.compile(val)  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermsx 
val = :yy_nil 
(yy_string("{") and while true
      yy_varsw = @yy_input.pos
      if not (not begin
      yy_varss = @yy_input.pos
      yy_varst = yy_string("}")
      @yy_input.pos = yy_varss
      yy_varst
    end and begin; yy_varsv = @yy_input.pos; yy_nontermsx or (@yy_input.pos = yy_varsv; @yy_input.getc); end) then
        @yy_input.pos = yy_varsw
        break true
      end
    end and yy_string("}")) and yy_to_pcv(val) 
end 
def yy_nontermt4 
val = :yy_nil 
(begin; yy_vart3 = @yy_input.pos; yy_string("<-") or (@yy_input.pos = yy_vart3; yy_string("=")) or (@yy_input.pos = yy_vart3; yy_string("\u{2190}")); end and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermt7 
val = :yy_nil 
(yy_string(";") and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermta 
val = :yy_nil 
(yy_string("/") and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermtd 
val = :yy_nil 
(yy_string("$") and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermtg 
val = :yy_nil 
(yy_string("(") and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermtj 
val = :yy_nil 
(yy_string(")") and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermtm 
val = :yy_nil 
(yy_string(":") and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermtp 
val = :yy_nil 
(yy_string("<") and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermts 
val = :yy_nil 
(yy_string(">") and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermtv 
val = :yy_nil 
(yy_string("*") and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermty 
val = :yy_nil 
(yy_string("?") and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermu1 
val = :yy_nil 
(yy_string("+") and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermu4 
val = :yy_nil 
(yy_string("&") and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermu7 
val = :yy_nil 
(yy_string("!") and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermue 
val = :yy_nil 
(yy_string("char") and not begin
      yy_varuc = @yy_input.pos
      yy_varud = yy_nontermz9
      @yy_input.pos = yy_varuc
      yy_varud
    end and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermul 
val = :yy_nil 
(yy_string("where") and not begin
      yy_varuj = @yy_input.pos
      yy_varuk = yy_nontermz9
      @yy_input.pos = yy_varuj
      yy_varuk
    end and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermus 
val = :yy_nil 
(yy_string("in") and not begin
      yy_varuq = @yy_input.pos
      yy_varur = yy_nontermz9
      @yy_input.pos = yy_varuq
      yy_varur
    end and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermuv 
val = :yy_nil 
begin; yy_varuu = @yy_input.pos; yy_nontermul or (@yy_input.pos = yy_varuu; yy_nontermus) or (@yy_input.pos = yy_varuu; yy_nontermue); end and yy_to_pcv(val) 
end 
def yy_nontermvi 
val = :yy_nil 
(begin
      yy_varvg = @yy_input.pos
      (yy_nontermvl and while true
      yy_varvf = @yy_input.pos
      if not yy_nontermvo then
        @yy_input.pos = yy_varvf
        break true
      end
    end) and begin
        yy_varvh = @yy_input.pos
        @yy_input.pos = yy_varvg
        val = @yy_input.read(yy_varvh - yy_varvg).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm12l) and yy_to_pcv(val) 
end 
def yy_nontermvl 
val = :yy_nil 
begin; yy_varvk = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varvk; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermvo 
val = :yy_nil 
begin; yy_varvn = @yy_input.pos; yy_nontermvl or (@yy_input.pos = yy_varvn; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermz3 
val = :yy_nil 
(not begin
      yy_varxf = @yy_input.pos
      yy_varxg = yy_nontermuv
      @yy_input.pos = yy_varxf
      yy_varxg
    end and begin; yy_varya = @yy_input.pos; (begin
      yy_varyj = @yy_input.pos
      (yy_nontermz6 and while true
      yy_varyi = @yy_input.pos
      if not yy_nontermz9 then
        @yy_input.pos = yy_varyi
        break true
      end
    end) and begin
        yy_varyk = @yy_input.pos
        @yy_input.pos = yy_varyj
        val = @yy_input.read(yy_varyk - yy_varyj).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm12l) or (@yy_input.pos = yy_varya; (begin
      yy_varz1 = @yy_input.pos
      (yy_string("`") and while true
      yy_varz0 = @yy_input.pos
      if not (not begin
      yy_varyy = @yy_input.pos
      yy_varyz = yy_string("`")
      @yy_input.pos = yy_varyy
      yy_varyz
    end and @yy_input.getc) then
        @yy_input.pos = yy_varz0
        break true
      end
    end and yy_string("`")) and begin
        yy_varz2 = @yy_input.pos
        @yy_input.pos = yy_varz1
        val = @yy_input.read(yy_varz2 - yy_varz1).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm12l)); end) and yy_to_pcv(val) 
end 
def yy_nontermz6 
val = :yy_nil 
begin; yy_varz5 = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varz5; yy_char_range("A", "Z")) or (@yy_input.pos = yy_varz5; yy_string("-")) or (@yy_input.pos = yy_varz5; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermz9 
val = :yy_nil 
begin; yy_varz8 = @yy_input.pos; yy_nontermz6 or (@yy_input.pos = yy_varz8; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermzk 
val = :yy_nil 
(begin
      yy_varzg = yy_nonterm11p
      if yy_varzg then
        from = yy_from_pcv(yy_varzg)
      end
      yy_varzg
    end and begin; yy_varzi = @yy_input.pos; yy_string("...") or (@yy_input.pos = yy_varzi; yy_string("..")) or (@yy_input.pos = yy_varzi; yy_string("\u{2026}")) or (@yy_input.pos = yy_varzi; yy_string("\u{2025}")); end and begin
      yy_varzj = yy_nonterm11p
      if yy_varzj then
        to = yy_from_pcv(yy_varzj)
      end
      yy_varzj
    end and yy_nonterm12l and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm11p 
val = :yy_nil 
begin; yy_var10n = @yy_input.pos; (yy_string("'") and begin
      yy_var114 = @yy_input.pos
      while true
      yy_var113 = @yy_input.pos
      if not (not begin
      yy_var111 = @yy_input.pos
      yy_var112 = yy_string("'")
      @yy_input.pos = yy_var111
      yy_var112
    end and @yy_input.getc) then
        @yy_input.pos = yy_var113
        break true
      end
    end and begin
        yy_var115 = @yy_input.pos
        @yy_input.pos = yy_var114
        val = @yy_input.read(yy_var115 - yy_var114).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("'") and yy_nonterm12l) or (@yy_input.pos = yy_var10n; (yy_string("\"") and begin
      yy_var11m = @yy_input.pos
      while true
      yy_var11l = @yy_input.pos
      if not (not begin
      yy_var11j = @yy_input.pos
      yy_var11k = yy_string("\"")
      @yy_input.pos = yy_var11j
      yy_var11k
    end and @yy_input.getc) then
        @yy_input.pos = yy_var11l
        break true
      end
    end and begin
        yy_var11n = @yy_input.pos
        @yy_input.pos = yy_var11m
        val = @yy_input.read(yy_var11n - yy_var11m).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("\"") and yy_nonterm12l)) or (@yy_input.pos = yy_var10n; (begin
      yy_var11o = yy_nonterm12c
      if yy_var11o then
        code = yy_from_pcv(yy_var11o)
      end
      yy_var11o
    end and yy_nonterm12l and begin 
  val = "" << code  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm12c 
val = :yy_nil 
(yy_string("U+") and begin
      yy_var12a = @yy_input.pos
      begin; yy_var128 = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_var128; yy_char_range("A", "F")); end and while true
      yy_var129 = @yy_input.pos
      if not begin; yy_var128 = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_var128; yy_char_range("A", "F")); end then
        @yy_input.pos = yy_var129
        break true
      end
    end and begin
        yy_var12b = @yy_input.pos
        @yy_input.pos = yy_var12a
        code = @yy_input.read(yy_var12b - yy_var12a).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = code.to_i(16)  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm12l 
val = :yy_nil 
while true
      yy_var12k = @yy_input.pos
      if not begin; yy_var12j = @yy_input.pos; yy_nonterm139 or (@yy_input.pos = yy_var12j; yy_nonterm136); end then
        @yy_input.pos = yy_var12k
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm136 
val = :yy_nil 
(begin; yy_var12y = @yy_input.pos; yy_string("#") or (@yy_input.pos = yy_var12y; yy_string("--")); end and while true
      yy_var135 = @yy_input.pos
      if not (not begin
      yy_var133 = @yy_input.pos
      yy_var134 = yy_nonterm13c
      @yy_input.pos = yy_var133
      yy_var134
    end and @yy_input.getc) then
        @yy_input.pos = yy_var135
        break true
      end
    end and yy_nonterm13c) and yy_to_pcv(val) 
end 
def yy_nonterm139 
val = :yy_nil 
begin; yy_var138 = @yy_input.pos; yy_char_range("\t", "\r") or (@yy_input.pos = yy_var138; yy_string(" ")) or (@yy_input.pos = yy_var138; yy_string("\u{85}")) or (@yy_input.pos = yy_var138; yy_string("\u{a0}")) or (@yy_input.pos = yy_var138; yy_string("\u{1680}")) or (@yy_input.pos = yy_var138; yy_string("\u{180e}")) or (@yy_input.pos = yy_var138; yy_char_range("\u{2000}", "\u{200a}")) or (@yy_input.pos = yy_var138; yy_string("\u{2028}")) or (@yy_input.pos = yy_var138; yy_string("\u{2029}")) or (@yy_input.pos = yy_var138; yy_string("\u{202f}")) or (@yy_input.pos = yy_var138; yy_string("\u{205f}")) or (@yy_input.pos = yy_var138; yy_string("\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nonterm13c 
val = :yy_nil 
begin; yy_var13b = @yy_input.pos; (yy_string("\r") and yy_string("\n")) or (@yy_input.pos = yy_var13b; yy_string("\r")) or (@yy_input.pos = yy_var13b; yy_string("\n")) or (@yy_input.pos = yy_var13b; yy_string("\u{85}")) or (@yy_input.pos = yy_var13b; yy_string("\v")) or (@yy_input.pos = yy_var13b; yy_string("\f")) or (@yy_input.pos = yy_var13b; yy_string("\u{2028}")) or (@yy_input.pos = yy_var13b; yy_string("\u{2029}")); end and yy_to_pcv(val) 
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
