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

      def next
        raise NotImplementedError, "You must implement #{self.class}##{__method__}"
      end

      private

      def build_input
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

      # Build filter clause.
      # `filter_expression`: e.g. "Artist = :a"
      # `expression_attribute_values`: e.g. { ":a" => "No One You Know" }
      #
      # @param input [Aws::DynamoDB::Types::ScanInput]
      # @return [Aws::DynamoDB::Types::ScanInput]
      def build_filter_clause(input)
        return input if filter_clause&.expression.blank?
        input[:filter_expression] = filter_clause.expression
        if filter_clause.values.present?
          if input[:expression_attribute_values].nil?
            input[:expression_attribute_values] = {}
          end
          input[:expression_attribute_values].
            merge!(filter_clause.values)
        end
        input
      end

      def build_expression_attribute_names(input)
        if filter_clause&.reserved_words.present?
          expression_attribute.add(filter_clause.reserved_words)
        end
        if expression_attribute.names.present?
          input[:expression_attribute_names] = expression_attribute.names
        end
      end
    end
  end
end
