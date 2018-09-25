# frozen_string_literal: true

require 'dynamodb/api/relation'

module Dynamodb
  module Api
    class Query # :nodoc:
      include Relation
      attr_accessor :reserved_words

      def initialize
        @reserved_words = ReservedWords.new
      end

      def all
        Adapter.client.query(build_query)
      end

      private

      def build_query
        build_params = base_params.merge(build_filter_clause)
        build_params[:scan_index_forward] = order_direct(order_clause)
        build_params[:select] = select_name(select_clause)
        if expression_attribute&.names
          build_params[:expression_attribute_names] = expression_attribute.names
        end
        build_params[:limit] = limit_clause.number if limit_clause&.number
        build_params
      end

      def base_params
        {
          table_name: from_clause.name,
          index_name: index_clause.name,
          key_conditions: where_clause.key_conditions,
        }
      end

      def order_direct(clause)
        clause&.direct ? clause.direct : OrderClause.new.direct
      end

      def select_name(clause)
        clause&.name ? clause.name : SelectClause.new.name
      end

      def build_filter_clause
        return {} unless filter_clause&.expression
        {
          filter_expression: filter_clause.expression,
          expression_attribute_values: filter_clause.values,
        }
      end
    end
  end
end
