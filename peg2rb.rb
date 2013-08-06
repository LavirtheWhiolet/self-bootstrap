#!/usr/bin/ruby
# encoding: UTF-8


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
        
        # It is YY_SyntaxExpectationError or nil.
        attr_accessor :worst_error
        
        # adds possible error to this YY_ParsingContext.
        # 
        # +error+ is YY_SyntaxExpectationError.
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
          context << YY_SyntaxExpectationError.new(yy_displayed(string), string_start_pos)
          # 
          return nil
        end
        # 
        return read_string
      end
      
      def yy_end?(context)
        #
        if not context.input.eof?
          context << YY_SyntaxExpectationError.new("the end", context.input.pos)
          return nil
        end
        #
        return true
      end
      
      def yy_begin?(context)
        #
        if not (context.input.pos == 0)
          context << YY_SyntaxExpectationError.new("the beginning", context.input.pos)
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
          context << YY_SyntaxExpectationError.new("a character", char_start_pos)
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
          context << YY_SyntaxExpectationError.new(%(#{yy_displayed from}...#{yy_displayed to}), char_start_pos)
          # 
          return nil
        end
        #
        return c
      end
      
      # The form of +string+ suitable for displaying in messages.
      def yy_displayed(string)
        if string.length == 1 then
          char = string[0]
          char_code = char.ord
          case char_code
          when 0x00...0x20 then %(#{yy_unicode_s char_code})
          when 0x20...0x80 then %("#{char}")
          when 0x80...Float::INFINITY then %("#{char} (#{yy_unicode_s char_code})")
          end
        else
          %("#{string}")
        end
      end
      
      # "U+XXXX" string corresponding to +char_code+.
      def yy_unicode_s(char_code)
        "U+#{"%04X" % char_code}"
      end
      
      class YY_SyntaxError < Exception
        
        def initialize(message, pos)
          super(message)
          @pos = pos
        end
        
        attr_reader :pos
        
      end
      
      class YY_SyntaxExpectationError < YY_SyntaxError
        
        # 
        # +expectations+ are String-s.
        # 
        def initialize(*expectations, pos)
          super(nil, pos)
          @expectations = expectations
        end
        
        # 
        # returns other YY_SyntaxExpectationError with #expectations combined.
        # 
        # +other+ is another YY_SyntaxExpectationError.
        # 
        # #pos of this YY_SyntaxExpectationError and +other+ must be equal.
        # 
        def or other
          raise %(can not "or" #{YY_SyntaxExpectationError}s with different pos) unless self.pos == other.pos
          YY_SyntaxExpectationError.new(*(self.expectations + other.expectations), pos)
        end
        
        def message
          expectations = self.expectations.uniq
          [expectations[0...-1].join(", "), expectations[-1]].join(" or ") + " is expected"
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
 end and yy_nontermix(yy_context) and while true
      yy_varc = yy_context.input.pos
      if not begin; yy_var8 = yy_context.input.pos; (begin
      yy_var9 = yy_context.input.pos
      if yy_var9 then
        rule_pos = yy_from_pcv(yy_var9)
      end
      yy_var9
    end and begin
      yy_vara = yy_nonterm2c(yy_context)
      if yy_vara then
        rule = yy_from_pcv(yy_vara)
      end
      yy_vara
    end and begin 
 
        # Check that the rule is not defined twice.
        if method_names.has_key?(rule.name) then
          raise YY_SyntaxError.new(%(rule #{rule.name} is defined more than once), rule_pos)
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
 end) or (yy_context.input.pos = yy_var8; (begin
      yy_varb = yy_nonterm4n(yy_context)
      if yy_varb then
        action_code = yy_from_pcv(yy_varb)
      end
      yy_varb
    end and begin 
 
        code += code(action_code)
       
 true 
 end)); end then
        yy_context.input.pos = yy_varc
        break true
      end
    end and yy_end?(yy_context) and begin 
 
    code = link(code, method_names)
    check_no_unresolved_code_in code
    print code
   
 true 
 end) and yy_to_pcv(val) 
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

  def check_no_unresolved_code_in code
    code.each do |code_part|
      case code_part
      when UnknownMethodCall
        raise YY_SyntaxError.new(%(rule #{code_part.nonterminal} is not defined), code_part.source_pos)
      when LazyRepeat::UnknownLookAheadCode
        raise YY_SyntaxError.new(%(at least one expression is expected to be in sequence with "*?" expression), code_part.source_pos)
      end
    end
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
        
        # It is YY_SyntaxExpectationError or nil.
        attr_accessor :worst_error
        
        # adds possible error to this YY_ParsingContext.
        # 
        # +error+ is YY_SyntaxExpectationError.
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
          context << YY_SyntaxExpectationError.new(yy_displayed(string), string_start_pos)
          # 
          return nil
        end
        # 
        return read_string
      end
      
      def yy_end?(context)
        #
        if not context.input.eof?
          context << YY_SyntaxExpectationError.new("the end", context.input.pos)
          return nil
        end
        #
        return true
      end
      
      def yy_begin?(context)
        #
        if not (context.input.pos == 0)
          context << YY_SyntaxExpectationError.new("the beginning", context.input.pos)
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
          context << YY_SyntaxExpectationError.new("a character", char_start_pos)
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
          context << YY_SyntaxExpectationError.new(%(\#{yy_displayed from}\...\#{yy_displayed to}), char_start_pos)
          # 
          return nil
        end
        #
        return c
      end
      
      # The form of +string+ suitable for displaying in messages.
      def yy_displayed(string)
        if string.length == 1 then
          char = string[0]
          char_code = char.ord
          case char_code
          when 0x00...0x20 then %(\#{yy_unicode_s char_code})
          when 0x20...0x80 then %("\#{char}")
          when 0x80...Float::INFINITY then %("\#{char} (\#{yy_unicode_s char_code})")
          end
        else
          %("\#{string}")
        end
      end
      
      # "U+XXXX" string corresponding to +char_code+.
      def yy_unicode_s(char_code)
        "U+\#{"%04X" % char_code}"
      end
      
      class YY_SyntaxError < Exception
        
        def initialize(message, pos)
          super(message)
          @pos = pos
        end
        
        attr_reader :pos
        
      end
      
      class YY_SyntaxExpectationError < YY_SyntaxError
        
        # 
        # +expectations+ are String-s.
        # 
        def initialize(*expectations, pos)
          super(nil, pos)
          @expectations = expectations
        end
        
        # 
        # returns other YY_SyntaxExpectationError with #expectations combined.
        # 
        # +other+ is another YY_SyntaxExpectationError.
        # 
        # #pos of this YY_SyntaxExpectationError and +other+ must be equal.
        # 
        def or other
          raise %(can not "or" \#{YY_SyntaxExpectationError}s with different pos) unless self.pos == other.pos
          YY_SyntaxExpectationError.new(*(self.expectations + other.expectations), pos)
        end
        
        def message
          expectations = self.expectations.uniq
          [expectations[0...-1].join(", "), expectations[-1]].join(" or ") + " is expected"
        end
        
        protected
        
        # Private
        attr_reader :expectations
        
      end
    )
  end
  
def yy_nonterme(yy_context) 
val = :yy_nil 
begin
      yy_varg = yy_nontermh(yy_context)
      if yy_varg then
        val = yy_from_pcv(yy_varg)
      end
      yy_varg
    end and yy_to_pcv(val) 
end 
def yy_nontermh(yy_context) 
val = :yy_nil 
(begin 
 
    single_expression = true
    remembered_pos_var = new_unique_variable_name
   
 true 
 end and begin
      yy_vark = yy_context.input.pos
      if not yy_nontermbd(yy_context) then
        yy_context.input.pos = yy_vark
      end
      true
    end and begin
      yy_varl = yy_nonterms(yy_context)
      if yy_varl then
        val = yy_from_pcv(yy_varl)
      end
      yy_varl
    end and while true
      yy_varr = yy_context.input.pos
      if not (yy_nontermbd(yy_context) and begin
      yy_varq = yy_nonterms(yy_context)
      if yy_varq then
        val2 = yy_from_pcv(yy_varq)
      end
      yy_varq
    end and begin 
 
      single_expression = false
      val = val + (code " or (yy_context.input.pos = #{remembered_pos_var}; ") + val2 + (code ")")
     
 true 
 end) then
        yy_context.input.pos = yy_varr
        break true
      end
    end and begin 
 
    if not single_expression then
      val = (code "begin; #{remembered_pos_var} = yy_context.input.pos; ") + val + (code "; end")
    end
   
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nonterms(yy_context) 
val = :yy_nil 
(begin 
  code_parts = []  
 true 
 end and begin; yy_varx = yy_context.input.pos; (begin
      yy_vary = yy_nonterm11(yy_context)
      if yy_vary then
        code_part = yy_from_pcv(yy_vary)
      end
      yy_vary
    end and begin 
  code_parts.add code_part  
 true 
 end) or (yy_context.input.pos = yy_varx; (yy_nontermbp(yy_context) and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end and while true
      yy_varz = yy_context.input.pos
      if not begin; yy_varx = yy_context.input.pos; (begin
      yy_vary = yy_nonterm11(yy_context)
      if yy_vary then
        code_part = yy_from_pcv(yy_vary)
      end
      yy_vary
    end and begin 
  code_parts.add code_part  
 true 
 end) or (yy_context.input.pos = yy_varx; (yy_nontermbp(yy_context) and begin 
  code_parts = [sequence_code(code_parts)]  
 true 
 end)); end then
        yy_context.input.pos = yy_varz
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
  
def yy_nonterm11(yy_context) 
val = :yy_nil 
begin; yy_var12 = yy_context.input.pos; (begin
      yy_var13 = yy_nonterm18(yy_context)
      if yy_var13 then
        c = yy_from_pcv(yy_var13)
      end
      yy_var13
    end and begin
      yy_var14 = yy_nonterm40(yy_context)
      if yy_var14 then
        t = yy_from_pcv(yy_var14)
      end
      yy_var14
    end and begin
      yy_var15 = yy_nonterm3w(yy_context)
      if yy_var15 then
        var = yy_from_pcv(yy_var15)
      end
      yy_var15
    end and begin 
  val = capture_semantic_value_code(var, c, t)  
 true 
 end) or (yy_context.input.pos = yy_var12; begin
      yy_var16 = yy_nonterm18(yy_context)
      if yy_var16 then
        val = yy_from_pcv(yy_var16)
      end
      yy_var16
    end); end and yy_to_pcv(val) 
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
  
def yy_nonterm18(yy_context) 
val = :yy_nil 
begin; yy_var19 = yy_context.input.pos; (yy_nontermc3(yy_context) and begin
      yy_var1a = yy_nonterm4n(yy_context)
      if yy_var1a then
        c = yy_from_pcv(yy_var1a)
      end
      yy_var1a
    end and begin 
  val = positive_predicate_with_native_code_code(c)  
 true 
 end) or (yy_context.input.pos = yy_var19; (yy_nontermc3(yy_context) and begin
      yy_var1b = yy_nonterm18(yy_context)
      if yy_var1b then
        val = yy_from_pcv(yy_var1b)
      end
      yy_var1b
    end and begin 
  val = positive_predicate_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var19; (yy_nontermc5(yy_context) and begin
      yy_var1c = yy_nonterm18(yy_context)
      if yy_var1c then
        val = yy_from_pcv(yy_var1c)
      end
      yy_var1c
    end and begin 
  val = negative_predicate_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var19; begin
      yy_var1d = yy_nonterm1f(yy_context)
      if yy_var1d then
        val = yy_from_pcv(yy_var1d)
      end
      yy_var1d
    end); end and yy_to_pcv(val) 
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

def yy_nonterm1f(yy_context) 
val = :yy_nil 
(begin
      yy_var1h = yy_nonterm1p(yy_context)
      if yy_var1h then
        val = yy_from_pcv(yy_var1h)
      end
      yy_var1h
    end and while true
      yy_var1n = yy_context.input.pos
      if not begin; yy_var1l = yy_context.input.pos; (begin
      yy_var1m = yy_context.input.pos
      if yy_var1m then
        p = yy_from_pcv(yy_var1m)
      end
      yy_var1m
    end and yy_nontermbx(yy_context) and begin 
  val = lazy_repeat_code(val, p)  
 true 
 end) or (yy_context.input.pos = yy_var1l; (yy_nontermbv(yy_context) and begin 
  val = repeat_many_times_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var1l; (yy_nontermc1(yy_context) and begin 
  val = repeat_at_least_once_code(val)  
 true 
 end)) or (yy_context.input.pos = yy_var1l; (yy_nontermbz(yy_context) and begin 
  val = optional_code(val)  
 true 
 end)); end then
        yy_context.input.pos = yy_var1n
        break true
      end
    end) and yy_to_pcv(val) 
end 
  
  # 
  # +source_pos+ is position in source code the "lazy repeat" code is compiled
  # from.
  # 
  def lazy_repeat_code(parsing_code, source_pos)
    #
    original_pos_var = new_unique_variable_name
    result_var = new_unique_variable_name
    #
    code(%[ begin
      while true
        ###
        #{original_pos_var} = yy_context.input.pos
        ### Look ahead.
        #{result_var} = ]) + LazyRepeat::UnknownLookAheadCode[source_pos] + code(%[
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
  
def yy_nonterm1p(yy_context) 
val = :yy_nil 
begin; yy_var1q = yy_context.input.pos; (yy_nontermbj(yy_context) and begin
      yy_var1r = yy_nonterme(yy_context)
      if yy_var1r then
        val = yy_from_pcv(yy_var1r)
      end
      yy_var1r
    end and yy_nontermbl(yy_context)) or (yy_context.input.pos = yy_var1q; (yy_nontermbr(yy_context) and begin
      yy_var1s = yy_nonterme(yy_context)
      if yy_var1s then
        c = yy_from_pcv(yy_var1s)
      end
      yy_var1s
    end and yy_nontermbt(yy_context) and begin
      yy_var1t = yy_nonterm40(yy_context)
      if yy_var1t then
        t = yy_from_pcv(yy_var1t)
      end
      yy_var1t
    end and begin
      yy_var1u = yy_nonterm3w(yy_context)
      if yy_var1u then
        var = yy_from_pcv(yy_var1u)
      end
      yy_var1u
    end and begin 
  val = capture_text_code(var, c, t)  
 true 
 end)) or (yy_context.input.pos = yy_var1q; begin
      yy_var1v = yy_nonterm1x(yy_context)
      if yy_var1v then
        val = yy_from_pcv(yy_var1v)
      end
      yy_var1v
    end); end and yy_to_pcv(val) 
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
  
def yy_nonterm1x(yy_context) 
val = :yy_nil 
begin; yy_var1y = yy_context.input.pos; (begin
      yy_var1z = yy_nontermgl(yy_context)
      if yy_var1z then
        r = yy_from_pcv(yy_var1z)
      end
      yy_var1z
    end and begin 
  val = code "yy_char_range(yy_context, #{r.begin.to_ruby_code}, #{r.end.to_ruby_code})"  
 true 
 end) or (yy_context.input.pos = yy_var1y; (begin
      yy_var20 = yy_nontermgr(yy_context)
      if yy_var20 then
        s = yy_from_pcv(yy_var20)
      end
      yy_var20
    end and begin 
  val = code "yy_string(yy_context, #{s.to_ruby_code})"  
 true 
 end)) or (yy_context.input.pos = yy_var1y; (begin
      yy_var21 = yy_context.input.pos
      if yy_var21 then
        n_pos = yy_from_pcv(yy_var21)
      end
      yy_var21
    end and begin
      yy_var22 = yy_nontermen(yy_context)
      if yy_var22 then
        n = yy_from_pcv(yy_var22)
      end
      yy_var22
    end and begin 
  val = UnknownMethodCall[n, %(yy_context), n_pos]  
 true 
 end)) or (yy_context.input.pos = yy_var1y; (yy_nontermcd(yy_context) and begin 
  val = code "yy_char(yy_context)"  
 true 
 end)) or (yy_context.input.pos = yy_var1y; (begin
      yy_var23 = yy_nonterm4n(yy_context)
      if yy_var23 then
        a = yy_from_pcv(yy_var23)
      end
      yy_var23
    end and begin 
  val = code "begin \n #{a} \n true \n end"  
 true 
 end)) or (yy_context.input.pos = yy_var1y; (yy_nontermbf(yy_context) and begin 
  val = code "yy_end?(yy_context)"  
 true 
 end)) or (yy_context.input.pos = yy_var1y; (yy_nontermbh(yy_context) and begin 
  val = code "yy_begin?(yy_context)"  
 true 
 end)) or (yy_context.input.pos = yy_var1y; (begin; yy_var27 = yy_context.input.pos; (yy_nontermc7(yy_context) and yy_nontermc9(yy_context) and begin
      yy_var28 = yy_nontermcv(yy_context)
      if yy_var28 then
        pos_variable = yy_from_pcv(yy_var28)
      end
      yy_var28
    end) or (yy_context.input.pos = yy_var27; (yy_nontermcl(yy_context) and begin
      yy_var29 = yy_nontermcv(yy_context)
      if yy_var29 then
        pos_variable = yy_from_pcv(yy_var29)
      end
      yy_var29
    end)); end and begin
      yy_var2b = yy_context.input.pos
      if not yy_nontermaf(yy_context) then
        yy_context.input.pos = yy_var2b
      end
      true
    end and begin 
  val = code "(yy_context.input.pos = #{pos_variable}; true)"  
 true 
 end)) or (yy_context.input.pos = yy_var1y; (yy_nontermc7(yy_context) and begin 
  val = code "yy_context.input.pos"  
 true 
 end)); end and yy_to_pcv(val) 
end 
def yy_nonterm2c(yy_context) 
val = :yy_nil 
(begin 
  rule = val = Rule.new  
 true 
 end and begin; yy_var2l = yy_context.input.pos; (begin
      yy_var2m = yy_nonterme3(yy_context)
      if yy_var2m then
        rule_name = yy_from_pcv(yy_var2m)
      end
      yy_var2m
    end and yy_nontermbj(yy_context) and begin
      yy_var2q = yy_context.input.pos
      if not begin; yy_var2p = yy_context.input.pos; yy_nontermcb(yy_context) or (yy_context.input.pos = yy_var2p; yy_nontermdj(yy_context)); end then
        yy_context.input.pos = yy_var2q
      end
      true
    end and yy_nontermbl(yy_context) and begin 
  rule.need_entry_point!  
 true 
 end) or (yy_context.input.pos = yy_var2l; begin
      yy_var2r = yy_nontermen(yy_context)
      if yy_var2r then
        rule_name = yy_from_pcv(yy_var2r)
      end
      yy_var2r
    end); end and begin 
  rule.name = rule_name  
 true 
 end and begin
      yy_var2v = yy_context.input.pos
      if not (yy_nontermaf(yy_context) and yy_nonterm2y(yy_context)) then
        yy_context.input.pos = yy_var2v
      end
      true
    end and yy_nontermab(yy_context) and begin
      yy_var2w = yy_nonterme(yy_context)
      if yy_var2w then
        c = yy_from_pcv(yy_var2w)
      end
      yy_var2w
    end and yy_nontermbb(yy_context) and begin 
  rule.method_definition = to_method_definition(c, rule.method_name)  
 true 
 end) and yy_to_pcv(val) 
end 
  
  def to_method_definition(code, method_name)
    code("def #{method_name}(yy_context) \n") +
      code("val = :yy_nil \n") +
      code + code(" and yy_to_pcv(val) \n") +
    code("end \n")
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
  
def yy_nonterm2y(yy_context) 
val = :yy_nil 
((begin
      yy_var3s = yy_context.worst_error
      begin
        not begin
      yy_var3t = yy_context.input.pos
      yy_var3u = yy_nontermab(yy_context)
      yy_context.input.pos = yy_var3t
      yy_var3u
    end
      ensure
        yy_context.worst_error = yy_var3s
      end
    end and yy_char(yy_context)) and yy_nontermix(yy_context)) and while true
      yy_var3v = yy_context.input.pos
      if not ((begin
      yy_var3s = yy_context.worst_error
      begin
        not begin
      yy_var3t = yy_context.input.pos
      yy_var3u = yy_nontermab(yy_context)
      yy_context.input.pos = yy_var3t
      yy_var3u
    end
      ensure
        yy_context.worst_error = yy_var3s
      end
    end and yy_char(yy_context)) and yy_nontermix(yy_context)) then
        yy_context.input.pos = yy_var3v
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nonterm3w(yy_context) 
val = :yy_nil 
begin; yy_var3x = yy_context.input.pos; begin
      yy_var3y = yy_nontermcv(yy_context)
      if yy_var3y then
        val = yy_from_pcv(yy_var3y)
      end
      yy_var3y
    end or (yy_context.input.pos = yy_var3x; (yy_nontermbj(yy_context) and begin
      yy_var3z = yy_nontermcv(yy_context)
      if yy_var3z then
        val = yy_from_pcv(yy_var3z)
      end
      yy_var3z
    end and yy_nontermbl(yy_context))); end and yy_to_pcv(val) 
end 
def yy_nonterm40(yy_context) 
val = :yy_nil 
begin; yy_var41 = yy_context.input.pos; (yy_nontermaf(yy_context) and begin 
 val = :capture 
 true 
 end) or (yy_context.input.pos = yy_var41; (yy_nontermb7(yy_context) and begin 
 val = :append 
 true 
 end)) or (yy_context.input.pos = yy_var41; (yy_nontermb9(yy_context) and begin 
 val = :append 
 true 
 end)); end and yy_to_pcv(val) 
end 

# [line, column] corresponding to position in +io+ (+pos+).
def line_and_column(pos, io)
  @pos = pos
  io.pos = 0
  return line_and_column0(io)
end



      # 
      # +input+ is IO. It must have working IO#pos, IO#pos= and
      # IO#set_encoding() methods.
      # 
      # It may raise YY_SyntaxError.
      # 
      def line_and_column0(input)
        input.set_encoding("UTF-8", "UTF-8")
        context = YY_ParsingContext.new(input)
        yy_from_pcv(
          yy_nonterm43(context) ||
          # TODO: context.worst_error can not be nil here. Prove it.
          raise(context.worst_error)
        )
      end

      # TODO: Allow to pass String to the entry point.
    def yy_nonterm43(yy_context) 
val = :yy_nil 
(begin 
  current_line_and_column = [1, 1]  
 true 
 end and while true
      yy_var4e = yy_context.input.pos
      if not (begin
      yy_var4b = yy_context.input.pos
      if yy_var4b then
        current_pos = yy_from_pcv(yy_var4b)
      end
      yy_var4b
    end and begin 
  if current_pos == @pos then val = current_line_and_column.dup; end  
 true 
 end and begin; yy_var4d = yy_context.input.pos; (yy_nontermjf(yy_context) and begin 
  current_line_and_column[0] += 1; current_line_and_column[1] = 1  
 true 
 end) or (yy_context.input.pos = yy_var4d; (yy_char(yy_context) and begin 
  current_line_and_column[1] += 1  
 true 
 end)); end) then
        yy_context.input.pos = yy_var4e
        break true
      end
    end) and yy_to_pcv(val) 
end 
def yy_nonterm4f(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "%%") and  begin
      while true
        ###
        yy_var4j = yy_context.input.pos
        ### Look ahead.
        yy_var4k = begin; yy_var4m = yy_context.input.pos; yy_nontermjf(yy_context) or (yy_context.input.pos = yy_var4m; yy_end?(yy_context)); end
        yy_context.input.pos = yy_var4j
        break if yy_var4k
        ### Repeat one more time (if possible).
        yy_var4k = yy_char(yy_context)
        if not yy_var4k then
          yy_context.input.pos = yy_var4j
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_var4m = yy_context.input.pos; yy_nontermjf(yy_context) or (yy_context.input.pos = yy_var4m; yy_end?(yy_context)); end) and yy_to_pcv(val) 
end 
def yy_nonterm4n(yy_context) 
val = :yy_nil 
(begin; yy_var7e = yy_context.input.pos; (yy_string(yy_context, "{") and while true
      yy_var7g = yy_context.input.pos
      if not yy_nontermjd(yy_context) then
        yy_context.input.pos = yy_var7g
        break true
      end
    end and yy_string(yy_context, "...") and begin
      yy_var7s = yy_context.input.pos
      if not ( begin
      while true
        ###
        yy_var7q = yy_context.input.pos
        ### Look ahead.
        yy_var7r = yy_nontermjf(yy_context)
        yy_context.input.pos = yy_var7q
        break if yy_var7r
        ### Repeat one more time (if possible).
        yy_var7r = yy_nontermjd(yy_context)
        if not yy_var7r then
          yy_context.input.pos = yy_var7q
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nontermjf(yy_context)) then
        yy_context.input.pos = yy_var7s
      end
      true
    end and begin
      val = ""
      yy_var85 = yy_context.input.pos
       begin
      while true
        ###
        yy_var83 = yy_context.input.pos
        ### Look ahead.
        yy_var84 = begin; yy_var8c = yy_context.input.pos; (yy_string(yy_context, "...") and while true
      yy_var8e = yy_context.input.pos
      if not yy_nontermjd(yy_context) then
        yy_context.input.pos = yy_var8e
        break true
      end
    end and yy_string(yy_context, "}")) or (yy_context.input.pos = yy_var8c; (yy_string(yy_context, "}") and while true
      yy_var8g = yy_context.input.pos
      if not yy_nontermjd(yy_context) then
        yy_context.input.pos = yy_var8g
        break true
      end
    end and yy_string(yy_context, "..."))); end
        yy_context.input.pos = yy_var83
        break if yy_var84
        ### Repeat one more time (if possible).
        yy_var84 = yy_char(yy_context)
        if not yy_var84 then
          yy_context.input.pos = yy_var83
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var86 = yy_context.input.pos
        yy_context.input.pos = yy_var85
        val << yy_context.input.read(yy_var86 - yy_var85).force_encoding(Encoding::UTF_8)
      end
    end and begin; yy_var8c = yy_context.input.pos; (yy_string(yy_context, "...") and while true
      yy_var8e = yy_context.input.pos
      if not yy_nontermjd(yy_context) then
        yy_context.input.pos = yy_var8e
        break true
      end
    end and yy_string(yy_context, "}")) or (yy_context.input.pos = yy_var8c; (yy_string(yy_context, "}") and while true
      yy_var8g = yy_context.input.pos
      if not yy_nontermjd(yy_context) then
        yy_context.input.pos = yy_var8g
        break true
      end
    end and yy_string(yy_context, "..."))); end) or (yy_context.input.pos = yy_var7e; (begin
      val = ""
      yy_var8l = yy_context.input.pos
      yy_nonterma3(yy_context) and begin
        yy_var8m = yy_context.input.pos
        yy_context.input.pos = yy_var8l
        val << yy_context.input.read(yy_var8m - yy_var8l).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  val = val[1...-1]  
 true 
 end)) or (yy_context.input.pos = yy_var7e; (yy_nonterm4f(yy_context) and begin
      val = ""
      yy_var9f = yy_context.input.pos
       begin
      while true
        ###
        yy_var9d = yy_context.input.pos
        ### Look ahead.
        yy_var9e = yy_nonterm4f(yy_context)
        yy_context.input.pos = yy_var9d
        break if yy_var9e
        ### Repeat one more time (if possible).
        yy_var9e = yy_char(yy_context)
        if not yy_var9e then
          yy_context.input.pos = yy_var9d
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var9g = yy_context.input.pos
        yy_context.input.pos = yy_var9f
        val << yy_context.input.read(yy_var9g - yy_var9f).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm4f(yy_context))) or (yy_context.input.pos = yy_var7e; (yy_nonterm4f(yy_context) and begin
      val = ""
      yy_vara1 = yy_context.input.pos
      while true
      yy_vara0 = yy_context.input.pos
      if not yy_char(yy_context) then
        yy_context.input.pos = yy_vara0
        break true
      end
    end and begin
        yy_vara2 = yy_context.input.pos
        yy_context.input.pos = yy_vara1
        val << yy_context.input.read(yy_vara2 - yy_vara1).force_encoding(Encoding::UTF_8)
      end
    end and yy_end?(yy_context))); end and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nonterma3(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "{") and  begin
      while true
        ###
        yy_vara9 = yy_context.input.pos
        ### Look ahead.
        yy_varaa = yy_string(yy_context, "}")
        yy_context.input.pos = yy_vara9
        break if yy_varaa
        ### Repeat one more time (if possible).
        yy_varaa = begin; yy_vara8 = yy_context.input.pos; yy_nonterma3(yy_context) or (yy_context.input.pos = yy_vara8; yy_char(yy_context)); end
        if not yy_varaa then
          yy_context.input.pos = yy_vara9
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string(yy_context, "}")) and yy_to_pcv(val) 
end 
def yy_nontermab(yy_context) 
val = :yy_nil 
(begin; yy_varae = yy_context.input.pos; yy_string(yy_context, "<-") or (yy_context.input.pos = yy_varae; yy_string(yy_context, "=")) or (yy_context.input.pos = yy_varae; yy_string(yy_context, "\u{2190}")); end and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermaf(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ":") and (begin
      yy_varay = yy_context.worst_error
      begin
        not begin
      yy_varaz = yy_context.input.pos
      yy_varb0 = yy_string(yy_context, "+")
      yy_context.input.pos = yy_varaz
      yy_varb0
    end
      ensure
        yy_context.worst_error = yy_varay
      end
    end and begin
      yy_varb4 = yy_context.worst_error
      begin
        not begin
      yy_varb5 = yy_context.input.pos
      yy_varb6 = yy_string(yy_context, ">>")
      yy_context.input.pos = yy_varb5
      yy_varb6
    end
      ensure
        yy_context.worst_error = yy_varb4
      end
    end) and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb7(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ":+") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermb9(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ":>>") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbb(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ";") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbd(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "/") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbf(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "$") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbh(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "^") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbj(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "(") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbl(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ")") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbn(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "[") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbp(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "]") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbr(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "<") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbt(yy_context) 
val = :yy_nil 
(yy_string(yy_context, ">") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbv(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "*") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbx(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "*?") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermbz(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "?") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermc1(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "+") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermc3(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "&") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermc5(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "!") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermc7(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "@") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermc9(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "=") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermcb(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "...") and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermcd(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "char") and begin
      yy_varci = yy_context.worst_error
      begin
        not begin
      yy_varcj = yy_context.input.pos
      yy_varck = yy_nontermgj(yy_context)
      yy_context.input.pos = yy_varcj
      yy_varck
    end
      ensure
        yy_context.worst_error = yy_varci
      end
    end and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermcl(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "at") and begin
      yy_varcq = yy_context.worst_error
      begin
        not begin
      yy_varcr = yy_context.input.pos
      yy_varcs = yy_nontermgj(yy_context)
      yy_context.input.pos = yy_varcr
      yy_varcs
    end
      ensure
        yy_context.worst_error = yy_varcq
      end
    end and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermct(yy_context) 
val = :yy_nil 
begin; yy_varcu = yy_context.input.pos; yy_nontermcd(yy_context) or (yy_context.input.pos = yy_varcu; yy_nontermcl(yy_context)); end and yy_to_pcv(val) 
end 
def yy_nontermcv(yy_context) 
val = :yy_nil 
(begin
      val = ""
      yy_vardh = yy_context.input.pos
      (begin
      yy_vardc = yy_context.input.pos
      if not begin; yy_vardb = yy_context.input.pos; yy_string(yy_context, "@") or (yy_context.input.pos = yy_vardb; yy_string(yy_context, "$")); end then
        yy_context.input.pos = yy_vardc
      end
      true
    end and yy_nontermdz(yy_context) and while true
      yy_vardg = yy_context.input.pos
      if not yy_nonterme1(yy_context) then
        yy_context.input.pos = yy_vardg
        break true
      end
    end) and begin
        yy_vardi = yy_context.input.pos
        yy_context.input.pos = yy_vardh
        val << yy_context.input.read(yy_vardi - yy_vardh).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermdj(yy_context) 
val = :yy_nil 
(begin
      val = ""
      yy_vardx = yy_context.input.pos
      (yy_nontermdz(yy_context) and while true
      yy_vardw = yy_context.input.pos
      if not yy_nonterme1(yy_context) then
        yy_context.input.pos = yy_vardw
        break true
      end
    end) and begin
        yy_vardy = yy_context.input.pos
        yy_context.input.pos = yy_vardx
        val << yy_context.input.read(yy_vardy - yy_vardx).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermdz(yy_context) 
val = :yy_nil 
begin; yy_vare0 = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_vare0; yy_string(yy_context, "_")); end and yy_to_pcv(val) 
end 
def yy_nonterme1(yy_context) 
val = :yy_nil 
begin; yy_vare2 = yy_context.input.pos; yy_nontermdz(yy_context) or (yy_context.input.pos = yy_vare2; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nonterme3(yy_context) 
val = :yy_nil 
(begin
      val = ""
      yy_vareh = yy_context.input.pos
      (yy_nontermej(yy_context) and while true
      yy_vareg = yy_context.input.pos
      if not yy_nontermel(yy_context) then
        yy_context.input.pos = yy_vareg
        break true
      end
    end) and begin
        yy_varei = yy_context.input.pos
        yy_context.input.pos = yy_vareh
        val << yy_context.input.read(yy_varei - yy_vareh).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermej(yy_context) 
val = :yy_nil 
begin; yy_varek = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_varek; yy_string(yy_context, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermel(yy_context) 
val = :yy_nil 
begin; yy_varem = yy_context.input.pos; yy_nontermej(yy_context) or (yy_context.input.pos = yy_varem; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermen(yy_context) 
val = :yy_nil 
(begin
      yy_vares = yy_context.worst_error
      begin
        not begin
      yy_varet = yy_context.input.pos
      yy_vareu = yy_nontermct(yy_context)
      yy_context.input.pos = yy_varet
      yy_vareu
    end
      ensure
        yy_context.worst_error = yy_vares
      end
    end and begin; yy_varfo = yy_context.input.pos; (begin
      val = ""
      yy_varg1 = yy_context.input.pos
      (yy_nontermgh(yy_context) and while true
      yy_varg0 = yy_context.input.pos
      if not yy_nontermgj(yy_context) then
        yy_context.input.pos = yy_varg0
        break true
      end
    end) and begin
        yy_varg2 = yy_context.input.pos
        yy_context.input.pos = yy_varg1
        val << yy_context.input.read(yy_varg2 - yy_varg1).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermix(yy_context)) or (yy_context.input.pos = yy_varfo; (begin
      val = ""
      yy_vargf = yy_context.input.pos
      (yy_string(yy_context, "`") and  begin
      while true
        ###
        yy_vargd = yy_context.input.pos
        ### Look ahead.
        yy_varge = yy_string(yy_context, "`")
        yy_context.input.pos = yy_vargd
        break if yy_varge
        ### Repeat one more time (if possible).
        yy_varge = yy_char(yy_context)
        if not yy_varge then
          yy_context.input.pos = yy_vargd
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string(yy_context, "`")) and begin
        yy_vargg = yy_context.input.pos
        yy_context.input.pos = yy_vargf
        val << yy_context.input.read(yy_vargg - yy_vargf).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermix(yy_context))); end) and yy_to_pcv(val) 
end 
def yy_nontermgh(yy_context) 
val = :yy_nil 
begin; yy_vargi = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_vargi; yy_char_range(yy_context, "A", "Z")) or (yy_context.input.pos = yy_vargi; yy_string(yy_context, "-")) or (yy_context.input.pos = yy_vargi; yy_string(yy_context, "_")); end and yy_to_pcv(val) 
end 
def yy_nontermgj(yy_context) 
val = :yy_nil 
begin; yy_vargk = yy_context.input.pos; yy_nontermgh(yy_context) or (yy_context.input.pos = yy_vargk; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val) 
end 
def yy_nontermgl(yy_context) 
val = :yy_nil 
(begin
      yy_vargn = yy_nontermgr(yy_context)
      if yy_vargn then
        from = yy_from_pcv(yy_vargn)
      end
      yy_vargn
    end and begin; yy_vargp = yy_context.input.pos; yy_string(yy_context, "...") or (yy_context.input.pos = yy_vargp; yy_string(yy_context, "..")) or (yy_context.input.pos = yy_vargp; yy_string(yy_context, "\u{2026}")) or (yy_context.input.pos = yy_vargp; yy_string(yy_context, "\u{2025}")); end and yy_nontermix(yy_context) and begin
      yy_vargq = yy_nontermgr(yy_context)
      if yy_vargq then
        to = yy_from_pcv(yy_vargq)
      end
      yy_vargq
    end and yy_nontermix(yy_context) and begin 
  raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1  
 true 
 end and begin 
  val = from...to  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermgr(yy_context) 
val = :yy_nil 
(begin; yy_varhn = yy_context.input.pos; (yy_string(yy_context, "'") and begin
      val = ""
      yy_vari0 = yy_context.input.pos
       begin
      while true
        ###
        yy_varhy = yy_context.input.pos
        ### Look ahead.
        yy_varhz = yy_string(yy_context, "'")
        yy_context.input.pos = yy_varhy
        break if yy_varhz
        ### Repeat one more time (if possible).
        yy_varhz = yy_char(yy_context)
        if not yy_varhz then
          yy_context.input.pos = yy_varhy
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_vari1 = yy_context.input.pos
        yy_context.input.pos = yy_vari0
        val << yy_context.input.read(yy_vari1 - yy_vari0).force_encoding(Encoding::UTF_8)
      end
    end and yy_string(yy_context, "'")) or (yy_context.input.pos = yy_varhn; (yy_string(yy_context, "\"") and begin
      val = ""
      yy_varie = yy_context.input.pos
       begin
      while true
        ###
        yy_varic = yy_context.input.pos
        ### Look ahead.
        yy_varid = yy_string(yy_context, "\"")
        yy_context.input.pos = yy_varic
        break if yy_varid
        ### Repeat one more time (if possible).
        yy_varid = yy_char(yy_context)
        if not yy_varid then
          yy_context.input.pos = yy_varic
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varif = yy_context.input.pos
        yy_context.input.pos = yy_varie
        val << yy_context.input.read(yy_varif - yy_varie).force_encoding(Encoding::UTF_8)
      end
    end and yy_string(yy_context, "\""))) or (yy_context.input.pos = yy_varhn; (begin
      yy_varig = yy_nontermih(yy_context)
      if yy_varig then
        code = yy_from_pcv(yy_varig)
      end
      yy_varig
    end and begin 
  val = "" << code  
 true 
 end)); end and yy_nontermix(yy_context)) and yy_to_pcv(val) 
end 
def yy_nontermih(yy_context) 
val = :yy_nil 
(yy_string(yy_context, "U+") and begin
      code = ""
      yy_variv = yy_context.input.pos
      begin; yy_varit = yy_context.input.pos; yy_char_range(yy_context, "0", "9") or (yy_context.input.pos = yy_varit; yy_char_range(yy_context, "A", "F")); end and while true
      yy_variu = yy_context.input.pos
      if not begin; yy_varit = yy_context.input.pos; yy_char_range(yy_context, "0", "9") or (yy_context.input.pos = yy_varit; yy_char_range(yy_context, "A", "F")); end then
        yy_context.input.pos = yy_variu
        break true
      end
    end and begin
        yy_variw = yy_context.input.pos
        yy_context.input.pos = yy_variv
        code << yy_context.input.read(yy_variw - yy_variv).force_encoding(Encoding::UTF_8)
      end
    end and begin 
  code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF  
 true 
 end and begin 
  val = code  
 true 
 end) and yy_to_pcv(val) 
end 
def yy_nontermix(yy_context) 
val = :yy_nil 
while true
      yy_varj2 = yy_context.input.pos
      if not begin; yy_varj1 = yy_context.input.pos; yy_nontermjd(yy_context) or (yy_context.input.pos = yy_varj1; yy_nontermj3(yy_context)); end then
        yy_context.input.pos = yy_varj2
        break true
      end
    end and yy_to_pcv(val) 
end 
def yy_nontermj3(yy_context) 
val = :yy_nil 
(begin; yy_varj6 = yy_context.input.pos; yy_string(yy_context, "#") or (yy_context.input.pos = yy_varj6; yy_string(yy_context, "--")); end and  begin
      while true
        ###
        yy_varj9 = yy_context.input.pos
        ### Look ahead.
        yy_varja = begin; yy_varjc = yy_context.input.pos; yy_nontermjf(yy_context) or (yy_context.input.pos = yy_varjc; yy_end?(yy_context)); end
        yy_context.input.pos = yy_varj9
        break if yy_varja
        ### Repeat one more time (if possible).
        yy_varja = yy_char(yy_context)
        if not yy_varja then
          yy_context.input.pos = yy_varj9
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_varjc = yy_context.input.pos; yy_nontermjf(yy_context) or (yy_context.input.pos = yy_varjc; yy_end?(yy_context)); end) and yy_to_pcv(val) 
end 
def yy_nontermjd(yy_context) 
val = :yy_nil 
begin; yy_varje = yy_context.input.pos; yy_char_range(yy_context, "\t", "\r") or (yy_context.input.pos = yy_varje; yy_string(yy_context, " ")) or (yy_context.input.pos = yy_varje; yy_string(yy_context, "\u{85}")) or (yy_context.input.pos = yy_varje; yy_string(yy_context, "\u{a0}")) or (yy_context.input.pos = yy_varje; yy_string(yy_context, "\u{1680}")) or (yy_context.input.pos = yy_varje; yy_string(yy_context, "\u{180e}")) or (yy_context.input.pos = yy_varje; yy_char_range(yy_context, "\u{2000}", "\u{200a}")) or (yy_context.input.pos = yy_varje; yy_string(yy_context, "\u{2028}")) or (yy_context.input.pos = yy_varje; yy_string(yy_context, "\u{2029}")) or (yy_context.input.pos = yy_varje; yy_string(yy_context, "\u{202f}")) or (yy_context.input.pos = yy_varje; yy_string(yy_context, "\u{205f}")) or (yy_context.input.pos = yy_varje; yy_string(yy_context, "\u{3000}")); end and yy_to_pcv(val) 
end 
def yy_nontermjf(yy_context) 
val = :yy_nil 
begin; yy_varjg = yy_context.input.pos; (yy_string(yy_context, "\r") and yy_string(yy_context, "\n")) or (yy_context.input.pos = yy_varjg; yy_string(yy_context, "\r")) or (yy_context.input.pos = yy_varjg; yy_string(yy_context, "\n")) or (yy_context.input.pos = yy_varjg; yy_string(yy_context, "\u{85}")) or (yy_context.input.pos = yy_varjg; yy_string(yy_context, "\v")) or (yy_context.input.pos = yy_varjg; yy_string(yy_context, "\f")) or (yy_context.input.pos = yy_varjg; yy_string(yy_context, "\u{2028}")) or (yy_context.input.pos = yy_varjg; yy_string(yy_context, "\u{2029}")); end and yy_to_pcv(val) 
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
    
    class << self
      
      alias [] new
      
    end
    
    def initialize(source_pos)
      @source_pos = source_pos
    end
    
    def to_s
      raise CodeCanNotBeDetermined.new self
    end
    
    # Position in source code associated with this UnknownLookAheadCode.
    attr_reader :source_pos
    
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


class Array
  
  alias add <<
  
end


begin
  grammar_file = ARGV[0] or abort %(Usage: ruby #{__FILE__} grammar-file)
  File.open(grammar_file) do |io|
    begin
      yy_parse(io)
    rescue PEGParserGenerator::YY_SyntaxError => e
      line, column = *(line_and_column(e.pos, io))
      STDERR.puts %(#{grammar_file}:#{line}:#{column}: error: #{e.message})
      exit 1
    end
  end
end

