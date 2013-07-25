#!/usr/bin/ruby
# encoding: UTF-8

# This file is both runnable and "require"-able.


# 
class String
  
  # returns Ruby code which evaluates to this String.
  def to_ruby_code
    self.dump
  end
  
end


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
        x = yy_nonterm0 or raise YY_SyntaxError
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
    def yy_nonterm0 
val = :yy_nil 
(begin 
 
    code = code("")
    rule_is_first = true
    method_names = HashMap.new
   
 true 
 end and yy_nontermgx() and while true
      yy_var9 = @yy_input.pos
      if not begin; yy_var6 = @yy_input.pos; (begin
      yy_var7 = yy_nonterm1y()
      if yy_var7 then
        r = yy_from_pcv(yy_var7)
      end
      yy_var7
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
 end) or (@yy_input.pos = yy_var6; (begin
      yy_var8 = yy_nonterm3l()
      if yy_var8 then
        x = yy_from_pcv(yy_var8)
      end
      yy_var8
    end and begin 
 
        code += code(x)
       
 true 
 end)); end then
        @yy_input.pos = yy_var9
        break true
      end
    end and @yy_input.eof? and begin 
 
    code = link(code, method_names)
    print code
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterma 
val = :yy_nil 
begin
      yy_varc = yy_nontermd()
      if yy_varc then
        val = yy_from_pcv(yy_varc)
      end
      yy_varc
    end and yy_to_pcv(val) 
end 
def yy_nontermd 
val = :yy_nil 
(begin 
 
    single_expression = true
    remembered_pos_var = new_unique_variable_name
   
 true 
 end and begin
      yy_varg = @yy_input.pos
      if not yy_nonterm9h() then
        @yy_input.pos = yy_varg
      end
      true
    end and begin
      yy_varh = yy_nontermo()
      if yy_varh then
        val = yy_from_pcv(yy_varh)
      end
      yy_varh
    end and while true
      yy_varn = @yy_input.pos
      if not (yy_nonterm9h() and begin
      yy_varm = yy_nontermo()
      if yy_varm then
        val2 = yy_from_pcv(yy_varm)
      end
      yy_varm
    end and begin 
 
      single_expression = false
      val = val + (code " or (@yy_input.pos = #{remembered_pos_var}; ") + val2 + (code ")")
     
 true 
 end) then
        @yy_input.pos = yy_varn
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "begin; #{remembered_pos_var} = @yy_input.pos; ") + val + (code "; end")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermo 
val = :yy_nil 
(begin 
  code_parts = []  
 true 
 end and begin; yy_vart = @yy_input.pos; (begin
      yy_varu = yy_nontermw()
      if yy_varu then
        code_part = yy_from_pcv(yy_varu)
      end
      yy_varu
    end and begin 
  code_parts.add code_part  
 true 
 end) or (@yy_input.pos = yy_vart; (yy_nonterm9t() and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end and while true
      yy_varv = @yy_input.pos
      if not begin; yy_vart = @yy_input.pos; (begin
      yy_varu = yy_nontermw()
      if yy_varu then
        code_part = yy_from_pcv(yy_varu)
      end
      yy_varu
    end and begin 
  code_parts.add code_part  
 true 
 end) or (@yy_input.pos = yy_vart; (yy_nonterm9t() and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end then
        @yy_input.pos = yy_varv
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
  
def yy_nontermw 
val = :yy_nil 
begin; yy_varx = @yy_input.pos; (begin
      yy_vary = yy_nonterm11()
      if yy_vary then
        c = yy_from_pcv(yy_vary)
      end
      yy_vary
    end and yy_nonterm9v() and begin
      yy_varz = yy_nonterm39()
      if yy_varz then
        var = yy_from_pcv(yy_varz)
      end
      yy_varz
    end and begin 
  val = capture_semantic_value_code(var, c)  
 true 
 end) or (@yy_input.pos = yy_varx; begin
      yy_var10 = yy_nonterm11()
      if yy_var10 then
        val = yy_from_pcv(yy_var10)
      end
      yy_var10
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm11 
val = :yy_nil 
begin; yy_var12 = @yy_input.pos; (yy_nonterma9() and begin
      yy_var13 = yy_nonterm3l()
      if yy_var13 then
        c = yy_from_pcv(yy_var13)
      end
      yy_var13
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (@yy_input.pos = yy_var12; (yy_nonterma9() and begin
      yy_var14 = yy_nonterm11()
      if yy_var14 then
        val = yy_from_pcv(yy_var14)
      end
      yy_var14
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var12; (yy_nontermab() and begin
      yy_var15 = yy_nonterm11()
      if yy_var15 then
        val = yy_from_pcv(yy_var15)
      end
      yy_var15
    end and begin 
  val = code(%(not )) + positive_predicate_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var12; begin
      yy_var16 = yy_nonterm17()
      if yy_var16 then
        val = yy_from_pcv(yy_var16)
      end
      yy_var16
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm17 
val = :yy_nil 
(begin
      yy_var19 = yy_nonterm1e()
      if yy_var19 then
        val = yy_from_pcv(yy_var19)
      end
      yy_var19
    end and while true
      yy_var1d = @yy_input.pos
      if not begin; yy_var1c = @yy_input.pos; (yy_nonterma3() and begin 
  val = lazy_repeat_code(val)  
 true 
 end) or (@yy_input.pos = yy_var1c; (yy_nonterma1() and begin 
  val = repeat_many_times_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1c; (yy_nonterma7() and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (@yy_input.pos = yy_var1c; (yy_nonterma5() and begin 
  val = optional_code(val)  
 true 
 end)); end then
        @yy_input.pos = yy_var1d
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm1e 
val = :yy_nil 
begin; yy_var1f = @yy_input.pos; (yy_nonterm9n() and begin
      yy_var1g = yy_nonterma()
      if yy_var1g then
        val = yy_from_pcv(yy_var1g)
      end
      yy_var1g
    end and yy_nonterm9p()) or (@yy_input.pos = yy_var1f; (yy_nonterm9x() and begin
      yy_var1h = yy_nonterma()
      if yy_var1h then
        c = yy_from_pcv(yy_var1h)
      end
      yy_var1h
    end and yy_nonterm9z() and yy_nonterm9v() and begin
      yy_var1i = yy_nonterm39()
      if yy_var1i then
        var = yy_from_pcv(yy_var1i)
      end
      yy_var1i
    end and begin 
  val = capture_text_code(var, c)  
 true 
 end)) or (@yy_input.pos = yy_var1f; begin
      yy_var1j = yy_nonterm1k()
      if yy_var1j then
        val = yy_from_pcv(yy_var1j)
      end
      yy_var1j
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1k 
val = :yy_nil 
begin; yy_var1l = @yy_input.pos; (begin
      yy_var1m = yy_nontermel()
      if yy_var1m then
        r = yy_from_pcv(yy_var1m)
      end
      yy_var1m
    end and begin 
  val = code "yy_char_range(#{r.begin.to_ruby_code}, #{r.end.to_ruby_code})"  
 true 
 end) or (@yy_input.pos = yy_var1l; (begin
      yy_var1n = yy_nontermer()
      if yy_var1n then
        s = yy_from_pcv(yy_var1n)
      end
      yy_var1n
    end and begin 
  val = code "yy_string(#{s.to_ruby_code})"  
 true 
 end)) or (@yy_input.pos = yy_var1l; (begin
      yy_var1o = yy_nontermcp()
      if yy_var1o then
        n = yy_from_pcv(yy_var1o)
      end
      yy_var1o
    end and begin 
  val = UnknownMethodCall[n]  
 true 
 end)) or (@yy_input.pos = yy_var1l; (yy_nontermaj() and begin 
  val = code "@yy_input.getc"  
 true 
 end)) or (@yy_input.pos = yy_var1l; (begin
      yy_var1p = yy_nonterm3l()
      if yy_var1p then
        a = yy_from_pcv(yy_var1p)
      end
      yy_var1p
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (@yy_input.pos = yy_var1l; (yy_nonterm9j() and begin 
  val = code "@yy_input.eof?"  
 true 
 end)) or (@yy_input.pos = yy_var1l; (yy_nonterm9l() and begin 
  val = code "(@yy_input.pos == 0)"  
 true 
 end)) or (@yy_input.pos = yy_var1l; (begin; yy_var1t = @yy_input.pos; (yy_nontermad() and yy_nontermaf() and begin
      yy_var1u = yy_nontermax()
      if yy_var1u then
        pos_variable = yy_from_pcv(yy_var1u)
      end
      yy_var1u
    end) or (@yy_input.pos = yy_var1t; (yy_nontermap() and begin
      yy_var1v = yy_nontermax()
      if yy_var1v then
        pos_variable = yy_from_pcv(yy_var1v)
      end
      yy_var1v
    end)); end and begin
      yy_var1x = @yy_input.pos
      if not yy_nonterm9v() then
        @yy_input.pos = yy_var1x
      end
      true
    end and begin 
  val = code "(@yy_input.pos = #{pos_variable}; true)"  
 true 
 end)) or (@yy_input.pos = yy_var1l; (yy_nontermad() and begin 
  val = code "@yy_input.pos"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm1y 
val = :yy_nil 
(begin; yy_var27 = @yy_input.pos; (begin
      yy_var28 = yy_nontermc5()
      if yy_var28 then
        rule_name = yy_from_pcv(yy_var28)
      end
      yy_var28
    end and yy_nonterm9n() and begin
      yy_var2c = @yy_input.pos
      if not begin; yy_var2b = @yy_input.pos; yy_nontermah() or (@yy_input.pos = yy_var2b; yy_nontermbl()); end then
        @yy_input.pos = yy_var2c
      end
      true
    end and yy_nonterm9p() and begin 
  method_name = rule_name  
 true 
 end) or (@yy_input.pos = yy_var27; (begin
      yy_var2d = yy_nontermcp()
      if yy_var2d then
        rule_name = yy_from_pcv(yy_var2d)
      end
      yy_var2d
    end and begin 
  method_name = new_unique_nonterminal_method_name  
 true 
 end)); end and begin
      yy_var2h = @yy_input.pos
      if not (yy_nonterm9v() and yy_nonterm2j()) then
        @yy_input.pos = yy_var2h
      end
      true
    end and yy_nonterm99() and begin
      yy_var2i = yy_nonterma()
      if yy_var2i then
        c = yy_from_pcv(yy_var2i)
      end
      yy_var2i
    end and yy_nonterm9f() and begin 
  val = [rule_name, method_name, to_method_definition(c, method_name)]  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterm2j 
val = :yy_nil 
((not begin
      yy_var36 = @yy_input.pos
      yy_var37 = yy_nonterm99()
      @yy_input.pos = yy_var36
      yy_var37
    end and @yy_input.getc) and yy_nontermgx()) and while true
      yy_var38 = @yy_input.pos
      if not ((not begin
      yy_var36 = @yy_input.pos
      yy_var37 = yy_nonterm99()
      @yy_input.pos = yy_var36
      yy_var37
    end and @yy_input.getc) and yy_nontermgx()) then
        @yy_input.pos = yy_var38
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm39 
val = :yy_nil 
begin; yy_var3a = @yy_input.pos; begin
      yy_var3b = yy_nontermax()
      if yy_var3b then
        val = yy_from_pcv(yy_var3b)
      end
      yy_var3b
    end or (@yy_input.pos = yy_var3a; (yy_nonterm9n() and begin
      yy_var3c = yy_nontermax()
      if yy_var3c then
        val = yy_from_pcv(yy_var3c)
      end
      yy_var3c
    end and yy_nonterm9p())); end and yy_to_pcv(val) 
end 
def yy_nonterm3d 
val = :yy_nil 
(yy_string("%%") and  begin
      while true
        ###
        yy_var3h = @yy_input.pos
        ### Look ahead.
        yy_var3i = begin; yy_var3k = @yy_input.pos; yy_nontermhf() or (@yy_input.pos = yy_var3k; @yy_input.eof?); end
        @yy_input.pos = yy_var3h
        break if yy_var3i
        ### Repeat one more time (if possible).
        yy_var3i = @yy_input.getc
        if not yy_var3i then
          @yy_input.pos = yy_var3h
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_var3k = @yy_input.pos; yy_nontermhf() or (@yy_input.pos = yy_var3k; @yy_input.eof?); end) and yy_to_pcv(val) 
end 
def yy_nonterm3l 
val = :yy_nil 
(begin; yy_var6c = @yy_input.pos; (yy_string("{") and while true
      yy_var6e = @yy_input.pos
      if not yy_nontermhd() then
        @yy_input.pos = yy_var6e
        break true
      end
    end and yy_string("...") and begin
      yy_var6q = @yy_input.pos
      if not ( begin
      while true
        ###
        yy_var6o = @yy_input.pos
        ### Look ahead.
        yy_var6p = yy_nontermhf()
        @yy_input.pos = yy_var6o
        break if yy_var6p
        ### Repeat one more time (if possible).
        yy_var6p = yy_nontermhd()
        if not yy_var6p then
          @yy_input.pos = yy_var6o
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nontermhf()) then
        @yy_input.pos = yy_var6q
      end
      true
    end and begin
      val = ""
      yy_var73 = @yy_input.pos
       begin
      while true
        ###
        yy_var71 = @yy_input.pos
        ### Look ahead.
        yy_var72 = begin; yy_var7a = @yy_input.pos; (yy_string("...") and while true
      yy_var7c = @yy_input.pos
      if not yy_nontermhd() then
        @yy_input.pos = yy_var7c
        break true
      end
    end and yy_string("}")) or (@yy_input.pos = yy_var7a; (yy_string("}") and while true
      yy_var7e = @yy_input.pos
      if not yy_nontermhd() then
        @yy_input.pos = yy_var7e
        break true
      end
    end and yy_string("..."))); end
        @yy_input.pos = yy_var71
        break if yy_var72
        ### Repeat one more time (if possible).
        yy_var72 = @yy_input.getc
        if not yy_var72 then
          @yy_input.pos = yy_var71
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var74 = @yy_input.pos
        @yy_input.pos = yy_var73
        val << @yy_input.read(yy_var74 - yy_var73).force_encoding(Encoding::UTF_8)
      end
    end and begin; yy_var7a = @yy_input.pos; (yy_string("...") and while true
      yy_var7c = @yy_input.pos
      if not yy_nontermhd() then
        @yy_input.pos = yy_var7c
        break true
      end
    end and yy_string("}")) or (@yy_input.pos = yy_var7a; (yy_string("}") and while true
      yy_var7e = @yy_input.pos
      if not yy_nontermhd() then
        @yy_input.pos = yy_var7e
        break true
      end
    end and yy_string("..."))); end) or (@yy_input.pos = yy_var6c; (begin
      val = ""
      yy_var7j = @yy_input.pos
      yy_nonterm91() and begin
        yy_var7k = @yy_input.pos
        @yy_input.pos = yy_var7j
        val << @yy_input.read(yy_var7k - yy_var7j).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = val[1...-1]  
 true 
 end)) or (@yy_input.pos = yy_var6c; (yy_nonterm3d() and begin
      val = ""
      yy_var8d = @yy_input.pos
       begin
      while true
        ###
        yy_var8b = @yy_input.pos
        ### Look ahead.
        yy_var8c = yy_nonterm3d()
        @yy_input.pos = yy_var8b
        break if yy_var8c
        ### Repeat one more time (if possible).
        yy_var8c = @yy_input.getc
        if not yy_var8c then
          @yy_input.pos = yy_var8b
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var8e = @yy_input.pos
        @yy_input.pos = yy_var8d
        val << @yy_input.read(yy_var8e - yy_var8d).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm3d())) or (@yy_input.pos = yy_var6c; (yy_nonterm3d() and begin
      val = ""
      yy_var8z = @yy_input.pos
      while true
      yy_var8y = @yy_input.pos
      if not @yy_input.getc then
        @yy_input.pos = yy_var8y
        break true
      end
    end and begin
        yy_var90 = @yy_input.pos
        @yy_input.pos = yy_var8z
        val << @yy_input.read(yy_var90 - yy_var8z).force_encoding(Encoding::UTF_8)
      end
    end and @yy_input.eof?)); end and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterm91 
val = :yy_nil 
(yy_string("{") and  begin
      while true
        ###
        yy_var97 = @yy_input.pos
        ### Look ahead.
        yy_var98 = yy_string("}")
        @yy_input.pos = yy_var97
        break if yy_var98
        ### Repeat one more time (if possible).
        yy_var98 = begin; yy_var96 = @yy_input.pos; yy_nonterm91() or (@yy_input.pos = yy_var96; @yy_input.getc); end
        if not yy_var98 then
          @yy_input.pos = yy_var97
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string("}")) and yy_to_pcv(val) 
end 
def yy_nonterm99 
val = :yy_nil 
(begin; yy_var9c = @yy_input.pos; yy_string("<-") or (@yy_input.pos = yy_var9c; yy_string("=")) or (@yy_input.pos = yy_var9c; yy_string("\u{2190}")); end and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterm9d 
val = :yy_nil 
(yy_string(":") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterm9f 
val = :yy_nil 
(yy_string(";") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterm9h 
val = :yy_nil 
(yy_string("/") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterm9j 
val = :yy_nil 
(yy_string("$") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterm9l 
val = :yy_nil 
(yy_string("^") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterm9n 
val = :yy_nil 
(yy_string("(") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterm9p 
val = :yy_nil 
(yy_string(")") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterm9r 
val = :yy_nil 
(yy_string("[") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterm9t 
val = :yy_nil 
(yy_string("]") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterm9v 
val = :yy_nil 
(yy_string(":") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterm9x 
val = :yy_nil 
(yy_string("<") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterm9z 
val = :yy_nil 
(yy_string(">") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterma1 
val = :yy_nil 
(yy_string("*") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterma3 
val = :yy_nil 
(yy_string("*?") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterma5 
val = :yy_nil 
(yy_string("?") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterma7 
val = :yy_nil 
(yy_string("+") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nonterma9 
val = :yy_nil 
(yy_string("&") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nontermab 
val = :yy_nil 
(yy_string("!") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nontermad 
val = :yy_nil 
(yy_string("@") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nontermaf 
val = :yy_nil 
(yy_string("=") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nontermah 
val = :yy_nil 
(yy_string("...") and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nontermaj 
val = :yy_nil 
(yy_string("char") and not begin
      yy_varan = @yy_input.pos
      yy_varao = yy_nontermej()
      @yy_input.pos = yy_varan
      yy_varao
    end and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nontermap 
val = :yy_nil 
(yy_string("at") and not begin
      yy_varat = @yy_input.pos
      yy_varau = yy_nontermej()
      @yy_input.pos = yy_varat
      yy_varau
    end and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nontermav 
val = :yy_nil 
begin; yy_varaw = @yy_input.pos; yy_nontermaj() or (@yy_input.pos = yy_varaw; yy_nontermap()); end and yy_to_pcv(val) 
end 
def yy_nontermax 
val = :yy_nil 
(begin
      val = ""
      yy_varbj = @yy_input.pos
      (begin
      yy_varbe = @yy_input.pos
      if not begin; yy_varbd = @yy_input.pos; yy_string("@") or (@yy_input.pos = yy_varbd; yy_string("$")); end then
        @yy_input.pos = yy_varbe
      end
      true
    end and yy_nontermc1() and while true
      yy_varbi = @yy_input.pos
      if not yy_nontermc3() then
        @yy_input.pos = yy_varbi
        break true
      end
    end) and begin
        yy_varbk = @yy_input.pos
        @yy_input.pos = yy_varbj
        val << @yy_input.read(yy_varbk - yy_varbj).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nontermbl 
val = :yy_nil 
(begin
      val = ""
      yy_varbz = @yy_input.pos
      (yy_nontermc1() and while true
      yy_varby = @yy_input.pos
      if not yy_nontermc3() then
        @yy_input.pos = yy_varby
        break true
      end
    end) and begin
        yy_varc0 = @yy_input.pos
        @yy_input.pos = yy_varbz
        val << @yy_input.read(yy_varc0 - yy_varbz).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nontermc1 
val = :yy_nil 
begin; yy_varc2 = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varc2; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermc3 
val = :yy_nil 
begin; yy_varc4 = @yy_input.pos; yy_nontermc1() or (@yy_input.pos = yy_varc4; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermc5 
val = :yy_nil 
(begin
      val = ""
      yy_varcj = @yy_input.pos
      (yy_nontermcl() and while true
      yy_varci = @yy_input.pos
      if not yy_nontermcn() then
        @yy_input.pos = yy_varci
        break true
      end
    end) and begin
        yy_varck = @yy_input.pos
        @yy_input.pos = yy_varcj
        val << @yy_input.read(yy_varck - yy_varcj).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nontermcl 
val = :yy_nil 
begin; yy_varcm = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varcm; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermcn 
val = :yy_nil 
begin; yy_varco = @yy_input.pos; yy_nontermcl() or (@yy_input.pos = yy_varco; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermcp 
val = :yy_nil 
(not begin
      yy_varct = @yy_input.pos
      yy_varcu = yy_nontermav()
      @yy_input.pos = yy_varct
      yy_varcu
    end and begin; yy_vardo = @yy_input.pos; (begin
      val = ""
      yy_vare1 = @yy_input.pos
      (yy_nontermeh() and while true
      yy_vare0 = @yy_input.pos
      if not yy_nontermej() then
        @yy_input.pos = yy_vare0
        break true
      end
    end) and begin
        yy_vare2 = @yy_input.pos
        @yy_input.pos = yy_vare1
        val << @yy_input.read(yy_vare2 - yy_vare1).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermgx()) or (@yy_input.pos = yy_vardo; (begin
      val = ""
      yy_varef = @yy_input.pos
      (yy_string("`") and  begin
      while true
        ###
        yy_vared = @yy_input.pos
        ### Look ahead.
        yy_varee = yy_string("`")
        @yy_input.pos = yy_vared
        break if yy_varee
        ### Repeat one more time (if possible).
        yy_varee = @yy_input.getc
        if not yy_varee then
          @yy_input.pos = yy_vared
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string("`")) and begin
        yy_vareg = @yy_input.pos
        @yy_input.pos = yy_varef
        val << @yy_input.read(yy_vareg - yy_varef).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermgx())); end) and yy_to_pcv(val) 
end 
def yy_nontermeh 
val = :yy_nil 
begin; yy_varei = @yy_input.pos; yy_char_range("a", "z") or (@yy_input.pos = yy_varei; yy_char_range("A", "Z")) or (@yy_input.pos = yy_varei; yy_string("-")) or (@yy_input.pos = yy_varei; yy_string("_")); end and yy_to_pcv(val) 
end 
def yy_nontermej 
val = :yy_nil 
begin; yy_varek = @yy_input.pos; yy_nontermeh() or (@yy_input.pos = yy_varek; yy_char_range("0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermel 
val = :yy_nil 
(begin
      yy_varen = yy_nontermer()
      if yy_varen then
        from = yy_from_pcv(yy_varen)
      end
      yy_varen
    end and begin; yy_varep = @yy_input.pos; yy_string("...") or (@yy_input.pos = yy_varep; yy_string("..")) or (@yy_input.pos = yy_varep; yy_string("\u{2026}")) or (@yy_input.pos = yy_varep; yy_string("\u{2025}")); end and yy_nontermgx() and begin
      yy_vareq = yy_nontermer()
      if yy_vareq then
        to = yy_from_pcv(yy_vareq)
      end
      yy_vareq
    end and yy_nontermgx() and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermer 
val = :yy_nil 
(begin; yy_varfn = @yy_input.pos; (yy_string("'") and begin
      val = ""
      yy_varg0 = @yy_input.pos
       begin
      while true
        ###
        yy_varfy = @yy_input.pos
        ### Look ahead.
        yy_varfz = yy_string("'")
        @yy_input.pos = yy_varfy
        break if yy_varfz
        ### Repeat one more time (if possible).
        yy_varfz = @yy_input.getc
        if not yy_varfz then
          @yy_input.pos = yy_varfy
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varg1 = @yy_input.pos
        @yy_input.pos = yy_varg0
        val << @yy_input.read(yy_varg1 - yy_varg0).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("'")) or (@yy_input.pos = yy_varfn; (yy_string("\"") and begin
      val = ""
      yy_varge = @yy_input.pos
       begin
      while true
        ###
        yy_vargc = @yy_input.pos
        ### Look ahead.
        yy_vargd = yy_string("\"")
        @yy_input.pos = yy_vargc
        break if yy_vargd
        ### Repeat one more time (if possible).
        yy_vargd = @yy_input.getc
        if not yy_vargd then
          @yy_input.pos = yy_vargc
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_vargf = @yy_input.pos
        @yy_input.pos = yy_varge
        val << @yy_input.read(yy_vargf - yy_varge).force_encoding(Encoding::UTF_8)
      end
    end and yy_string("\""))) or (@yy_input.pos = yy_varfn; (begin
      yy_vargg = yy_nontermgh()
      if yy_vargg then
        code = yy_from_pcv(yy_vargg)
      end
      yy_vargg
    end and begin 
  val = "" << code  
 true 
 end)); end and yy_nontermgx()) and yy_to_pcv(val) 
end 
def yy_nontermgh 
val = :yy_nil 
(yy_string("U+") and begin
      code = ""
      yy_vargv = @yy_input.pos
      begin; yy_vargt = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_vargt; yy_char_range("A", "F")); end and while true
      yy_vargu = @yy_input.pos
      if not begin; yy_vargt = @yy_input.pos; yy_char_range("0", "9") or (@yy_input.pos = yy_vargt; yy_char_range("A", "F")); end then
        @yy_input.pos = yy_vargu
        break true
      end
    end and begin
        yy_vargw = @yy_input.pos
        @yy_input.pos = yy_vargv
        code << @yy_input.read(yy_vargw - yy_vargv).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermgx 
val = :yy_nil 
while true
      yy_varh2 = @yy_input.pos
      if not begin; yy_varh1 = @yy_input.pos; yy_nontermhd() or (@yy_input.pos = yy_varh1; yy_nontermh3()); end then
        @yy_input.pos = yy_varh2
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nontermh3 
val = :yy_nil 
(begin; yy_varh6 = @yy_input.pos; yy_string("#") or (@yy_input.pos = yy_varh6; yy_string("--")); end and  begin
      while true
        ###
        yy_varh9 = @yy_input.pos
        ### Look ahead.
        yy_varha = begin; yy_varhc = @yy_input.pos; yy_nontermhf() or (@yy_input.pos = yy_varhc; @yy_input.eof?); end
        @yy_input.pos = yy_varh9
        break if yy_varha
        ### Repeat one more time (if possible).
        yy_varha = @yy_input.getc
        if not yy_varha then
          @yy_input.pos = yy_varh9
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_varhc = @yy_input.pos; yy_nontermhf() or (@yy_input.pos = yy_varhc; @yy_input.eof?); end) and yy_to_pcv(val) 
end 
def yy_nontermhd 
val = :yy_nil 
begin; yy_varhe = @yy_input.pos; yy_char_range("\t", "\r") or (@yy_input.pos = yy_varhe; yy_string(" ")) or (@yy_input.pos = yy_varhe; yy_string("\u{85}")) or (@yy_input.pos = yy_varhe; yy_string("\u{a0}")) or (@yy_input.pos = yy_varhe; yy_string("\u{1680}")) or (@yy_input.pos = yy_varhe; yy_string("\u{180e}")) or (@yy_input.pos = yy_varhe; yy_char_range("\u{2000}", "\u{200a}")) or (@yy_input.pos = yy_varhe; yy_string("\u{2028}")) or (@yy_input.pos = yy_varhe; yy_string("\u{2029}")) or (@yy_input.pos = yy_varhe; yy_string("\u{202f}")) or (@yy_input.pos = yy_varhe; yy_string("\u{205f}")) or (@yy_input.pos = yy_varhe; yy_string("\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nontermhf 
val = :yy_nil 
begin; yy_varhg = @yy_input.pos; (yy_string("\r") and yy_string("\n")) or (@yy_input.pos = yy_varhg; yy_string("\r")) or (@yy_input.pos = yy_varhg; yy_string("\n")) or (@yy_input.pos = yy_varhg; yy_string("\u{85}")) or (@yy_input.pos = yy_varhg; yy_string("\v")) or (@yy_input.pos = yy_varhg; yy_string("\f")) or (@yy_input.pos = yy_varhg; yy_string("\u{2028}")) or (@yy_input.pos = yy_varhg; yy_string("\u{2029}")); end and yy_to_pcv(val) 
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
