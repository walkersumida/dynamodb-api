# frozen_string_literal: true

module Dynamodb
  module Api
    module Delete
      class Tables # :nodoc:
        def self.delete_tables
          client = Adapter.client
          table_names = client.list_tables[:table_names]
          table_names.each do |table_name|
            client.delete_table(table_name: table_name)
          end
        end
      end
    end
  end
end
