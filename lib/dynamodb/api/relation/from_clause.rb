# frozen_string_literal: true

module Dynamodb
  module Api
    module Relation
      class FromClause # :nodoc:
        attr_reader :name

        # @param name [String] the table name
        def initialize(name)
          @name = Dynamodb::Api::Config.build_table_name(name)
        end
      end
    end
  end
end
