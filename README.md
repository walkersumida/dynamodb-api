# Dynamodb::Api

[![Build Status](https://travis-ci.org/walkersumida/dynamodb-api.svg?branch=master)](https://travis-ci.org/walkersumida/dynamodb-api)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/dynamodb/api`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dynamodb-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dynamodb-api

## Configuration

`config/initializers/dynamodb_api.rb`

```
Dynamodb::Api.config do |config|
  config.access_key_id = ''
  config.secret_access_key = ''
  config.region = ''
  config.table_name_prefix = ''
  config.index_name_prefix = ''
end
```

## Development

- Run `docker-compose up` to run the dynamodb_local.
- After checking out the repo, run `bin/setup` to install dependencies.
- Run `rake spec` to run the tests.
- You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dynamodb-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Dynamodb::Api project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/dynamodb-api/blob/master/CODE_OF_CONDUCT.md).
