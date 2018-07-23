# frozen_string_literal: true

module Dynamodb
  module Api
    class Relation
      class WhereClause # :nodoc:
        attr_reader :key_conditions

        KEY = 0
        VALUE = 1
        OPERATOR = 2

        def initialize(key_conditions)
          @key_conditions = build(key_conditions)
        end

        private

        def build(key_conditions)
          key_conditions.each_with_object({}) do |c, h|
            h[c[KEY]] = {
              attribute_value_list: c[VALUE],
              comparison_operator: c[OPERATOR]
            }
          end
        end
      end
    end
  end
end
