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
      attr_accessor :attr_expression_attribute
      attr_accessor :limit_clause

      def expression_attribute
        if attr_expression_attribute.nil?
          self.attr_expression_attribute = Relation::ExpressionAttributeNames.new
        else
          attr_expression_attribute
        end
      end
    end
  end
end
