require 'aws-sdk'
require 'active_support'

require 'dynamodb/api/version'
require 'dynamodb/api/config'
require 'dynamodb/api/adapter'
require 'dynamodb/api/query'
require 'dynamodb/api/relation'
require 'dynamodb/api/relation/query_methods'
require 'dynamodb/api/relation/from_clause'
require 'dynamodb/api/relation/select_clause'
require 'dynamodb/api/relation/order_clause'
require 'dynamodb/api/relation/global_secondary_index'

module Dynamodb
  module Api
    extend self

    def config
      block_given? ? yield(Dynamodb::Api::Config) : Dynamodb::Api::Config
    end

    def adapter
      @adapter ||= Dynamodb::Api::Adapter.new
    end
  end
end
