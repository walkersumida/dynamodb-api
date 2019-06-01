# frozen_string_literal: true

module Dynamodb
  module Api
    module Delete
      class Item
        # @param key [Hash] the item key
        # @param table_name [String] the table name
        def self.delete_item(key, table_name)
          client = Adapter.client
          table_name = Dynamodb::Api::Config.build_table_name(table_name)

          client.delete_item(key: key, table_name: table_name)
        end
      end
    end
  end
end
