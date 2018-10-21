# frozen_string_literal: true

module Dynamodb
  module Api
    module Delete
      class Item # :nodoc:
        def self.delete_item(key, table_name)
          client = Adapter.client
          client.delete_item(key: key, table_name: table_name)
        end
      end
    end
  end
end
