# frozen_string_literal: true

module Dynamodb
  module Api
    module Put
      class Item
        # @param key [Hash] the item key
        # @param table_name [String] the table name
        def self.put_item(item, table_name)
          client = Adapter.client
          table_name = Dynamodb::Api::Config.build_table_name(table_name)

          client.put_item(item: item, table_name: table_name)
        end
      end
    end
  end
end
