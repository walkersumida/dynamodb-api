# frozen_string_literal: true

module Dynamodb
  module Api
    module Update
      class Attributes < Base # :nodoc:
        def remove_attributes(key, cols, table_name)
          update_item(key, cols, table_name)
        end

        private

        def build_update_expression
          str = @cols.each_with_object([]) do |k, ary|
            ary << "##{k}"
          end.join(', ')
          "REMOVE #{str}"
        end

        def build_expression_attribute_names
          @cols.each_with_object({}) do |k, h|
            h["##{k}"] = k
          end
        end

        def build_update_clause
          {
            key: @key, table_name: @table_name,
            update_expression: build_update_expression,
            expression_attribute_names: build_expression_attribute_names,
          }
        end
      end
    end
  end
end
