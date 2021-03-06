require 'bundler/setup'
require 'dynamodb/api'
require 'support/dynamodb_helper'
require 'pry'

ENV['ACCESS_KEY'] ||= 'abcd'
ENV['SECRET_KEY'] ||= '1234'

Aws.config.update(
  region: 'ap-northeast-1',
  credentials: Aws::Credentials.new(ENV['ACCESS_KEY'], ENV['SECRET_KEY'])
)

Dynamodb::Api.config do |config|
  # Add `TEST_DYNAMODB_ENDPOINT`, as it may not be accessible on CI.
  # So specify `http://0.0.0.0:8000` on CI.
  endpoint = ENV['TEST_DYNAMODB_ENDPOINT'] || 'http://dynamodb:8000'
  config.endpoint = endpoint
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before :each do
    Dynamodb::Api.drop_tables
    Dynamodb::Api.config.table_name_prefix = ''
    Dynamodb::Api.config.index_name_prefix = ''
  end
end
