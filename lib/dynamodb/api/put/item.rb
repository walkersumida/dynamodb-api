# frozen_string_literal: true

module Dynamodb
  module Api
    module Put
      class Item # :nodoc:
        def self.put_item(item, table_name)
          client = Adapter.client
          client.put_item(item: item, table_name: table_name)
        end
      end
    end
  end
end
