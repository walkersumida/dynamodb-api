# frozen_string_literal: true

module Dynamodb
  module Api
    module Relation
      class FromClause # :nodoc:
        attr_reader :name

        def initialize(name)
          if Dynamodb::Api::Config.table_name_prefix?
            name = Dynamodb::Api::Config.table_name_prefix + name
          end
          @name = name
        end
      end
    end
  end
end
