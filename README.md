# FirstOf

FirstOf can be used when multiple values can be reduced into a single return value.
This is common in things like XML/JSON where the "intended" value is available in
2 fields and is determined by the presence of a value in the document and is often
prioritized (first check field 1, then field 2, then field x)

FirstOf handles calling methods/lambdas and prioritizing them.

## Installation

Add this line to your application's Gemfile:

    gem 'first_of'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install first_of

## Usage

```ruby
  require 'first_of'

  class Widget
    include ::FirstOf

    def nothing; nil; end
    def selfie; self; end
    def something; "something"; end
  end

  widget = Widget.new

  # Use it to get to something usable on self
  widget.first_of(:nothing, :something, :self) # => "something"
  widget.first_of(:nothing, :self, :something) # => self
  widget.first_of(:nothing, :nothing, :something) # => "something"

  # Wrap calls in an Array to `try_chain` them
  widget.first_of([:self, :nothing], :something) # => "something"

  # Wrap a call in a lambda (or any callable) to delay execution
  widget.first_of(:something, lambda { "derp" }) # => "something"
  widget.first_of(lambda { "derp" }, :something) # => "derp"
  widget.first_of(lambda { nothing }, :something) # => "something"

  # Prioritize the calls/call chains if desired
  widget.first_of(2 => :something, 1 => lambda { "derp" }) # => "derp"
  widget.first_of(2 => lambda { "derp" }, 1 => :something) # => "something"
  widget.first_of(2 => lambda { nothing }, 1 => :something) # => "something"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
