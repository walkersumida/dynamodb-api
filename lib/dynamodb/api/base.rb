# frozen_string_literal: true

require 'dynamodb/api/relation'

module Dynamodb
  module Api
    class Base # :nodoc:
      include Relation
      attr_accessor :last_evaluated_key

      def all
        raise NotImplementedError, "You must implement #{self.class}##{__method__}"
      end

      private

      def build_query
        raise NotImplementedError, "You must implement #{self.class}##{__method__}"
      end

      def base_params
        raise NotImplementedError, "You must implement #{self.class}##{__method__}"
      end

      def order_direct(clause)
        clause&.direct ? clause.direct : OrderClause.new.direct
      end

      def select_name(clause)
        clause&.name ? clause.name : SelectClause.new.name
      end

      def build_filter_clause
        return {} if filter_clause&.expression.blank?
        {
          filter_expression: filter_clause.expression,
          expression_attribute_values: filter_clause.values,
        }
      end

      def build_expression_attribute_names(params)
        if filter_clause&.reserved_words.present?
          expression_attribute.add(filter_clause.reserved_words)
        end
        if expression_attribute.names.present?
          params[:expression_attribute_names] = expression_attribute.names
        end
      end
    end
  end
end
