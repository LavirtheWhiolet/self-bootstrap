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
              # Initialize.
              @yy_input = input
              # Parse!
              (val = yy_nonterm1u) or raise SyntaxError
              # 
              return yy_from_pcv(val)
            end
          
          def yy_nonterm1u
            val = :yy_nil
            (yy_nonterm4 and begin; yy_var6 = @yy_input.pos; (yy_nonterma and begin; yy_varq = @yy_input.pos; yy_vars = begin; while true; yy_varf = @yy_input.pos; (begin; yy_varh = @yy_input.pos; (not yy_nonterma) and (@yy_input.pos = yy_varh; true); end and @yy_input.getc) or (@yy_input.pos = yy_varf; break); end; true; end; if yy_vars then yy_varr = @yy_input.pos; @yy_input.pos = yy_varq; code = @yy_input.read(yy_varr - yy_varq) end; yy_vars; end and yy_nonterma and yy_nonterm4 and begin  print code ; true; end) or (@yy_input.pos = yy_var6); true; end and begin; yy_var14 = yy_nonterm13; if yy_var14 then val = yy_from_pcv(yy_var14) end; yy_var14; end and begin  generate_parser_body(val) ; true; end and begin; yy_var18 = @yy_input.pos; (yy_nonterma and begin; yy_var1j = @yy_input.pos; yy_var1l = begin; while true; yy_var1g = @yy_input.pos; @yy_input.getc or (@yy_input.pos = yy_var1g; break); end; true; end; if yy_var1l then yy_var1k = @yy_input.pos; @yy_input.pos = yy_var1j; code = @yy_input.read(yy_var1k - yy_var1j) end; yy_var1l; end and begin  print code ; true; end) or (@yy_input.pos = yy_var18); true; end and @yy_input.eof?) and yy_to_pcv(val)
          end
        

          def yy_nonterm13
            val = :yy_nil
            begin; yy_var1z = yy_nonterm1y; if yy_var1z then val = yy_from_pcv(yy_var1z) end; yy_var1z; end and yy_to_pcv(val)
          end
        

          def yy_nonterm1y
            val = :yy_nil
            begin; yy_var22 = @yy_input.pos; (begin; yy_var28 = @yy_input.pos; (begin; yy_var2c = yy_nonterm2b; if yy_var2c then r = yy_from_pcv(yy_var2c) end; yy_var2c; end and yy_nonterm2f and begin; yy_var2i = yy_nonterm1y; if yy_var2i then c = yy_from_pcv(yy_var2i) end; yy_var2i; end) or (@yy_input.pos = yy_var28; (begin; yy_var2o = yy_nonterm2n; if yy_var2o then c = yy_from_pcv(yy_var2o) end; yy_var2o; end and yy_nonterm2r and begin; yy_var2u = yy_nonterm2b; if yy_var2u then r = yy_from_pcv(yy_var2u) end; yy_var2u; end)) or (@yy_input.pos = yy_var28; (begin; yy_var2z = yy_nonterm2b; if yy_var2z then r = yy_from_pcv(yy_var2z) end; yy_var2z; end and begin  c = code "#{r.first_value.method_name}" ; true; end)); end and begin  val = link(c, r) ; true; end) or (@yy_input.pos = yy_var22; begin; yy_var3c = yy_nonterm2n; if yy_var3c then val = yy_from_pcv(yy_var3c) end; yy_var3c; end); end and yy_to_pcv(val)
          end
        

          def yy_nonterm2n
            val = :yy_nil
            (begin 
    single_expression = true
    remembered_pos_var = new_unique_variable_name
  ; true; end and begin; yy_var3j = @yy_input.pos; yy_nonterm3k or (@yy_input.pos = yy_var3j); true; end and begin; yy_var3o = yy_nonterm3n; if yy_var3o then val = yy_from_pcv(yy_var3o) end; yy_var3o; end and begin; while true; yy_var3q = @yy_input.pos; (yy_nonterm3k and begin; yy_var3w = yy_nonterm3n; if yy_var3w then val2 = yy_from_pcv(yy_var3w) end; yy_var3w; end and begin 
      single_expression = false
      val = val + (code " or (@yy_input.pos = #{remembered_pos_var}; ") + val2 + (code ")")
    ; true; end) or (@yy_input.pos = yy_var3q; break); end; true; end and begin 
    if not single_expression then
      val = (code "begin; #{remembered_pos_var} = @yy_input.pos; ") + val + (code "; end")
    end
  ; true; end) and yy_to_pcv(val)
          end
        

          def yy_nonterm3n
            val = :yy_nil
            (begin  single_expression = true ; true; end and begin; yy_var4b = yy_nonterm4a; if yy_var4b then val = yy_from_pcv(yy_var4b) end; yy_var4b; end and begin; while true; yy_var4d = @yy_input.pos; (begin; yy_var4h = yy_nonterm4a; if yy_var4h then val2 = yy_from_pcv(yy_var4h) end; yy_var4h; end and begin 
      single_expression = false
      val = val + (code " and ") + val2
    ; true; end) or (@yy_input.pos = yy_var4d; break); end; true; end and begin 
    if not single_expression then
      val = (code "(") + val + (code ")")
    end
  ; true; end) and yy_to_pcv(val)
          end
        

          def yy_nonterm4a
            val = :yy_nil
            begin; yy_var4q = @yy_input.pos; (begin; yy_var4u = yy_nonterm4t; if yy_var4u then var = yy_from_pcv(yy_var4u) end; yy_var4u; end and yy_nonterm4x and begin; yy_var50 = yy_nonterm4a; if yy_var50 then c = yy_from_pcv(yy_var50) end; yy_var50; end and begin  val = capture_semantic_value_code(var, c) ; true; end) or (@yy_input.pos = yy_var4q; begin; yy_var58 = yy_nonterm57; if yy_var58 then val = yy_from_pcv(yy_var58) end; yy_var58; end); end and yy_to_pcv(val)
          end
        

          def yy_nonterm57
            val = :yy_nil
            begin; yy_var5b = @yy_input.pos; (yy_nonterm5e and begin; yy_var5h = yy_nonterm57; if yy_var5h then val = yy_from_pcv(yy_var5h) end; yy_var5h; end and begin  val = positive_predicate_code(val) ; true; end) or (@yy_input.pos = yy_var5b; (yy_nonterm5o and begin; yy_var5r = yy_nonterm57; if yy_var5r then val = yy_from_pcv(yy_var5r) end; yy_var5r; end and begin  val = code(%(not )) + positive_predicate_code(val) ; true; end)) or (@yy_input.pos = yy_var5b; begin; yy_var5z = yy_nonterm5y; if yy_var5z then val = yy_from_pcv(yy_var5z) end; yy_var5z; end); end and yy_to_pcv(val)
          end
        

          def yy_nonterm5y
            val = :yy_nil
            (begin; yy_var66 = yy_nonterm65; if yy_var66 then val = yy_from_pcv(yy_var66) end; yy_var66; end and begin; while true; yy_var68 = @yy_input.pos; begin; yy_var69 = @yy_input.pos; (yy_nonterm6c and begin  val = repeat_many_times_code(val) ; true; end) or (@yy_input.pos = yy_var69; (yy_nonterm6j and begin  val = repeat_at_least_once_code(val) ; true; end)) or (@yy_input.pos = yy_var69; (yy_nonterm6q and begin  val = optional_code(val) ; true; end)); end or (@yy_input.pos = yy_var68; break); end; true; end) and yy_to_pcv(val)
          end
        

          def yy_nonterm65
            val = :yy_nil
            begin; yy_var6x = @yy_input.pos; (yy_nonterm70 and begin; yy_var73 = yy_nonterm13; if yy_var73 then val = yy_from_pcv(yy_var73) end; yy_var73; end and yy_nonterm76) or (@yy_input.pos = yy_var6x; (begin; yy_var7b = yy_nonterm4t; if yy_var7b then var = yy_from_pcv(yy_var7b) end; yy_var7b; end and yy_nonterm4x and yy_nonterm7g and begin; yy_var7j = yy_nonterm13; if yy_var7j then c = yy_from_pcv(yy_var7j) end; yy_var7j; end and yy_nonterm7m and begin  val = capture_text_code(var, c) ; true; end)) or (@yy_input.pos = yy_var6x; begin; yy_var7u = yy_nonterm7t; if yy_var7u then val = yy_from_pcv(yy_var7u) end; yy_var7u; end); end and yy_to_pcv(val)
          end
        

          def yy_nonterm7t
            val = :yy_nil
            begin; yy_var7x = @yy_input.pos; (begin; yy_var81 = yy_nonterm80; if yy_var81 then r = yy_from_pcv(yy_var81) end; yy_var81; end and begin  val = code "yy_char_range(#{r.begin.dump}, #{r.end.dump})" ; true; end) or (@yy_input.pos = yy_var7x; (begin; yy_var89 = yy_nonterm88; if yy_var89 then s = yy_from_pcv(yy_var89) end; yy_var89; end and begin  val = code "yy_string(#{s.force_encoding("UTF-8").dump})" ; true; end)) or (@yy_input.pos = yy_var7x; (begin; yy_var8h = yy_nonterm8g; if yy_var8h then n = yy_from_pcv(yy_var8h) end; yy_var8h; end and begin  val = UnknownCode[n] ; true; end)) or (@yy_input.pos = yy_var7x; (yy_nonterm8o and begin  val = code "@yy_input.getc" ; true; end)) or (@yy_input.pos = yy_var7x; (begin; yy_var8w = yy_nonterm8v; if yy_var8w then a = yy_from_pcv(yy_var8w) end; yy_var8w; end and begin  val = code "begin \n #{a} \n true \n end" ; true; end)) or (@yy_input.pos = yy_var7x; (yy_nonterm93 and begin  val = code "@yy_input.eof?" ; true; end)); end and yy_to_pcv(val)
          end
        

          def yy_nonterm2b
            val = :yy_nil
            (begin  val = HashMap1.new ; true; end and ((begin; yy_var9h = yy_nonterm9g; if yy_var9h then r = yy_from_pcv(yy_var9h) end; yy_var9h; end and begin 
      nonterminal, definition = *r
      raise %(rule "#{nonterminal}" is already defined) if val.has_key? nonterminal
      val[nonterminal] = definition
    ; true; end) and begin; while true; yy_var9c = @yy_input.pos; (begin; yy_var9h = yy_nonterm9g; if yy_var9h then r = yy_from_pcv(yy_var9h) end; yy_var9h; end and begin 
      nonterminal, definition = *r
      raise %(rule "#{nonterminal}" is already defined) if val.has_key? nonterminal
      val[nonterminal] = definition
    ; true; end) or (@yy_input.pos = yy_var9c; break); end; true; end)) and yy_to_pcv(val)
          end
        

          def yy_nonterm9g
            val = :yy_nil
            (begin; yy_var9r = yy_nonterm8g; if yy_var9r then n = yy_from_pcv(yy_var9r) end; yy_var9r; end and yy_nonterm9u and begin; yy_var9x = yy_nonterm13; if yy_var9x then c = yy_from_pcv(yy_var9x) end; yy_var9x; end and yy_nonterma0 and begin  val = [n, to_method_definition(c, new_unique_nonterminal_method_name)] ; true; end) and yy_to_pcv(val)
          end
        

          def yy_nonterma
            val = :yy_nil
            (yy_string("%%") and begin; while true; yy_vara9 = @yy_input.pos; (begin; yy_varab = @yy_input.pos; (not yy_nontermae) and (@yy_input.pos = yy_varab; true); end and @yy_input.getc) or (@yy_input.pos = yy_vara9; break); end; true; end and yy_nontermae) and yy_to_pcv(val)
          end
        

          def yy_nonterm8v
            val = :yy_nil
            (begin; yy_varaw = @yy_input.pos; yy_varay = yy_nontermat; if yy_varay then yy_varax = @yy_input.pos; @yy_input.pos = yy_varaw; val = @yy_input.read(yy_varax - yy_varaw) end; yy_varay; end and yy_nonterm4 and begin  val = val[1...-1] ; true; end and begin  RubyVM::InstructionSequence.compile(val) ; true; end) and yy_to_pcv(val)
          end
        

          def yy_nontermat
            val = :yy_nil
            (yy_string("{") and begin; while true; yy_varbb = @yy_input.pos; (begin; yy_varbd = @yy_input.pos; (not yy_string("}")) and (@yy_input.pos = yy_varbd; true); end and begin; yy_varbi = @yy_input.pos; yy_nontermat or (@yy_input.pos = yy_varbi; @yy_input.getc); end) or (@yy_input.pos = yy_varbb; break); end; true; end and yy_string("}")) and yy_to_pcv(val)
          end
        

          def yy_nonterm9u
            val = :yy_nil
            (begin; yy_varc0 = @yy_input.pos; yy_string("<-") or (@yy_input.pos = yy_varc0; yy_string("=")); end and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nonterma0
            val = :yy_nil
            (yy_string(";") and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nonterm3k
            val = :yy_nil
            (yy_string("/") and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nonterm93
            val = :yy_nil
            (yy_string("$") and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nonterm70
            val = :yy_nil
            (yy_string("(") and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nonterm76
            val = :yy_nil
            (yy_string(")") and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nonterm4x
            val = :yy_nil
            (yy_string(":") and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nonterm7g
            val = :yy_nil
            (yy_string("<") and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nonterm7m
            val = :yy_nil
            (yy_string(">") and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nonterm6c
            val = :yy_nil
            (yy_string("*") and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nonterm6q
            val = :yy_nil
            (yy_string("?") and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nonterm6j
            val = :yy_nil
            (yy_string("+") and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nonterm5e
            val = :yy_nil
            (yy_string("&") and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nonterm5o
            val = :yy_nil
            (yy_string("!") and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nonterm8o
            val = :yy_nil
            (yy_string("char") and begin; yy_varez = @yy_input.pos; (not yy_nontermf2) and (@yy_input.pos = yy_varez; true); end and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nonterm2r
            val = :yy_nil
            (yy_string("where") and begin; yy_varfa = @yy_input.pos; (not yy_nontermf2) and (@yy_input.pos = yy_varfa; true); end and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nonterm2f
            val = :yy_nil
            (yy_string("in") and begin; yy_varfk = @yy_input.pos; (not yy_nontermf2) and (@yy_input.pos = yy_varfk; true); end and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nontermg4
            val = :yy_nil
            begin; yy_varfr = @yy_input.pos; yy_nonterm2r or (@yy_input.pos = yy_varfr; yy_nonterm2f) or (@yy_input.pos = yy_varfr; yy_nonterm8o); end and yy_to_pcv(val)
          end
        

          def yy_nonterm4t
            val = :yy_nil
            (begin; yy_vargm = @yy_input.pos; yy_vargo = (yy_nontermgb and begin; while true; yy_vargd = @yy_input.pos; yy_nontermgh or (@yy_input.pos = yy_vargd; break); end; true; end); if yy_vargo then yy_vargn = @yy_input.pos; @yy_input.pos = yy_vargm; val = @yy_input.read(yy_vargn - yy_vargm) end; yy_vargo; end and yy_nonterm4) and yy_to_pcv(val)
          end
        

          def yy_nontermgb
            val = :yy_nil
            begin; yy_vargt = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_vargt; yy_string("_")); end and yy_to_pcv(val)
          end
        

          def yy_nontermgh
            val = :yy_nil
            begin; yy_varh2 = @yy_input.pos; yy_nontermgb or (@yy_input.pos = yy_varh2; yy_char_range("0", "9")); end and yy_to_pcv(val)
          end
        

          def yy_nonterm8g
            val = :yy_nil
            (begin; yy_varhc = @yy_input.pos; (not yy_nontermg4) and (@yy_input.pos = yy_varhc; true); end and begin; yy_varhh = @yy_input.pos; (begin; yy_varhx = @yy_input.pos; yy_varhz = (yy_nontermhn and begin; while true; yy_varhp = @yy_input.pos; yy_nontermf2 or (@yy_input.pos = yy_varhp; break); end; true; end); if yy_varhz then yy_varhy = @yy_input.pos; @yy_input.pos = yy_varhx; val = @yy_input.read(yy_varhy - yy_varhx) end; yy_varhz; end and yy_nonterm4) or (@yy_input.pos = yy_varhh; (begin; yy_varin = @yy_input.pos; yy_varip = (yy_string("`") and begin; while true; yy_varia = @yy_input.pos; (begin; yy_varic = @yy_input.pos; (not yy_string("`")) and (@yy_input.pos = yy_varic; true); end and @yy_input.getc) or (@yy_input.pos = yy_varia; break); end; true; end and yy_string("`")); if yy_varip then yy_vario = @yy_input.pos; @yy_input.pos = yy_varin; val = @yy_input.read(yy_vario - yy_varin) end; yy_varip; end and yy_nonterm4)); end) and yy_to_pcv(val)
          end
        

          def yy_nontermhn
            val = :yy_nil
            begin; yy_variw = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_variw; yy_char_range("A", "Z")) or (@yy_input.pos = yy_variw; yy_string("-")) or (@yy_input.pos = yy_variw; yy_string("_")); end and yy_to_pcv(val)
          end
        

          def yy_nontermf2
            val = :yy_nil
            begin; yy_varjd = @yy_input.pos; yy_nontermhn or (@yy_input.pos = yy_varjd; yy_char_range("0", "9")); end and yy_to_pcv(val)
          end
        

          def yy_nonterm80
            val = :yy_nil
            (begin; yy_varjp = yy_nonterm88; if yy_varjp then from = yy_from_pcv(yy_varjp) end; yy_varjp; end and begin; yy_varjs = @yy_input.pos; yy_string("...") or (@yy_input.pos = yy_varjs; yy_string("..")) or (@yy_input.pos = yy_varjs; yy_string("\u{2026}")) or (@yy_input.pos = yy_varjs; yy_string("\u{2025}")); end and begin; yy_varkb = yy_nonterm88; if yy_varkb then to = yy_from_pcv(yy_varkb) end; yy_varkb; end and yy_nonterm4 and begin  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1 ; true; end and begin  val = (from.force_encoding("UTF-8"))...(to.force_encoding("UTF-8")) ; true; end) and yy_to_pcv(val)
          end
        

          def yy_nonterm88
            val = :yy_nil
            begin; yy_varkk = @yy_input.pos; (yy_string("'") and begin; yy_varl2 = @yy_input.pos; yy_varl4 = begin; while true; yy_varkr = @yy_input.pos; (begin; yy_varkt = @yy_input.pos; (not yy_string("'")) and (@yy_input.pos = yy_varkt; true); end and @yy_input.getc) or (@yy_input.pos = yy_varkr; break); end; true; end; if yy_varl4 then yy_varl3 = @yy_input.pos; @yy_input.pos = yy_varl2; val = @yy_input.read(yy_varl3 - yy_varl2) end; yy_varl4; end and yy_string("'") and yy_nonterm4) or (@yy_input.pos = yy_varkk; (yy_string("\"") and begin; yy_varls = @yy_input.pos; yy_varlu = begin; while true; yy_varlh = @yy_input.pos; (begin; yy_varlj = @yy_input.pos; (not yy_string("\"")) and (@yy_input.pos = yy_varlj; true); end and @yy_input.getc) or (@yy_input.pos = yy_varlh; break); end; true; end; if yy_varlu then yy_varlt = @yy_input.pos; @yy_input.pos = yy_varls; val = @yy_input.read(yy_varlt - yy_varls) end; yy_varlu; end and yy_string("\"") and yy_nonterm4)) or (@yy_input.pos = yy_varkk; (begin; yy_varm4 = yy_nontermm3; if yy_varm4 then code = yy_from_pcv(yy_varm4) end; yy_varm4; end and yy_nonterm4 and begin  val = "".force_encoding("UTF-8") << code ; true; end)); end and yy_to_pcv(val)
          end
        

          def yy_nontermm3
            val = :yy_nil
            (yy_string("U+") and begin; yy_varmu = @yy_input.pos; yy_varmw = (begin; yy_varmj = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_varmj; yy_char_range("A", "F")); end and begin; while true; yy_varmi = @yy_input.pos; begin; yy_varmj = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_varmj; yy_char_range("A", "F")); end or (@yy_input.pos = yy_varmi; break); end; true; end); if yy_varmw then yy_varmv = @yy_input.pos; @yy_input.pos = yy_varmu; code = @yy_input.read(yy_varmv - yy_varmu) end; yy_varmw; end and begin  val = code.to_i(16) ; true; end) and yy_to_pcv(val)
          end
        

          def yy_nonterm4
            val = :yy_nil
            begin; while true; yy_varn3 = @yy_input.pos; begin; yy_varn4 = @yy_input.pos; yy_nontermn7 or (@yy_input.pos = yy_varn4; yy_nontermnc); end or (@yy_input.pos = yy_varn3; break); end; true; end and yy_to_pcv(val)
          end
        

          def yy_nontermnc
            val = :yy_nil
            (begin; yy_varnk = @yy_input.pos; yy_string("#") or (@yy_input.pos = yy_varnk; yy_string("--")); end and begin; while true; yy_varnu = @yy_input.pos; (begin; yy_varnw = @yy_input.pos; (not yy_nontermae) and (@yy_input.pos = yy_varnw; true); end and @yy_input.getc) or (@yy_input.pos = yy_varnu; break); end; true; end and yy_nontermae) and yy_to_pcv(val)
          end
        

          def yy_nontermn7
            val = :yy_nil
            begin; yy_varo7 = @yy_input.pos; yy_char_range("\t", "\r") or (@yy_input.pos = yy_varo7; yy_string(" ")) or (@yy_input.pos = yy_varo7; yy_string("\u{85}")) or (@yy_input.pos = yy_varo7; yy_string("\u{a0}")) or (@yy_input.pos = yy_varo7; yy_string("\u{1680}")) or (@yy_input.pos = yy_varo7; yy_string("\u{180e}")) or (@yy_input.pos = yy_varo7; yy_char_range("\u{2000}", "\u{200a}")) or (@yy_input.pos = yy_varo7; yy_string("\u{2028}")) or (@yy_input.pos = yy_varo7; yy_string("\u{2029}")) or (@yy_input.pos = yy_varo7; yy_string("\u{202f}")) or (@yy_input.pos = yy_varo7; yy_string("\u{205f}")) or (@yy_input.pos = yy_varo7; yy_string("\u{3000}")); end and yy_to_pcv(val)
          end
        

          def yy_nontermae
            val = :yy_nil
            begin; yy_varpk = @yy_input.pos; (yy_string("\r") and yy_string("\n")) or (@yy_input.pos = yy_varpk; yy_string("\r")) or (@yy_input.pos = yy_varpk; yy_string("\n")) or (@yy_input.pos = yy_varpk; yy_string("\u{85}")) or (@yy_input.pos = yy_varpk; yy_string("\v")) or (@yy_input.pos = yy_varpk; yy_string("\f")) or (@yy_input.pos = yy_varpk; yy_string("\u{2028}")) or (@yy_input.pos = yy_varpk; yy_string("\u{2029}")); end and yy_to_pcv(val)
          end
        

        def yy_char_range(from, to)
          return nil if @yy_input.eof?
          c = @yy_input.getc
          if from <= c and c <= to then
            return c
          else
            nil
          end
        end
        
        def yy_string(string)
          if ((@yy_input.read(string.bytesize) or "").force_encoding(string.encoding) == string) then string else nil end
        end
        
        # parser compatible (non-nil) value of +value+.
        def yy_to_pcv(value)
          if value.nil? then :yy_nil else value end
        end
        
        # real value of parser compatible value got by #yy_to_pcv().
        def yy_from_pcv(value)
          if value == :yy_nil then nil else value end
        end
        
        class SyntaxError < Exception
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
        #{variable_name} = @yy_input.read(#{end_pos_var} - #{start_pos_var}).force_encoding("UTF-8")
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
        read_string.force_encoding(string.encoding)
        # 
        if read_string == string then return string
        else return nil
        end
      end
      
      def yy_char_range(from, to)
        # 
        c = @yy_input.getc
        return nil if not c
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
