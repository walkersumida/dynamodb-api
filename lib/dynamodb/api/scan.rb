# frozen_string_literal: true

require 'dynamodb/api/relation'

module Dynamodb
  module Api
    class Scan < Base # :nodoc:
      def all
        Adapter.client.scan(build_query)
      end

      private

      def build_query
        build_params = base_params.merge(build_filter_clause)
        build_params[:index_name] = index_clause.name if index_clause&.name
        build_params[:key_conditions] = where_clause.key_conditions if where_clause&.key_conditions
        build_params[:select] = select_name(select_clause)
        build_expression_attribute_names(build_params)
        build_params[:limit] = limit_clause.number if limit_clause&.number
        build_params
      end

      def base_params
        {
          table_name: from_clause.name,
        }
      end
    end
  end
end
