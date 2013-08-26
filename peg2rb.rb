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
        val = :yy_nil
        (begin
      
    code = code("")
    rule_is_first = true
    method_names = HashMap.new
  
      true
    end and yy_nontermiy(yy_context) and while true
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
      yy_varb = yy_nonterm4o(yy_context)
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
        val = :yy_nil
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
        val = :yy_nil
        (begin
      
    single_expression = true
    remembered_pos_var = new_unique_variable_name
  
      true
    end and begin
      yy_vark = yy_context.input.pos
      if not yy_nontermbe(yy_context) then
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
      if not (yy_nontermbe(yy_context) and begin
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
    end) or (yy_context.input.pos = yy_varx; (yy_nontermbq(yy_context) and begin
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
    end) or (yy_context.input.pos = yy_varx; (yy_nontermbq(yy_context) and begin
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
        val = :yy_nil
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
        val = :yy_nil
        begin; yy_var19 = yy_context.input.pos; (yy_nontermc4(yy_context) and begin
      yy_var1a = yy_nonterm4o(yy_context)
      if yy_var1a then
        predicate_code = yy_from_pcv(yy_var1a)
      end
      yy_var1a
    end and begin
       val = positive_predicate_with_native_code_code(predicate_code) 
      true
    end) or (yy_context.input.pos = yy_var19; (yy_nontermc4(yy_context) and begin
      yy_var1b = yy_nonterm18(yy_context)
      if yy_var1b then
        val = yy_from_pcv(yy_var1b)
      end
      yy_var1b
    end and begin
       val = positive_predicate_code(val) 
      true
    end)) or (yy_context.input.pos = yy_var19; (yy_nontermc6(yy_context) and begin
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
    end and yy_nontermby(yy_context) and begin
       val = lazy_repeat_code(val, p) 
      true
    end) or (yy_context.input.pos = yy_var1l; (yy_nontermbw(yy_context) and begin
       val = repeat_many_times_code(val) 
      true
    end)) or (yy_context.input.pos = yy_var1l; (yy_nontermc2(yy_context) and begin
       val = repeat_at_least_once_code(val) 
      true
    end)) or (yy_context.input.pos = yy_var1l; (yy_nontermc0(yy_context) and begin
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
        val = :yy_nil
        begin; yy_var1q = yy_context.input.pos; (yy_nontermbk(yy_context) and begin
      yy_var1r = yy_nonterme(yy_context)
      if yy_var1r then
        val = yy_from_pcv(yy_var1r)
      end
      yy_var1r
    end and yy_nontermbm(yy_context)) or (yy_context.input.pos = yy_var1q; (yy_nontermbs(yy_context) and begin
      yy_var1s = yy_nonterme(yy_context)
      if yy_var1s then
        c = yy_from_pcv(yy_var1s)
      end
      yy_var1s
    end and yy_nontermbu(yy_context) and begin
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
        val = :yy_nil
        begin; yy_var1y = yy_context.input.pos; (begin
      yy_var1z = yy_nontermgm(yy_context)
      if yy_var1z then
        r = yy_from_pcv(yy_var1z)
      end
      yy_var1z
    end and begin
       val = code "yy_char_range(yy_context, #{r.begin.to_ruby_code}, #{r.end.to_ruby_code})" 
      true
    end) or (yy_context.input.pos = yy_var1y; (begin
      yy_var20 = yy_nontermgs(yy_context)
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
      yy_var22 = yy_nontermeo(yy_context)
      if yy_var22 then
        n = yy_from_pcv(yy_var22)
      end
      yy_var22
    end and begin
       val = UnknownMethodCall[n, %(yy_context), n_pos] 
      true
    end)) or (yy_context.input.pos = yy_var1y; (yy_nontermce(yy_context) and begin
       val = code "yy_char(yy_context)" 
      true
    end)) or (yy_context.input.pos = yy_var1y; (begin
      yy_var23 = yy_nonterm4o(yy_context)
      if yy_var23 then
        action_code = yy_from_pcv(yy_var23)
      end
      yy_var23
    end and begin
       val = compile_action_expression(action_code) 
      true
    end)) or (yy_context.input.pos = yy_var1y; (yy_nontermbg(yy_context) and begin
       val = code "yy_end?(yy_context)" 
      true
    end)) or (yy_context.input.pos = yy_var1y; (yy_nontermbi(yy_context) and begin
       val = code "yy_begin?(yy_context)" 
      true
    end)) or (yy_context.input.pos = yy_var1y; (begin; yy_var27 = yy_context.input.pos; (yy_nontermc8(yy_context) and yy_nontermca(yy_context) and begin
      yy_var28 = yy_nontermcw(yy_context)
      if yy_var28 then
        pos_variable = yy_from_pcv(yy_var28)
      end
      yy_var28
    end) or (yy_context.input.pos = yy_var27; (yy_nontermcm(yy_context) and begin
      yy_var29 = yy_nontermcw(yy_context)
      if yy_var29 then
        pos_variable = yy_from_pcv(yy_var29)
      end
      yy_var29
    end)); end and begin
      yy_var2b = yy_context.input.pos
      if not yy_nontermag(yy_context) then
        yy_context.input.pos = yy_var2b
      end
      true
    end and begin
       val = code "(yy_context.input.pos = #{pos_variable}; true)" 
      true
    end)) or (yy_context.input.pos = yy_var1y; (yy_nontermc8(yy_context) and begin
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
        val = :yy_nil
        (begin
       rule = val = Rule.new 
      true
    end and begin; yy_var2m = yy_context.input.pos; (begin
      yy_var2n = yy_nonterme4(yy_context)
      if yy_var2n then
        rule_name = yy_from_pcv(yy_var2n)
      end
      yy_var2n
    end and yy_nontermbk(yy_context) and begin
      yy_var2r = yy_context.input.pos
      if not begin; yy_var2q = yy_context.input.pos; yy_nontermcc(yy_context) or (yy_context.input.pos = yy_var2q; yy_nontermdk(yy_context)); end then
        yy_context.input.pos = yy_var2r
      end
      true
    end and yy_nontermbm(yy_context) and begin
       rule.need_entry_point! 
      true
    end) or (yy_context.input.pos = yy_var2m; begin
      yy_var2s = yy_nontermeo(yy_context)
      if yy_var2s then
        rule_name = yy_from_pcv(yy_var2s)
      end
      yy_var2s
    end); end and begin
       rule.name = rule_name 
      true
    end and begin
      yy_var2w = yy_context.input.pos
      if not (yy_nontermag(yy_context) and yy_nonterm2z(yy_context)) then
        yy_context.input.pos = yy_var2w
      end
      true
    end and yy_nontermac(yy_context) and begin
      yy_var2x = yy_nonterme(yy_context)
      if yy_var2x then
        c = yy_from_pcv(yy_var2x)
      end
      yy_var2x
    end and yy_nontermbc(yy_context) and begin
       rule.method_definition = to_method_definition(c, rule.method_name) 
      true
    end) and yy_to_pcv(val)
      end
      
  def to_method_definition(code, method_name)
    code(%(
      # :nodoc:
      def #{method_name}(yy_context)
        val = :yy_nil
        )) + code + code(%( and yy_to_pcv(val)
      end
    ))
  end
  

      # :nodoc:
      def yy_nonterm2z(yy_context)
        val = :yy_nil
        ((begin
      yy_var3t = yy_context.worst_error
      begin
        not begin
      yy_var3u = yy_context.input.pos
      yy_var3v = yy_nontermac(yy_context)
      yy_context.input.pos = yy_var3u
      yy_var3v
    end
      ensure
        yy_context.worst_error = yy_var3t
      end
    end and yy_char(yy_context)) and yy_nontermiy(yy_context)) and while true
      yy_var3w = yy_context.input.pos
      if not ((begin
      yy_var3t = yy_context.worst_error
      begin
        not begin
      yy_var3u = yy_context.input.pos
      yy_var3v = yy_nontermac(yy_context)
      yy_context.input.pos = yy_var3u
      yy_var3v
    end
      ensure
        yy_context.worst_error = yy_var3t
      end
    end and yy_char(yy_context)) and yy_nontermiy(yy_context)) then
        yy_context.input.pos = yy_var3w
        break true
      end
    end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm3x(yy_context)
        val = :yy_nil
        begin; yy_var3y = yy_context.input.pos; begin
      yy_var3z = yy_nontermcw(yy_context)
      if yy_var3z then
        val = yy_from_pcv(yy_var3z)
      end
      yy_var3z
    end or (yy_context.input.pos = yy_var3y; (yy_nontermbk(yy_context) and begin
      yy_var40 = yy_nontermcw(yy_context)
      if yy_var40 then
        val = yy_from_pcv(yy_var40)
      end
      yy_var40
    end and yy_nontermbm(yy_context))); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm41(yy_context)
        val = :yy_nil
        begin; yy_var42 = yy_context.input.pos; (yy_nontermag(yy_context) and begin
      val = :capture
      true
    end) or (yy_context.input.pos = yy_var42; (yy_nontermb8(yy_context) and begin
      val = :append
      true
    end)) or (yy_context.input.pos = yy_var42; (yy_nontermba(yy_context) and begin
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
        val = :yy_nil
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
    end and begin; yy_var4e = yy_context.input.pos; (yy_nontermjg(yy_context) and begin
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
        val = :yy_nil
        (yy_string(yy_context, "%%") and  begin
      while true
        ###
        yy_var4k = yy_context.input.pos
        ### Look ahead.
        yy_var4l = begin; yy_var4n = yy_context.input.pos; yy_nontermjg(yy_context) or (yy_context.input.pos = yy_var4n; yy_end?(yy_context)); end
        yy_context.input.pos = yy_var4k
        break if yy_var4l
        ### Repeat one more time (if possible).
        yy_var4l = yy_char(yy_context)
        if not yy_var4l then
          yy_context.input.pos = yy_var4k
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_var4n = yy_context.input.pos; yy_nontermjg(yy_context) or (yy_context.input.pos = yy_var4n; yy_end?(yy_context)); end) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterm4o(yy_context)
        val = :yy_nil
        (begin; yy_var7f = yy_context.input.pos; (yy_string(yy_context, "{") and while true
      yy_var7h = yy_context.input.pos
      if not yy_nontermje(yy_context) then
        yy_context.input.pos = yy_var7h
        break true
      end
    end and yy_string(yy_context, "...") and begin
      yy_var7t = yy_context.input.pos
      if not ( begin
      while true
        ###
        yy_var7r = yy_context.input.pos
        ### Look ahead.
        yy_var7s = yy_nontermjg(yy_context)
        yy_context.input.pos = yy_var7r
        break if yy_var7s
        ### Repeat one more time (if possible).
        yy_var7s = yy_nontermje(yy_context)
        if not yy_var7s then
          yy_context.input.pos = yy_var7r
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_nontermjg(yy_context)) then
        yy_context.input.pos = yy_var7t
      end
      true
    end and begin
      val = ""
      yy_var86 = yy_context.input.pos
       begin
      while true
        ###
        yy_var84 = yy_context.input.pos
        ### Look ahead.
        yy_var85 = begin; yy_var8d = yy_context.input.pos; (yy_string(yy_context, "...") and while true
      yy_var8f = yy_context.input.pos
      if not yy_nontermje(yy_context) then
        yy_context.input.pos = yy_var8f
        break true
      end
    end and yy_string(yy_context, "}")) or (yy_context.input.pos = yy_var8d; (yy_string(yy_context, "}") and while true
      yy_var8h = yy_context.input.pos
      if not yy_nontermje(yy_context) then
        yy_context.input.pos = yy_var8h
        break true
      end
    end and yy_string(yy_context, "..."))); end
        yy_context.input.pos = yy_var84
        break if yy_var85
        ### Repeat one more time (if possible).
        yy_var85 = yy_char(yy_context)
        if not yy_var85 then
          yy_context.input.pos = yy_var84
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var87 = yy_context.input.pos
        yy_context.input.pos = yy_var86
        val << yy_context.input.read(yy_var87 - yy_var86).force_encoding(Encoding::UTF_8)
      end
    end and begin; yy_var8d = yy_context.input.pos; (yy_string(yy_context, "...") and while true
      yy_var8f = yy_context.input.pos
      if not yy_nontermje(yy_context) then
        yy_context.input.pos = yy_var8f
        break true
      end
    end and yy_string(yy_context, "}")) or (yy_context.input.pos = yy_var8d; (yy_string(yy_context, "}") and while true
      yy_var8h = yy_context.input.pos
      if not yy_nontermje(yy_context) then
        yy_context.input.pos = yy_var8h
        break true
      end
    end and yy_string(yy_context, "..."))); end) or (yy_context.input.pos = yy_var7f; (begin
      val = ""
      yy_var8m = yy_context.input.pos
      yy_nonterma4(yy_context) and begin
        yy_var8n = yy_context.input.pos
        yy_context.input.pos = yy_var8m
        val << yy_context.input.read(yy_var8n - yy_var8m).force_encoding(Encoding::UTF_8)
      end
    end and begin
       val = val[1...-1] 
      true
    end)) or (yy_context.input.pos = yy_var7f; (yy_nonterm4g(yy_context) and begin
      val = ""
      yy_var9g = yy_context.input.pos
       begin
      while true
        ###
        yy_var9e = yy_context.input.pos
        ### Look ahead.
        yy_var9f = yy_nonterm4g(yy_context)
        yy_context.input.pos = yy_var9e
        break if yy_var9f
        ### Repeat one more time (if possible).
        yy_var9f = yy_char(yy_context)
        if not yy_var9f then
          yy_context.input.pos = yy_var9e
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_var9h = yy_context.input.pos
        yy_context.input.pos = yy_var9g
        val << yy_context.input.read(yy_var9h - yy_var9g).force_encoding(Encoding::UTF_8)
      end
    end and yy_nonterm4g(yy_context))) or (yy_context.input.pos = yy_var7f; (yy_nonterm4g(yy_context) and begin
      val = ""
      yy_vara2 = yy_context.input.pos
      while true
      yy_vara1 = yy_context.input.pos
      if not yy_char(yy_context) then
        yy_context.input.pos = yy_vara1
        break true
      end
    end and begin
        yy_vara3 = yy_context.input.pos
        yy_context.input.pos = yy_vara2
        val << yy_context.input.read(yy_vara3 - yy_vara2).force_encoding(Encoding::UTF_8)
      end
    end and yy_end?(yy_context))); end and yy_nontermiy(yy_context) and begin
       val = code(val) 
      true
    end) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterma4(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "{") and  begin
      while true
        ###
        yy_varaa = yy_context.input.pos
        ### Look ahead.
        yy_varab = yy_string(yy_context, "}")
        yy_context.input.pos = yy_varaa
        break if yy_varab
        ### Repeat one more time (if possible).
        yy_varab = begin; yy_vara9 = yy_context.input.pos; yy_nonterma4(yy_context) or (yy_context.input.pos = yy_vara9; yy_char(yy_context)); end
        if not yy_varab then
          yy_context.input.pos = yy_varaa
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string(yy_context, "}")) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermac(yy_context)
        val = :yy_nil
        (begin; yy_varaf = yy_context.input.pos; yy_string(yy_context, "<-") or (yy_context.input.pos = yy_varaf; yy_string(yy_context, "=")) or (yy_context.input.pos = yy_varaf; yy_string(yy_context, "\u{2190}")); end and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermag(yy_context)
        val = :yy_nil
        (yy_string(yy_context, ":") and (begin
      yy_varaz = yy_context.worst_error
      begin
        not begin
      yy_varb0 = yy_context.input.pos
      yy_varb1 = yy_string(yy_context, "+")
      yy_context.input.pos = yy_varb0
      yy_varb1
    end
      ensure
        yy_context.worst_error = yy_varaz
      end
    end and begin
      yy_varb5 = yy_context.worst_error
      begin
        not begin
      yy_varb6 = yy_context.input.pos
      yy_varb7 = yy_string(yy_context, ">>")
      yy_context.input.pos = yy_varb6
      yy_varb7
    end
      ensure
        yy_context.worst_error = yy_varb5
      end
    end) and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermb8(yy_context)
        val = :yy_nil
        (yy_string(yy_context, ":+") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermba(yy_context)
        val = :yy_nil
        (yy_string(yy_context, ":>>") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermbc(yy_context)
        val = :yy_nil
        (yy_string(yy_context, ";") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermbe(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "/") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermbg(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "$") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermbi(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "^") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermbk(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "(") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermbm(yy_context)
        val = :yy_nil
        (yy_string(yy_context, ")") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermbo(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "[") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermbq(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "]") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermbs(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "<") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermbu(yy_context)
        val = :yy_nil
        (yy_string(yy_context, ">") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermbw(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "*") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermby(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "*?") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermc0(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "?") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermc2(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "+") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermc4(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "&") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermc6(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "!") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermc8(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "@") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermca(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "=") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermcc(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "...") and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermce(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "char") and begin
      yy_varcj = yy_context.worst_error
      begin
        not begin
      yy_varck = yy_context.input.pos
      yy_varcl = yy_nontermgk(yy_context)
      yy_context.input.pos = yy_varck
      yy_varcl
    end
      ensure
        yy_context.worst_error = yy_varcj
      end
    end and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermcm(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "at") and begin
      yy_varcr = yy_context.worst_error
      begin
        not begin
      yy_varcs = yy_context.input.pos
      yy_varct = yy_nontermgk(yy_context)
      yy_context.input.pos = yy_varcs
      yy_varct
    end
      ensure
        yy_context.worst_error = yy_varcr
      end
    end and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermcu(yy_context)
        val = :yy_nil
        begin; yy_varcv = yy_context.input.pos; yy_nontermce(yy_context) or (yy_context.input.pos = yy_varcv; yy_nontermcm(yy_context)); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermcw(yy_context)
        val = :yy_nil
        (begin
      val = ""
      yy_vardi = yy_context.input.pos
      (begin
      yy_vardd = yy_context.input.pos
      if not begin; yy_vardc = yy_context.input.pos; yy_string(yy_context, "@") or (yy_context.input.pos = yy_vardc; yy_string(yy_context, "$")); end then
        yy_context.input.pos = yy_vardd
      end
      true
    end and yy_nonterme0(yy_context) and while true
      yy_vardh = yy_context.input.pos
      if not yy_nonterme2(yy_context) then
        yy_context.input.pos = yy_vardh
        break true
      end
    end) and begin
        yy_vardj = yy_context.input.pos
        yy_context.input.pos = yy_vardi
        val << yy_context.input.read(yy_vardj - yy_vardi).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermdk(yy_context)
        val = :yy_nil
        (begin
      val = ""
      yy_vardy = yy_context.input.pos
      (yy_nonterme0(yy_context) and while true
      yy_vardx = yy_context.input.pos
      if not yy_nonterme2(yy_context) then
        yy_context.input.pos = yy_vardx
        break true
      end
    end) and begin
        yy_vardz = yy_context.input.pos
        yy_context.input.pos = yy_vardy
        val << yy_context.input.read(yy_vardz - yy_vardy).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterme0(yy_context)
        val = :yy_nil
        begin; yy_vare1 = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_vare1; yy_string(yy_context, "_")); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterme2(yy_context)
        val = :yy_nil
        begin; yy_vare3 = yy_context.input.pos; yy_nonterme0(yy_context) or (yy_context.input.pos = yy_vare3; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nonterme4(yy_context)
        val = :yy_nil
        (begin
      val = ""
      yy_varei = yy_context.input.pos
      (yy_nontermek(yy_context) and while true
      yy_vareh = yy_context.input.pos
      if not yy_nontermem(yy_context) then
        yy_context.input.pos = yy_vareh
        break true
      end
    end) and begin
        yy_varej = yy_context.input.pos
        yy_context.input.pos = yy_varei
        val << yy_context.input.read(yy_varej - yy_varei).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermek(yy_context)
        val = :yy_nil
        begin; yy_varel = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_varel; yy_string(yy_context, "_")); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermem(yy_context)
        val = :yy_nil
        begin; yy_varen = yy_context.input.pos; yy_nontermek(yy_context) or (yy_context.input.pos = yy_varen; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermeo(yy_context)
        val = :yy_nil
        (begin
      yy_varet = yy_context.worst_error
      begin
        not begin
      yy_vareu = yy_context.input.pos
      yy_varev = yy_nontermcu(yy_context)
      yy_context.input.pos = yy_vareu
      yy_varev
    end
      ensure
        yy_context.worst_error = yy_varet
      end
    end and begin; yy_varfp = yy_context.input.pos; (begin
      val = ""
      yy_varg2 = yy_context.input.pos
      (yy_nontermgi(yy_context) and while true
      yy_varg1 = yy_context.input.pos
      if not yy_nontermgk(yy_context) then
        yy_context.input.pos = yy_varg1
        break true
      end
    end) and begin
        yy_varg3 = yy_context.input.pos
        yy_context.input.pos = yy_varg2
        val << yy_context.input.read(yy_varg3 - yy_varg2).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermiy(yy_context)) or (yy_context.input.pos = yy_varfp; (begin
      val = ""
      yy_vargg = yy_context.input.pos
      (yy_string(yy_context, "`") and  begin
      while true
        ###
        yy_varge = yy_context.input.pos
        ### Look ahead.
        yy_vargf = yy_string(yy_context, "`")
        yy_context.input.pos = yy_varge
        break if yy_vargf
        ### Repeat one more time (if possible).
        yy_vargf = yy_char(yy_context)
        if not yy_vargf then
          yy_context.input.pos = yy_varge
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and yy_string(yy_context, "`")) and begin
        yy_vargh = yy_context.input.pos
        yy_context.input.pos = yy_vargg
        val << yy_context.input.read(yy_vargh - yy_vargg).force_encoding(Encoding::UTF_8)
      end
    end and yy_nontermiy(yy_context))); end) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermgi(yy_context)
        val = :yy_nil
        begin; yy_vargj = yy_context.input.pos; yy_char_range(yy_context, "a", "z") or (yy_context.input.pos = yy_vargj; yy_char_range(yy_context, "A", "Z")) or (yy_context.input.pos = yy_vargj; yy_string(yy_context, "-")) or (yy_context.input.pos = yy_vargj; yy_string(yy_context, "_")); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermgk(yy_context)
        val = :yy_nil
        begin; yy_vargl = yy_context.input.pos; yy_nontermgi(yy_context) or (yy_context.input.pos = yy_vargl; yy_char_range(yy_context, "0", "9")); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermgm(yy_context)
        val = :yy_nil
        (begin
      yy_vargo = yy_nontermgs(yy_context)
      if yy_vargo then
        from = yy_from_pcv(yy_vargo)
      end
      yy_vargo
    end and begin; yy_vargq = yy_context.input.pos; yy_string(yy_context, "...") or (yy_context.input.pos = yy_vargq; yy_string(yy_context, "..")) or (yy_context.input.pos = yy_vargq; yy_string(yy_context, "\u{2026}")) or (yy_context.input.pos = yy_vargq; yy_string(yy_context, "\u{2025}")); end and yy_nontermiy(yy_context) and begin
      yy_vargr = yy_nontermgs(yy_context)
      if yy_vargr then
        to = yy_from_pcv(yy_vargr)
      end
      yy_vargr
    end and yy_nontermiy(yy_context) and begin
       raise %("#{from}" or "#{to}" is not a character) if from.length != 1 or to.length != 1 
      true
    end and begin
       val = from...to 
      true
    end) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermgs(yy_context)
        val = :yy_nil
        (begin; yy_varho = yy_context.input.pos; (yy_string(yy_context, "'") and begin
      val = ""
      yy_vari1 = yy_context.input.pos
       begin
      while true
        ###
        yy_varhz = yy_context.input.pos
        ### Look ahead.
        yy_vari0 = yy_string(yy_context, "'")
        yy_context.input.pos = yy_varhz
        break if yy_vari0
        ### Repeat one more time (if possible).
        yy_vari0 = yy_char(yy_context)
        if not yy_vari0 then
          yy_context.input.pos = yy_varhz
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_vari2 = yy_context.input.pos
        yy_context.input.pos = yy_vari1
        val << yy_context.input.read(yy_vari2 - yy_vari1).force_encoding(Encoding::UTF_8)
      end
    end and yy_string(yy_context, "'")) or (yy_context.input.pos = yy_varho; (yy_string(yy_context, "\"") and begin
      val = ""
      yy_varif = yy_context.input.pos
       begin
      while true
        ###
        yy_varid = yy_context.input.pos
        ### Look ahead.
        yy_varie = yy_string(yy_context, "\"")
        yy_context.input.pos = yy_varid
        break if yy_varie
        ### Repeat one more time (if possible).
        yy_varie = yy_char(yy_context)
        if not yy_varie then
          yy_context.input.pos = yy_varid
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin
        yy_varig = yy_context.input.pos
        yy_context.input.pos = yy_varif
        val << yy_context.input.read(yy_varig - yy_varif).force_encoding(Encoding::UTF_8)
      end
    end and yy_string(yy_context, "\""))) or (yy_context.input.pos = yy_varho; (begin
      yy_varih = yy_nontermii(yy_context)
      if yy_varih then
        code = yy_from_pcv(yy_varih)
      end
      yy_varih
    end and begin
       val = "" << code 
      true
    end)); end and yy_nontermiy(yy_context)) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermii(yy_context)
        val = :yy_nil
        (yy_string(yy_context, "U+") and begin
      code = ""
      yy_variw = yy_context.input.pos
      begin; yy_variu = yy_context.input.pos; yy_char_range(yy_context, "0", "9") or (yy_context.input.pos = yy_variu; yy_char_range(yy_context, "A", "F")); end and while true
      yy_variv = yy_context.input.pos
      if not begin; yy_variu = yy_context.input.pos; yy_char_range(yy_context, "0", "9") or (yy_context.input.pos = yy_variu; yy_char_range(yy_context, "A", "F")); end then
        yy_context.input.pos = yy_variv
        break true
      end
    end and begin
        yy_varix = yy_context.input.pos
        yy_context.input.pos = yy_variw
        code << yy_context.input.read(yy_varix - yy_variw).force_encoding(Encoding::UTF_8)
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
      def yy_nontermiy(yy_context)
        val = :yy_nil
        while true
      yy_varj3 = yy_context.input.pos
      if not begin; yy_varj2 = yy_context.input.pos; yy_nontermje(yy_context) or (yy_context.input.pos = yy_varj2; yy_nontermj4(yy_context)); end then
        yy_context.input.pos = yy_varj3
        break true
      end
    end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermj4(yy_context)
        val = :yy_nil
        (begin; yy_varj7 = yy_context.input.pos; yy_string(yy_context, "#") or (yy_context.input.pos = yy_varj7; yy_string(yy_context, "--")); end and  begin
      while true
        ###
        yy_varja = yy_context.input.pos
        ### Look ahead.
        yy_varjb = begin; yy_varjd = yy_context.input.pos; yy_nontermjg(yy_context) or (yy_context.input.pos = yy_varjd; yy_end?(yy_context)); end
        yy_context.input.pos = yy_varja
        break if yy_varjb
        ### Repeat one more time (if possible).
        yy_varjb = yy_char(yy_context)
        if not yy_varjb then
          yy_context.input.pos = yy_varja
          break
        end
      end
      ### The repetition is always successful.
      true
    end  and begin; yy_varjd = yy_context.input.pos; yy_nontermjg(yy_context) or (yy_context.input.pos = yy_varjd; yy_end?(yy_context)); end) and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermje(yy_context)
        val = :yy_nil
        begin; yy_varjf = yy_context.input.pos; yy_char_range(yy_context, "\t", "\r") or (yy_context.input.pos = yy_varjf; yy_string(yy_context, " ")) or (yy_context.input.pos = yy_varjf; yy_string(yy_context, "\u{85}")) or (yy_context.input.pos = yy_varjf; yy_string(yy_context, "\u{a0}")) or (yy_context.input.pos = yy_varjf; yy_string(yy_context, "\u{1680}")) or (yy_context.input.pos = yy_varjf; yy_string(yy_context, "\u{180e}")) or (yy_context.input.pos = yy_varjf; yy_char_range(yy_context, "\u{2000}", "\u{200a}")) or (yy_context.input.pos = yy_varjf; yy_string(yy_context, "\u{2028}")) or (yy_context.input.pos = yy_varjf; yy_string(yy_context, "\u{2029}")) or (yy_context.input.pos = yy_varjf; yy_string(yy_context, "\u{202f}")) or (yy_context.input.pos = yy_varjf; yy_string(yy_context, "\u{205f}")) or (yy_context.input.pos = yy_varjf; yy_string(yy_context, "\u{3000}")); end and yy_to_pcv(val)
      end
    
      # :nodoc:
      def yy_nontermjg(yy_context)
        val = :yy_nil
        begin; yy_varjh = yy_context.input.pos; (yy_string(yy_context, "\r") and yy_string(yy_context, "\n")) or (yy_context.input.pos = yy_varjh; yy_string(yy_context, "\r")) or (yy_context.input.pos = yy_varjh; yy_string(yy_context, "\n")) or (yy_context.input.pos = yy_varjh; yy_string(yy_context, "\u{85}")) or (yy_context.input.pos = yy_varjh; yy_string(yy_context, "\v")) or (yy_context.input.pos = yy_varjh; yy_string(yy_context, "\f")) or (yy_context.input.pos = yy_varjh; yy_string(yy_context, "\u{2028}")) or (yy_context.input.pos = yy_varjh; yy_string(yy_context, "\u{2029}")); end and yy_to_pcv(val)
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
      yy_parse(io)
    rescue PEGParserGenerator::YY_SyntaxError => e
      line, column = *(line_and_column(e.pos, io))
      STDERR.puts %(#{grammar_file}:#{line}:#{column}: error: #{e.message})
      exit 1
    end
  end
end

