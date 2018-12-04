# frozen_string_literal: true

module Dynamodb
  module Api
    module Update
      class Base # :nodoc:
        def update_item(key, cols, table_name)
          @key = key
          @cols = cols
          @table_name = table_name

          client = Adapter.client
          client.update_item(build_update_clause)
        end

        private

        def build_update_expression
          raise NotImplementedError, "You must implement #{self.class}##{__method__}"
        end

        def build_expression_attribute_names
          raise NotImplementedError, "You must implement #{self.class}##{__method__}"
        end

        def build_expression_attribute_values
          raise NotImplementedError, "You must implement #{self.class}##{__method__}"
        end

        def build_update_clause
          raise NotImplementedError, "You must implement #{self.class}##{__method__}"
        end
      end
    end
  end
end
