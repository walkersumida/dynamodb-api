# frozen_string_literal: true

require 'dynamodb/api/relation'

module Dynamodb
  module Api
    class Query # :nodoc:
      include Relation
      attr_reader :client

      def initialize
        @client = Adapter.new.client
      end

      def all
        @client.query(build_query)
      end

      private

      def build_query
        {
          table_name: from_clause.name,
          index_name: index_clause.name,
          select: select_clause.name,
          scan_index_forward: order_clause.direct,
          key_conditions: where_clause.key_conditions
        }.merge(build_filter_clause)
      end

      def build_filter_clause
        {
          filter_expression: filter_clause.expression,
          expression_attribute_values: filter_clause.values
        }
      end
    end
  end
end
