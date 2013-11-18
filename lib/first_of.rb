require "first_of/version"

require "try_chain"
require "active_support/core_ext/object/blank"
require "active_support/core_ext/array/extract_options"
require "active_support/core_ext/object/try"

module FirstOf

  # Should take arguments:
  # first_of(:symbol1, :symbol2) # will return first respond to and present
  # first_of([:symbol1, :symbol2]) # will return value if try_chain(:symbol1, :symbol2) present
  # first_of(1 => :symbol1, 2 => :symbol2) # will prioritize trying by key and return first present
  # first_of(1 => :symbol1, 2 => lambda { _call }) # will prioritize and only execute callable if first not present
  # first_of(1 => [:symbol1, :symbol2], 2 => -> { _call }) # will prioritize and execute try_chain on first and call 2nd if first not present
  # first_of(1 => :symbol1, 2 => 4) # will prioritize and return value (4) if first not present
  # first_of(lambda { _call }, 1 => :symbol1, 2 => :symbol2)
  def first_of(*args)
    extract_hash = args.extract_options!        

    # Don't care if the hash is empty or not because of #each call
    sorted_keys = extract_hash.keys.sort
    sorted_keys.each do |key|
      args << extract_hash[key]
    end

    args.each do |argument|
      if argument.respond_to?(:call)
        value = argument.call
      else
        value = _extract_from_message_chain(argument) # calls try_chain if array, or try if symbol, or returns value
      end

      return value if _valid_value?(value) # return value if found
    end

    return nil
  end

  private

  def _extract_from_message_chain(methods_or_value)
    case methods_or_value
    when Symbol, Array then
      if self.respond_to?(:try_chain)
        self.try_chain(*methods_or_value)
      else
        ::TryChain.proxy_try_chain(self, *methods_or_value)
      end
    else
      methods_or_value
    end
  end

  def _valid_value?(value)
    value.present? || [true, false].include?(value)
  end

end
