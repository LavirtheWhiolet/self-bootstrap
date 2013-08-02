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


class UniqueNumber
  
  begin
    @@next = 0
  end

  def self.new
    @@next.tap { @@next += 1 }
  end

end


# The value starts with "yy_var" and is lowcase.
def new_unique_variable_name
  "yy_var#{UniqueNumber.new.to_s(36)}"
end


# The value starts with "yy_nonterm" and is lowcase.
def new_unique_nonterminal_method_name
  "yy_nonterm#{UniqueNumber.new.to_s(36)}"
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
        input.set_encoding("UTF-8", "UTF-8")
        context = YY_ParsingContext.new(input)
        yy_from_pcv(
          yy_nonterm1(context) ||
          # TODO: context.worst_error can not be nil here. Prove it.
          raise(context.worst_error)
        )
      end

      # TODO: Allow to pass String to the entry point.
    
      
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

      class YY_ParsingContext
        
        # +input+ is IO.
        def initialize(input)
          @input = input
          @worst_error = nil
        end
        
        attr_reader :input
        
        # It is YY_SyntaxError or nil.
        attr_accessor :worst_error
        
        # adds possible error to this YY_ParsingContext.
        # 
        # +error+ is YY_SyntaxError.
        # 
        def << error
          # Update worst_error.
          if worst_error.nil? or worst_error.pos < error.pos then
            @worst_error = error
          elsif worst_error.pos == error.pos then
            @worst_error = @worst_error.or error
          end
          # 
          return self
        end
        
      end
      
      def yy_string(context, string)
        # 
        string_start_pos = context.input.pos
        # Read string.
        read_string = context.input.read(string.bytesize)
        # Set the string's encoding; check if it fits the argument.
        unless read_string and (read_string.force_encoding(Encoding::UTF_8)) == string then
          # 
          context << YY_SyntaxError.new(string_start_pos, string.inspect)
          # 
          return nil
        end
        # 
        return read_string
      end
      
      def yy_end?(context)
        #
        if not context.input.eof?
          context << YY_SyntaxError.new(context.input.pos, "the end")
          return nil
        end
        #
        return true
      end
      
      def yy_begin?(context)
        #
        if not (context.input.pos == 0)
          context << YY_SyntaxError.new(context.input.pos, "the beginning")
          return nil
        end
        #
        return true
      end
      
      def yy_char(context)
        # 
        char_start_pos = context.input.pos
        # Read a char.
        c = context.input.getc
        # 
        unless c then
          #
          context << YY_SyntaxError.new(char_start_pos, "a character")
          #
          return nil
        end
        #
        return c
      end
      
      def yy_char_range(context, from, to)
        # 
        char_start_pos = context.input.pos
        # Read the char.
        c = context.input.getc
        # Check if it fits the range.
        # NOTE: c has UTF-8 encoding.
        unless c and (from <= c and c <= to) then
          # 
          context << YY_SyntaxError.new(char_start_pos, %(#{from.inspect}...#{to.inspect}))
          # 
          return nil
        end
        #
        return c
      end
      
      class YY_SyntaxError < Exception
        
        def initialize(pos, *expectations)
          @expectations = expectations
          @pos = pos
        end
        
        attr_reader :pos
        
        # +other+ is another YY_SyntaxError.
        # 
        # #pos of this YY_SyntaxError and +other+ must be equal.
        # 
        def or other
          raise %(can not "or" #{YY_SyntaxError}s with different pos) unless self.pos == other.pos
          YY_SyntaxError.new(pos, *(self.expectations + other.expectations))
        end
        
        def message
          expectations = self.expectations.uniq
          [expectations[0...-1].join(", "), expectations[-1]].join(" or ") + " is expected"
        end
        
        # 
        def row_pos(io)
          # TODO
        end
        
        def column(io)
          # TODO
        end
        
        protected
        
        # Private
        attr_reader :expectations
        
      end
    def yy_nonterm1(yy_context) 
val = :yy_nil 
(begin 
 
    code = code("")
    rule_is_first = true
    method_names = HashMap.new
   
 true 
 end and yy_nontermib(yy_context) and while true
      yy_vara = yy_context.input.pos
      if not begin; yy_var7 = yy_context.input.pos; (begin
      yy_var8 = yy_nonterm23(yy_context)
      if yy_var8 then
        rule = yy_from_pcv(yy_var8)
      end
      yy_var8
    end and begin 
 
        # Check that the rule is not defined twice.
        if method_names.has_key?(rule.name) then
          raise %(rule #{rule.name} is defined more than once)
        end
        # 
        if rule_is_first
          code += parser_entry_point_code("yy_parse", rule.method_name)
          code += auxiliary_parser_code
          rule_is_first = false
        end
        # 
        if rule.need_entry_point?
          code += parser_entry_point_code(rule.entry_point_method_name, rule.method_name)
        end
        #
        code += rule.method_definition
        # 
        method_names[rule.name] = rule.method_name
       
 true 
 end) or (yy_context.input.pos = yy_var7; (begin
      yy_var9 = yy_nonterm41(yy_context)
      if yy_var9 then
        action_code = yy_from_pcv(yy_var9)
      end
      yy_var9
    end and begin 
 
        code += code(action_code)
       
 true 
 end)); end then
        yy_context.input.pos = yy_vara
        break true
      end
    end and yy_end?(yy_context) and begin 
 
    code = link(code, method_names)
    check_no_unresolved_nonterminals(code)
    print code
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermb(yy_context) 
val = :yy_nil 
begin
      yy_vard = yy_nonterme(yy_context)
      if yy_vard then
        val = yy_from_pcv(yy_vard)
      end
      yy_vard
    end and yy_to_pcv(val) 
end 
def yy_nonterme(yy_context) 
val = :yy_nil 
(begin 
 
    single_expression = true
    remembered_pos_var = new_unique_variable_name
   
 true 
 end and begin
      yy_varh = yy_context.input.pos
      if not yy_nontermar(yy_context) then
        yy_context.input.pos = yy_varh
      end
      true
    end and begin
      yy_vari = yy_nontermp(yy_context)
      if yy_vari then
        val = yy_from_pcv(yy_vari)
      end
      yy_vari
    end and while true
      yy_varo = yy_context.input.pos
      if not (yy_nontermar(yy_context) and begin
      yy_varn = yy_nontermp(yy_context)
      if yy_varn then
        val2 = yy_from_pcv(yy_varn)
      end
      yy_varn
    end and begin 
 
      single_expression = false
      val = val + (code " or (yy_context.input.pos = #{remembered_pos_var}; ") + val2 + (code ")")
     
 true 
 end) then
        yy_context.input.pos = yy_varo
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "begin; #{remembered_pos_var} = yy_context.input.pos; ") + val + (code "; end")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermp(yy_context) 
val = :yy_nil 
(begin 
  code_parts = []  
 true 
 end and begin; yy_varu = yy_context.input.pos; (begin
      yy_varv = yy_nontermy(yy_context)
      if yy_varv then
        code_part = yy_from_pcv(yy_varv)
      end
      yy_varv
    end and begin 
  code_parts.add code_part  
 true 
 end) or (yy_context.input.pos = yy_varu; (yy_nontermb3(yy_context) and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end and while true
      yy_varw = yy_context.input.pos
      if not begin; yy_varu = yy_context.input.pos; (begin
      yy_varv = yy_nontermy(yy_context)
      if yy_varv then
        code_part = yy_from_pcv(yy_varv)
      end
      yy_varv
    end and begin 
  code_parts.add code_part  
 true 
 end) or (yy_context.input.pos = yy_varu; (yy_nontermb3(yy_context) and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end then
        yy_context.input.pos = yy_varw
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
  
def yy_nontermy(yy_context) 
val = :yy_nil 
begin; yy_varz = yy_context.input.pos; (begin
      yy_var10 = yy_nonterm14(yy_context)
      if yy_var10 then
        c = yy_from_pcv(yy_var10)
      end
      yy_var10
    end and begin
      yy_var11 = yy_nonterm3r(yy_context)
      if yy_var11 then
        t = yy_from_pcv(yy_var11)
      end
      yy_var11
    end and begin
      yy_var12 = yy_nonterm3n(yy_context)
      if yy_var12 then
        var = yy_from_pcv(yy_var12)
      end
      yy_var12
    end and begin 
  val = capture_semantic_value_code(var, c, t)  
 true 
 end) or (yy_context.input.pos = yy_varz; begin
      yy_var13 = yy_nonterm14(yy_context)
      if yy_var13 then
        val = yy_from_pcv(yy_var13)
      end
      yy_var13
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm14(yy_context) 
val = :yy_nil 
begin; yy_var15 = yy_context.input.pos; (yy_nontermbh(yy_context) and begin
      yy_var16 = yy_nonterm41(yy_context)
      if yy_var16 then
        c = yy_from_pcv(yy_var16)
      end
      yy_var16
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (yy_context.input.pos = yy_var15; (yy_nontermbh(yy_context) and begin
      yy_var17 = yy_nonterm14(yy_context)
      if yy_var17 then
        val = yy_from_pcv(yy_var17)
      end
      yy_var17
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var15; (yy_nontermbj(yy_context) and begin
      yy_var18 = yy_nonterm14(yy_context)
      if yy_var18 then
        val = yy_from_pcv(yy_var18)
      end
      yy_var18
    end and begin 
  val = negative_predicate_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var15; begin
      yy_var19 = yy_nonterm1a(yy_context)
      if yy_var19 then
        val = yy_from_pcv(yy_var19)
      end
      yy_var19
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1a(yy_context) 
val = :yy_nil 
(begin
      yy_var1c = yy_nonterm1h(yy_context)
      if yy_var1c then
        val = yy_from_pcv(yy_var1c)
      end
      yy_var1c
    end and while true
      yy_var1g = yy_context.input.pos
      if not begin; yy_var1f = yy_context.input.pos; (yy_nontermbb(yy_context) and begin 
  val = lazy_repeat_code(val)  
 true 
 end) or (yy_context.input.pos = yy_var1f; (yy_nontermb9(yy_context) and begin 
  val = repeat_many_times_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var1f; (yy_nontermbf(yy_context) and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var1f; (yy_nontermbd(yy_context) and begin 
  val = optional_code(val)  
 true 
 end)); end then
        yy_context.input.pos = yy_var1g
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm1h(yy_context) 
val = :yy_nil 
begin; yy_var1i = yy_context.input.pos; (yy_nontermax(yy_context) and begin
      yy_var1j = yy_nontermb(yy_context)
      if yy_var1j then
        val = yy_from_pcv(yy_var1j)
      end
      yy_var1j
    end and yy_nontermaz(yy_context)) or (yy_context.input.pos = yy_var1i; (yy_nontermb5(yy_context) and begin
      yy_var1k = yy_nontermb(yy_context)
      if yy_var1k then
        c = yy_from_pcv(yy_var1k)
      end
      yy_var1k
    end and yy_nontermb7(yy_context) and begin
      yy_var1l = yy_nonterm3r(yy_context)
      if yy_var1l then
        t = yy_from_pcv(yy_var1l)
      end
      yy_var1l
    end and begin
      yy_var1m = yy_nonterm3n(yy_context)
      if yy_var1m then
        var = yy_from_pcv(yy_var1m)
      end
      yy_var1m
    end and begin 
  val = capture_text_code(var, c, t)  
 true 
 end)) or (yy_context.input.pos = yy_var1i; begin
      yy_var1n = yy_nonterm1o(yy_context)
      if yy_var1n then
        val = yy_from_pcv(yy_var1n)
      end
      yy_var1n
    end); end and yy_to_pcv(val) 
end 
def yy_nonterm1o(yy_context) 
val = :yy_nil 
begin; yy_var1p = yy_context.input.pos; (begin
      yy_var1q = yy_nontermfz(yy_context)
      if yy_var1q then
        r = yy_from_pcv(yy_var1q)
      end
      yy_var1q
    end and begin 
  val = code "yy_char_range(yy_context, #{r.begin.to_ruby_code}, #{r.end.to_ruby_code})"  
 true 
 end) or (yy_context.input.pos = yy_var1p; (begin
      yy_var1r = yy_nontermg5(yy_context)
      if yy_var1r then
        s = yy_from_pcv(yy_var1r)
      end
      yy_var1r
    end and begin 
  val = code "yy_string(yy_context, #{s.to_ruby_code})"  
 true 
 end)) or (yy_context.input.pos = yy_var1p; (begin
      yy_var1s = yy_context.input.pos
      if yy_var1s then
        n_pos = yy_from_pcv(yy_var1s)
      end
      yy_var1s
    end and begin
      yy_var1t = yy_nonterme1(yy_context)
      if yy_var1t then
        n = yy_from_pcv(yy_var1t)
      end
      yy_var1t
    end and begin 
  val = UnknownMethodCall[n, %(yy_context), n_pos]  
 true 
 end)) or (yy_context.input.pos = yy_var1p; (yy_nontermbr(yy_context) and begin 
  val = code "yy_char(yy_context)"  
 true 
 end)) or (yy_context.input.pos = yy_var1p; (begin
      yy_var1u = yy_nonterm41(yy_context)
      if yy_var1u then
        a = yy_from_pcv(yy_var1u)
      end
      yy_var1u
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (yy_context.input.pos = yy_var1p; (yy_nontermat(yy_context) and begin 
  val = code "yy_end?(yy_context)"  
 true 
 end)) or (yy_context.input.pos = yy_var1p; (yy_nontermav(yy_context) and begin 
  val = code "yy_begin?(yy_context)"  
 true 
 end)) or (yy_context.input.pos = yy_var1p; (begin; yy_var1y = yy_context.input.pos; (yy_nontermbl(yy_context) and yy_nontermbn(yy_context) and begin
      yy_var1z = yy_nontermc9(yy_context)
      if yy_var1z then
        pos_variable = yy_from_pcv(yy_var1z)
      end
      yy_var1z
    end) or (yy_context.input.pos = yy_var1y; (yy_nontermbz(yy_context) and begin
      yy_var20 = yy_nontermc9(yy_context)
      if yy_var20 then
        pos_variable = yy_from_pcv(yy_var20)
      end
      yy_var20
    end)); end and begin
      yy_var22 = yy_context.input.pos
      if not yy_nonterm9t(yy_context) then
        yy_context.input.pos = yy_var22
      end
      true
    end and begin 
  val = code "(yy_context.input.pos = #{pos_variable}; true)"  
 true 
 end)) or (yy_context.input.pos = yy_var1p; (yy_nontermbl(yy_context) and begin 
  val = code "yy_context.input.pos"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm23(yy_context) 
val = :yy_nil 
(begin 
  rule = val = Rule.new  
 true 
 end and begin; yy_var2c = yy_context.input.pos; (begin
      yy_var2d = yy_nontermdh(yy_context)
      if yy_var2d then
        rule_name = yy_from_pcv(yy_var2d)
      end
      yy_var2d
    end and yy_nontermax(yy_context) and begin
      yy_var2h = yy_context.input.pos
      if not begin; yy_var2g = yy_context.input.pos; yy_nontermbp(yy_context) or (yy_context.input.pos = yy_var2g; yy_nontermcx(yy_context)); end then
        yy_context.input.pos = yy_var2h
      end
      true
    end and yy_nontermaz(yy_context) and begin 
  rule.need_entry_point!  
 true 
 end) or (yy_context.input.pos = yy_var2c; begin
      yy_var2i = yy_nonterme1(yy_context)
      if yy_var2i then
        rule_name = yy_from_pcv(yy_var2i)
      end
      yy_var2i
    end); end and begin 
  rule.name = rule_name  
 true 
 end and begin
      yy_var2m = yy_context.input.pos
      if not (yy_nonterm9t(yy_context) and yy_nonterm2p(yy_context)) then
        yy_context.input.pos = yy_var2m
      end
      true
    end and yy_nonterm9p(yy_context) and begin
      yy_var2n = yy_nontermb(yy_context)
      if yy_var2n then
        c = yy_from_pcv(yy_var2n)
      end
      yy_var2n
    end and yy_nontermap(yy_context) and begin 
  rule.method_definition = to_method_definition(c, rule.method_name)  
 true 
 end) and yy_to_pcv(val) 
end 
  
  class Rule

    def initialize()
      @need_entry_point = false
      @method_name = new_unique_nonterminal_method_name
    end

    # Nonterminal
    attr_accessor :name
    
    # Definition of method implementing this Rule.
    # 
    # It is Code.
    # 
    attr_accessor :method_definition

    # MethodName
    attr_reader :method_name

    # Default is false.
    def need_entry_point?
      @need_entry_point
    end

    # sets #need_entry_point? to true.
    def need_entry_point!
      @need_entry_point = true
    end

    def entry_point_method_name
      name
    end

  end

def yy_nonterm2p(yy_context) 
val = :yy_nil 
((begin
      yy_var3j = yy_context.worst_error
      begin
        not begin
      yy_var3k = yy_context.input.pos
      yy_var3l = yy_nonterm9p(yy_context)
      yy_context.input.pos = yy_var3k
      yy_var3l
    end
      ensure
        yy_context.worst_error = yy_var3j
      end
    end and yy_char(yy_context)) and yy_nontermib(yy_context)) and while true
      yy_var3m = yy_context.input.pos
      if not ((begin
      yy_var3j = yy_context.worst_error
      begin
        not begin
      yy_var3k = yy_context.input.pos
      yy_var3l = yy_nonterm9p(yy_context)
      yy_context.input.pos = yy_var3k
      yy_var3l
    end
      ensure
        yy_context.worst_error = yy_var3j
      end
    end and yy_char(yy_context)) and yy_nontermib(yy_context)) then
        yy_context.input.pos = yy_var3m
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm3n(yy_context) 
val = :yy_nil 
begin; yy_var3o = yy_context.input.pos; begin
      yy_var3p = yy_nontermc9(yy_context)
      if yy_var3p then
        val = yy_from_pcv(yy_var3p)
      end
      yy_var3p
    end or (yy_context.input.pos = yy_var3o; (yy_nontermax(yy_context) and begin
      yy_var3q = yy_nontermc9(yy_context)
      if yy_var3q then
        val = yy_from_pcv(yy_var3q)
      end
      yy_var3q
    end and yy_nontermaz(yy_context))); end and yy_to_pcv(val) 
end 
def yy_nonterm3r(yy_context) 
val = :yy_nil 
begin; yy_var3s = yy_context.input.pos; (yy_nonterm9t(yy_context) and begin 
 val = :capture 
 true 
 end) or (yy_context.input.pos = yy_var3s; (yy_nontermal(yy_context) and begin 
 val = :append 
 true 
 end)) or (yy_context.input.pos = yy_var3s; (yy_nonterman(yy_context) and begin 
 val = :append 
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm3t(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "%%") and  begin
      while true
        ###
        yy_var3x = yy_context.input.pos
        ### Look ahead.
        yy_var3y = begin; yy_var40 = yy_context.input.pos; yy_nontermit(yy_context) or (yy_context.input.pos = yy_var40; yy_end?(yy_context)); end
        yy_context.input.pos = yy_var3x
        break if yy_var3y
        ### Repeat one more time (if possible).
        yy_var3y = yy_char(yy_context)
        if not yy_var3y then
          yy_context.input.pos = yy_var3x
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_var40 = yy_context.input.pos; yy_nontermit(yy_context) or (yy_context.input.pos = yy_var40; yy_end?(yy_context)); end) and yy_to_pcv(val) 
end 
def yy_nonterm41(yy_context) 
val = :yy_nil 
(begin; yy_var6s = yy_context.input.pos; (yy_string(yy_context, "{") and while true
      yy_var6u = yy_context.input.pos
      if not yy_nontermir(yy_context) then
        yy_context.input.pos = yy_var6u
        break true
      end
    end and yy_string(yy_context, "...") and begin
      yy_var76 = yy_context.input.pos
      if not ( begin
      while true
        ###
        yy_var74 = yy_context.input.pos
        ### Look ahead.
        yy_var75 = yy_nontermit(yy_context)
        yy_context.input.pos = yy_var74
        break if yy_var75
        ### Repeat one more time (if possible).
        yy_var75 = yy_nontermir(yy_context)
        if not yy_var75 then
          yy_context.input.pos = yy_var74
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nontermit(yy_context)) then
        yy_context.input.pos = yy_var76
      end
      true
    end and begin
      val = ""
      yy_var7j = yy_context.input.pos
       begin
      while true
        ###
        yy_var7h = yy_context.input.pos
        ### Look ahead.
        yy_var7i = begin; yy_var7q = yy_context.input.pos; (yy_string(yy_context, "...") and while true
      yy_var7s = yy_context.input.pos
      if not yy_nontermir(yy_context) then
        yy_context.input.pos = yy_var7s
        break true
      end
    end and yy_string(yy_context, "}")) or (yy_context.input.pos = yy_var7q; (yy_string(yy_context, "}") and while true
      yy_var7u = yy_context.input.pos
      if not yy_nontermir(yy_context) then
        yy_context.input.pos = yy_var7u
        break true
      end
    end and yy_string(yy_context, "..."))); end
        yy_context.input.pos = yy_var7h
        break if yy_var7i
        ### Repeat one more time (if possible).
        yy_var7i = yy_char(yy_context)
        if not yy_var7i then
          yy_context.input.pos = yy_var7h
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var7k = yy_context.input.pos
        yy_context.input.pos = yy_var7j
        val << yy_context.input.read(yy_var7k - yy_var7j).force_encoding(Encoding::UTF_8)
      end
    end and begin; yy_var7q = yy_context.input.pos; (yy_string(yy_context, "...") and while true
      yy_var7s = yy_context.input.pos
      if not yy_nontermir(yy_context) then
        yy_context.input.pos = yy_var7s
        break true
      end
    end and yy_string(yy_context, "}")) or (yy_context.input.pos = yy_var7q; (yy_string(yy_context, "}") and while true
      yy_var7u = yy_context.input.pos
      if not yy_nontermir(yy_context) then
        yy_context.input.pos = yy_var7u
        break true
      end
    end and yy_string(yy_context, "..."))); end) or (yy_context.input.pos = yy_var6s; (begin
      val = ""
      yy_var7z = yy_context.input.pos
      yy_nonterm9h(yy_context) and begin
        yy_var80 = yy_context.input.pos
        yy_context.input.pos = yy_var7z
        val << yy_context.input.read(yy_var80 - yy_var7z).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = val[1...-1]  
 true 
 end)) or (yy_context.input.pos = yy_var6s; (yy_nonterm3t(yy_context) and begin
      val = ""
      yy_var8t = yy_context.input.pos
       begin
      while true
        ###
        yy_var8r = yy_context.input.pos
        ### Look ahead.
        yy_var8s = yy_nonterm3t(yy_context)
        yy_context.input.pos = yy_var8r
        break if yy_var8s
        ### Repeat one more time (if possible).
        yy_var8s = yy_char(yy_context)
        if not yy_var8s then
          yy_context.input.pos = yy_var8r
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var8u = yy_context.input.pos
        yy_context.input.pos = yy_var8t
        val << yy_context.input.read(yy_var8u - yy_var8t).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm3t(yy_context))) or (yy_context.input.pos = yy_var6s; (yy_nonterm3t(yy_context) and begin
      val = ""
      yy_var9f = yy_context.input.pos
      while true
      yy_var9e = yy_context.input.pos
      if not yy_char(yy_context) then
        yy_context.input.pos = yy_var9e
        break true
      end
    end and begin
        yy_var9g = yy_context.input.pos
        yy_context.input.pos = yy_var9f
        val << yy_context.input.read(yy_var9g - yy_var9f).force_encoding(Encoding::UTF_8)
      end
    end and yy_end?(yy_context))); end and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nonterm9h(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "{") and  begin
      while true
        ###
        yy_var9n = yy_context.input.pos
        ### Look ahead.
        yy_var9o = yy_string(yy_context, "}")
        yy_context.input.pos = yy_var9n
        break if yy_var9o
        ### Repeat one more time (if possible).
        yy_var9o = begin; yy_var9m = yy_context.input.pos; yy_nonterm9h(yy_context) or (yy_context.input.pos = yy_var9m; yy_char(yy_context)); end
        if not yy_var9o then
          yy_context.input.pos = yy_var9n
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string(yy_context, "}")) and yy_to_pcv(val) 
end 
def yy_nonterm9p(yy_context) 
val = :yy_nil 
(begin; yy_var9s = yy_context.input.pos; yy_string(yy_context, "<-") or (yy_context.input.pos = yy_var9s; yy_string(yy_context, "=")) or (yy_context.input.pos = yy_var9s; yy_string(yy_context, "\u{2190}")); end and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nonterm9t(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ":") and (begin
      yy_varac = yy_context.worst_error
      begin
        not begin
      yy_varad = yy_context.input.pos
      yy_varae = yy_string(yy_context, "+")
      yy_context.input.pos = yy_varad
      yy_varae
    end
      ensure
        yy_context.worst_error = yy_varac
      end
    end and begin
      yy_varai = yy_context.worst_error
      begin
        not begin
      yy_varaj = yy_context.input.pos
      yy_varak = yy_string(yy_context, ">>")
      yy_context.input.pos = yy_varaj
      yy_varak
    end
      ensure
        yy_context.worst_error = yy_varai
      end
    end) and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermal(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ":+") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nonterman(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ":>>") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermap(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ";") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermar(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "/") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermat(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "$") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermav(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "^") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermax(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "(") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermaz(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ")") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb1(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "[") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb3(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "]") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb5(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "<") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb7(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ">") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb9(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "*") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbb(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "*?") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbd(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "?") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbf(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "+") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbh(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "&") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbj(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "!") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbl(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "@") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbn(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "=") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbp(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "...") and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbr(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "char") and begin
      yy_varbw = yy_context.worst_error
      begin
        not begin
      yy_varbx = yy_context.input.pos
      yy_varby = yy_nontermfx(yy_context)
      yy_context.input.pos = yy_varbx
      yy_varby
    end
      ensure
        yy_context.worst_error = yy_varbw
      end
    end and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbz(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "at") and begin
      yy_varc4 = yy_context.worst_error
      begin
        not begin
      yy_varc5 = yy_context.input.pos
      yy_varc6 = yy_nontermfx(yy_context)
      yy_context.input.pos = yy_varc5
      yy_varc6
    end
      ensure
        yy_context.worst_error = yy_varc4
      end
    end and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermc7(yy_context) 
val = :yy_nil 
begin; yy_varc8 = yy_context.input.pos; yy_nontermbr(yy_context) or (yy_context.input.pos = yy_varc8; yy_nontermbz(yy_context)); end and yy_to_pcv(val) 
end 
def yy_nontermc9(yy_context) 
val = :yy_nil 
(begin
      val = ""
      yy_varcv = yy_context.input.pos
      (begin
      yy_varcq = yy_context.input.pos
      if not begin; yy_varcp = yy_context.input.pos; yy_string(yy_context, "@") or (yy_context.input.pos = yy_varcp; yy_string(yy_context, "$")); end then
        yy_context.input.pos = yy_varcq
      end
      true
    end and yy_nontermdd(yy_context) and while true
      yy_varcu = yy_context.input.pos
      if not yy_nontermdf(yy_context) then
        yy_context.input.pos = yy_varcu
        break true
      end
    end) and begin
        yy_varcw = yy_context.input.pos
        yy_context.input.pos = yy_varcv
        val << yy_context.input.read(yy_varcw - yy_varcv).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermcx(yy_context) 
val = :yy_nil 
(begin
      val = ""
      yy_vardb = yy_context.input.pos
      (yy_nontermdd(yy_context) and while true
      yy_varda = yy_context.input.pos
      if not yy_nontermdf(yy_context) then
        yy_context.input.pos = yy_varda
        break true
      end
    end) and begin
        yy_vardc = yy_context.input.pos
        yy_context.input.pos = yy_vardb
        val << yy_context.input.read(yy_vardc - yy_vardb).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermdd(yy_context) 
val = :yy_nil 
begin; yy_varde = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_varde; yy_string(yy_context, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermdf(yy_context) 
val = :yy_nil 
begin; yy_vardg = yy_context.input.pos; yy_nontermdd(yy_context) or (yy_context.input.pos = yy_vardg; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermdh(yy_context) 
val = :yy_nil 
(begin
      val = ""
      yy_vardv = yy_context.input.pos
      (yy_nontermdx(yy_context) and while true
      yy_vardu = yy_context.input.pos
      if not yy_nontermdz(yy_context) then
        yy_context.input.pos = yy_vardu
        break true
      end
    end) and begin
        yy_vardw = yy_context.input.pos
        yy_context.input.pos = yy_vardv
        val << yy_context.input.read(yy_vardw - yy_vardv).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermdx(yy_context) 
val = :yy_nil 
begin; yy_vardy = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_vardy; yy_string(yy_context, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermdz(yy_context) 
val = :yy_nil 
begin; yy_vare0 = yy_context.input.pos; yy_nontermdx(yy_context) or (yy_context.input.pos = yy_vare0; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nonterme1(yy_context) 
val = :yy_nil 
(begin
      yy_vare6 = yy_context.worst_error
      begin
        not begin
      yy_vare7 = yy_context.input.pos
      yy_vare8 = yy_nontermc7(yy_context)
      yy_context.input.pos = yy_vare7
      yy_vare8
    end
      ensure
        yy_context.worst_error = yy_vare6
      end
    end and begin; yy_varf2 = yy_context.input.pos; (begin
      val = ""
      yy_varff = yy_context.input.pos
      (yy_nontermfv(yy_context) and while true
      yy_varfe = yy_context.input.pos
      if not yy_nontermfx(yy_context) then
        yy_context.input.pos = yy_varfe
        break true
      end
    end) and begin
        yy_varfg = yy_context.input.pos
        yy_context.input.pos = yy_varff
        val << yy_context.input.read(yy_varfg - yy_varff).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermib(yy_context)) or (yy_context.input.pos = yy_varf2; (begin
      val = ""
      yy_varft = yy_context.input.pos
      (yy_string(yy_context, "`") and  begin
      while true
        ###
        yy_varfr = yy_context.input.pos
        ### Look ahead.
        yy_varfs = yy_string(yy_context, "`")
        yy_context.input.pos = yy_varfr
        break if yy_varfs
        ### Repeat one more time (if possible).
        yy_varfs = yy_char(yy_context)
        if not yy_varfs then
          yy_context.input.pos = yy_varfr
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string(yy_context, "`")) and begin
        yy_varfu = yy_context.input.pos
        yy_context.input.pos = yy_varft
        val << yy_context.input.read(yy_varfu - yy_varft).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermib(yy_context))); end) and yy_to_pcv(val) 
end 
def yy_nontermfv(yy_context) 
val = :yy_nil 
begin; yy_varfw = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_varfw; yy_char_range(yy_context, "A", "Z")) or (yy_context.input.pos = yy_varfw; yy_string(yy_context, "-")) or (yy_context.input.pos = yy_varfw; yy_string(yy_context, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermfx(yy_context) 
val = :yy_nil 
begin; yy_varfy = yy_context.input.pos; yy_nontermfv(yy_context) or (yy_context.input.pos = yy_varfy; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermfz(yy_context) 
val = :yy_nil 
(begin
      yy_varg1 = yy_nontermg5(yy_context)
      if yy_varg1 then
        from = yy_from_pcv(yy_varg1)
      end
      yy_varg1
    end and begin; yy_varg3 = yy_context.input.pos; yy_string(yy_context, "...") or (yy_context.input.pos = yy_varg3; yy_string(yy_context, "..")) or (yy_context.input.pos = yy_varg3; yy_string(yy_context, "\u{2026}")) or (yy_context.input.pos = yy_varg3; yy_string(yy_context, "\u{2025}")); end and yy_nontermib(yy_context) and begin
      yy_varg4 = yy_nontermg5(yy_context)
      if yy_varg4 then
        to = yy_from_pcv(yy_varg4)
      end
      yy_varg4
    end and yy_nontermib(yy_context) and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermg5(yy_context) 
val = :yy_nil 
(begin; yy_varh1 = yy_context.input.pos; (yy_string(yy_context, "'") and begin
      val = ""
      yy_varhe = yy_context.input.pos
       begin
      while true
        ###
        yy_varhc = yy_context.input.pos
        ### Look ahead.
        yy_varhd = yy_string(yy_context, "'")
        yy_context.input.pos = yy_varhc
        break if yy_varhd
        ### Repeat one more time (if possible).
        yy_varhd = yy_char(yy_context)
        if not yy_varhd then
          yy_context.input.pos = yy_varhc
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varhf = yy_context.input.pos
        yy_context.input.pos = yy_varhe
        val << yy_context.input.read(yy_varhf - yy_varhe).force_encoding(Encoding::UTF_8)
      end
    end and yy_string(yy_context, "'")) or (yy_context.input.pos = yy_varh1; (yy_string(yy_context, "\"") and begin
      val = ""
      yy_varhs = yy_context.input.pos
       begin
      while true
        ###
        yy_varhq = yy_context.input.pos
        ### Look ahead.
        yy_varhr = yy_string(yy_context, "\"")
        yy_context.input.pos = yy_varhq
        break if yy_varhr
        ### Repeat one more time (if possible).
        yy_varhr = yy_char(yy_context)
        if not yy_varhr then
          yy_context.input.pos = yy_varhq
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varht = yy_context.input.pos
        yy_context.input.pos = yy_varhs
        val << yy_context.input.read(yy_varht - yy_varhs).force_encoding(Encoding::UTF_8)
      end
    end and yy_string(yy_context, "\""))) or (yy_context.input.pos = yy_varh1; (begin
      yy_varhu = yy_nontermhv(yy_context)
      if yy_varhu then
        code = yy_from_pcv(yy_varhu)
      end
      yy_varhu
    end and begin 
  val = "" << code  
 true 
 end)); end and yy_nontermib(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermhv(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "U+") and begin
      code = ""
      yy_vari9 = yy_context.input.pos
      begin; yy_vari7 = yy_context.input.pos; yy_char_range(yy_context, "0", "9") or (yy_context.input.pos = yy_vari7; yy_char_range(yy_context, "A", "F")); end and while true
      yy_vari8 = yy_context.input.pos
      if not begin; yy_vari7 = yy_context.input.pos; yy_char_range(yy_context, "0", "9") or (yy_context.input.pos = yy_vari7; yy_char_range(yy_context, "A", "F")); end then
        yy_context.input.pos = yy_vari8
        break true
      end
    end and begin
        yy_varia = yy_context.input.pos
        yy_context.input.pos = yy_vari9
        code << yy_context.input.read(yy_varia - yy_vari9).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermib(yy_context) 
val = :yy_nil 
while true
      yy_varig = yy_context.input.pos
      if not begin; yy_varif = yy_context.input.pos; yy_nontermir(yy_context) or (yy_context.input.pos = yy_varif; yy_nontermih(yy_context)); end then
        yy_context.input.pos = yy_varig
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nontermih(yy_context) 
val = :yy_nil 
(begin; yy_varik = yy_context.input.pos; yy_string(yy_context, "#") or (yy_context.input.pos = yy_varik; yy_string(yy_context, "--")); end and  begin
      while true
        ###
        yy_varin = yy_context.input.pos
        ### Look ahead.
        yy_vario = begin; yy_variq = yy_context.input.pos; yy_nontermit(yy_context) or (yy_context.input.pos = yy_variq; yy_end?(yy_context)); end
        yy_context.input.pos = yy_varin
        break if yy_vario
        ### Repeat one more time (if possible).
        yy_vario = yy_char(yy_context)
        if not yy_vario then
          yy_context.input.pos = yy_varin
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_variq = yy_context.input.pos; yy_nontermit(yy_context) or (yy_context.input.pos = yy_variq; yy_end?(yy_context)); end) and yy_to_pcv(val) 
end 
def yy_nontermir(yy_context) 
val = :yy_nil 
begin; yy_varis = yy_context.input.pos; yy_char_range(yy_context, "\t", "\r") or (yy_context.input.pos = yy_varis; yy_string(yy_context, " ")) or (yy_context.input.pos = yy_varis; yy_string(yy_context, "\u{85}")) or (yy_context.input.pos = yy_varis; yy_string(yy_context, "\u{a0}")) or (yy_context.input.pos = yy_varis; yy_string(yy_context, "\u{1680}")) or (yy_context.input.pos = yy_varis; yy_string(yy_context, "\u{180e}")) or (yy_context.input.pos = yy_varis; yy_char_range(yy_context, "\u{2000}", "\u{200a}")) or (yy_context.input.pos = yy_varis; yy_string(yy_context, "\u{2028}")) or (yy_context.input.pos = yy_varis; yy_string(yy_context, "\u{2029}")) or (yy_context.input.pos = yy_varis; yy_string(yy_context, "\u{202f}")) or (yy_context.input.pos = yy_varis; yy_string(yy_context, "\u{205f}")) or (yy_context.input.pos = yy_varis; yy_string(yy_context, "\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nontermit(yy_context) 
val = :yy_nil 
begin; yy_variu = yy_context.input.pos; (yy_string(yy_context, "\r") and yy_string(yy_context, "\n")) or (yy_context.input.pos = yy_variu; yy_string(yy_context, "\r")) or (yy_context.input.pos = yy_variu; yy_string(yy_context, "\n")) or (yy_context.input.pos = yy_variu; yy_string(yy_context, "\u{85}")) or (yy_context.input.pos = yy_variu; yy_string(yy_context, "\v")) or (yy_context.input.pos = yy_variu; yy_string(yy_context, "\f")) or (yy_context.input.pos = yy_variu; yy_string(yy_context, "\u{2028}")) or (yy_context.input.pos = yy_variu; yy_string(yy_context, "\u{2029}")); end and yy_to_pcv(val) 
end 
  
  # 
  # +capture_type+ may be:
  # 
  # [:capture] "Capture the semantic value to +target_var+"
  # [:append]  "Append semantic value to +target_var+ using "<<" operator".
  # 
  def capture_semantic_value_code(target_var, code, capture_type)
    parse_result_var = new_unique_variable_name
    capture_operator =
      case capture_type
      when :capture then "="
      when :append then "<<"
      else raise %(capture_type #{capture_type.inspect} is not supported)
      end
    #
    code(%(begin
      #{parse_result_var} = )) + code + code(%(
      if #{parse_result_var} then
        #{target_var} #{capture_operator} yy_from_pcv(#{parse_result_var})
      end
      #{parse_result_var}
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
      #{stored_pos_var} = yy_context.input.pos
      #{result_var} = )) + code + code(%(
      yy_context.input.pos = #{stored_pos_var}
      #{result_var}
    end))
  end
  
  def negative_predicate_code(code)
    stored_worst_error_var = new_unique_variable_name
    # 
    code(%(begin
      #{stored_worst_error_var} = yy_context.worst_error
      begin
        not )) + positive_predicate_code(code) + code(%(
      ensure
        yy_context.worst_error = #{stored_worst_error_var}
      end
    end))
  end
  
  def repeat_many_times_code(code)
    stored_pos_var = new_unique_variable_name
    #
    code(%(while true
      #{stored_pos_var} = yy_context.input.pos
      if not )) + code + code(%( then
        yy_context.input.pos = #{stored_pos_var}
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
      #{stored_pos_var} = yy_context.input.pos
      if not )) + code + code(%( then
        yy_context.input.pos = #{stored_pos_var}
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
        #{original_pos_var} = yy_context.input.pos
        ### Look ahead.
        #{result_var} = ]) + LazyRepeat::UnknownLookAheadCode.new + code(%[
        yy_context.input.pos = #{original_pos_var}
        break if #{result_var}
        ### Repeat one more time (if possible).
        #{result_var} = ]) + parsing_code + code(%[
        if not #{result_var} then
          yy_context.input.pos = #{original_pos_var}
          break
        end
      end
      ### The repetition is always successful.
      true
    end ])
  end
  
  # returns code which captures text to specified variable.
  # 
  # +capture_type+ may be one of the following:
  # 
  # [:capture] "Capture the text into the variable +target_variable_name+"
  # [:append]  "Append the text to the variable +target_variable_name+"
  # 
  def capture_text_code(target_variable_name, parsing_code, capture_type)
    #
    init_target_variable_code =
      case capture_type
      when :capture then %(#{target_variable_name} = "")
      when :append then %()
      else raise %(capture_type #{capture_type.inspect} is not supported)
      end
    start_pos_var = new_unique_variable_name
    end_pos_var = new_unique_variable_name
    # 
    code(%(begin
      #{init_target_variable_code}
      #{start_pos_var} = yy_context.input.pos
      )) +
      parsing_code + code(%( and begin
        #{end_pos_var} = yy_context.input.pos
        yy_context.input.pos = #{start_pos_var}
        #{target_variable_name} << yy_context.input.read(#{end_pos_var} - #{start_pos_var}).force_encoding(Encoding::UTF_8)
      end
    end))
  end
  
  def auxiliary_parser_code
    code %(
      
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

      class YY_ParsingContext
        
        # +input+ is IO.
        def initialize(input)
          @input = input
          @worst_error = nil
        end
        
        attr_reader :input
        
        # It is YY_SyntaxError or nil.
        attr_accessor :worst_error
        
        # adds possible error to this YY_ParsingContext.
        # 
        # +error+ is YY_SyntaxError.
        # 
        def << error
          # Update worst_error.
          if worst_error.nil? or worst_error.pos < error.pos then
            @worst_error = error
          elsif worst_error.pos == error.pos then
            @worst_error = @worst_error.or error
          end
          # 
          return self
        end
        
      end
      
      def yy_string(context, string)
        # 
        string_start_pos = context.input.pos
        # Read string.
        read_string = context.input.read(string.bytesize)
        # Set the string's encoding; check if it fits the argument.
        unless read_string and (read_string.force_encoding(Encoding::UTF_8)) == string then
          # 
          context << YY_SyntaxError.new(string_start_pos, string.inspect)
          # 
          return nil
        end
        # 
        return read_string
      end
      
      def yy_end?(context)
        #
        if not context.input.eof?
          context << YY_SyntaxError.new(context.input.pos, "the end")
          return nil
        end
        #
        return true
      end
      
      def yy_begin?(context)
        #
        if not (context.input.pos == 0)
          context << YY_SyntaxError.new(context.input.pos, "the beginning")
          return nil
        end
        #
        return true
      end
      
      def yy_char(context)
        # 
        char_start_pos = context.input.pos
        # Read a char.
        c = context.input.getc
        # 
        unless c then
          #
          context << YY_SyntaxError.new(char_start_pos, "a character")
          #
          return nil
        end
        #
        return c
      end
      
      def yy_char_range(context, from, to)
        # 
        char_start_pos = context.input.pos
        # Read the char.
        c = context.input.getc
        # Check if it fits the range.
        # NOTE: c has UTF-8 encoding.
        unless c and (from <= c and c <= to) then
          # 
          context << YY_SyntaxError.new(char_start_pos, %(\#{from.inspect}\...\#{to.inspect}))
          # 
          return nil
        end
        #
        return c
      end
      
      class YY_SyntaxError < Exception
        
        def initialize(pos, *expectations)
          @expectations = expectations
          @pos = pos
        end
        
        attr_reader :pos
        
        # +other+ is another YY_SyntaxError.
        # 
        # #pos of this YY_SyntaxError and +other+ must be equal.
        # 
        def or other
          raise %(can not "or" \#{YY_SyntaxError}s with different pos) unless self.pos == other.pos
          YY_SyntaxError.new(pos, *(self.expectations + other.expectations))
        end
        
        def message
          expectations = self.expectations.uniq
          [expectations[0...-1].join(", "), expectations[-1]].join(" or ") + " is expected"
        end
        
        # 
        def row_pos(io)
          # TODO
        end
        
        def column(io)
          # TODO
        end
        
        protected
        
        # Private
        attr_reader :expectations
        
      end
    )
  end

  def parser_entry_point_code(method_name, parsing_method_name)
    code %(

      # 
      # +input+ is IO. It must have working IO#pos, IO#pos= and
      # IO#set_encoding() methods.
      # 
      # It may raise YY_SyntaxError.
      # 
      def #{method_name}(input)
        input.set_encoding("UTF-8", "UTF-8")
        context = YY_ParsingContext.new(input)
        yy_from_pcv(
          #{parsing_method_name}(context) ||
          # TODO: context.worst_error can not be nil here. Prove it.
          raise(context.worst_error)
        )
      end

      # TODO: Allow to pass String to the entry point.
    )
  end
  
  # 
  # See source code.
  # 
  def link(code, method_names)
    code.map do |code_part|
      if code_part.is_a? UnknownMethodCall and method_names.has_key? code_part.nonterminal
        code "#{method_names[code_part.nonterminal]}(#{code_part.args_code.to_s})"
      else
        code_part
      end
    end
  end
  
  def check_no_unresolved_nonterminals(code)
    code.each do |code_part|
      if code_part.is_a? UnknownMethodCall then
        raise YY_SyntaxError.new(%(rule #{code_part.nonterminal} is not defined), code_part.source_pos)
      end
    end
  end
  
  def to_method_definition(code, method_name)
    code("def #{method_name}(yy_context) \n") +
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
    # passes every atomic Code comprising this Code to +block+.
    # 
    # It returns this Code.
    # 
    # Not overridable.
    # 
    def each(&block)
      map do |part|
        block.(part)
        part
      end
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
    
    def initialize(nonterminal, args_code, source_pos)
      @nonterminal = nonterminal
      @args_code = args_code
      @source_pos = source_pos
    end
    
    # Nonterminal associated with this UnknownMethodCall.
    attr_reader :nonterminal
    
    # Code of arguments of this call (as String).
    attr_reader :args_code
    
    # Position in source code of this UnknownMethodCall.
    attr_reader :source_pos

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
    begin
      PEGParserGenerator.new.call(io)
    rescue PEGParserGenerator::YY_SyntaxError => e
      STDERR.puts %(#{e.pos}: #{e.message})
      exit 1
    end
  end
end
