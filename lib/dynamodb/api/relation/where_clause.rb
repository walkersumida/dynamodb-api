# frozen_string_literal: true

module Dynamodb
  module Api
    module Relation
      class WhereClause # :nodoc:
        attr_reader :key_conditions

        KEY = 0
        VALUE = 2
        OPERATOR = 1

        def initialize(key_conditions)
          @key_conditions = build(key_conditions)
        end

        private

        def build(key_conditions)
          conditions = format_conditions(key_conditions)
          conditions.each_with_object({}) do |c, h|
            h[c[KEY]] = {
              attribute_value_list: format_value(c[VALUE]),
              comparison_operator: Map::Operator.key(c[OPERATOR]),
            }
          end
        end

        def format_conditions(conditions)
          return [conditions] unless conditions[0].is_a?(Array)
          conditions
        end

        def format_value(value)
          return [value] unless value.is_a?(Array)
          value
        end
      end
    end
  end
end
