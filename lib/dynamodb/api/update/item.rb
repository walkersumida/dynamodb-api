# frozen_string_literal: true

module Dynamodb
  module Api
    module Update
      class Item < Base # :nodoc:
        def update_item(key, cols, table_name)
          super(key, cols, table_name)
        end

        private

        def build_update_expression
          str = @cols.each_with_object([]) do |(k, _v), ary|
            ary << "##{k} = :#{k}"
          end.join(', ')
          "SET #{str}"
        end

        def build_expression_attribute_names
          @cols.each_with_object({}) do |(k, _v), h|
            h["##{k}"] = k
          end
        end

        def build_expression_attribute_values
          @cols.each_with_object({}) do |(k, v), h|
            h[":#{k}"] = v
          end
        end

        def build_update_clause
          {
            key: @key, table_name: @table_name,
            update_expression: build_update_expression,
            expression_attribute_names: build_expression_attribute_names,
            expression_attribute_values: build_expression_attribute_values,
          }
        end
      end
    end
  end
end
