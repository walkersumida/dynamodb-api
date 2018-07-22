# frozen_string_literal: true

require 'dynamodb/api/relation/query_methods'

module Dynamodb
  module Api
    class Relation # :nodoc:
      include QueryMethods
      attr_accessor :index_clause
      attr_accessor :from_clause
      attr_accessor :select_clause
      attr_accessor :order_clause
    end
  end
end
