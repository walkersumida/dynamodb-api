# frozen_string_literal: true

require 'dynamodb/api/relation/query_methods'

module Dynamodb
  module Api
    module Relation # :nodoc:
      include QueryMethods
      attr_accessor :index_clause
      attr_accessor :from_clause
      attr_accessor :select_clause
      attr_accessor :order_clause
      attr_accessor :where_clause
      attr_accessor :filter_clause
    end
  end
end
