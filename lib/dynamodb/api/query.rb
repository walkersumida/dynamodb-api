# frozen_string_literal: true

require 'dynamodb/api/relation'

module Dynamodb
  module Api
    class Query # :nodoc:
      include Relation

      def all
        Adapter.client.query(build_query)
      end

      private

      def build_query
        build_params = {
          table_name: from_clause.name,
          index_name: index_clause.name,
          select: select_clause.name,
          scan_index_forward: order_clause.direct,
          key_conditions: where_clause.key_conditions
        }.merge(build_filter_clause)
        if expression_attribute&.names
          build_params[:expression_attribute_names] = expression_attribute.names
        end
        build_params
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
