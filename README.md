# Sushi Go

This is a work-in-progress conversion of Sushi Go (original), the popular card game into Ruby.

The long term goal is to make it easily scriptable via a RPC-interface that hooks into
something as described in [my ideas repo][ideas].

Currently only supports the original game, and not Sushi Go Party.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sushigo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sushigo

## Usage

Run `rake` to run tests

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/captn3m0/sushigo.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[ideas]: https://github.com/captn3m0/ideas/blob/master/card-game-modelling.md