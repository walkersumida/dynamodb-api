# frozen_string_literal: true

module Dynamodb
  module Api
    module Update
      class Item # :nodoc:
        def update_item(key, cols, table_name)
          @key = key
          @cols = cols
          @table_name = table_name

          client = Adapter.client
          client.update_item(build_update_clause)
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
