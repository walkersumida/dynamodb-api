# frozen_string_literal: true

require 'dynamodb/api/relation'

module Dynamodb
  module Api
    class Query < Base # :nodoc:
      private

      def build_query
        build_params = base_params.merge(build_filter_clause)
        build_params[:scan_index_forward] = order_direct(order_clause)
        build_params[:select] = select_name(select_clause)
        build_expression_attribute_names(build_params)
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
    end
  end
end
