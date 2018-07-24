# frozen_string_literal: true

module Dynamodb
  module Api
    module Relation
      class GlobalSecondaryIndex
        attr_reader  :name

        def initialize(name)
          if Dynamodb::Api::Config.index_name_prefix?
            name = Dynamodb::Api::Config.index_name_prefix + name
          end
          @name = name
        end
      end
    end
  end
end
