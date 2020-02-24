# frozen_string_literal: true

module Dynamodb
  module Api
    module Relation
      class WhereClause # :nodoc:
        attr_reader :key_condition
        attr_reader :attribute_values

        KEY = 0
        VALUE = 2
        OPERATOR = 1
        FROM = 0
        TO = 1

        # @param conditions [Array]
        def initialize(conditions)
          built_conditions = build(conditions)
          @key_condition = built_conditions[:key_conditions]
          @attribute_values = built_conditions[:attribute_values]
        end

        private

        # Build where clause.
        #
        # @param conditions [Array]
        def build(conditions)
          init = { key_conditions: [], attribute_values: {} }
          conditions = format_conditions(conditions)
          built = conditions.each_with_object(init) do |c, h|
            h[:key_conditions] <<
              format_key_condition(c[KEY], c[OPERATOR])
            h[:attribute_values].
              merge!(format_values(c[KEY], c[OPERATOR], c[VALUE]))
          end
          built[:key_conditions] =
            built[:key_conditions].join(' AND ')
          built
        end

        # Format to the `key_condition_expression`.
        # e.g.
        #   `format_key_condition("Artist", "=")` =>
        #     `"Artist = :Artist"`
        #
        #   `format_key_condition("Artist", "begins_with")` =>
        #     `"begins_with(Artist, :Artist)"`
        #
        #   `format_key_condition("Year", "between")` =>
        #     `"Year between :from_Year and :to_Year"`
        #
        # @param key [String] a attribute name
        # @param operator [String] a operator
        # @return [String] Formatted expression.
        def format_key_condition(key, operator)
          case operator.downcase
          when 'begins_with'
            "#{operator.downcase}(#{key}, :#{key})"
          when 'between'
            "#{key} #{operator.downcase}" \
              " :from_#{key} AND :to_#{key}"
          else
            "#{key} #{Map::Operator.key(operator)} :#{key}"
          end
        end

        # Format to the `expression_attribute_values`
        # e.g.
        #   `format_values("Artist", "=", "blue")` =>
        #     `{ ":Artist" => "blue" }`
        #
        #   `format_values("Year", "between", [1999, 2020])` =>
        #     `{ ":from_Year" => 1999, ":to_Year" => 2020 }`
        #
        # @param key [String] a attribute name
        # @param operator [String] a operator
        # @param values [Object] values
        # @return [Hash<Object>] Formatted expression.
        def format_values(key, operator, values)
          case operator.downcase
          when 'between'
            {
              ":from_#{key}" => values[FROM],
              ":to_#{key}" => values[TO],
            }
          else
            {
              ":#{key}" => values.is_a?(Array) ? values[0] : values
            }
          end
        end

        def format_conditions(conditions)
          return [conditions] unless conditions[0].is_a?(Array)
          conditions
        end
      end
    end
  end
end
