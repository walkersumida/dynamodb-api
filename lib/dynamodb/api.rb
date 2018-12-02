require 'aws-sdk'
require 'active_support'
require 'active_support/core_ext'

require 'dynamodb/api/version'
require 'dynamodb/api/config'
require 'dynamodb/api/adapter'
require 'dynamodb/api/query'
require 'dynamodb/api/relation'
require 'dynamodb/api/relation/query_methods'
require 'dynamodb/api/relation/from_clause'
require 'dynamodb/api/relation/select_clause'
require 'dynamodb/api/relation/order_clause'
require 'dynamodb/api/relation/where_clause'
require 'dynamodb/api/relation/filter_clause'
require 'dynamodb/api/relation/global_secondary_index'
require 'dynamodb/api/relation/expression_attribute_names'
require 'dynamodb/api/relation/limit_clause'
require 'dynamodb/api/put/item'
require 'dynamodb/api/delete/tables'
require 'dynamodb/api/delete/item'
require 'dynamodb/api/map/operator'
require 'dynamodb/api/update/base'
require 'dynamodb/api/update/item'
require 'dynamodb/api/update/attributes'

module Dynamodb
  module Api # :nodoc:
    module_function

    def config
      block_given? ? yield(Dynamodb::Api::Config) : Dynamodb::Api::Config
    end

    def adapter
      @adapter ||= Dynamodb::Api::Adapter.new
    end

    def drop_tables
      Delete::Tables.delete_tables
    end

    def query
      Query.new
    end

    def insert(table_name, value)
      # TODO: BatchWriteItem
      Put::Item.put_item(value, table_name)
    end

    def update(table_name, key, value)
      Update::Item.new.update_item(key, value, table_name)
    end

    def delete(table_name, key)
      Delete::Item.delete_item(key, table_name)
    end
  end
end
