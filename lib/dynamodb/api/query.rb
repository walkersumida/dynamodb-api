# frozen_string_literal: true

require 'dynamodb/api/relation'

module Dynamodb
  module Api
    class Query < Base # :nodoc:
      def all
        result = Adapter.client.query(build_input)
        @last_evaluated_key = result.last_evaluated_key
        result
      end

      def next
        return nil if @last_evaluated_key.blank?
        input = build_input
        input[:exclusive_start_key] = @last_evaluated_key
        result = Adapter.client.query(input)
        @last_evaluated_key = result.last_evaluated_key
        return nil if result.count.zero?
        result
      end

      private

      # Build options.
      #
      # @return [Aws::DynamoDB::Types::ScanInput]
      def build_input
        input = Aws::DynamoDB::Types::QueryInput.new
        input[:expression_attribute_values] = {}
        input = base_input(input)
        input = build_filter_clause(input)
        input[:scan_index_forward] = order_direct(order_clause)
        input[:select] = select_name(select_clause)
        build_expression_attribute_names(input)
        input[:limit] = limit_clause.number if limit_clause&.number
        input
      end

      # Build required options.
      # `key_condition_expression`: e.g. "Artist = :a"
      # `expression_attribute_values`: e.g. { ":a" => "No One You Know" }
      #
      # @param input [Aws::DynamoDB::Types::ScanInput]
      # @return [Aws::DynamoDB::Types::ScanInput]
      def base_input(input)
        input[:table_name] = from_clause.name
        input[:index_name] = index_clause.name
        input[:key_condition_expression] = where_clause.key_condition
        input[:expression_attribute_values].
          merge!(where_clause.attribute_values)
        input
      end
    end
  end
end
