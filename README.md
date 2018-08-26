# Dynamodb::Api

[![Build Status](https://travis-ci.org/walkersumida/dynamodb-api.svg?branch=master)](https://travis-ci.org/walkersumida/dynamodb-api)


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

### Rails

`config/initializers/dynamodb_api.rb`

```ruby
Dynamodb::Api.config do |config|
  config.access_key_id = ''
  config.secret_access_key = ''
  config.region = ''
  config.table_name_prefix = ''
  config.index_name_prefix = ''
end
```

### Other

```ruby
Dynamodb::Api.config.access_key_id = ''
Dynamodb::Api.config.secret_access_key = ''
Dynamodb::Api.config.region = ''
Dynamodb::Api.config.table_name_prefix = ''
Dynamodb::Api.config.index_name_prefix = ''
```

## How to use
e.g.

cars table.

| maker_id(Partition key) | model | release_date(Sort key) |
|:---|:---|:---|
|1 |Accord |0.19760508e8 |
|2 |CROWN |0.19550101e8 |
|3 |Model S |0.20120601e8 |
|1 |S2000 |0.19980101e8 |

### Query
https://docs.aws.amazon.com/sdkforruby/api/Aws/DynamoDB/Client.html#query-instance_method

#### only Partition(Hash) key

```ruby
query = Dynamodb::Api::Query.new
query.from('cars').index('index_maker_id_release_date')
query.where(['maker_id', 1, 'EQ'])
items = query.all.items
```

| maker_id | model | release_date |
|:---|:---|:---|
|1 |S2000 |0.19980101e8 |
|1 |Accord |0.19760508e8 |

#### Partition key and Sort(Range) key

```ruby
query = Dynamodb::Api::Query.new
query.from('cars').index('index_maker_id_release_date')
query.where([['maker_id', 1, 'EQ'], ['release_date', 19_980_101, 'GE']])
items = query.all.items
```

| maker_id | model | release_date |
|:---|:---|:---|
|1 |S2000 |0.19980101e8 |

#### Sorting

```ruby
query = Dynamodb::Api::Query.new
query.from('cars').index('index_maker_id_release_date')
query.where(['maker_id', 1, 'EQ'])
query.order('asc') # default: 'desc'
items = query.all.items
```

| maker_id | model | release_date |
|:---|:---|:---|
|1 |Accord |0.19760508e8 |
|1 |S2000 |0.19980101e8 |

#### filter

```ruby
query = Dynamodb::Api::Query.new
query.from('cars').index('index_maker_id_release_date')
query.where(['maker_id', 1, 'EQ'])
query.filter('model = :model', ':model': 'S2000')
items = query.all.items
```

| maker_id | model | release_date |
|:---|:---|:---|
|1 |S2000 |0.19980101e8 |

#### Limit

```ruby
query = Dynamodb::Api::Query.new
query.from('cars').index('index_maker_id_release_date').
  where(['maker_id', 1, 'EQ']).
  order('asc'). # default: 'desc'
  limit(1)
items = query.all.items
```

| maker_id | model | release_date |
|:---|:---|:---|
|1 |Accord |0.19760508e8 |

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
