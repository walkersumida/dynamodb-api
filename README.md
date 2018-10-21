# Dynamodb::Api

[![Build Status](https://travis-ci.org/walkersumida/dynamodb-api.svg?branch=master)](https://travis-ci.org/walkersumida/dynamodb-api)
[![Gem Version](https://badge.fury.io/rb/dynamodb-api.svg)](https://badge.fury.io/rb/dynamodb-api)

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

| maker_id(Partition key) | model | release_date(Sort key) | status |
|:---|:---|:---|:---|
|1 |Accord |0.19760508e8 |0 |
|2 |CROWN |0.19550101e8 |0 |
|3 |Model S |0.20120601e8 |0 |
|1 |S2000 |0.19980101e8 |1 |

### Query
https://docs.aws.amazon.com/sdkforruby/api/Aws/DynamoDB/Client.html#query-instance_method

#### Partition(Hash) key

```ruby
query = Dynamodb::Api.query
query.from('cars').index('index_maker_id_release_date').
  where(['maker_id', '=', 1])
items = query.all.items
```

| maker_id(Partition key) | model | release_date(Sort key) | status |
|:---|:---|:---|:---|
|1 |S2000 |0.19980101e8 |1 |
|1 |Accord |0.19760508e8 |0 |

#### Partition key and Sort(Range) key

```ruby
query = Dynamodb::Api.query
query.from('cars').index('index_maker_id_release_date').
  where([['maker_id', '=', 1], ['release_date', '>=', 19_980_101]])
items = query.all.items
```

| maker_id(Partition key) | model | release_date(Sort key) | status |
|:---|:---|:---|:---|
|1 |S2000 |0.19980101e8 |1 |

#### Sorting

```ruby
query = Dynamodb::Api.query
query.from('cars').index('index_maker_id_release_date').
  where(['maker_id', '=', 1]).
  order('asc') # default: 'desc'
items = query.all.items
```

| maker_id(Partition key) | model | release_date(Sort key) | status |
|:---|:---|:---|:---|
|1 |Accord |0.19760508e8 |0 |
|1 |S2000 |0.19980101e8 |1 |

#### Filter

```ruby
query = Dynamodb::Api.query
query.from('cars').index('index_maker_id_release_date').
  where(['maker_id', '=', 1]).
  filter('model = :model', ':model': 'S2000')
items = query.all.items
```

| maker_id(Partition key) | model | release_date(Sort key) | status |
|:---|:---|:---|:---|
|1 |S2000 |0.19980101e8 |1 |

#### Limit

```ruby
query = Dynamodb::Api.query
query.from('cars').index('index_maker_id_release_date').
  where(['maker_id', '=', 1]).
  order('asc'). # default: 'desc'
  limit(1)
items = query.all.items
```

| maker_id(Partition key) | model | release_date(Sort key) | status |
|:---|:---|:---|:---|
|1 |Accord |0.19760508e8 |0 |

#### Expression Attribute Names

Words reserved in DynamoDB can not be used without special processing.
In `dynamodb-api` , you can omit the special processing by putting `#` at the beginning of the word.
Refer to the list of reserved words from [here](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ReservedWords.html).

```ruby
query = Dynamodb::Api.query
query.from('cars').index('index_maker_id_release_date').
  where(['maker_id', '=', 1]).
  filter('#status = :status', ':status': 1)
items = query.all.items
```

| maker_id(Partition key) | model | release_date(Sort key) | status |
|:---|:---|:---|:---|
|1 |S2000 |0.19980101e8 |1 |

If you don't add `#` to a reserved word, the following error will occur:

    Aws::DynamoDB::Errors::ValidationException:
      Invalid FilterExpression: Attribute name is a reserved keyword; reserved keyword: [reserved word]

### Delete

```ruby
key = { model: 'NSX', release_date: 19900914 }
Dynamodb::Api.delete('cars', key)
```

## Development

- Run `docker-compose up` to run the dynamodb_local.
- After checking out the repo, run `bin/setup` to install dependencies.
- Run `bundle exec rake spec` to run the tests. Or run `bundle exec appraisal aws-sdk-* rake spec` to run the tests. Replase `*` with aws sdk major version.
- You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dynamodb-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Dynamodb::Api project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/dynamodb-api/blob/master/CODE_OF_CONDUCT.md).
