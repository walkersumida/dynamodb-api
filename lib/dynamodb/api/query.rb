# frozen_string_literal: true

module Dynamodb
  module Api
    class Query # :nodoc:
      attr_reader :client
      attr_reader :relation

      def initialize
        @relation = Relation.new
        @client = Adapter.new.client
      end

      def all
        @client.query(build_query)
      end

      private

      def build_query
        {
          table_name: @relation.from_clause.name,
          index_name: @relation.index_clause.name,
          select: @relation.select_clause.name,
          scan_index_forward: @relation.order_clause.direct,
          key_conditions: @relation.where_clause.key_conditions
        }.merge(build_filter_clause)
      end

      def build_filter_clause
        {
          filter_expression: @relation.filter_clause.expression,
          expression_attribute_values: @relation.filter_clause.values
        }
      end
    end
  end
end
