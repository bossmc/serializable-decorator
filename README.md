# SerializableDecorator

An implementation of Delegate that groups the member variables of the delegator (a subclass of SerializableDecorator) together with those of the delegated object.  For example:

    class MyDecorator < SerializableDecorator
      :attr_accessor :foo
    end

    class SomeClass
      :attr_accessor :bar
    end

    decorated_class = MyDecorator.new(SomeClass.new)
    decorated_class.foo = "Hello"
    decorated_class.bar = "World"
    puts decorated_class.foo                 # => "Hello"
    puts decorated_class.bar                 # => "World"
    puts decorated_class.instance_variables  # => @foo and @bar
    puts decorated_class.instance_values     # => { "foo" => "Hello", "bar" => "World" }

## Installation

Add this line to your application's Gemfile:

    gem 'serializable-decorator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install serializable-decorator

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
