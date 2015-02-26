#!/usr/bin/ruby
# encoding: UTF-8

      
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
    
      
      # :nodoc:
      ### converts value to parser-compatible value (which is always non-false and
      ### non-nil).
      def yy_to_pcv(value)
        if value.nil? then :yy_nil
        elsif value == false then :yy_false
        else value
        end
      end
      
      # :nodoc:
      ### converts value got by #yy_to_pcv() to actual value.
      def yy_from_pcv(value)
        if value == :yy_nil then nil
        elsif value == :yy_false then false
        else value
        end
      end
      
      # :nodoc:
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
      
      # :nodoc:
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
      
      # :nodoc:
      def yy_end?(context)
        #
        if not context.input.eof?
          context << YY_SyntaxExpectationError.new("the end", context.input.pos)
          return nil
        end
        #
        return true
      end
      
      # :nodoc:
      def yy_begin?(context)
        #
        if not (context.input.pos == 0)
          context << YY_SyntaxExpectationError.new("the beginning", context.input.pos)
          return nil
        end
        #
        return true
      end
      
      # :nodoc:
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
      
      # :nodoc:
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
      
      # :nodoc:
      ### The form of +string+ suitable for displaying in messages.
      def yy_displayed(string)
        if string.length == 1 then
          char = string[0]
          char_code = char.ord
          case char_code
          when 0x00...0x20, 0x2028, 0x2029 then %(#{yy_unicode_s char_code})
          when 0x20...0x80 then %("#{char}")
          when 0x80...Float::INFINITY then %("#{char} (#{yy_unicode_s char_code})")
          end
        else
          %("#{string}")
        end
      end
      
      # :nodoc:
      ### "U+XXXX" string corresponding to +char_code+.
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
      
      # :nodoc:
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
    
      # :nodoc:
      def yy_nonterm1(yy_context)
        val = nil
        (begin
      
    code = code("")
    rule_is_first = true
    method_names = HashMap.new
  
      true
    end and yy_nontermfu(yy_context) and while true
      yy_varc = yy_context.input.pos
      if not begin; yy_var8 = yy_context.input.pos; (begin
      yy_var9 = yy_context.input.pos
      if yy_var9 then
        rule_pos = yy_from_pcv(yy_var9)
      end
      yy_var9
    end and begin
      yy_vara = yy_nonterm2d(yy_context)
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
      yy_varb = yy_nonterm4g(yy_context)
      if yy_varb then
        code_insertion = yy_from_pcv(yy_varb)
      end
      yy_varb
    end and begin
      
        code += code_insertion
      
      true
    end)); end then
        yy_context.input.pos = yy_varc
        break true
      end
    end and yy_end?(yy_context) and begin
      
    code = link(code, method_names)
    check_no_unresolved_code_in code
    val = code
  
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
      
      # :nodoc:
      ### converts value to parser-compatible value (which is always non-false and
      ### non-nil).
      def yy_to_pcv(value)
        if value.nil? then :yy_nil
        elsif value == false then :yy_false
        else value
        end
      end
      
      # :nodoc:
      ### converts value got by #yy_to_pcv() to actual value.
      def yy_from_pcv(value)
        if value == :yy_nil then nil
        elsif value == :yy_false then false
        else value
        end
      end
      
      # :nodoc:
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
      
      # :nodoc:
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
      
      # :nodoc:
      def yy_end?(context)
        #
        if not context.input.eof?
          context << YY_SyntaxExpectationError.new("the end", context.input.pos)
          return nil
        end
        #
        return true
      end
      
      # :nodoc:
      def yy_begin?(context)
        #
        if not (context.input.pos == 0)
          context << YY_SyntaxExpectationError.new("the beginning", context.input.pos)
          return nil
        end
        #
        return true
      end
      
      # :nodoc:
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
      
      # :nodoc:
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
      
      # :nodoc:
      ### The form of +string+ suitable for displaying in messages.
      def yy_displayed(string)
        if string.length == 1 then
          char = string[0]
          char_code = char.ord
          case char_code
          when 0x00...0x20, 0x2028, 0x2029 then %(\#{yy_unicode_s char_code})
          when 0x20...0x80 then %("\#{char}")
          when 0x80...Float::INFINITY then %("\#{char} (\#{yy_unicode_s char_code})")
          end
        else
          %("\#{string}")
        end
      end
      
      # :nodoc:
      ### "U+XXXX" string corresponding to +char_code+.
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
      
      # :nodoc:
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
  

      # :nodoc:
      def yy_nonterme(yy_context)
        val = nil
        begin
      yy_varg = yy_nontermh(yy_context)
      if yy_varg then
        val = yy_from_pcv(yy_varg)
      end
      yy_varg
    end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermh(yy_context)
        val = nil
        (begin
      
    single_expression = true
    remembered_pos_var = new_unique_variable_name
  
      true
    end and begin
      yy_vark = yy_context.input.pos
      if not yy_nonterm8a(yy_context) then
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
      if not (yy_nonterm8a(yy_context) and begin
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
    
      # :nodoc:
      def yy_nonterms(yy_context)
        val = nil
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
    end) or (yy_context.input.pos = yy_varx; (yy_nonterm8m(yy_context) and begin
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
    end) or (yy_context.input.pos = yy_varx; (yy_nonterm8m(yy_context) and begin
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
  

      # :nodoc:
      def yy_nonterm11(yy_context)
        val = nil
        begin; yy_var12 = yy_context.input.pos; (begin
      yy_var13 = yy_nonterm18(yy_context)
      if yy_var13 then
        c = yy_from_pcv(yy_var13)
      end
      yy_var13
    end and begin
      yy_var14 = yy_nonterm41(yy_context)
      if yy_var14 then
        t = yy_from_pcv(yy_var14)
      end
      yy_var14
    end and begin
      yy_var15 = yy_nonterm3x(yy_context)
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
  

      # :nodoc:
      def yy_nonterm18(yy_context)
        val = nil
        begin; yy_var19 = yy_context.input.pos; (yy_nonterm90(yy_context) and begin
      yy_var1a = yy_nonterm4g(yy_context)
      if yy_var1a then
        predicate_code = yy_from_pcv(yy_var1a)
      end
      yy_var1a
    end and begin
       val = positive_predicate_with_native_code_code(predicate_code) 
      true
    end) or (yy_context.input.pos = yy_var19; (yy_nonterm90(yy_context) and begin
      yy_var1b = yy_nonterm18(yy_context)
      if yy_var1b then
        val = yy_from_pcv(yy_var1b)
      end
      yy_var1b
    end and begin
       val = positive_predicate_code(val) 
      true
    end)) or (yy_context.input.pos = yy_var19; (yy_nonterm92(yy_context) and begin
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
    code(%(begin \n )) + native_code + code(%( \n end))  # Newlines are needed because native_code may contain comments.
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


      # :nodoc:
      def yy_nonterm1f(yy_context)
        val = nil
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
    end and yy_nonterm8u(yy_context) and begin
       val = lazy_repeat_code(val, p) 
      true
    end) or (yy_context.input.pos = yy_var1l; (yy_nonterm8s(yy_context) and begin
       val = repeat_many_times_code(val) 
      true
    end)) or (yy_context.input.pos = yy_var1l; (yy_nonterm8y(yy_context) and begin
       val = repeat_at_least_once_code(val) 
      true
    end)) or (yy_context.input.pos = yy_var1l; (yy_nonterm8w(yy_context) and begin
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
  

      # :nodoc:
      def yy_nonterm1p(yy_context)
        val = nil
        begin; yy_var1q = yy_context.input.pos; (yy_nonterm8g(yy_context) and begin
      yy_var1r = yy_nonterme(yy_context)
      if yy_var1r then
        val = yy_from_pcv(yy_var1r)
      end
      yy_var1r
    end and yy_nonterm8i(yy_context)) or (yy_context.input.pos = yy_var1q; (yy_nonterm8o(yy_context) and begin
      yy_var1s = yy_nonterme(yy_context)
      if yy_var1s then
        c = yy_from_pcv(yy_var1s)
      end
      yy_var1s
    end and yy_nonterm8q(yy_context) and begin
      yy_var1t = yy_nonterm41(yy_context)
      if yy_var1t then
        t = yy_from_pcv(yy_var1t)
      end
      yy_var1t
    end and begin
      yy_var1u = yy_nonterm3x(yy_context)
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
  

      # :nodoc:
      def yy_nonterm1x(yy_context)
        val = nil
        begin; yy_var1y = yy_context.input.pos; (begin
      yy_var1z = yy_nontermdi(yy_context)
      if yy_var1z then
        r = yy_from_pcv(yy_var1z)
      end
      yy_var1z
    end and begin
       val = code "yy_char_range(yy_context, #{r.begin.to_ruby_code}, #{r.end.to_ruby_code})" 
      true
    end) or (yy_context.input.pos = yy_var1y; (begin
      yy_var20 = yy_nontermdo(yy_context)
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
      yy_var22 = yy_nontermbk(yy_context)
      if yy_var22 then
        n = yy_from_pcv(yy_var22)
      end
      yy_var22
    end and begin
       val = UnknownMethodCall[n, %(yy_context), n_pos] 
      true
    end)) or (yy_context.input.pos = yy_var1y; (yy_nonterm9a(yy_context) and begin
       val = code "yy_char(yy_context)" 
      true
    end)) or (yy_context.input.pos = yy_var1y; (begin
      yy_var23 = yy_nonterm4g(yy_context)
      if yy_var23 then
        action_code = yy_from_pcv(yy_var23)
      end
      yy_var23
    end and begin
       val = compile_action_expression(action_code) 
      true
    end)) or (yy_context.input.pos = yy_var1y; (yy_nonterm8c(yy_context) and begin
       val = code "yy_end?(yy_context)" 
      true
    end)) or (yy_context.input.pos = yy_var1y; (yy_nonterm8e(yy_context) and begin
       val = code "yy_begin?(yy_context)" 
      true
    end)) or (yy_context.input.pos = yy_var1y; (begin; yy_var27 = yy_context.input.pos; (yy_nonterm94(yy_context) and yy_nonterm96(yy_context) and begin
      yy_var28 = yy_nonterm9s(yy_context)
      if yy_var28 then
        pos_variable = yy_from_pcv(yy_var28)
      end
      yy_var28
    end) or (yy_context.input.pos = yy_var27; (yy_nonterm9i(yy_context) and begin
      yy_var29 = yy_nonterm9s(yy_context)
      if yy_var29 then
        pos_variable = yy_from_pcv(yy_var29)
      end
      yy_var29
    end)); end and begin
      yy_var2b = yy_context.input.pos
      if not yy_nonterm7c(yy_context) then
        yy_context.input.pos = yy_var2b
      end
      true
    end and begin
       val = code "(yy_context.input.pos = #{pos_variable}; true)" 
      true
    end)) or (yy_context.input.pos = yy_var1y; (yy_nonterm94(yy_context) and begin
       val = code "yy_context.input.pos" 
      true
    end)); end and yy_to_pcv(val)
      end
      
  # +action_code+ is the Code extracted from the "action" expression.
  def compile_action_expression(action_code)
    # Validate action code.
    begin
      RubyVM::InstructionSequence.compile(action_code.to_s)
    rescue SyntaxError => e
      raise YY_SyntaxError.new("syntax error", action_code.pos)
    end
    # Compile the expression!
    code(%(begin
      )) + action_code + code(%(
      true
    end))
    # NOTE: Newline must be present after action's body because it may include
    # comments.
  end
  

      # :nodoc:
      def yy_nonterm2d(yy_context)
        val = nil
        (begin
       rule = val = Rule.new 
      true
    end and begin; yy_var2m = yy_context.input.pos; (begin
      yy_var2n = yy_nontermb0(yy_context)
      if yy_var2n then
        rule_name = yy_from_pcv(yy_var2n)
      end
      yy_var2n
    end and yy_nonterm8g(yy_context) and begin
      yy_var2r = yy_context.input.pos
      if not begin; yy_var2q = yy_context.input.pos; yy_nonterm98(yy_context) or (yy_context.input.pos = yy_var2q; yy_nontermag(yy_context)); end then
        yy_context.input.pos = yy_var2r
      end
      true
    end and yy_nonterm8i(yy_context) and begin
       rule.need_entry_point! 
      true
    end) or (yy_context.input.pos = yy_var2m; begin
      yy_var2s = yy_nontermbk(yy_context)
      if yy_var2s then
        rule_name = yy_from_pcv(yy_var2s)
      end
      yy_var2s
    end); end and begin
       rule.name = rule_name 
      true
    end and begin
      yy_var2w = yy_context.input.pos
      if not (yy_nonterm7c(yy_context) and yy_nonterm2z(yy_context)) then
        yy_context.input.pos = yy_var2w
      end
      true
    end and yy_nonterm78(yy_context) and begin
      yy_var2x = yy_nonterme(yy_context)
      if yy_var2x then
        c = yy_from_pcv(yy_var2x)
      end
      yy_var2x
    end and yy_nonterm88(yy_context) and begin
       rule.method_definition = to_method_definition(c, rule.method_name) 
      true
    end) and yy_to_pcv(val)
      end
      
  def to_method_definition(code, method_name)
    code(%(
      # :nodoc:
      def #{method_name}(yy_context)
        val = nil
        )) + code + code(%( and yy_to_pcv(val)
      end
    ))
  end
  

      # :nodoc:
      def yy_nonterm2z(yy_context)
        val = nil
        ((begin
      yy_var3t = yy_context.worst_error
      begin
        not begin
      yy_var3u = yy_context.input.pos
      yy_var3v = yy_nonterm78(yy_context)
      yy_context.input.pos = yy_var3u
      yy_var3v
    end
      ensure
        yy_context.worst_error = yy_var3t
      end
    end and yy_char(yy_context)) and yy_nontermfu(yy_context)) and while true
      yy_var3w = yy_context.input.pos
      if not ((begin
      yy_var3t = yy_context.worst_error
      begin
        not begin
      yy_var3u = yy_context.input.pos
      yy_var3v = yy_nonterm78(yy_context)
      yy_context.input.pos = yy_var3u
      yy_var3v
    end
      ensure
        yy_context.worst_error = yy_var3t
      end
    end and yy_char(yy_context)) and yy_nontermfu(yy_context)) then
        yy_context.input.pos = yy_var3w
        break true
      end
    end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm3x(yy_context)
        val = nil
        begin; yy_var3y = yy_context.input.pos; begin
      yy_var3z = yy_nonterm9s(yy_context)
      if yy_var3z then
        val = yy_from_pcv(yy_var3z)
      end
      yy_var3z
    end or (yy_context.input.pos = yy_var3y; (yy_nonterm8g(yy_context) and begin
      yy_var40 = yy_nonterm9s(yy_context)
      if yy_var40 then
        val = yy_from_pcv(yy_var40)
      end
      yy_var40
    end and yy_nonterm8i(yy_context))); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm41(yy_context)
        val = nil
        begin; yy_var42 = yy_context.input.pos; (yy_nonterm7c(yy_context) and begin
      val = :capture
      true
    end) or (yy_context.input.pos = yy_var42; (yy_nonterm84(yy_context) and begin
      val = :append
      true
    end)) or (yy_context.input.pos = yy_var42; (yy_nonterm86(yy_context) and begin
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
          yy_nonterm44(context) ||
          # TODO: context.worst_error can not be nil here. Prove it.
          raise(context.worst_error)
        )
      end

      # TODO: Allow to pass String to the entry point.
    
      # :nodoc:
      def yy_nonterm44(yy_context)
        val = nil
        (begin
       current_line_and_column = [1, 1] 
      true
    end and while true
      yy_var4f = yy_context.input.pos
      if not (begin
      yy_var4c = yy_context.input.pos
      if yy_var4c then
        current_pos = yy_from_pcv(yy_var4c)
      end
      yy_var4c
    end and begin
       if current_pos == @pos then val = current_line_and_column.dup; end 
      true
    end and begin; yy_var4e = yy_context.input.pos; (yy_nontermgc(yy_context) and begin
       current_line_and_column[0] += 1; current_line_and_column[1] = 1 
      true
    end) or (yy_context.input.pos = yy_var4e; (yy_char(yy_context) and begin
       current_line_and_column[1] += 1 
      true
    end)); end) then
        yy_context.input.pos = yy_var4f
        break true
      end
    end) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm4g(yy_context)
        val = nil
        (begin; yy_var5r = yy_context.input.pos; (yy_string(yy_context, "{") and while true
      yy_var5t = yy_context.input.pos
      if not yy_nontermga(yy_context) then
        yy_context.input.pos = yy_var5t
        break true
      end
    end and yy_string(yy_context, "...") and begin
      yy_var65 = yy_context.input.pos
      if not ( begin
      while true
        ###
        yy_var63 = yy_context.input.pos
        ### Look ahead.
        yy_var64 = yy_nontermgc(yy_context)
        yy_context.input.pos = yy_var63
        break if yy_var64
        ### Repeat one more time (if possible).
        yy_var64 = yy_nontermga(yy_context)
        if not yy_var64 then
          yy_context.input.pos = yy_var63
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nontermgc(yy_context)) then
        yy_context.input.pos = yy_var65
      end
      true
    end and begin
      val = ""
      yy_var6i = yy_context.input.pos
       begin
      while true
        ###
        yy_var6g = yy_context.input.pos
        ### Look ahead.
        yy_var6h = begin; yy_var6p = yy_context.input.pos; (yy_string(yy_context, "...") and while true
      yy_var6r = yy_context.input.pos
      if not yy_nontermga(yy_context) then
        yy_context.input.pos = yy_var6r
        break true
      end
    end and yy_string(yy_context, "}")) or (yy_context.input.pos = yy_var6p; (yy_string(yy_context, "}") and while true
      yy_var6t = yy_context.input.pos
      if not yy_nontermga(yy_context) then
        yy_context.input.pos = yy_var6t
        break true
      end
    end and yy_string(yy_context, "..."))); end
        yy_context.input.pos = yy_var6g
        break if yy_var6h
        ### Repeat one more time (if possible).
        yy_var6h = yy_char(yy_context)
        if not yy_var6h then
          yy_context.input.pos = yy_var6g
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var6j = yy_context.input.pos
        yy_context.input.pos = yy_var6i
        val << yy_context.input.read(yy_var6j - yy_var6i).force_encoding(Encoding::UTF_8)
      end
    end and begin; yy_var6p = yy_context.input.pos; (yy_string(yy_context, "...") and while true
      yy_var6r = yy_context.input.pos
      if not yy_nontermga(yy_context) then
        yy_context.input.pos = yy_var6r
        break true
      end
    end and yy_string(yy_context, "}")) or (yy_context.input.pos = yy_var6p; (yy_string(yy_context, "}") and while true
      yy_var6t = yy_context.input.pos
      if not yy_nontermga(yy_context) then
        yy_context.input.pos = yy_var6t
        break true
      end
    end and yy_string(yy_context, "..."))); end) or (yy_context.input.pos = yy_var5r; (begin
      val = ""
      yy_var6y = yy_context.input.pos
      yy_nonterm70(yy_context) and begin
        yy_var6z = yy_context.input.pos
        yy_context.input.pos = yy_var6y
        val << yy_context.input.read(yy_var6z - yy_var6y).force_encoding(Encoding::UTF_8)
      end
    end and begin
       val = val[1...-1] 
      true
    end)); end and yy_nontermfu(yy_context) and begin
       val = code(val) 
      true
    end) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm70(yy_context)
        val = nil
        (yy_string(yy_context, "{") and  begin
      while true
        ###
        yy_var76 = yy_context.input.pos
        ### Look ahead.
        yy_var77 = yy_string(yy_context, "}")
        yy_context.input.pos = yy_var76
        break if yy_var77
        ### Repeat one more time (if possible).
        yy_var77 = begin; yy_var75 = yy_context.input.pos; yy_nonterm70(yy_context) or (yy_context.input.pos = yy_var75; yy_char(yy_context)); end
        if not yy_var77 then
          yy_context.input.pos = yy_var76
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string(yy_context, "}")) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm78(yy_context)
        val = nil
        (begin; yy_var7b = yy_context.input.pos; yy_string(yy_context, "<-") or (yy_context.input.pos = yy_var7b; yy_string(yy_context, "=")) or (yy_context.input.pos = yy_var7b; yy_string(yy_context, "\u{2190}")); end and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm7c(yy_context)
        val = nil
        (yy_string(yy_context, ":") and (begin
      yy_var7v = yy_context.worst_error
      begin
        not begin
      yy_var7w = yy_context.input.pos
      yy_var7x = yy_string(yy_context, "+")
      yy_context.input.pos = yy_var7w
      yy_var7x
    end
      ensure
        yy_context.worst_error = yy_var7v
      end
    end and begin
      yy_var81 = yy_context.worst_error
      begin
        not begin
      yy_var82 = yy_context.input.pos
      yy_var83 = yy_string(yy_context, ">>")
      yy_context.input.pos = yy_var82
      yy_var83
    end
      ensure
        yy_context.worst_error = yy_var81
      end
    end) and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm84(yy_context)
        val = nil
        (yy_string(yy_context, ":+") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm86(yy_context)
        val = nil
        (yy_string(yy_context, ":>>") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm88(yy_context)
        val = nil
        (yy_string(yy_context, ";") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm8a(yy_context)
        val = nil
        (yy_string(yy_context, "/") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm8c(yy_context)
        val = nil
        (yy_string(yy_context, "$") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm8e(yy_context)
        val = nil
        (yy_string(yy_context, "^") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm8g(yy_context)
        val = nil
        (yy_string(yy_context, "(") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm8i(yy_context)
        val = nil
        (yy_string(yy_context, ")") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm8k(yy_context)
        val = nil
        (yy_string(yy_context, "[") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm8m(yy_context)
        val = nil
        (yy_string(yy_context, "]") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm8o(yy_context)
        val = nil
        (yy_string(yy_context, "<") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm8q(yy_context)
        val = nil
        (yy_string(yy_context, ">") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm8s(yy_context)
        val = nil
        (yy_string(yy_context, "*") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm8u(yy_context)
        val = nil
        (yy_string(yy_context, "*?") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm8w(yy_context)
        val = nil
        (yy_string(yy_context, "?") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm8y(yy_context)
        val = nil
        (yy_string(yy_context, "+") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm90(yy_context)
        val = nil
        (yy_string(yy_context, "&") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm92(yy_context)
        val = nil
        (yy_string(yy_context, "!") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm94(yy_context)
        val = nil
        (yy_string(yy_context, "@") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm96(yy_context)
        val = nil
        (yy_string(yy_context, "=") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm98(yy_context)
        val = nil
        (yy_string(yy_context, "...") and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm9a(yy_context)
        val = nil
        (yy_string(yy_context, "char") and begin
      yy_var9f = yy_context.worst_error
      begin
        not begin
      yy_var9g = yy_context.input.pos
      yy_var9h = yy_nontermdg(yy_context)
      yy_context.input.pos = yy_var9g
      yy_var9h
    end
      ensure
        yy_context.worst_error = yy_var9f
      end
    end and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm9i(yy_context)
        val = nil
        (yy_string(yy_context, "at") and begin
      yy_var9n = yy_context.worst_error
      begin
        not begin
      yy_var9o = yy_context.input.pos
      yy_var9p = yy_nontermdg(yy_context)
      yy_context.input.pos = yy_var9o
      yy_var9p
    end
      ensure
        yy_context.worst_error = yy_var9n
      end
    end and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm9q(yy_context)
        val = nil
        begin; yy_var9r = yy_context.input.pos; yy_nonterm9a(yy_context) or (yy_context.input.pos = yy_var9r; yy_nonterm9i(yy_context)); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm9s(yy_context)
        val = nil
        (begin
      val = ""
      yy_varae = yy_context.input.pos
      (begin
      yy_vara9 = yy_context.input.pos
      if not begin; yy_vara8 = yy_context.input.pos; yy_string(yy_context, "@") or (yy_context.input.pos = yy_vara8; yy_string(yy_context, "$")); end then
        yy_context.input.pos = yy_vara9
      end
      true
    end and yy_nontermaw(yy_context) and while true
      yy_varad = yy_context.input.pos
      if not yy_nontermay(yy_context) then
        yy_context.input.pos = yy_varad
        break true
      end
    end) and begin
        yy_varaf = yy_context.input.pos
        yy_context.input.pos = yy_varae
        val << yy_context.input.read(yy_varaf - yy_varae).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermag(yy_context)
        val = nil
        (begin
      val = ""
      yy_varau = yy_context.input.pos
      (yy_nontermaw(yy_context) and while true
      yy_varat = yy_context.input.pos
      if not yy_nontermay(yy_context) then
        yy_context.input.pos = yy_varat
        break true
      end
    end) and begin
        yy_varav = yy_context.input.pos
        yy_context.input.pos = yy_varau
        val << yy_context.input.read(yy_varav - yy_varau).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermaw(yy_context)
        val = nil
        begin; yy_varax = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_varax; yy_string(yy_context, "_")); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermay(yy_context)
        val = nil
        begin; yy_varaz = yy_context.input.pos; yy_nontermaw(yy_context) or (yy_context.input.pos = yy_varaz; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermb0(yy_context)
        val = nil
        (begin
      val = ""
      yy_varbe = yy_context.input.pos
      (yy_nontermbg(yy_context) and while true
      yy_varbd = yy_context.input.pos
      if not yy_nontermbi(yy_context) then
        yy_context.input.pos = yy_varbd
        break true
      end
    end) and begin
        yy_varbf = yy_context.input.pos
        yy_context.input.pos = yy_varbe
        val << yy_context.input.read(yy_varbf - yy_varbe).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermbg(yy_context)
        val = nil
        begin; yy_varbh = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_varbh; yy_string(yy_context, "_")); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermbi(yy_context)
        val = nil
        begin; yy_varbj = yy_context.input.pos; yy_nontermbg(yy_context) or (yy_context.input.pos = yy_varbj; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermbk(yy_context)
        val = nil
        (begin
      yy_varbp = yy_context.worst_error
      begin
        not begin
      yy_varbq = yy_context.input.pos
      yy_varbr = yy_nonterm9q(yy_context)
      yy_context.input.pos = yy_varbq
      yy_varbr
    end
      ensure
        yy_context.worst_error = yy_varbp
      end
    end and begin; yy_varcl = yy_context.input.pos; (begin
      val = ""
      yy_varcy = yy_context.input.pos
      (yy_nontermde(yy_context) and while true
      yy_varcx = yy_context.input.pos
      if not yy_nontermdg(yy_context) then
        yy_context.input.pos = yy_varcx
        break true
      end
    end) and begin
        yy_varcz = yy_context.input.pos
        yy_context.input.pos = yy_varcy
        val << yy_context.input.read(yy_varcz - yy_varcy).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermfu(yy_context)) or (yy_context.input.pos = yy_varcl; (begin
      val = ""
      yy_vardc = yy_context.input.pos
      (yy_string(yy_context, "`") and  begin
      while true
        ###
        yy_varda = yy_context.input.pos
        ### Look ahead.
        yy_vardb = yy_string(yy_context, "`")
        yy_context.input.pos = yy_varda
        break if yy_vardb
        ### Repeat one more time (if possible).
        yy_vardb = yy_char(yy_context)
        if not yy_vardb then
          yy_context.input.pos = yy_varda
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string(yy_context, "`")) and begin
        yy_vardd = yy_context.input.pos
        yy_context.input.pos = yy_vardc
        val << yy_context.input.read(yy_vardd - yy_vardc).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermfu(yy_context))); end) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermde(yy_context)
        val = nil
        begin; yy_vardf = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_vardf; yy_char_range(yy_context, "A", "Z")) or (yy_context.input.pos = yy_vardf; yy_string(yy_context, "-")) or (yy_context.input.pos = yy_vardf; yy_string(yy_context, "_")); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermdg(yy_context)
        val = nil
        begin; yy_vardh = yy_context.input.pos; yy_nontermde(yy_context) or (yy_context.input.pos = yy_vardh; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermdi(yy_context)
        val = nil
        (begin
      yy_vardk = yy_nontermdo(yy_context)
      if yy_vardk then
        from = yy_from_pcv(yy_vardk)
      end
      yy_vardk
    end and begin; yy_vardm = yy_context.input.pos; yy_string(yy_context, "...") or (yy_context.input.pos = yy_vardm; yy_string(yy_context, "..")) or (yy_context.input.pos = yy_vardm; yy_string(yy_context, "\u{2026}")) or (yy_context.input.pos = yy_vardm; yy_string(yy_context, "\u{2025}")); end and yy_nontermfu(yy_context) and begin
      yy_vardn = yy_nontermdo(yy_context)
      if yy_vardn then
        to = yy_from_pcv(yy_vardn)
      end
      yy_vardn
    end and yy_nontermfu(yy_context) and begin
       raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1 
      true
    end and begin
       val = from...to 
      true
    end) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermdo(yy_context)
        val = nil
        (begin; yy_varek = yy_context.input.pos; (yy_string(yy_context, "'") and begin
      val = ""
      yy_varex = yy_context.input.pos
       begin
      while true
        ###
        yy_varev = yy_context.input.pos
        ### Look ahead.
        yy_varew = yy_string(yy_context, "'")
        yy_context.input.pos = yy_varev
        break if yy_varew
        ### Repeat one more time (if possible).
        yy_varew = yy_char(yy_context)
        if not yy_varew then
          yy_context.input.pos = yy_varev
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varey = yy_context.input.pos
        yy_context.input.pos = yy_varex
        val << yy_context.input.read(yy_varey - yy_varex).force_encoding(Encoding::UTF_8)
      end
    end and yy_string(yy_context, "'")) or (yy_context.input.pos = yy_varek; (yy_string(yy_context, "\"") and begin
      val = ""
      yy_varfb = yy_context.input.pos
       begin
      while true
        ###
        yy_varf9 = yy_context.input.pos
        ### Look ahead.
        yy_varfa = yy_string(yy_context, "\"")
        yy_context.input.pos = yy_varf9
        break if yy_varfa
        ### Repeat one more time (if possible).
        yy_varfa = yy_char(yy_context)
        if not yy_varfa then
          yy_context.input.pos = yy_varf9
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varfc = yy_context.input.pos
        yy_context.input.pos = yy_varfb
        val << yy_context.input.read(yy_varfc - yy_varfb).force_encoding(Encoding::UTF_8)
      end
    end and yy_string(yy_context, "\""))) or (yy_context.input.pos = yy_varek; (begin
      yy_varfd = yy_nontermfe(yy_context)
      if yy_varfd then
        code = yy_from_pcv(yy_varfd)
      end
      yy_varfd
    end and begin
       val = "" << code 
      true
    end)); end and yy_nontermfu(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermfe(yy_context)
        val = nil
        (yy_string(yy_context, "U+") and begin
      code = ""
      yy_varfs = yy_context.input.pos
      begin; yy_varfq = yy_context.input.pos; yy_char_range(yy_context, "0", "9") or (yy_context.input.pos = yy_varfq; yy_char_range(yy_context, "A", "F")); end and while true
      yy_varfr = yy_context.input.pos
      if not begin; yy_varfq = yy_context.input.pos; yy_char_range(yy_context, "0", "9") or (yy_context.input.pos = yy_varfq; yy_char_range(yy_context, "A", "F")); end then
        yy_context.input.pos = yy_varfr
        break true
      end
    end and begin
        yy_varft = yy_context.input.pos
        yy_context.input.pos = yy_varfs
        code << yy_context.input.read(yy_varft - yy_varfs).force_encoding(Encoding::UTF_8)
      end
    end and begin
       code  = code.to_i(16); raise %(U+#{code.to_s(16).upcase} is not supported) if code > 0x10FFFF 
      true
    end and begin
       val = code 
      true
    end) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermfu(yy_context)
        val = nil
        while true
      yy_varfz = yy_context.input.pos
      if not begin; yy_varfy = yy_context.input.pos; yy_nontermga(yy_context) or (yy_context.input.pos = yy_varfy; yy_nontermg0(yy_context)); end then
        yy_context.input.pos = yy_varfz
        break true
      end
    end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermg0(yy_context)
        val = nil
        (begin; yy_varg3 = yy_context.input.pos; yy_string(yy_context, "#") or (yy_context.input.pos = yy_varg3; yy_string(yy_context, "--")); end and  begin
      while true
        ###
        yy_varg6 = yy_context.input.pos
        ### Look ahead.
        yy_varg7 = begin; yy_varg9 = yy_context.input.pos; yy_nontermgc(yy_context) or (yy_context.input.pos = yy_varg9; yy_end?(yy_context)); end
        yy_context.input.pos = yy_varg6
        break if yy_varg7
        ### Repeat one more time (if possible).
        yy_varg7 = yy_char(yy_context)
        if not yy_varg7 then
          yy_context.input.pos = yy_varg6
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_varg9 = yy_context.input.pos; yy_nontermgc(yy_context) or (yy_context.input.pos = yy_varg9; yy_end?(yy_context)); end) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermga(yy_context)
        val = nil
        begin; yy_vargb = yy_context.input.pos; yy_char_range(yy_context, "\t", "\r") or (yy_context.input.pos = yy_vargb; yy_string(yy_context, " ")) or (yy_context.input.pos = yy_vargb; yy_string(yy_context, "\u{85}")) or (yy_context.input.pos = yy_vargb; yy_string(yy_context, "\u{a0}")) or (yy_context.input.pos = yy_vargb; yy_string(yy_context, "\u{1680}")) or (yy_context.input.pos = yy_vargb; yy_string(yy_context, "\u{180e}")) or (yy_context.input.pos = yy_vargb; yy_char_range(yy_context, "\u{2000}", "\u{200a}")) or (yy_context.input.pos = yy_vargb; yy_string(yy_context, "\u{2028}")) or (yy_context.input.pos = yy_vargb; yy_string(yy_context, "\u{2029}")) or (yy_context.input.pos = yy_vargb; yy_string(yy_context, "\u{202f}")) or (yy_context.input.pos = yy_vargb; yy_string(yy_context, "\u{205f}")) or (yy_context.input.pos = yy_vargb; yy_string(yy_context, "\u{3000}")); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermgc(yy_context)
        val = nil
        begin; yy_vargd = yy_context.input.pos; (yy_string(yy_context, "\r") and yy_string(yy_context, "\n")) or (yy_context.input.pos = yy_vargd; yy_string(yy_context, "\r")) or (yy_context.input.pos = yy_vargd; yy_string(yy_context, "\n")) or (yy_context.input.pos = yy_vargd; yy_string(yy_context, "\u{85}")) or (yy_context.input.pos = yy_vargd; yy_string(yy_context, "\v")) or (yy_context.input.pos = yy_vargd; yy_string(yy_context, "\f")) or (yy_context.input.pos = yy_vargd; yy_string(yy_context, "\u{2028}")) or (yy_context.input.pos = yy_vargd; yy_string(yy_context, "\u{2029}")); end and yy_to_pcv(val)
      end
    
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


RubyCode = String


Nonterminal = String


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


begin
  grammar_file = ARGV[0] or abort %(Usage: ruby #{__FILE__} grammar-file)
  File.open(grammar_file) do |io|
    begin
      print(yy_parse(io))
    rescue YY_SyntaxError => e
      line, column = *(line_and_column(e.pos, io))
      STDERR.puts %(#{grammar_file}:#{line}:#{column}: error: #{e.message})
      exit 1
    end
  end
end

